package com.meromart.controller.admin;

import com.meromart.util.AdminViewDataFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admindashboard")
public class AdminDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("activePage", "dashboard");
		request.setAttribute("dashboardStats", AdminViewDataFactory.dashboardStats());
		request.setAttribute("salesOverviewCards", AdminViewDataFactory.salesOverviewCards());
		request.setAttribute("salesChartPoints", AdminViewDataFactory.salesChartPoints());
		request.setAttribute("quickInsights", AdminViewDataFactory.quickInsights());
		request.setAttribute("stockSegments", AdminViewDataFactory.stockSegments());
		request.setAttribute("latestActivities", AdminViewDataFactory.latestActivities());
		request.setAttribute("recentProducts", AdminViewDataFactory.recentProducts());
		request.getRequestDispatcher("/pages/admin/admin-dashboard.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
