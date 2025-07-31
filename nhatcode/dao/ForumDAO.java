/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Forum;
import utils.DBConnection;

import java.sql.*;
import java.util.*;

public class ForumDAO {

    public List<Forum> getForumsByCourse(int courseId) throws SQLException {
        List<Forum> list = new ArrayList<>();
        String sql = "SELECT * FROM forums WHERE course_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Forum f = new Forum(
                    rs.getInt("forum_id"),
                    courseId,
                    rs.getString("title"),
                    rs.getInt("created_by"),
                    rs.getTimestamp("created_at")
                );
                list.add(f);
            }
        }
        return list;
    }

    public boolean createForum(Forum f) throws SQLException {
        String sql = "INSERT INTO forums (course_id, title, created_by) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, f.getCourseId());
            ps.setString(2, f.getTitle());
            ps.setInt(3, f.getCreatedBy());
            return ps.executeUpdate() > 0;
        }
    }
}