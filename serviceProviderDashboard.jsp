<%-- 
    Document   : serviceProviderDashboard
    Created on : 23 Nov, 2024, 2:41:56 PM
    Author     : Shiva
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    HttpSession session1 = request.getSession(false); // Prevent creating a new session
    if (session1 == null || session1.getAttribute("userId") == null) {
        response.sendRedirect("BeforeLogin.jsp"); // Redirect to login page
    }

    String providerName = (String) session1.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Service Provider Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Global Styles */
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b); /* Orange-Pink Gradient */
            margin: 0;
            padding: 0;
            color: #333; /* Darker text for visibility */
        }

        .dashboard-container {
            max-width: 1200px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.8); /* Lightened semi-transparent white */
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            overflow: hidden;
        }

        /* Header */
        header {
            background: rgba(255, 94, 58, 0.9); /* Matching orange color */
            padding: 20px;
            text-align: center;
            color: white;
        }

        header h1 {
            margin: 0;
            font-size: 2.5rem;
        }

        header .logout-btn {
            text-decoration: none;
            background: rgba(255, 75, 43, 0.9); /* Darker orange button */
            color: white;
            padding: 10px 20px;
            border-radius: 20px;
            font-size: 1rem;
            transition: all 0.3s ease;
            position: absolute;
            top: 20px;
            right: 20px;
        }

        header .logout-btn:hover {
            background: rgba(255, 50, 20, 0.9);
        }

        /* Dashboard Content */
        section {
            padding: 20px;
            text-align: center;
        }

        section h2 {
            font-size: 2rem;
            margin-bottom: 20px;
            color: #ff5722; /* Bright orange for headings */
        }

        /* Cards */
        .card-container {
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 30px;
        }

        .card {
            background: rgba(255, 255, 255, 0.9); /* Lighter card background for readability */
            width: 300px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
            text-align: center;
            padding: 20px;
            color: #333; /* Darker text */
        }

        .card:hover {
            transform: translateY(-10px);
        }

        .card i {
            font-size: 3rem;
            color: #ff7e5f; /* Matching orange shade for icons */
            margin-bottom: 15px;
        }

        .card h3 {
            font-size: 1.5rem;
            margin: 10px 0;
        }

        .card p {
            font-size: 1rem;
            color: #666; /* Slightly darker paragraph text */
        }

        .card a {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            color: white;
            background: #ff7e5f; /* Orange button */
            padding: 10px 20px;
            border-radius: 20px;
            transition: all 0.3s ease;
            font-weight: bold;
        }

        .card a:hover {
            background: #feb47b; /* Lighter pink hover */
            color: white;
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Header -->
        <header>
            <h1>Welcome, <%= providerName %>!</h1>
            <a href="logout.jsp" class="logout-btn">Logout</a>
        </header>

        <!-- Dashboard Content -->
        <section>
            <h2>Your Dashboard</h2>
            <div class="card-container">
                <!-- Manage Services -->
                <div class="card">
                    <i class="fas fa-tools"></i>
                    <h3>Manage Services</h3>
                    <p>Add, update, or remove the services you offer.</p>
                    <a href="manageServices.jsp">Go to Manage Services</a>
                </div>

                <!-- View Service Requests -->
                <div class="card">
                    <i class="fas fa-envelope-open-text"></i>
                    <h3>Service Requests</h3>
                    <p>View and manage the requests from customers.</p>
                    <a href="viewRequests.jsp">View Requests</a>
                </div>

                <!-- My Profile -->
                <div class="card">
                    <i class="fas fa-user"></i>
                    <h3>My Profile</h3>
                    <p>View and edit your personal and business information.</p>
                    <a href="profile.jsp">View Profile</a>
                </div>
            </div>
        </section>
    </div>
</body>
</html>
