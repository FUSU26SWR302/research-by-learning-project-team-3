package com.carrental.servlet.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * AdminDashboardServlet – forwards to the Admin dashboard view.
 *
 * Protected by AuthenticationFilter: only ADMIN role may reach this servlet.
 * The filter validates the session before this code ever runs.
 *
 * Future sprints: inject real stats (user counts, revenue) via DAOs before forwarding.
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: load real dashboard stats and set as request attributes
        // req.setAttribute("totalUsers", userDAO.countAll());
        req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
    }
}
