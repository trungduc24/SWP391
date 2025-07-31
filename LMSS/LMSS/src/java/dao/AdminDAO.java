package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Admin;
import utils.DBConnection;

public class AdminDAO {

    // Thêm admin mới
    public boolean insertAdmin(Admin admin) throws SQLException {
        String sql = "INSERT INTO admins (user_id, full_name, email, avatar_url) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, admin.getUserId());
            ps.setString(2, admin.getFullName());
            ps.setString(3, admin.getEmail());
            ps.setString(4, admin.getAvatarUrl());
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    // Cập nhật thông tin admin
    public boolean updateAdmin(Admin admin) throws SQLException {
        String sql = "UPDATE admins SET full_name = ?, email = ?, avatar_url = ? WHERE admin_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, admin.getFullName());
            ps.setString(2, admin.getEmail());
            ps.setString(3, admin.getAvatarUrl());
            ps.setInt(4, admin.getAdminId());
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    // Xóa admin theo admin_id
    public boolean deleteAdmin(int adminId) throws SQLException {
        String sql = "DELETE FROM admins WHERE admin_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    // Lấy admin theo admin_id
    public Admin getAdminById(int adminId) throws SQLException {
        String sql = "SELECT * FROM admins WHERE admin_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, adminId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Admin a = new Admin();
                    a.setAdminId(rs.getInt("admin_id"));
                    a.setUserId(rs.getInt("user_id"));
                    a.setFullName(rs.getString("full_name"));
                    a.setEmail(rs.getString("email"));
                    a.setAvatarUrl(rs.getString("avatar_url"));
                    return a;
                }
            }
        }
        return null;
    }

    // Lấy danh sách tất cả admin
    public List<Admin> getAllAdmins() throws SQLException {
        List<Admin> list = new ArrayList<>();
        String sql = "SELECT * FROM admins";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Admin a = new Admin();
                a.setAdminId(rs.getInt("admin_id"));
                a.setUserId(rs.getInt("user_id"));
                a.setFullName(rs.getString("full_name"));
                a.setEmail(rs.getString("email"));
                a.setAvatarUrl(rs.getString("avatar_url"));
                list.add(a);
            }
        }
        return list;
    }
}
