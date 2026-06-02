package com.carrental.servlet.staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * StaffDashboardServlet – forwards to the Support Staff dashboard view.
 *
 * Protected by AuthenticationFilter: only STAFF role may reach this servlet.
 *
 * Future sprints: load open support tickets and pending verifications
 * via TicketDAO and VerificationDAO.
 */
@WebServlet("/staff/dashboard")
public class StaffDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: load open tickets
        // req.setAttribute("tickets", ticketDAO.getOpen());
        req.getRequestDispatcher("/WEB-INF/views/staff/dashboard.jsp").forward(req, resp);
    }
}
