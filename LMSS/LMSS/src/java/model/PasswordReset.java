package model;

import java.sql.Timestamp;

public class PasswordReset {
    private int resetId;
    private int userId;
    private String token;
    private Timestamp createdAt;
    private boolean isUsed;

    // Constructor đầy đủ
    public PasswordReset(int resetId, int userId, String token, Timestamp createdAt, boolean isUsed) {
        this.resetId = resetId;
        this.userId = userId;
        this.token = token;
        this.createdAt = createdAt;
        this.isUsed = isUsed;
    }

    // Constructor không có resetId và createdAt (thường dùng khi tạo token mới)
    public PasswordReset(int userId, String token) {
        this.userId = userId;
        this.token = token;
        this.isUsed = false;  // Mặc định token mới chưa dùng
    }

    // Constructor mặc định (nếu cần)
    public PasswordReset() {
    }

    // Getter & Setter
    public int getResetId() {
        return resetId;
    }

    public void setResetId(int resetId) {
        this.resetId = resetId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    // Với boolean thường dùng tên get hoặc is đều được, giữ nguyên isUsed() cho chuẩn JavaBean
    public boolean isUsed() {
        return isUsed;
    }

    public void setUsed(boolean isUsed) {
        this.isUsed = isUsed;
    }

    @Override
    public String toString() {
        return "PasswordReset{" +
                "resetId=" + resetId +
                ", userId=" + userId +
                ", token='" + token + '\'' +
                ", createdAt=" + createdAt +
                ", isUsed=" + isUsed +
                '}';
    }
}
