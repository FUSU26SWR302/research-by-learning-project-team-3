package com.carrental.servlet;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

/**
 * RegisterServlet – UC01: Guest registers a new account.
 *
 * GET  /register  → forwards to register.jsp
 * POST /register  → validates input, saves new user, redirects to /login
 *
 * Server-side validation checks:
 *   1. All required fields are present and non-empty
 *   2. Email format is valid (basic regex)
 *   3. Password length ≥ 8 characters
 *   4. Passwords match
 *   5. Email is not already registered (via UserDAO.isEmailExist)
 *
 * Password hashing is delegated to UserDAO.registerUser (BCrypt work-factor 12).
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final String VIEW_REGISTER = "/WEB-INF/views/register.jsp";
    private static final int    MIN_PASSWORD_LENGTH = 8;

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    // ---------------------------------------------------------------
    // GET – render the registration form
    // ---------------------------------------------------------------
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Forward to the JSP view – no model needed for a blank form
        req.getRequestDispatcher(VIEW_REGISTER).forward(req, resp);
    }

    // ---------------------------------------------------------------
    // POST – process the submitted form
    // ---------------------------------------------------------------
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 1. Extract form parameters
        String email           = trimOrEmpty(req.getParameter("email"));
        String password        = trimOrEmpty(req.getParameter("password"));
        String confirmPassword = trimOrEmpty(req.getParameter("confirmPassword"));
        String fullName        = trimOrEmpty(req.getParameter("fullName"));
        String phone           = trimOrEmpty(req.getParameter("phone"));
        String role            = trimOrEmpty(req.getParameter("role"));

        // 2. Server-side validation
        String error = validate(email, password, confirmPassword, fullName, role);

        if (error != null) {
            // Redisplay form with error message, preserving safe fields
            req.setAttribute("error",   error);
            req.setAttribute("email",   email);
            req.setAttribute("fullName", fullName);
            req.setAttribute("phone",   phone);
            req.setAttribute("role",    role);
            req.getRequestDispatcher(VIEW_REGISTER).forward(req, resp);
            return;
        }

        // 3. Check for duplicate email
        try {
            if (userDAO.isEmailExist(email)) {
                req.setAttribute("error",   "This email address is already registered.");
                req.setAttribute("email",   email);
                req.setAttribute("fullName", fullName);
                req.setAttribute("phone",   phone);
                req.setAttribute("role",    role);
                req.getRequestDispatcher(VIEW_REGISTER).forward(req, resp);
                return;
            }

            // 4. Persist the new user (UserDAO hashes the password with BCrypt)
            User newUser = new User(email, password, fullName, phone, role);
            boolean success = userDAO.registerUser(newUser);

            if (success) {
                // Redirect to login with a success message (PRG pattern)
                resp.sendRedirect(req.getContextPath() + "/login?registered=true");
            } else {
                req.setAttribute("error", "Registration failed. Please try again.");
                req.getRequestDispatcher(VIEW_REGISTER).forward(req, resp);
            }

        } catch (SQLException e) {
            getServletContext().log("RegisterServlet: database error", e);
            req.setAttribute("error", "A system error occurred. Please try again later.");
            req.getRequestDispatcher(VIEW_REGISTER).forward(req, resp);
        }
    }

    // ---------------------------------------------------------------
    // Validation helper
    // ---------------------------------------------------------------

    /**
     * Validates all registration form fields.
     *
     * @return an error message string, or {@code null} when validation passes
     */
    private String validate(String email, String password, String confirmPassword,
                            String fullName, String role) {

        if (email.isEmpty() || password.isEmpty() || fullName.isEmpty() || role.isEmpty()) {
            return "All required fields must be filled in.";
        }

        // Basic email format check
        if (!email.matches("^[\\w._%+\\-]+@[\\w.\\-]+\\.[a-zA-Z]{2,}$")) {
            return "Please enter a valid email address.";
        }

        if (password.length() < MIN_PASSWORD_LENGTH) {
            return "Password must be at least " + MIN_PASSWORD_LENGTH + " characters long.";
        }

        if (!password.equals(confirmPassword)) {
            return "Passwords do not match.";
        }

        // Only RENTER and CAR_OWNER roles may self-register
        if (!User.ROLE_RENTER.equals(role) && !User.ROLE_CAR_OWNER.equals(role)) {
            return "Invalid role selected.";
        }

        return null; // all checks passed
    }

    private String trimOrEmpty(String value) {
        return value != null ? value.trim() : "";
    }
}
