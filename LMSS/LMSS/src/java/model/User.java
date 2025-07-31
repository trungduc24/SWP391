package model;

public class User {
    private int userId;
    private String username;
    private String password;
    private String role;
    private String email;
    private String avatarUrl;
    private boolean emailVerified;   // thêm trường mới
    private String emailVerificationToken; // nếu bạn cần dùng (có thể bỏ nếu chưa cần)

    // Constructor đầy đủ
    public User(int userId, String username, String password, String role, String email, String avatarUrl, boolean emailVerified) {
        this.userId = userId;
        this.username = username;
        this.password = password;
        this.role = role;
        this.email = email;
        this.avatarUrl = avatarUrl;
        this.emailVerified = emailVerified;
    }

    // Constructor có thêm token (nếu bạn cần)
    public User(int userId, String username, String password, String role, String email, String avatarUrl, boolean emailVerified, String emailVerificationToken) {
        this(userId, username, password, role, email, avatarUrl, emailVerified);
        this.emailVerificationToken = emailVerificationToken;
    }

    // Constructor không có userId (thường dùng khi tạo mới)
    public User(String username, String password, String role, String email, String avatarUrl) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.email = email;
        this.avatarUrl = avatarUrl;
        this.emailVerified = false;  // mặc định false
    }

    // Getter & Setter
    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;
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

    public boolean isEmailVerified() {
        return emailVerified;
    }
    public void setEmailVerified(boolean emailVerified) {
        this.emailVerified = emailVerified;
    }

    public String getEmailVerificationToken() {
        return emailVerificationToken;
    }
    public void setEmailVerificationToken(String emailVerificationToken) {
        this.emailVerificationToken = emailVerificationToken;
    }
}
