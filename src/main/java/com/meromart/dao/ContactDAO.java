package com.meromart.dao;

import com.meromart.model.ContactModel;
import com.meromart.util.DBConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;

// DAO class for contact form database operation
public class ContactDAO {

    // Saves contact form data into contact_messages table
    public boolean saveContact(ContactModel contact) {
        boolean status = false;

        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";

        try (
            Connection conn = DBConfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, contact.getName());
            ps.setString(2, contact.getEmail());
            ps.setString(3, contact.getSubject());
            ps.setString(4, contact.getMessage());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}