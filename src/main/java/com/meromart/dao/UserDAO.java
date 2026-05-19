package com.meromart.dao;

import com.meromart.model.UserModel;
import com.meromart.util.DBConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("dd MMM yyyy");

    public List<UserModel> getAllUsers() {
        return searchUsers(null);
    }

    public List<UserModel> searchUsers(String query) {
        List<UserModel> users = new ArrayList<>();
        String sql = """
                SELECT user_id, full_name, email, phone, password, role, address, created_at
                FROM users
                WHERE (? IS NULL OR ? = '' OR full_name LIKE ? OR email LIKE ? OR role LIKE ?)
                ORDER BY created_at DESC, full_name ASC
                """;

        String keyword = query == null ? null : "%" + query.trim() + "%";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, query);
            ps.setString(2, query);
            ps.setString(3, keyword);
            ps.setString(4, keyword);
            ps.setString(5, keyword);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(mapUser(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return users;
    }

    public UserModel getUserById(int id) {
        String sql = "SELECT user_id, full_name, email, phone, password, role, address, created_at FROM users WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addUser(UserModel user) {
        String sql = "INSERT INTO users (full_name, email, phone, password, role, address) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            ps.setString(6, user.getAddress());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateUser(UserModel user) {
        String sql = "UPDATE users SET full_name = ?, email = ?, phone = ?, role = ?, address = ? WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getRole());
            ps.setString(5, user.getAddress());
            ps.setInt(6, user.getId());
            int rows = ps.executeUpdate();
            return rows > 0 || userExists(conn, user.getId());
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePassword(int userId, String hashedPassword) {
        String sql = "UPDATE users SET password = ? WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);
            int rows = ps.executeUpdate();
            return rows > 0 || userExists(conn, userId);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean emailExists(String email, Integer excludeId) {
        String sql = "SELECT COUNT(*) FROM users WHERE LOWER(email) = LOWER(?)"
                + (excludeId != null ? " AND user_id <> ?" : "");
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            if (excludeId != null) {
                ps.setInt(2, excludeId);
            }
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public UserModel getUserByEmailAndPassword(String email, String hashedPassword) {
        String sql = """
                SELECT user_id, full_name, email, phone, password, role, address, created_at
                FROM users
                WHERE LOWER(email) = LOWER(?) AND password = ?
                LIMIT 1
                """;
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, hashedPassword);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean hasAnyAdminUsers() {
        String sql = "SELECT COUNT(*) FROM users WHERE role = 'admin'";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private UserModel mapUser(ResultSet rs) throws Exception {
        UserModel user = new UserModel();
        user.setId(rs.getInt("user_id"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));
        user.setPhone(rs.getString("phone"));
        user.setPassword(rs.getString("password"));
        user.setRole(rs.getString("role"));
        user.setAddress(rs.getString("address"));
        user.setCreatedAt(formatTimestamp(rs.getTimestamp("created_at")));
        user.setInitials(buildInitials(user.getFullName()));
        user.setAccessClass("admin".equalsIgnoreCase(user.getRole()) ? "status-success" : "status-plain");
        user.setLastLogin("No login tracked");
        return user;
    }

    private boolean userExists(Connection conn, int userId) throws Exception {
        String sql = "SELECT COUNT(*) FROM users WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        }
    }

    private String formatTimestamp(Timestamp timestamp) {
        if (timestamp == null) {
            return "-";
        }
        return timestamp.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate()
                .format(DATE_FORMAT);
    }

    private String buildInitials(String fullName) {
        if (fullName == null || fullName.isBlank()) {
            return "NA";
        }

        String[] parts = fullName.trim().split("\\s+");
        StringBuilder initials = new StringBuilder();
        for (String part : parts) {
            if (!part.isBlank()) {
                initials.append(Character.toUpperCase(part.charAt(0)));
            }
            if (initials.length() == 2) {
                break;
            }
        }

        if (initials.length() == 1 && fullName.length() > 1) {
            initials.append(Character.toUpperCase(fullName.charAt(1)));
        }

        return initials.toString();
    }
}
