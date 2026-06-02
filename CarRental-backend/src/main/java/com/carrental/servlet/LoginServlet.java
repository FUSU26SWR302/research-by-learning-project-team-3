package com.carrental.servlet;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

/**
 * LoginServlet – UC02: User logs in via email + password.
 *
 * GET  /login  → forwards to login.jsp
 * POST /login  → verifies credentials, creates session, redirects by Role
 *
 * ---------------------------------------------------------------
 * Session-based Role Routing (how it works)
 * ---------------------------------------------------------------
 * After a successful login the authenticated {@link User} object is
 * stored in the HTTP Session under the key "loggedInUser":
 *
 *   session.setAttribute("loggedInUser", user);
 *
 * The session is then used in two places:
 *   1. AuthenticationFilter.java – checks that the session contains a
 *      valid user AND that the user's role matches the URL being accessed.
 *   2. JSP views – can inspect ${sessionScope.loggedInUser.role} to
 *      conditionally render role-specific navigation links, etc.
 *
 * Role → redirect mapping:
 *   ADMIN     → /admin/dashboard
 *   STAFF     → /staff/dashboard
 *   CAR_OWNER → /owner/dashboard
 *   RENTER    → /renter/dashboard
 *   (default) → /index.jsp
 * ---------------------------------------------------------------
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final String VIEW_LOGIN = "/WEB-INF/views/login.jsp";

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    // ---------------------------------------------------------------
    // GET – render the login form
    // ---------------------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // If user is already logged in, skip the login page
        HttpSession existingSession = req.getSession(false);
        if (existingSession != null && existingSession.getAttribute("loggedInUser") != null) {
            User user = (User) existingSession.getAttribute("loggedInUser");
            resp.sendRedirect(req.getContextPath() + roleToRedirectPath(user.getRole()));
            return;
        }

        req.getRequestDispatcher(VIEW_LOGIN).forward(req, resp);
    }

    // ---------------------------------------------------------------
    // POST – authenticate the submitted credentials
    // ---------------------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String email    = trimOrEmpty(req.getParameter("email"));
        String password = trimOrEmpty(req.getParameter("password"));

        // Basic empty-field check
        if (email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Email and password are required.");
            req.setAttribute("email", email);
            req.getRequestDispatcher(VIEW_LOGIN).forward(req, resp);
            return;
        }

        try {
            // Delegate credential verification + BCrypt check to the DAO
            User user = userDAO.checkLogin(email, password);

            if (user == null) {
                // Wrong email or wrong password – intentionally vague message
                req.setAttribute("error", "Invalid email or password. Please try again.");
                req.setAttribute("email", email);
                req.getRequestDispatcher(VIEW_LOGIN).forward(req, resp);
                return;
            }

            // Check if the account is allowed to log in
            if (!user.isActive()) {
                req.setAttribute("error", "Your account has been deactivated. Please contact support.");
                req.getRequestDispatcher(VIEW_LOGIN).forward(req, resp);
                return;
            }

            // -------------------------------------------------------
            // Create / renew the HTTP Session
            // -------------------------------------------------------
            // Invalidate any pre-existing session to prevent session fixation
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            // Create a brand-new session and store the User object
            HttpSession session = req.getSession(true);
            session.setAttribute("loggedInUser", user);  // key used by the Filter + JSPs
            session.setMaxInactiveInterval(30 * 60);      // 30-minute inactivity timeout

            // -------------------------------------------------------
            // Redirect to the role-appropriate dashboard
            // -------------------------------------------------------
            String redirectPath = roleToRedirectPath(user.getRole());
            resp.sendRedirect(req.getContextPath() + redirectPath);

        } catch (SQLException e) {
            getServletContext().log("LoginServlet: database error", e);
            req.setAttribute("error", "A system error occurred. Please try again later.");
            req.getRequestDispatcher(VIEW_LOGIN).forward(req, resp);
        }
    }

    // ---------------------------------------------------------------
    // Role → redirect path mapping
    // ---------------------------------------------------------------

    /**
     * Maps a user role string to the target dashboard URL path.
     *
     * This mapping mirrors the filter-mapping entries in web.xml so that
     * AuthenticationFilter will always allow the redirected user through.
     */
    private String roleToRedirectPath(String role) {
        return switch (role) {
            case User.ROLE_ADMIN     -> "/admin/dashboard";
            case User.ROLE_STAFF     -> "/staff/dashboard";
            case User.ROLE_CAR_OWNER -> "/owner/dashboard";
            case User.ROLE_RENTER    -> "/renter/dashboard";
            default                  -> "/";
        };
    }

    private String trimOrEmpty(String value) {
        return value != null ? value.trim() : "";
    }
}
