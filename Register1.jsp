<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - EventHub</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff7e5f, #feb47b); /* Gradient background */
            margin: 0;
            padding: 0;
            color: #333;
        }

        .register-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: linear-gradient(to right, #ff7e5f, #feb47b); /* Gradient background */
        }

        .register-box {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            text-align: center;
            color: #ff5722; /* Bright orange heading */
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
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
        }

        .register-btn {
            width: 100%;
            background-color: #ff7e5f;
            color: white;
            padding: 10px;
            border-radius: 5px;
            border: none;
            font-size: 1.2rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .register-btn:hover {
            background-color: #feb47b;
        }

        .message {
            color: red;
            text-align: center;
        }

        .login-link {
            text-align: center;
            display: block;
            margin-top: 15px;
            text-decoration: none;
            color: #ff5722;
        }

        .login-link:hover {
            text-decoration: underline;
        }

        .register-btn, .login-link {
            margin-top: 15px;
        }
    </style>

    <script>
        // JavaScript functions for dynamic dropdowns (countries, states, districts)
     const data = {
    "India": {
        "Andhra Pradesh": ["Anantapur", "Chittoor", "East Godavari", "Guntur", "Krishna", "Kurnool", "Prakasam", "Srikakulam", "Visakhapatnam", "West Godavari", "YSR Kadapa"],
        "Uttar Pradesh": ["Agra", "Aligarh", "Allahabad", "Ambedkar Nagar", "Azamgarh", "Baghpat", "Bahraich", "Ballia", "Balrampur", "Banda"],
        "Madhya Pradesh": ["Ashok Nagar", "Balaghat", "Barwani", "Betul", "Bhind", "Bhopal", "Chhatarpur", "Chhindwara", "Damoh", "Datia", "Dewas", "Dhar", "Dindori", "Guna", "Gwalior", "Harda", "Hoshangabad", "Indore", "Jabalpur", "Jhabua", "Katni", "Khandwa", "Khargone","Mauganj", "Mandla", "Mandsaur", "Morena", "Narsinghpur", "Neemuch", "Pachmarhi", "Panna", "Raisen", "Rajgarh", "Ratlam", "Rewa", "Sagar", "Satna", "Sehore", "Seoni", "Shahdol", "Shajapur", "Sheopur", "Shivpuri", "Sidhi", "Singrauli", "Tikamgarh", "Ujjain", "Umaria", "Vidisha"],
        "Maharashtra": ["Ahmednagar", "Akola", "Amravati", "Aurangabad", "Beed", "Bhandara", "Buldhana", "Chandrapur", "Dhule", "Gadchiroli", "Gondia", "Hingoli", "Jalgaon", "Jalna", "Kolhapur", "Latur", "Mumbai City", "Nagpur", "Nanded", "Nandurbar", "Nashik", "Osmanabad", "Palghar", "Parbhani", "Pune", "Raigad", "Ratnagiri", "Sangli", "Satara", "Sindhudurg", "Solapur", "Thane", "Wardha", "Washim", "Yavatmal"],
        "Rajasthan": ["Ajmer", "Alwar", "Banswara", "Baran", "Barmer", "Bhilwara", "Bikaner", "Bundi", "Chittorgarh", "Churu", "Dausa", "Dholpur", "Dungarpur", "Hanumangarh", "Jaipur", "Jaisalmer", "Jalore", "Jhalawar", "Jhunjhunu", "Jodhpur", "Karauli", "Kota", "Nagaur", "Pali", "Pratapgarh", "Rajsamand", "Sawai Madhopur", "Sikar", "Sirohi", "Tonk", "Udaipur"],
        "Chhattisgarh": ["Balod", "Baloda Bazar", "Bastar", "Bijapur", "Bilaspur", "Dantewada", "Dhamtari", "Durg", "Gariaband", "Janjgir-Champa", "Jashpur", "Korba", "Koriya", "Mahasamund", "Mungeli", "Narayanpur", "Raigarh", "Raipur", "Rajnandgaon", "Sukma", "Surajpur", "Surguja"],
        "Gujarat": ["Ahmedabad", "Amreli", "Anand", "Aravalli", "Banaskantha", "Bharuch", "Bhavnagar", "Botad", "Chhota Udepur", "Dahod", "Dang", "Gandhinagar", "Gir Somnath", "Jamnagar", "Junagadh", "Kachchh", "Kheda", "Mahisagar", "Mehsana", "Morbi", "Narmada", "Navsari", "Panchmahal", "Patan", "Porbandar", "Rajkot", "Sabarkantha", "Surat", "Surendranagar", "Tapi", "Vadodara", "Valsad"],
        "Delhi": ["Central Delhi", "East Delhi", "New Delhi", "North Delhi", "North East Delhi", "North West Delhi", "South Delhi", "South East Delhi", "South West Delhi", "West Delhi"]
    },
    "United States": {
        "California": ["Los Angeles", "San Francisco", "San Diego", "Sacramento"],
        "Texas": ["Houston", "Dallas", "Austin", "San Antonio"]
    }
};


        function populateStates() {
            const country = document.getElementById('country').value;
            const stateDropdown = document.getElementById('state');
            const districtDropdown = document.getElementById('district');
            stateDropdown.innerHTML = '<option value="" disabled selected>Select your state</option>';
            districtDropdown.innerHTML = '<option value="" disabled selected>Select your district</option>';

            if (country && data[country]) {
                const states = Object.keys(data[country]);
                states.forEach(function(state) {
                    const option = document.createElement('option');
                    option.value = state;
                    option.textContent = state;
                    stateDropdown.appendChild(option);
                });
            }
        }

        function populateDistricts() {
            const country = document.getElementById('country').value;
            const state = document.getElementById('state').value;
            const districtDropdown = document.getElementById('district');
            districtDropdown.innerHTML = '<option value="" disabled selected>Select your district</option>';

            if (country && state && data[country][state]) {
                const districts = data[country][state];
                districts.forEach(function(district) {
                    const option = document.createElement('option');
                    option.value = district;
                    option.textContent = district;
                    districtDropdown.appendChild(option);
                });
            }
        }
    </script>
</head>
<body>
    <div class="register-container">
        <div class="register-box">
            <h2>Create Your Account</h2>
            <p>Join EventHub as a <span class="highlight">User</span> or <span class="highlight">Service Provider</span></p>

            <form method="post">
                <label for="name">Full Name:</label>
                <input type="text" id="name" name="name" required placeholder="Enter your full name">

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required placeholder="Create a password">

                <label for="confirmPassword">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required placeholder="Confirm your password">

                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>

                <label for="country">Country:</label>
                <select id="country" name="country" required onchange="populateStates()">
                    <option value="" disabled selected>Select your country</option>
                    <option value="India">India</option>
                    <option value="United States">United States</option>
                </select>

                <label for="state">State/Province:</label>
                <select id="state" name="state" required onchange="populateDistricts()">
                    <option value="" disabled selected>Select your state/province</option>
                </select>

                <label for="district">District:</label>
                <select id="district" name="district" required>
                    <option value="" disabled selected>Select your district</option>
                </select>

                <label for="role">Register as:</label>
                <select id="role" name="role" required>
                    <option value="user">User</option>
                    <option value="serviceProvider">Service Provider</option>
                </select>

                <button type="submit" class="register-btn">Register</button>
                <a href="BeforeLogin.jsp" class="login-link">Already have an account? Log in here</a>
            </form>

            <%
                // Variables for storing form input data
                String message = "";  // Initialize message variable
                
                // Check if the form is submitted (POST request)
                if (request.getMethod().equalsIgnoreCase("POST")) {
                    String name = request.getParameter("name");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");
                    String confirmPassword = request.getParameter("confirmPassword");
                    String dob = request.getParameter("dob");
                    String country = request.getParameter("country");
                    String state = request.getParameter("state");
                    String district = request.getParameter("district");
                    String role = request.getParameter("role");

                    // Database connection and insertion using Statement
                    Connection conn = null;
                    Statement stmt = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");

                        conn = DriverManager.getConnection("jdbc:mysql:///EventPlanner?useSSL=false", "root", "Shubham@123");
                        
                        stmt = conn.createStatement();

                        // Check if email already exists
                        String checkEmailQuery = "SELECT * FROM users WHERE email = '" + email + "'";
                        ResultSet rs = stmt.executeQuery(checkEmailQuery);

                        if (rs.next()) {
                            message = "Email already exists! Please choose another email.";
                        } else if (!password.equals(confirmPassword)) {
                            message = "Passwords do not match!";
                        } else {
                            // Construct SQL query for insertion
                            String insertQuery = "INSERT INTO users (name, email, password, dob, country, state, district, role) " +
                                                 "VALUES ('" + name + "', '" + email + "', '" + password + "', '" + dob + "', '" + country + "', '" + state + "', '" + district + "', '" + role + "')";
                            int rowsAffected = stmt.executeUpdate(insertQuery);

                            if (rowsAffected > 0) {
                                message = "Registration successful! Please log in.";
                            } else {
                                message = "Registration failed! Please try again.";
                            }
                        }
                    } catch (Exception e) {
                        message = "Error: " + e.getMessage(); // Display error if an exception occurs
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

            <!-- Display success/error message -->
            <div class="message">
                <%= message %> <!-- This will output the value of the message variable -->
            </div>

        </div>
    </div>
</body>
</html>
