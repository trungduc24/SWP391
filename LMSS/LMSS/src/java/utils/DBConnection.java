package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnection {
    private static final String USER = "sa";
    private static final String PASSWORD = "123";
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=LMS_System;encrypt=false;trustServerCertificate=true";

    private static Connection connection = null;

    // Trả về connection dùng chung
    public static Connection getConnection() {
        if (connection == null) {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, "Lỗi kết nối CSDL", ex);
            }
        }
        return connection;
    }

    // Đóng connection khi cần (không dùng nhiều trong web app nhưng hỗ trợ cho test/unit test)
    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
            } catch (SQLException ex) {
                Logger.getLogger(DBConnection.class.getName()).log(Level.SEVERE, "Lỗi đóng connection", ex);
            }
        }
    }

    // Hàm main để test kết nối
    public static void main(String[] args) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            System.out.println("✅ Kết nối CSDL thành công!");
        } else {
            System.out.println("❌ Kết nối thất bại!");
        }
    }
}
