<%-- 
    Document   : submitFeedback
    Created on : 23 Nov, 2024, 9:23:58 PM
    Author     : Shiva
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%
    // Simulating a feedback store (In real-world, use database)
    List<String> feedbackList = (List<String>) session.getAttribute("feedbackList");

    if (feedbackList == null) {
        feedbackList = new ArrayList<>();
        session.setAttribute("feedbackList", feedbackList);
    }

    // Check if feedback is submitted
    String feedback = request.getParameter("feedback");
    if (feedback != null && !feedback.trim().isEmpty()) {
        feedbackList.add(feedback);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Feedback</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .feedback-container {
            max-width: 400px;
            width: 100%;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h2 {
            color: #0056D2;
        }
        textarea {
            width: 100%;
            height: 100px;
            margin: 10px 0;
            padding: 10px;
            font-size: 14px;
        }
        button {
            background-color: #ff5722;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #e64a19;
        }
        .feedback-list {
            margin-top: 20px;
            text-align: left;
        }
    </style>
</head>
<body>

    <div class="feedback-container">
        <h2>User Feedback</h2>
        <p>We value your opinion! Please let us know how we’ve helped you plan your event.</p>
        <form action="feedback.jsp" method="post">
            <textarea name="feedback" placeholder="Enter your feedback here..."></textarea>
            <button type="submit">Submit Feedback</button>
        </form>

        <!-- Display Submitted Feedback -->
        <div class="feedback-list">
            <h3>Previous Feedback:</h3>
            <ul>
                <%
                    for (String fb : feedbackList) {
                %>
                    <li><%= fb %></li>
                <%
                    }
                %>
            </ul>
        </div>
    </div>

</body>
</html>
