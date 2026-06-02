package com.carrental.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * LogoutServlet – UC03: User logs out.
 *
 * GET  /logout → invalidates the current session and redirects to /login
 * POST /logout → same behaviour (supports both form submissions and links)
 *
 * After session invalidation the user becomes a Guest again.
 * AuthenticationFilter will deny any subsequent requests to protected routes.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        processLogout(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        processLogout(req, resp);
    }

    // ---------------------------------------------------------------
    // Shared logout logic
    // ---------------------------------------------------------------

    private void processLogout(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        // getSession(false) → returns null if no session exists, avoiding
        // the accidental creation of a new session just to invalidate it.
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate(); // removes ALL session attributes and the session id
        }

        // Redirect to login page with a ?logout=true flag so the login page
        // can optionally display a "You have been successfully logged out." message.
        resp.sendRedirect(req.getContextPath() + "/login?logout=true");
    }
}
