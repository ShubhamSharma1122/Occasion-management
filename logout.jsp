<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    // Get the current session
    HttpSession session1 = request.getSession(false);
    
    if (session1 != null) {
        session1.invalidate();  // Invalidate the session to log out the user
    }
    
    // Redirect the user to the homepage (index.jsp or your preferred page)
    response.sendRedirect("StartHomePage.html");  // Change "index.jsp" to your actual home page if needed
%>
