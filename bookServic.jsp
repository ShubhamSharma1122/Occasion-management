<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Service</title>
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
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            padding: 20px;
            text-align: center;
            width: 300px;
            margin: 20px auto;
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
        Book Your Service
    </div>
    <button class="logout" onclick="window.location.href='logout.jsp'">Logout</button>

    <div class="container">
        <h2>Confirm Your Service Booking</h2>
        <div class="card">
            <% 
                // Retrieving service details from the query parameters
                String serviceName = request.getParameter("serviceName");
                String description = request.getParameter("description");
                String priceParam = request.getParameter("price");

                // Checking if any parameter is missing
                if (serviceName == null || description == null || priceParam == null) {
                    out.println("<p style='color:red;'>Error: Missing required parameters.</p>");
                } else {
                    try {
                        double price = Double.parseDouble(priceParam); // Converting price to double
            %>
                    <h3><%= serviceName %></h3>
                    <p><%= description %></p>
                    <p><strong>Price:</strong> ?<%= price %></p>

                    <form action="confirmBooking.jsp" method="post">
                        <input type="hidden" name="serviceName" value="<%= serviceName %>">
                        <input type="hidden" name="description" value="<%= description %>">
                        <input type="hidden" name="price" value="<%= price %>">
                        <div>
                            <label for="clientName">Your Name:</label>
                            <input type="text" id="clientName" name="clientName" required>
                        </div>
                        <div>
                            <label for="clientContact">Your Contact:</label>
                            <input type="text" id="clientContact" name="clientContact" required>
                        </div>
                        <div>
                            <button type="submit" class="btn">Confirm Booking</button>
                        </div>
                    </form>
            <%
                    } catch (NumberFormatException e) {
                        out.println("<p style='color:red;'>Error: Invalid price format.</p>");
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
