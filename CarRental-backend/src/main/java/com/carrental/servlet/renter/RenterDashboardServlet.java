package com.carrental.servlet.renter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * RenterDashboardServlet – forwards to the Renter dashboard view.
 *
 * Protected by AuthenticationFilter: only RENTER role may reach this servlet.
 *
 * Future sprints: load the logged-in user's bookings via BookingDAO and set
 * as a request attribute before forwarding.
 */
@WebServlet("/renter/dashboard")
public class RenterDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: load bookings for this renter
        // User user = (User) req.getSession().getAttribute("loggedInUser");
        // req.setAttribute("bookings", bookingDAO.getByUser(user.getUserID()));
        req.getRequestDispatcher("/WEB-INF/views/renter/dashboard.jsp").forward(req, resp);
    }
}
