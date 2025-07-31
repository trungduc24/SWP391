package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Student;
import utils.DBConnection;  // Bạn cần tạo class DBConnection để kết nối DB

public class StudentDAO {
    public List<Student> getStudentsByCourse(int courseId) throws SQLException {
    List<Student> list = new ArrayList<>();
    String sql = """
        SELECT s.* FROM students s
        JOIN enrollments e ON s.student_id = e.student_id
        WHERE e.course_id = ?
    """;
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, courseId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Student s = new Student(
                rs.getInt("student_id"),
                rs.getInt("user_id"),
                rs.getString("full_name"),
                rs.getString("student_code"),
                rs.getString("email"),
                rs.getString("avatar_url")
            );
            list.add(s);
        }
    }
    return list;
}

    // Thêm student mới
    public boolean insertStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (user_id, full_name, student_code, email, avatar_url) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, student.getUserId());
            ps.setString(2, student.getFullName());
            ps.setString(3, student.getStudentCode());
            ps.setString(4, student.getEmail());
            ps.setString(5, student.getAvatarUrl());
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    // Cập nhật thông tin student
    public boolean updateStudent(Student student) throws SQLException {
        String sql = "UPDATE students SET full_name = ?, student_code = ?, email = ?, avatar_url = ? WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, student.getFullName());
            ps.setString(2, student.getStudentCode());
            ps.setString(3, student.getEmail());
            ps.setString(4, student.getAvatarUrl());
            ps.setInt(5, student.getStudentId());
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    // Xóa student theo student_id
    public boolean deleteStudent(int studentId) throws SQLException {
        String sql = "DELETE FROM students WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            int rows = ps.executeUpdate();
            return rows > 0;
        }
    }

    // Lấy student theo student_id
    public Student getStudentById(int studentId) throws SQLException {
        String sql = "SELECT * FROM students WHERE student_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Student s = new Student();
                    s.setStudentId(rs.getInt("student_id"));
                    s.setUserId(rs.getInt("user_id"));
                    s.setFullName(rs.getString("full_name"));
                    s.setStudentCode(rs.getString("student_code"));
                    s.setEmail(rs.getString("email"));
                    s.setAvatarUrl(rs.getString("avatar_url"));
                    return s;
                }
            }
        }
        return null;
    }

    // Lấy danh sách tất cả student
    public List<Student> getAllStudents() throws SQLException {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT * FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Student s = new Student();
                s.setStudentId(rs.getInt("student_id"));
                s.setUserId(rs.getInt("user_id"));
                s.setFullName(rs.getString("full_name"));
                s.setStudentCode(rs.getString("student_code"));
                s.setEmail(rs.getString("email"));
                s.setAvatarUrl(rs.getString("avatar_url"));
                list.add(s);
            }
        }
        return list;
    }
}
