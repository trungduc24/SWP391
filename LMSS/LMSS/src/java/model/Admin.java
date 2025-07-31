package model;

public class Admin {
    private int adminId;
    private int userId;
    private String fullName;
    private String email;
    private String avatarUrl;

    public Admin() {}

    public Admin(int adminId, int userId, String fullName, String email, String avatarUrl) {
        this.adminId = adminId;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.avatarUrl = avatarUrl;
    }

    // Getter và Setter
    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
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
