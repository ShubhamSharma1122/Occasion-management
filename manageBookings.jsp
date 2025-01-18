<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%
    // Database connection
    String dbURL = "jdbc:mysql://localhost:3306/eventdb";
    String dbUser = "root";
    String dbPassword = "Shubham@123";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    List bookings = new ArrayList(); // Using non-generic type for compatibility

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        stmt = conn.createStatement();

        String query = "SELECT id, event_name, user_name, booking_date, status FROM bookings";
        rs = stmt.executeQuery(query);

        while (rs.next()) {
            Map booking = new HashMap(); // Using non-generic Map
            booking.put("id", rs.getString("id"));
            booking.put("event_name", rs.getString("event_name"));
            booking.put("user_name", rs.getString("user_name"));
            booking.put("booking_date", rs.getString("booking_date"));
            booking.put("status", rs.getString("status"));
            bookings.add(booking);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Bookings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #333;
            text-align: center;
        }

        table {
            width: 100%;
            margin: 20px 0;
            border-collapse: collapse;
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        a {
            text-decoration: none;
            color: #2196F3;
        }

        a:hover {
            color: #0b7dda;
        }

        .actions {
            display: flex;
            justify-content: space-between;
        }

        .actions a {
            margin: 0 5px;
        }

        .confirmation {
            color: red;
        }
    </style>
</head>
<body>
    <h1>Manage Bookings</h1>
    <table>
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>Event Name</th>
                <th>User Name</th>
                <th>Booking Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% for (int i = 0; i < bookings.size(); i++) { 
                    Map booking = (Map) bookings.get(i);
            %>
                <tr>
                    <td><%= booking.get("id") %></td>
                    <td><%= booking.get("event_name") %></td>
                    <td><%= booking.get("user_name") %></td>
                    <td><%= booking.get("booking_date") %></td>
                    <td><%= booking.get("status") %></td>
                    <td class="actions">
                        <a href="updateBooking.jsp?id=<%= booking.get("id") %>">Edit</a> |
                        <a href="deleteBooking.jsp?id=<%= booking.get("id") %>" 
                           onclick="return confirm('Are you sure you want to delete this booking?');">Delete</a>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
