package dao;

import model.User;
import utils.BCryptUtil;

import java.sql.*;
import java.time.LocalDateTime;

public class UsersDAO {
    private final Connection conn;

    public UsersDAO(Connection conn) {
        this.conn = conn;
    }

    // Kiểm tra email đã tồn tại chưa
    public boolean isEmailExists(String email) throws SQLException {
        String sql = "SELECT 1 FROM users WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Lấy User theo username
    public User getUserByUsername(String username) throws SQLException {
        String sql = "SELECT user_id, username, password, role, email, avatar_url, email_verified FROM users WHERE username = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getString("avatar_url"),
                        rs.getBoolean("email_verified")
                    );
                }
            }
        }
        return null;
    }

    // Lấy User theo email
    public User getUserByEmail(String email) throws SQLException {
        String sql = "SELECT user_id, username, password, role, email, avatar_url, email_verified FROM users WHERE email = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getString("avatar_url"),
                        rs.getBoolean("email_verified")
                    );
                }
            }
        }
        return null;
    }

    // Lấy User theo token xác thực email
    public User getUserByVerificationToken(String token) throws SQLException {
        String sql = "SELECT user_id, username, password, role, email, avatar_url, email_verified FROM users WHERE email_verification_token = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getString("email"),
                        rs.getString("avatar_url"),
                        rs.getBoolean("email_verified")
                    );
                }
            }
        }
        return null;
    }

    // Đăng ký user mới (mật khẩu đã được mã hóa trước khi gọi hàm này)
    public boolean registerUserWithToken(String username, String hashedPassword, String role, String email, String avatarUrl, String token) throws SQLException {
        String sql = "INSERT INTO users (username, password, role, email, avatar_url, email_verified, email_verification_token) " +
                     "VALUES (?, ?, ?, ?, ?, 0, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, hashedPassword);
            stmt.setString(3, role);
            stmt.setString(4, email);
            stmt.setString(5, avatarUrl);
            stmt.setString(6, token);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    // Cập nhật trạng thái xác thực email
    public boolean verifyEmail(String token) throws SQLException {
        String sql = "UPDATE users SET email_verified = 1, email_verification_token = NULL WHERE email_verification_token = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    // Kiểm tra đăng nhập (username + password)
    public User checkLogin(String username, String password) throws SQLException {
        User user = getUserByUsername(username);
        if (user != null) {
            // So sánh mật khẩu nhập vào với mật khẩu đã hash
            if (BCryptUtil.checkPassword(password, user.getPassword())) {
                if (user.isEmailVerified()) {
                    return user;
                } else {
                    throw new SQLException("Email chưa được xác thực.");
                }
            }
        }
        return null;
    }

    // Lưu token reset password vào bảng password_resets
    public boolean savePasswordResetToken(int userId, String token) throws SQLException {
        String sql = "INSERT INTO password_resets (user_id, token) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setString(2, token);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    // Lấy User theo token reset password, kiểm tra token chưa bị dùng và còn hiệu lực (15 phút)
    public User getUserByResetToken(String token) throws SQLException {
        String sql = "SELECT u.user_id, u.username, u.password, u.role, u.email, u.avatar_url, u.email_verified, pr.created_at, pr.is_used " +
                     "FROM users u JOIN password_resets pr ON u.user_id = pr.user_id " +
                     "WHERE pr.token = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Timestamp createdAt = rs.getTimestamp("created_at");
                    boolean isUsed = rs.getBoolean("is_used");
                    if (!isUsed && createdAt != null) {
                        LocalDateTime createdTime = createdAt.toLocalDateTime();
                        LocalDateTime expiryTime = createdTime.plusMinutes(15);
                        if (expiryTime.isAfter(LocalDateTime.now())) {
                            return new User(
                                rs.getInt("user_id"),
                                rs.getString("username"),
                                rs.getString("password"),
                                rs.getString("role"),
                                rs.getString("email"),
                                rs.getString("avatar_url"),
                                rs.getBoolean("email_verified")
                            );
                        }
                    }
                }
            }
        }
        return null;
    }

    // Đánh dấu token reset password đã dùng
    public boolean markTokenAsUsed(String token) throws SQLException {
        String sql = "UPDATE password_resets SET is_used = 1 WHERE token = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    // Cập nhật mật khẩu mới (hash đã được tạo sẵn)
    public boolean updatePassword(int userId, String hashedPassword) throws SQLException {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hashedPassword);
            stmt.setInt(2, userId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }
}
