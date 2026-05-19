package com.meromart.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {

    // Keeping YOUR database name exactly as it is!
    private static final String URL = "jdbc:mysql://localhost:3306/mero_mart_db";
    private static final String USER = "root";
    private static final String PASSWORD = "";

    private DBConfig() {
    }

    public static Connection getConnection() throws SQLException {
        try {
            // This line simply ensures Tomcat knows which MySQL driver to use
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("MySQL Driver not found! Make sure you added the connector dependency.");
        }
        
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}