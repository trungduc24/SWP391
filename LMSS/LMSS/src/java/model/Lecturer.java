package model;

public class Lecturer {
    private int lecturerId;
    private int userId;
    private String fullName;
    private String lecturerCode;
    private String email;
    private String avatarUrl;

    public Lecturer() {}

    public Lecturer(int lecturerId, int userId, String fullName, String lecturerCode, String email, String avatarUrl) {
        this.lecturerId = lecturerId;
        this.userId = userId;
        this.fullName = fullName;
        this.lecturerCode = lecturerCode;
        this.email = email;
        this.avatarUrl = avatarUrl;
    }

    // Getter và Setter
    public int getLecturerId() {
        return lecturerId;
    }

    public void setLecturerId(int lecturerId) {
        this.lecturerId = lecturerId;
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

    public String getLecturerCode() {
        return lecturerCode;
    }

    public void setLecturerCode(String lecturerCode) {
        this.lecturerCode = lecturerCode;
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
