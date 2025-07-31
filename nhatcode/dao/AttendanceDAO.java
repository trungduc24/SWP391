/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Attendance;
import utils.DBConnection;

import java.sql.*;
import java.util.*;

public class AttendanceDAO {

    public List<Attendance> getAttendanceByCourse(int courseId) throws SQLException {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Attendance a = new Attendance(
                    rs.getInt("attendance_id"),
                    rs.getInt("student_id"),
                    courseId,
                    rs.getInt("session_number"),
                    rs.getString("status"),
                    rs.getDate("date")
                );
                list.add(a);
            }
        }
        return list;
    }

    public boolean insertAttendance(Attendance a) throws SQLException {
        String sql = "INSERT INTO attendance (student_id, course_id, session_number, status, date) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, a.getStudentId());
            ps.setInt(2, a.getCourseId());
            ps.setInt(3, a.getSessionNumber());
            ps.setString(4, a.getStatus());
            ps.setDate(5, new java.sql.Date(a.getDate().getTime()));
            return ps.executeUpdate() > 0;
        }
    }
}