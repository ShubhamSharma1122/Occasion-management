<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Services</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Body and overall page styling */
        body {
            font-family: Arial, sans-serif;
            background-color: #f5e6e6; /* Light red background */
            margin: 0;
            padding: 0;
        }

        /* Container styling */
        .container {
            margin: 30px auto;
            width: 90%;
            max-width: 1200px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        /* Title styling */
        h1 {
            color: #e74c3c; /* Red color for header */
            text-align: center;
        }

        /* Button styling */
        .button {
            background-color: #e74c3c; /* Red button color */
            color: #fff;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
        }

        .button:hover {
            background-color: #c0392b; /* Darker red on hover */
        }

        /* Services section styling */
        .services {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        /* Individual service card styling */
        .service-card {
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 300px;
            padding: 15px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s;
        }

        .service-card:hover {
            transform: translateY(-5px);
        }

        .service-card h3 {
            margin: 10px 0;
            color: #e74c3c; /* Red color for service names */
        }

        .service-card p {
            font-size: 14px;
            color: #555;
        }

        /* Actions section in service cards */
        .actions button, .actions form {
            margin: 5px;
        }

        /* Add service form styling */
        .add-service {
            background-color: #f9e4e4; /* Light red background */
            padding: 15px;
            border: 1px solid #ffe0cc;
            border-radius: 8px;
            margin: 20px auto;
            text-align: center;
            width: 90%;
        }

        input[type="text"], input[type="number"] {
            padding: 8px;
            width: 200px;
            margin: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        /* Logout button styling */
        .logout-button {
            float: right;
            margin: 10px;
        }

        /* Message color */
        p.message {
            color: #e74c3c; /* Red color for success/error messages */
            text-align: center;
        }
    </style>
</head>
<body>
    <a href="logout.jsp" class="button logout-button">Logout</a>
    <div class="container">
        <h1>Manage Services</h1>

        <%-- Database Connection --%>
        <% 
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            String message = "";
            try {
                
                 Class.forName("com.mysql.jdbc.Driver");
                 conn = DriverManager.getConnection("jdbc:mysql:///EventPlanner?useSSL=false", "root", "Shubham@123");
                         
                stmt = conn.createStatement();

                // Handle form submissions
                if (request.getParameter("action") != null) {
                    String action = request.getParameter("action");

                    if ("add".equals(action)) {
                        String name = request.getParameter("name");
                        String description = request.getParameter("description");
                        String price = request.getParameter("price");

                        String query = "INSERT INTO services (name, description, price) VALUES ('" + name + "', '" + description + "', '" + price + "')";
                        stmt.executeUpdate(query);
                        message = "Service added successfully!";
                    } else if ("delete".equals(action)) {
                        String id = request.getParameter("id");
                        String query = "DELETE FROM services WHERE id=" + id;
                        stmt.executeUpdate(query);
                        message = "Service deleted successfully!";
                    }
                }

                // Fetch all services
                rs = stmt.executeQuery("SELECT * FROM services");
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
            }
        %>

        <%-- Display Message --%>
        <% if (!message.isEmpty()) { %>
            <p class="message"><%= message %></p>
        <% } %>

        <%-- Services List --%>
        <div class="services">
            <% while (rs != null && rs.next()) { %>
                <div class="service-card">
                    <h3><%= rs.getString("name") %></h3>
                    <p><%= rs.getString("description") %></p>
                    <p><strong>Price: </strong>&#8377; <%= rs.getString("price") %></p>
                    <div class="actions">
                        <form method="post" style="display:inline;">
                            <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit" class="button"><i class="fas fa-trash"></i> Delete</button>
                        </form>
                    </div>
                </div>
            <% } %>
        </div>

        <%-- Add Service Form --%>
        <div class="add-service">
            <h2>Add New Service</h2>
            <form method="post">
                <input type="hidden" name="action" value="add">
                <input type="text" name="name" placeholder="Service Name" required>
                <input type="text" name="description" placeholder="Description" required>
                <input type="number" name="price" placeholder="Price" required>
                <button type="submit" class="button"><i class="fas fa-plus"></i> Add Service</button>
            </form>
        </div>

        <%-- Close resources --%>
        <% 
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        %>
    </div>
</body>
</html>
