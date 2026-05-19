package com.meromart.controller.common;

import com.meromart.dao.ContactDAO;
import com.meromart.model.ContactModel;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Handles contact page display and contact form submission
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ContactDAO contactDAO;

    @Override
    public void init() {
        contactDAO = new ContactDAO();
    }

    // Opens the contact page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("activePage", "contact");
        request.getRequestDispatcher("/pages/common/contact.jsp").forward(request, response);
    }

    // Handles contact form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (isEmpty(name) || isEmpty(email) || isEmpty(subject) || isEmpty(message)) {
            request.setAttribute("activePage", "contact");
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/pages/common/contact.jsp").forward(request, response);
            return;
        }

        if (!email.contains("@") || !email.contains(".")) {
            request.setAttribute("activePage", "contact");
            request.setAttribute("errorMessage", "Please enter a valid email address.");
            request.getRequestDispatcher("/pages/common/contact.jsp").forward(request, response);
            return;
        }

        ContactModel contact = new ContactModel(
                name.trim(),
                email.trim(),
                subject.trim(),
                message.trim()
        );

        boolean result = contactDAO.saveContact(contact);

        request.setAttribute("activePage", "contact");

        if (result) {
            request.setAttribute("successMessage", "Message sent successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to send message. Please try again.");
        }

        request.getRequestDispatcher("/pages/common/contact.jsp").forward(request, response);
    }

    // Checks empty input
    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}