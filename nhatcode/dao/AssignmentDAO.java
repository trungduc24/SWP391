/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Assignment;
import utils.DBConnection;

import java.sql.*;
import java.util.*;

public class AssignmentDAO {

    // Lấy tất cả bài tập của một khóa học
    public List<Assignment> getAssignmentsByCourse(int courseId) throws SQLException {
        List<Assignment> list = new ArrayList<>();
        String sql = "SELECT * FROM assignments WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Assignment a = new Assignment(
                    rs.getInt("assignment_id"),
                    rs.getInt("course_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getTimestamp("due_date"),
                    rs.getString("type")
                );
                list.add(a);
            }
        }
        return list;
    }

    // Thêm bài tập mới
    public boolean insertAssignment(Assignment a) throws SQLException {
        String sql = "INSERT INTO assignments (course_id, title, description, due_date, type) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, a.getCourseId());
            ps.setString(2, a.getTitle());
            ps.setString(3, a.getDescription());
            ps.setTimestamp(4, new Timestamp(a.getDueDate().getTime()));
            ps.setString(5, a.getType());
            return ps.executeUpdate() > 0;
        }
    }

    // Lấy bài tập theo ID
    public Assignment getAssignmentById(int assignmentId) throws SQLException {
        String sql = "SELECT * FROM assignments WHERE assignment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Assignment(
                    rs.getInt("assignment_id"),
                    rs.getInt("course_id"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getTimestamp("due_date"),
                    rs.getString("type")
                );
            }
        }
        return null;
    }

    // Cập nhật bài tập
    public boolean updateAssignment(Assignment a) throws SQLException {
        String sql = "UPDATE assignments SET title = ?, description = ?, due_date = ?, type = ? WHERE assignment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, a.getTitle());
            ps.setString(2, a.getDescription());
            ps.setTimestamp(3, new Timestamp(a.getDueDate().getTime()));
            ps.setString(4, a.getType());
            ps.setInt(5, a.getId());
            return ps.executeUpdate() > 0;
        }
    }

    // Xóa bài tập
    public boolean deleteAssignment(int assignmentId) throws SQLException {
        String sql = "DELETE FROM assignments WHERE assignment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            return ps.executeUpdate() > 0;
        }
    }
}