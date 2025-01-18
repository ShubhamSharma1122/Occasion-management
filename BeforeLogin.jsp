<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - EventHub</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b); /* Vibrant gradient background */
            margin: 0;
            padding: 0;
            color: #333;
            background-size: cover;
            background-position: center;
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            /* Removed the transparent overlay */
        }

        .login-box {
            background: rgba(255, 255, 255, 0.9); /* White background with slight opacity */
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 420px; /* Adjusted max-width */
            transform: translateY(100px);
            animation: slideUp 0.6s ease forwards; /* Slide-in animation */
        }

        @keyframes slideUp {
            from {
                transform: translateY(100px);
            }
            to {
                transform: translateY(0);
            }
        }

        h2 {
            text-align: center;
            color: #ff5722; /* Bright orange heading */
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5); /* Text shadow */
            font-size: 2rem;
        }

        p {
            text-align: center;
            color: #555;
        }

        .highlight {
            color: #ff5722;
            font-weight: bold;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        input, select {
            width: 100%;
            padding: 14px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box; /* Ensures padding doesn't overflow */
            transition: border-color 0.3s ease;
        }

        input:focus, select:focus {
            border-color: #ff7e5f; /* Focused border color */
            outline: none;
        }

        .login-btn {
            width: 100%;
            background-color: #ff7e5f;
            color: white;
            padding: 12px;
            border-radius: 5px;
            border: none;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .login-btn:hover {
            background-color: #feb47b;
            transform: scale(1.05); /* Button scale effect */
        }

        .message {
            color: red;
            text-align: center;
        }

        .register-link {
            text-align: center;
            display: block;
            margin-top: 15px;
            text-decoration: none;
            color: #ff5722;
            font-weight: bold;
        }

        .register-link:hover {
            text-decoration: underline;
        }

        .login-btn, .register-link {
            margin-top: 15px;
        }

        /* Style for the Role Selection (User / Service Provider) Dropdown */
        .role-select {
            margin-top: 10px;
        }

        .role-select select {
            padding: 12px;
            font-size: 1rem;
            border-radius: 5px;
            background-color: #ff5722;
            color: white;
            border: none;
            width: 100%;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .role-select select:hover {
            background-color: #feb47b;
        }

        /* Adjusts input field layout */
        .input-wrapper {
            position: relative;
            margin-bottom: 20px;
        }

        .input-wrapper input, .input-wrapper select {
            padding-left: 20px; /* Space for icon */
        }

        .input-wrapper i {
            position: absolute;
            top: 50%;
            left: 10px;
            transform: translateY(-50%);
            color: #ff5722;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <h2>Login to Smart Event Planner</h2>

            <form method="post">
                <div class="input-wrapper">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required placeholder="Enter your email">
                </div>

                <div class="input-wrapper">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required placeholder="Enter your password">
                </div>

                <!-- Role selection dropdown moved below the password -->
                <div class="role-select">
                    <label for="role">Login as:</label>
                    <select id="role" name="role">
                        <option value="user">User</option>
                        <option value="serviceProvider">Service Provider</option>
                    </select>
                </div>

                <button type="submit" class="login-btn">Login</button>
                <a href="Register1.jsp" class="register-link">Don't have an account? Register here</a>
            </form>

            <%
                String loginMessage = "";  // Message to display errors or success
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String role = request.getParameter("role");

                    Connection conn = null;
                    Statement stmt = null;
                    try {
                        // Database connection
                        Class.forName("com.mysql.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql:///EventPlanner?useSSL=false", "root", "Shubham@123");
                        stmt = conn.createStatement();

                        // Query to verify email, password, and role
                        String query = "SELECT * FROM users WHERE email = '" + email + "' AND password = '" + password + "' AND role = '" + role + "'";
                        ResultSet rs = stmt.executeQuery(query);

                        if (rs.next()) {
                            // Login successful, create a session
                            HttpSession session1 = request.getSession(); // Create a new session
                            session1.setAttribute("userId", rs.getInt("id")); // Store user ID
                            session1.setAttribute("userName", rs.getString("name")); // Store user name
                            session1.setAttribute("role", rs.getString("role")); // Store role from the database

                            // Redirect to respective dashboard
                            response.sendRedirect(role.equals("user") ? "userDashboard.jsp" : "serviceProviderDashboard.jsp");
                        } else {
                            loginMessage = "Invalid email, password, or role. Please try again.";
                        }
                    } catch (Exception e) {
                        loginMessage = "Error: " + e.getMessage();
                    } finally {
                        try {
                            if (conn != null) conn.close();
                            if (stmt != null) stmt.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>

            <!-- Display message -->
            <div class="message">
                <%= loginMessage %> <!-- Output the login message -->
            </div>
        </div>
    </div>

    <script>
        // Set the role based on user selection
        document.getElementById("role").addEventListener("change", function() {
            document.getElementById("role").value = this.value;
        });
    </script>
</body>
</html>
