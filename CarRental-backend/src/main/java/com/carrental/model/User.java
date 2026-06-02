package com.carrental.model;

import java.time.LocalDateTime;

/**
 * User – Domain / POJO class.
 *
 * Maps 1-to-1 with the dbo.Users table in MS SQL Server.
 *
 * The "Role" field drives authorization throughout the application:
 *   RENTER    → can browse cars and create rental orders
 *   CAR_OWNER → can list / manage their own vehicles
 *   ADMIN     → full system access
 *   STAFF     → customer-service / support access
 *
 * The password field carries the BCrypt hash – NEVER the plain-text value.
 */
public class User {

    // ---------------------------------------------------------------
    // Role constants – match the CHECK constraint in schema.sql
    // ---------------------------------------------------------------
    public static final String ROLE_RENTER    = "RENTER";
    public static final String ROLE_CAR_OWNER = "CAR_OWNER";
    public static final String ROLE_ADMIN     = "ADMIN";
    public static final String ROLE_STAFF     = "STAFF";

    // Status constants
    public static final String STATUS_ACTIVE   = "ACTIVE";
    public static final String STATUS_INACTIVE = "INACTIVE";
    public static final String STATUS_BANNED   = "BANNED";

    // ---------------------------------------------------------------
    // Fields
    // ---------------------------------------------------------------
    private int           userID;
    private String        email;
    private String        password;   // BCrypt hash only
    private String        fullName;
    private String        phone;
    private String        role;
    private String        status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // ---------------------------------------------------------------
    // Constructors
    // ---------------------------------------------------------------

    public User() {}

    /** Convenience constructor used during registration. */
    public User(String email, String password, String fullName, String phone, String role) {
        this.email    = email;
        this.password = password;
        this.fullName = fullName;
        this.phone    = phone;
        this.role     = role;
        this.status   = STATUS_ACTIVE;
    }

    // ---------------------------------------------------------------
    // Getters & Setters
    // ---------------------------------------------------------------

    public int getUserID()                      { return userID; }
    public void setUserID(int userID)           { this.userID = userID; }

    public String getEmail()                    { return email; }
    public void setEmail(String email)          { this.email = email; }

    public String getPassword()                 { return password; }
    public void setPassword(String password)    { this.password = password; }

    public String getFullName()                 { return fullName; }
    public void setFullName(String fullName)    { this.fullName = fullName; }

    public String getPhone()                    { return phone; }
    public void setPhone(String phone)          { this.phone = phone; }

    public String getRole()                     { return role; }
    public void setRole(String role)            { this.role = role; }

    public String getStatus()                   { return status; }
    public void setStatus(String status)        { this.status = status; }

    public LocalDateTime getCreatedAt()                     { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt)       { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt()                     { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt)       { this.updatedAt = updatedAt; }

    // ---------------------------------------------------------------
    // Helpers
    // ---------------------------------------------------------------

    /** Convenience: check whether the user has a specific role. */
    public boolean hasRole(String roleName) {
        return roleName != null && roleName.equalsIgnoreCase(this.role);
    }

    public boolean isActive() {
        return STATUS_ACTIVE.equals(this.status);
    }

    @Override
    public String toString() {
        return "User{userID=" + userID +
               ", email='" + email + '\'' +
               ", fullName='" + fullName + '\'' +
               ", role='" + role + '\'' +
               ", status='" + status + '\'' + '}';
    }
}
