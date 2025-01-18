<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Explore Events</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(to bottom, #ff7e5f, #feb47b);
            color: #333;
        }
        .container {
            text-align: center;
            padding: 20px;
        }
        .header {
            background-color: #ff6b4b;
            padding: 20px;
            color: #fff;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
        .card-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
            width: 300px;
            margin: 10px;
        }
        .card h3 {
            margin-bottom: 10px;
            color: #333;
        }
        .card p {
            color: #666;
            margin-bottom: 20px;
        }
        .card .btn {
            background-color: #ff6b4b;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
        .card .btn:hover {
            background-color: #e65c3b;
        }
        .logout {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #ff4d4d;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="header">
        Welcome, Smart Event Planner! Trust  our Services we will never make user unhappy 
    </div>
    <button class="logout" onclick="window.location.href='logout.jsp'">Logout</button>

    <div class="container">
        <h2>Explore Available Services</h2>
        <div class="card-container">
            <% 
                // Database connection to fetch services from Service Provider
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                     Class.forName("com.mysql.jdbc.Driver");
                 conn = DriverManager.getConnection("jdbc:mysql:///EventPlanner?useSSL=false", "root", "Shubham@123");
                
                    stmt = conn.createStatement();
                    
                    // Adjust this query to match your column names
                    String query = "SELECT name, description, price FROM services";
                    rs = stmt.executeQuery(query);
                    
                    while (rs.next()) {
                        String serviceName = rs.getString("name");  // Column name from your database
                        String description = rs.getString("description");  // Column name from your database
                        double price = rs.getDouble("price");  // Column name from your database
            %>
            <div class="card">
                <h3><%= serviceName %></h3>
                <p><%= description %></p>
                <p><strong>Price:</strong> ?<%= price %></p>
                <a href="bookService.jsp?serviceName=<%= serviceName %>&description=<%= description %>&price=<%= price %>" class="btn">Book Now</a>
            </div>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <div style="color: red;">Error: <%= e.getMessage() %></div>
            <% 
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            %>
        </div>
    </div>
</body>
</html>
