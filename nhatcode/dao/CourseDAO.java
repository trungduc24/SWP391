package dao;

import model.Course;


import java.sql.*;
import java.util.*;

public class CourseDAO {
    public List<Course> getCoursesByLecturer(int lecturerId) throws Exception {
        List<Course> list = new ArrayList<>();
        try (Connection conn = Database.getConnection()) {
            String sql = "SELECT * FROM courses WHERE lecturer_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, lecturerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course c = new Course(rs.getInt("course_id"), rs.getString("name"),
                        rs.getString("code"), rs.getString("room"));
                list.add(c);
            }
        }
        return list;
    }

}
