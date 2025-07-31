/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import model.Semester;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SemesterDAO {
    private Connection conn;

    public SemesterDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean createSemester(Semester s) throws SQLException {
        String sql = "INSERT INTO semesters (name, start_date, end_date) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, s.getName());
        ps.setDate(2, Date.valueOf(s.getStartDate()));
        ps.setDate(3, Date.valueOf(s.getEndDate()));
        return ps.executeUpdate() > 0;
    }

    public boolean deleteSemester(int id) throws SQLException {
        String sql = "DELETE FROM semesters WHERE semester_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, id);
        return ps.executeUpdate() > 0;
    }

    public List<Semester> getAll() throws SQLException {
        String sql = "SELECT * FROM semesters ORDER BY start_date DESC";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        List<Semester> list = new ArrayList<>();
        while (rs.next()) {
            list.add(new Semester(
                                rs.getString("name"),
                rs.getDate("start_date").toString(),
                rs.getDate("end_date").toString()
            ));
        }
        return list;
    }
}