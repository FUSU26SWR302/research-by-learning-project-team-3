package com.carrental.servlet.api;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.BufferedReader;
import java.sql.SQLException;

/**
 * ApiLoginServlet – REST API for user login.
 * Maps to /api/login
 */
@WebServlet("/api/login")
public class ApiLoginServlet extends HttpServlet {

    private UserDAO userDAO;
    private final Gson gson = new Gson();

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        StringBuilder jsonBuffer = new StringBuilder();
        String line;
        try (BufferedReader reader = req.getReader()) {
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        JsonObject responseJson = new JsonObject();

        try {
            JsonObject requestJson = gson.fromJson(jsonBuffer.toString(), JsonObject.class);
            if (requestJson == null || !requestJson.has("email") || !requestJson.has("password")) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                responseJson.addProperty("message", "Email and password are required.");
                resp.getWriter().write(gson.toJson(responseJson));
                return;
            }

            String email = requestJson.get("email").getAsString().trim();
            String password = requestJson.get("password").getAsString().trim();

            if (email.isEmpty() || password.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                responseJson.addProperty("message", "Email and password cannot be empty.");
                resp.getWriter().write(gson.toJson(responseJson));
                return;
            }

            User user = userDAO.checkLogin(email, password);

            if (user == null) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                responseJson.addProperty("message", "Invalid email or password.");
                resp.getWriter().write(gson.toJson(responseJson));
                return;
            }

            if (!user.isActive()) {
                resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
                responseJson.addProperty("message", "Your account has been deactivated. Please contact support.");
                resp.getWriter().write(gson.toJson(responseJson));
                return;
            }

            // Create HTTP Session (invalidate old session for security)
            HttpSession oldSession = req.getSession(false);
            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session = req.getSession(true);
            session.setAttribute("loggedInUser", user);
            session.setMaxInactiveInterval(30 * 60); // 30 mins

            // Return user details (without password hash)
            resp.setStatus(HttpServletResponse.SC_OK);
            resp.getWriter().write(gson.toJson(user));

        } catch (SQLException e) {
            getServletContext().log("ApiLoginServlet: Database error", e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            responseJson.addProperty("message", "A system error occurred. Please try again later.");
            resp.getWriter().write(gson.toJson(responseJson));
        } catch (Exception e) {
            getServletContext().log("ApiLoginServlet: Parsing error", e);
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            responseJson.addProperty("message", "Invalid JSON request payload.");
            resp.getWriter().write(gson.toJson(responseJson));
        }
    }
}
