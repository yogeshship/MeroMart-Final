package com.meromart.controller.admin;

import com.meromart.dao.ContactDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// Shows customer contact messages to admin
@WebServlet("/admin/contacts")
public class AdminContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("activePage", "contacts");
        request.setAttribute("contacts", contactDAO.getAllContacts());

        request.getRequestDispatcher("/WEB-INF/pages/admin/manage-contacts.jsp").forward(request, response);
    }
}