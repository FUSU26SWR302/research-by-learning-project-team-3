package com.carrental.servlet.owner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * OwnerDashboardServlet – forwards to the Car Owner dashboard view.
 *
 * Protected by AuthenticationFilter: only CAR_OWNER role may reach this servlet.
 *
 * Future sprints: load the owner's vehicles and incoming booking requests
 * via VehicleDAO and BookingDAO.
 */
@WebServlet("/owner/dashboard")
public class OwnerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // TODO: load vehicles for this owner
        // User user = (User) req.getSession().getAttribute("loggedInUser");
        // req.setAttribute("vehicles", vehicleDAO.getByOwner(user.getUserID()));
        req.getRequestDispatcher("/WEB-INF/views/owner/dashboard.jsp").forward(req, resp);
    }
}
