package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Assignment;
import utils.DBConnection;

public class AssignmentDAO {

    public List<Assignment> getAllAssignments() {
        List<Assignment> assignments = new ArrayList<>();
        String sql = "SELECT a.assignment_id, a.course_id, a.title, a.description, a.due_date, a.type, c.name AS course_name " +
                     "FROM assignments a " +
                     "JOIN courses c ON a.course_id = c.course_id " +
                     "ORDER BY a.due_date DESC"; // Sắp xếp theo ngày đến hạn mới nhất lên trước

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Assignment assignment = new Assignment();
                assignment.setAssignmentId(rs.getInt("assignment_id"));
                assignment.setCourseId(rs.getInt("course_id"));
                assignment.setTitle(rs.getString("title"));
                assignment.setDescription(rs.getString("description"));
                
                // Chuyển đổi Timestamp sang LocalDateTime
                Timestamp timestamp = rs.getTimestamp("due_date");
                if (timestamp != null) {
                    assignment.setDueDate(timestamp.toLocalDateTime());
                }
                
                assignment.setType(rs.getString("type"));
                assignment.setCourseName(rs.getString("course_name")); // Lấy tên khóa học
                assignments.add(assignment);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all assignments: " + e.getMessage());
            e.printStackTrace();
        }
        return assignments;
    }

    public boolean createAssignment(Assignment assignment) {
        String sql = "INSERT INTO assignments (course_id, title, description, due_date, type) VALUES (?, ?, ?, ?, ?)";
        boolean rowAffected = false;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, assignment.getCourseId());
            pstmt.setString(2, assignment.getTitle());
            pstmt.setString(3, assignment.getDescription());
            
            // Chuyển đổi LocalDateTime sang Timestamp để lưu vào CSDL
            if (assignment.getDueDate() != null) {
                pstmt.setTimestamp(4, Timestamp.valueOf(assignment.getDueDate()));
            } else {
                pstmt.setNull(4, java.sql.Types.TIMESTAMP);
            }
            
            pstmt.setString(5, assignment.getType());

            int rows = pstmt.executeUpdate();
            rowAffected = rows > 0;

        } catch (SQLException e) {
            System.err.println("Error creating assignment: " + e.getMessage());
            e.printStackTrace();
        }
        return rowAffected;
    }
}