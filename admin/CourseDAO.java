package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Course;
import utils.DBConnection;

public class CourseDAO {

    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT course_id, name, code FROM courses ORDER BY name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setName(rs.getString("name"));
                course.setCode(rs.getString("code"));
                courses.add(course);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all courses: " + e.getMessage());
            e.printStackTrace();
        }
        return courses;
    }
}