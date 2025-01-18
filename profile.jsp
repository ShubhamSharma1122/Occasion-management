<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    // Session Validation
    HttpSession session1 = request.getSession(false); // Get the session without creating a new one
    if (session1 == null || session1.getAttribute("userId") == null) {
        response.sendRedirect("BeforeLogin.jsp"); // Redirect to login page
        return; // Prevent further processing of the page
    }

    // Correctly retrieve userId as Integer from session
    Integer userIdInt = (Integer) session.getAttribute("userId");
    String userId = String.valueOf(userIdInt); // Convert Integer to String if needed

    // Variables for user data
    String userName = "";
    String email = "";
    String contact = "";

    // Database Connection
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Connect to the database
        Class.forName("com.mysql.cj.jdbc.Driver"); // Updated MySQL driver class
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/EventPlanner?useSSL=false", "root", "Shubham@123");

        // Query to fetch user profile details
        String query = "SELECT name, email, contact FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setInt(1, userIdInt); // Use prepared statement to avoid SQL injection
        ResultSet rs = pstmt.executeQuery();

        // Fetch user details
        if (rs.next()) {
            userName = rs.getString("name");
            email = rs.getString("email");
            contact = rs.getString("contact");
        }
    } catch (Exception e) {
        out.println("<p style='color: red; text-align: center;'>Error: " + e.getMessage() + "</p>");
    } finally {
        // Close resources
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b);
            color: #333;
            margin: 0;
            padding: 0;
        }

        .profile-container {
            max-width: 600px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #ff5722;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }

        .form-actions {
            text-align: center;
            margin-top: 20px;
        }

        .form-actions button {
            background: #ff7e5f;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .form-actions button:hover {
            background: #feb47b;
        }

        .logout-link {
            display: inline-block;
            margin-top: 10px;
            text-decoration: none;
            color: #ff7e5f;
            font-weight: bold;
        }

        .logout-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <h1>My Profile</h1>
        <form method="post">
            <!-- Name -->
            <div class="form-group">
                <label for="userName">Name:</label>
                <input type="text" id="userName" name="userName" value="<%= userName %>" required>
            </div>

            <!-- Email -->
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= email %>" required>
            </div>

            <!-- Contact -->
            <div class="form-group">
                <label for="contact">Contact:</label>
                <input type="text" id="contact" name="contact" value="<%= contact %>" required>
            </div>

            <!-- Form Actions -->
            <div class="form-actions">
                <button type="submit">Save Changes</button>
            </div>
        </form>

        <div class="form-actions">
            <a href="serviceProviderDashboard.jsp" class="logout-link">Go Back to Dashboard</a>
        </div>

        <% 
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String updatedName = request.getParameter("userName");
                String updatedEmail = request.getParameter("email");
                String updatedContact = request.getParameter("contact");

                try {
                    // Update user details
                    Connection updateConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/EventPlanner?useSSL=false", "root", "Shubham@123");
                    PreparedStatement updatePstmt = updateConn.prepareStatement(
                        "UPDATE users SET name = ?, email = ?, contact = ? WHERE id = ?"
                    );
                    updatePstmt.setString(1, updatedName);
                    updatePstmt.setString(2, updatedEmail);
                    updatePstmt.setString(3, updatedContact);
                    updatePstmt.setInt(4, userIdInt);

                    int rowsUpdated = updatePstmt.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<p style='color: green; text-align: center;'>Profile updated successfully!</p>");
                    } else {
                        out.println("<p style='color: red; text-align: center;'>Failed to update profile. Try again!</p>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color: red; text-align: center;'>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
