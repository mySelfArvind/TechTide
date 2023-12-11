package com.techtide.helpers;

import java.sql.*;

public class ConnectionProvider {

    private static Connection conn;

    public static Connection getConnection() {
        try {
            if (conn == null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/techtide";
                String userName = "root";
                String password = "root";
                conn = DriverManager.getConnection(url, userName, password);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
