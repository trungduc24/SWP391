/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Attendance {
    private int id;
    private int studentId;
    private int courseId;
    private int sessionNumber;
    private String status; // present, absent, late
    private Date date;

    public Attendance() {}

    public Attendance(int id, int studentId, int courseId, int sessionNumber, String status, Date date) {
        this.id = id;
        this.studentId = studentId;
        this.courseId = courseId;
        this.sessionNumber = sessionNumber;
        this.status = status;
        this.date = date;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getCourseId() { return courseId; }
    public void setCourseId(int courseId) { this.courseId = courseId; }

    public int getSessionNumber() { return sessionNumber; }
    public void setSessionNumber(int sessionNumber) { this.sessionNumber = sessionNumber; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
}