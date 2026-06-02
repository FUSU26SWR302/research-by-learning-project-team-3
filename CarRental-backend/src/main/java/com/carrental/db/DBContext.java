package com.carrental.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBContext – Central JDBC connection factory.
 *
 * Connection parameters are read once from the static initialiser.
 * In a production environment you should externalise these values
 * into a context.xml resource or environment variables, rather than
 * hard-coding them here.
 *
 * Usage:
 *   try (Connection conn = DBContext.getConnection()) {
 *       // execute SQL …
 *   }
 */
public class DBContext {

    // ---------------------------------------------------------------
    // Connection parameters – update to match your SQL Server instance
    // ---------------------------------------------------------------
    private static final String DRIVER   = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String URL      = "jdbc:sqlserver://localhost:1433;"
                                         + "databaseName=CarRentalDB;"
                                         + "encrypt=true;"
                                         + "trustServerCertificate=true;";
    private static final String USERNAME = "sa";          // change as needed
    private static final String PASSWORD = "YourStrong!Passw0rd"; // change as needed

    // Load the driver once when the class is loaded
    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(
                "MS SQL Server JDBC Driver not found. " +
                "Add mssql-jdbc to pom.xml. Cause: " + e.getMessage()
            );
        }
    }

    // Prevent instantiation – this is a utility class
    private DBContext() {}

    /**
     * Opens and returns a new JDBC {@link Connection}.
     *
     * The caller is responsible for closing the connection.
     * Use try-with-resources for automatic cleanup:
     * <pre>
     *     try (Connection conn = DBContext.getConnection()) { … }
     * </pre>
     *
     * @return a new {@link Connection} to CarRentalDB
     * @throws SQLException if the connection cannot be established
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
