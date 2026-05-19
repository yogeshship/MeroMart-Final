package com.meromart.model;

public class UserModel {
    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String role;
    private String address;
    private String createdAt;
    private String initials;
    private String accessClass;
    private String lastLogin;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }

    public String getInitials() { return initials; }
    public void setInitials(String initials) { this.initials = initials; }

    public String getAccessClass() { return accessClass; }
    public void setAccessClass(String accessClass) { this.accessClass = accessClass; }

    public String getLastLogin() { return lastLogin; }
    public void setLastLogin(String lastLogin) { this.lastLogin = lastLogin; }

    public String getDisplayRole() {
        if (role == null || role.isBlank()) {
            return "User";
        }
        return Character.toUpperCase(role.charAt(0)) + role.substring(1);
    }

    public boolean isAdmin() {
        return role != null && role.equalsIgnoreCase("admin");
    }
}
