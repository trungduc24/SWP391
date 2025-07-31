package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Lecturer;
import utils.DBConnection;

public class LecturerDAO {

    // Thêm lecturer mới
    public boolean insertLecturer(Lecturer lecturer) throws SQLException {
        String sql = "INSERT INTO lecturers (user_id, full_name, lecturer_code, email, avatar_url) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lecturer.getUserId());
            ps.setString(2, lecturer.getFullName());
            ps.setString(3, lecturer.getLecturerCode());
            ps.setString(4, lecturer.getEmail());
            ps.setString(5, lecturer.getAvatarUrl());
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    // Cập nhật thông tin lecturer
    public boolean updateLecturer(Lecturer lecturer) throws SQLException {
        String sql = "UPDATE lecturers SET full_name = ?, lecturer_code = ?, email = ?, avatar_url = ? WHERE lecturer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, lecturer.getFullName());
            ps.setString(2, lecturer.getLecturerCode());
            ps.setString(3, lecturer.getEmail());
            ps.setString(4, lecturer.getAvatarUrl());
            ps.setInt(5, lecturer.getLecturerId());
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    // Xóa lecturer theo lecturer_id
    public boolean deleteLecturer(int lecturerId) throws SQLException {
        String sql = "DELETE FROM lecturers WHERE lecturer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lecturerId);
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    // Lấy lecturer theo lecturer_id
    public Lecturer getLecturerById(int lecturerId) throws SQLException {
        String sql = "SELECT * FROM lecturers WHERE lecturer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, lecturerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Lecturer l = new Lecturer();
                    l.setLecturerId(rs.getInt("lecturer_id"));
                    l.setUserId(rs.getInt("user_id"));
                    l.setFullName(rs.getString("full_name"));
                    l.setLecturerCode(rs.getString("lecturer_code"));
                    l.setEmail(rs.getString("email"));
                    l.setAvatarUrl(rs.getString("avatar_url"));
                    return l;
                }
            }
        }
        return null;
    }

    // Lấy danh sách tất cả lecturer
    public List<Lecturer> getAllLecturers() throws SQLException {
        List<Lecturer> list = new ArrayList<>();
        String sql = "SELECT * FROM lecturers";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Lecturer l = new Lecturer();
                l.setLecturerId(rs.getInt("lecturer_id"));
                l.setUserId(rs.getInt("user_id"));
                l.setFullName(rs.getString("full_name"));
                l.setLecturerCode(rs.getString("lecturer_code"));
                l.setEmail(rs.getString("email"));
                l.setAvatarUrl(rs.getString("avatar_url"));
                list.add(l);
            }
        }
        return list;
    }
}
