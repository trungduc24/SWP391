package model;

import java.time.LocalDateTime;

public class Assignment {
    private int assignmentId;
    private int courseId;
    private String title;
    private String description;
    private LocalDateTime dueDate;
    private String type;
    private String courseName; // Thêm trường này để hiển thị tên khóa học trong JSP

    // Constructors
    public Assignment() {
    }

    public Assignment(int assignmentId, int courseId, String title, String description, LocalDateTime dueDate, String type) {
        this.assignmentId = assignmentId;
        this.courseId = courseId;
        this.title = title;
        this.description = description;
        this.dueDate = dueDate;
        this.type = type;
    }

    // Getters and Setters
    public int getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(int assignmentId) {
        this.assignmentId = assignmentId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDateTime getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDateTime dueDate) {
        this.dueDate = dueDate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    @Override
    public String toString() {
        return "Assignment{" +
               "assignmentId=" + assignmentId +
               ", courseId=" + courseId +
               ", title='" + title + '\'' +
               ", description='" + description + '\'' +
               ", dueDate=" + dueDate +
               ", type='" + type + '\'' +
               ", courseName='" + courseName + '\'' +
               '}';
    }
}