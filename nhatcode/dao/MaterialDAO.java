/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import model.Material;
import utils.DBConnection;

import java.sql.*;
import java.util.*;

public class MaterialDAO {

    public List<Material> getMaterialsByCourse(int courseId) throws SQLException {
        List<Material> list = new ArrayList<>();
        String sql = "SELECT * FROM course_materials WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Material m = new Material(
                    rs.getInt("material_id"),
                    courseId,
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("file_url"),
                    rs.getTimestamp("uploaded_at")
                );
                list.add(m);
            }
        }
        return list;
    }

    public boolean insertMaterial(Material m) throws SQLException {
        String sql = "INSERT INTO course_materials (course_id, title, description, file_url) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, m.getCourseId());
            ps.setString(2, m.getTitle());
            ps.setString(3, m.getDescription());
            ps.setString(4, m.getFileUrl());
            return ps.executeUpdate() > 0;
        }
    }
}