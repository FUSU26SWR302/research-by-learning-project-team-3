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

import java.io.IOException;
import java.io.BufferedReader;
import java.sql.SQLException;

/**
 * ApiRegisterServlet – REST API for user registration.
 * Maps to /api/register
 */
@WebServlet("/api/register")
public class ApiRegisterServlet extends HttpServlet {

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
            if (requestJson == null || !requestJson.has("name") || !requestJson.has("email") 
                    || !requestJson.has("password") || !requestJson.has("role")) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                responseJson.addProperty("message", "Full name, email, password, and role are required.");
                resp.getWriter().write(gson.toJson(responseJson));
                return;
            }

            String name = requestJson.get("name").getAsString().trim();
            String email = requestJson.get("email").getAsString().trim();
            String password = requestJson.get("password").getAsString().trim();
            String role = requestJson.get("role").getAsString().trim().toUpperCase();
            String phone = requestJson.has("phone") ? requestJson.get("phone").getAsString().trim() : "";

            if (name.isEmpty() || email.isEmpty() || password.isEmpty() || role.isEmpty()) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                responseJson.addProperty("message", "Required fields cannot be empty.");
                resp.getWriter().write(gson.toJson(responseJson));
                return;
            }

            // Verify role matches valid options
            if (!User.ROLE_RENTER.equals(role) && !User.ROLE_CAR_OWNER.equals(role)) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                responseJson.addProperty("message", "Invalid account role requested.");
                resp.getWriter().write(gson.toJson(responseJson));
                return;
            }

            // Check if email already exists
            if (userDAO.isEmailExist(email)) {
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                responseJson.addProperty("message", "An account with this email already exists.");
                resp.getWriter().write(gson.toJson(responseJson));
                return;
            }

            // Construct new user (will be marked active by default in DAO)
            User newUser = new User(email, password, name, phone, role);
            boolean success = userDAO.registerUser(newUser);

            if (success) {
                resp.setStatus(HttpServletResponse.SC_CREATED);
                responseJson.addProperty("message", "User account registered successfully.");
                resp.getWriter().write(gson.toJson(responseJson));
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                responseJson.addProperty("message", "Unable to create account. Please try again.");
                resp.getWriter().write(gson.toJson(responseJson));
            }

        } catch (SQLException e) {
            getServletContext().log("ApiRegisterServlet: Database error", e);
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            responseJson.addProperty("message", "A system error occurred. Please try again later.");
            resp.getWriter().write(gson.toJson(responseJson));
        } catch (Exception e) {
            getServletContext().log("ApiRegisterServlet: Parsing error", e);
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            responseJson.addProperty("message", "Invalid JSON request payload.");
            resp.getWriter().write(gson.toJson(responseJson));
        }
    }
}
