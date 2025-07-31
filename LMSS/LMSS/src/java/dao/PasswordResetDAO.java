package dao;

import java.sql.*;
import model.PasswordReset;
import utils.DBConnection;

public class PasswordResetDAO {
    private final Connection conn;

    public PasswordResetDAO() {
        this.conn = DBConnection.getConnection();
    }

    // Thêm token mới (is_used mặc định 0, created_at do DB set)
    public boolean insertToken(PasswordReset token) throws SQLException {
        String sql = "INSERT INTO password_resets(user_id, token) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, token.getUserId());
            ps.setString(2, token.getToken());
            int affected = ps.executeUpdate();
            if (affected == 1) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        token.setResetId(rs.getInt(1));
                    }
                }
                return true;
            }
        }
        return false;
    }

    // Lấy token chưa dùng (is_used = 0)
    public PasswordReset getActiveToken(String token) throws SQLException {
        String sql = "SELECT reset_id, user_id, token, created_at, is_used FROM password_resets WHERE token = ? AND is_used = 0";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PasswordReset(
                        rs.getInt("reset_id"),
                        rs.getInt("user_id"),
                        rs.getString("token"),
                        rs.getTimestamp("created_at"),
                        rs.getBoolean("is_used")
                    );
                }
            }
        }
        return null;
    }

    // Đánh dấu token đã sử dụng (is_used = 1)
    public boolean markTokenUsed(int resetId) throws SQLException {
        String sql = "UPDATE password_resets SET is_used = 1 WHERE reset_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resetId);
            return ps.executeUpdate() == 1;
        }
    }

    // Xóa token theo reset_id
    public boolean deleteToken(int resetId) throws SQLException {
        String sql = "DELETE FROM password_resets WHERE reset_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, resetId);
            return ps.executeUpdate() == 1;
        }
    }

    // Xóa các token cũ (tạo trước expiryDate) hoặc đã dùng (is_used = 1)
    public int deleteExpiredTokens(Timestamp expiryDate) throws SQLException {
        String sql = "DELETE FROM password_resets WHERE created_at < ? OR is_used = 1";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setTimestamp(1, expiryDate);
            return ps.executeUpdate();
        }
    }
}
