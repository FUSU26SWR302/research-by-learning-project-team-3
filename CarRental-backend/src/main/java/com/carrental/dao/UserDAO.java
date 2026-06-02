package com.carrental.dao;

import com.carrental.db.DBContext;
import com.carrental.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.time.LocalDateTime;

/**
 * UserDAO – Data Access Object for the {@link User} entity.
 *
 * All SQL operations against the dbo.Users table are centralised here.
 * BCrypt password hashing / verification is also handled in this layer
 * so that the Servlet layer never touches plain-text passwords directly.
 */
public class UserDAO {

    // ---------------------------------------------------------------
    // SQL constants
    // ---------------------------------------------------------------

    private static final String SQL_FIND_BY_EMAIL =
            "SELECT UserID, Email, Password, FullName, Phone, Role, Status, CreatedAt, UpdatedAt " +
            "FROM dbo.Users " +
            "WHERE Email = ?";

    private static final String SQL_INSERT_USER =
            "INSERT INTO dbo.Users (Email, Password, FullName, Phone, Role, Status) " +
            "VALUES (?, ?, ?, ?, ?, 'ACTIVE')";

    private static final String SQL_EMAIL_EXISTS =
            "SELECT 1 FROM dbo.Users WHERE Email = ?";

    // ---------------------------------------------------------------
    // Public API
    // ---------------------------------------------------------------

    /**
     * UC01 – Register a new user.
     *
     * The caller must pass a {@link User} with a plain-text password in
     * {@code user.getPassword()}. This method hashes it with BCrypt
     * (work-factor 12) before persisting.
     *
     * @param user the new user; password field should be plain-text
     * @return {@code true} if the INSERT succeeded
     * @throws SQLException on any database error
     */
    public boolean registerUser(User user) throws SQLException {
        // Hash the plain-text password with BCrypt work-factor 12
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt(12));

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_INSERT_USER)) {

            ps.setString(1, user.getEmail());
            ps.setString(2, hashedPassword);
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getRole());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        }
    }

    /**
     * UC02 – Verify credentials for login.
     *
     * Looks up the user by e-mail, then uses {@link BCrypt#checkpw} to
     * compare the supplied plain-text password against the stored hash.
     *
     * @param email         the submitted e-mail address
     * @param plainPassword the submitted plain-text password
     * @return the authenticated {@link User}, or {@code null} if credentials are invalid
     * @throws SQLException on any database error
     */
    public User checkLogin(String email, String plainPassword) throws SQLException {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_FIND_BY_EMAIL)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("Password");

                    // BCrypt constant-time comparison – safe against timing attacks
                    if (BCrypt.checkpw(plainPassword, storedHash)) {
                        return mapRow(rs);
                    }
                }
            }
        }
        return null; // credentials do not match
    }

    /**
     * Check whether an e-mail address is already registered.
     *
     * Used during registration to prevent duplicate accounts.
     *
     * @param email the e-mail address to check
     * @return {@code true} if the e-mail already exists in dbo.Users
     * @throws SQLException on any database error
     */
    public boolean isEmailExist(String email) throws SQLException {
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(SQL_EMAIL_EXISTS)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // result set has at least one row → email found
            }
        }
    }

    // ---------------------------------------------------------------
    // Private helpers
    // ---------------------------------------------------------------

    /**
     * Maps the current row of a {@link ResultSet} to a {@link User} object.
     * The ResultSet cursor must already be positioned on a valid row.
     */
    private User mapRow(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserID(rs.getInt("UserID"));
        user.setEmail(rs.getString("Email"));
        // Do NOT propagate the hash to the application layer
        // user.setPassword(rs.getString("Password"));
        user.setFullName(rs.getString("FullName"));
        user.setPhone(rs.getString("Phone"));
        user.setRole(rs.getString("Role"));
        user.setStatus(rs.getString("Status"));

        Timestamp createdAt = rs.getTimestamp("CreatedAt");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("UpdatedAt");
        if (updatedAt != null) {
            user.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        return user;
    }
}
