/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import java.sql.*;
import java.util.*;

public class GradeDAO {
    public void addGrade(int assignmentId, int studentId, double score, String comment) throws Exception {
        String sql = "INSERT INTO grades (assignment_id, student_id, score, comment) VALUES (?, ?, ?, ?)";
        try (Connection conn = Database.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, assignmentId);
            ps.setInt(2, studentId);
            ps.setDouble(3, score);
            ps.setString(4, comment);
            ps.executeUpdate();
        }
    }
}