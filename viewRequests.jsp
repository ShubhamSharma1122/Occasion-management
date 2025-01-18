<%-- 
    Document   : viewRequests
    Created on : 16 Dec, 2024, 9:13:37 PM
    Author     : Shiva
--%>

<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - View Requests</title>
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
        .dashboard {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
            width: 300px;
        }
        .card h2 {
            margin-bottom: 10px;
            color: #333;
        }
        .card p {
            color: #666;
            margin-bottom: 20px;
        }
        .btn {
            background-color: #ff6b4b;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
        .btn:hover {
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
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #ff6b4b;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>
<body>
    <div class="header">
        Welcome, Er.Shivam Dwivedi!
    </div>
    <!--<button class="logout">Logout</button>-->
    <form action="logout.jsp" method="post">
        <button type="submit" class="logout">Logout</button>
    </form>
    <div class="container">
        <h2>Service Requests</h2>
        <table>
            <tr>
                <th>Request ID</th>
                <th>Client Name</th>
                <th>Event Type</th>
                <th>Event Date</th>
                <th>Status</th>
            </tr>
            <% 
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/smart_event_planner", "root", "Shubham@123");
                    stmt = conn.createStatement();
                    String query = "SELECT request_id, client_name, event_type, event_date, status FROM event_requests";
                    rs = stmt.executeQuery(query);
                    while (rs.next()) {
                        int requestId = rs.getInt("request_id");
                        String clientName = rs.getString("client_name");
                        String eventType = rs.getString("event_type");
                        Date eventDate = rs.getDate("event_date");
                        String status = rs.getString("status");
            %>
            <tr>
                <td><%= requestId %></td>
                <td><%= clientName %></td>
                <td><%= eventType %></td>
                <td><%= eventDate %></td>
                <td><%= status %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <tr>
                <td colspan="5">Error: <%= e.getMessage() %></td>
            </tr>
            <%
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            %>
        </table>
    </div>
</body>
</html>
