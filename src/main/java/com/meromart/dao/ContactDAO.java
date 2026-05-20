package com.meromart.dao;

import com.meromart.model.ContactModel;
import com.meromart.util.DBConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

// DAO class for contact form database operations
public class ContactDAO {

    // Saves contact form data into contact_messages table
    public boolean saveContact(ContactModel contact) {
        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";

        try (
            Connection conn = DBConfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, contact.getName());
            ps.setString(2, contact.getEmail());
            ps.setString(3, contact.getSubject());
            ps.setString(4, contact.getMessage());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Gets all contact messages for admin side
    public List<ContactModel> getAllContacts() {
        List<ContactModel> contacts = new ArrayList<>();

        String sql = "SELECT message_id, name, email, subject, message, submitted_at "
                   + "FROM contact_messages "
                   + "ORDER BY message_id DESC";

        try (
            Connection conn = DBConfig.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                ContactModel contact = new ContactModel();

                contact.setId(rs.getInt("message_id"));
                contact.setName(rs.getString("name"));
                contact.setEmail(rs.getString("email"));
                contact.setSubject(rs.getString("subject"));
                contact.setMessage(rs.getString("message"));
                contact.setCreatedAt(rs.getString("submitted_at"));

                contacts.add(contact);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return contacts;
    }
}