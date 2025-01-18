<%-- 
    Document   : userDashboard
    Created on : 23 Nov, 2024
    Author     : Shiva
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    // Get session
    HttpSession session1 = request.getSession(false);
    if (session1 == null || session1.getAttribute("userId") == null) {
        response.sendRedirect("BeforeLogin.jsp"); // Redirect to login page
    }

    // Retrieve user details from session
    String userName = (String) session1.getAttribute("userName");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b); /* Gradient background */
            margin: 0;
            padding: 0;
            color: #333;
        }

        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #ff5722;
            color: white;
            padding: 15px 20px;
        }

        .dashboard-header h1 {
            margin: 0;
            font-size: 1.5rem;
        }

        .logout-btn {
            color: white;
            text-decoration: none;
            font-weight: bold;
            background: #e64a19;
            padding: 8px 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background: #ff3d00;
        }

        .dashboard-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            padding: 20px;
        }

        .dashboard-card {
            background: white;
            margin: 10px;
            width: 250px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
            padding: 20px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .dashboard-card:hover {
            transform: scale(1.05);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        .dashboard-card i {
            font-size: 2.5rem;
            color: #ff5722;
            margin-bottom: 10px;
        }

        .dashboard-card h2 {
            font-size: 1.2rem;
            margin: 10px 0;
            color: #333;
        }

        .dashboard-card p {
            font-size: 0.9rem;
            color: #666;
            margin-bottom: 15px;
        }

        .dashboard-card a {
            display: inline-block;
            text-decoration: none;
            color: white;
            background: #ff7e5f;
            padding: 10px 15px;
            border-radius: 20px;
            transition: all 0.3s ease;
        }

        .dashboard-card a:hover {
            background: #feb47b;
        }
    </style>
</head>
<body>
    <div class="dashboard-header">
        <h1>Welcome, <%= userName %>!</h1>
        <a href="logout.jsp" class="logout-btn">Logout</a>
    </div>
    <div class="dashboard-container">
        <!-- Card 1: Manage Bookings -->
        <div class="dashboard-card">
            <i class="fas fa-calendar-alt"></i>
            <h2>Manage Bookings</h2>
            <p>View and manage all your event bookings in one place.</p>
            <a href="manageBookings.jsp">Go to Bookings</a>
        </div>

        <!-- Card 2: Explore Events -->
        <div class="dashboard-card">
            <i class="fas fa-search"></i>
            <h2>Explore Events</h2>
            <p>Discover upcoming events and book your spot today!</p>
            <a href="exploreEvent.jsp">Explore Now</a>
        </div>

        <!-- Card 3: Update Profile -->
        <div class="dashboard-card">
            <i class="fas fa-user"></i>
            <h2>My Profile</h2>
            <p>Update your personal details and contact information.</p>
            <a href="profile.jsp">View Profile</a>
        </div>

        <!-- Card 4: Feedback -->
        <div class="dashboard-card">
            <i class="fas fa-comment-alt"></i>
            <h2>Feedback</h2>
            <p>Share your thoughts and suggestions with us.</p>
            <a href="feedback.jsp">Give Feedback</a>
        </div>
    </div>
</body>
</html>
