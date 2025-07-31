package model;

public class Student {
    private int studentId;
    private int userId;
    private String fullName;
    private String studentCode;
    private String email;
    private String avatarUrl;

    public Student() {}

    public Student(int studentId, int userId, String fullName, String studentCode, String email, String avatarUrl) {
        this.studentId = studentId;
        this.userId = userId;
        this.fullName = fullName;
        this.studentCode = studentCode;
        this.email = email;
        this.avatarUrl = avatarUrl;
    }

    // Getter and Setter
    public int getStudentId() {
        return studentId;
    }
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getFullName() {
        return fullName;
    }
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    public String getStudentCode() {
        return studentCode;
    }
    public void setStudentCode(String studentCode) {
        this.studentCode = studentCode;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getAvatarUrl() {
        return avatarUrl;
    }
    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }
}
