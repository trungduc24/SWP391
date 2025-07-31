/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class Grade { private int id;
    private int studentId;
    private int assignmentId;
    private double score;
    private String comment;

    public Grade() {}

    public Grade(int id, int studentId, int assignmentId, double score, String comment) {
        this.id = id;
        this.studentId = studentId;
        this.assignmentId = assignmentId;
        this.score = score;
        this.comment = comment;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getAssignmentId() { return assignmentId; }
    public void setAssignmentId(int assignmentId) { this.assignmentId = assignmentId; }

    public double getScore() { return score; }
    public void setScore(double score) { this.score = score; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
}