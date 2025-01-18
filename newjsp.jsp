<%-- 
    Document   : newjsp
    Created on : 14 Nov, 2024, 10:31:41 PM
    Author     : Shiva
--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Event Management Dashboard</title>
    <link rel="stylesheet" href="newcss.css">
</head>
<body>
    <div class="dashboard-container">
        <!-- Navigation Panel -->
        <aside class="sidebar">
            <h2>Dashboard</h2>
            <ul>
                <li><a href="#overview">Overview</a></li>
                <li><a href="#events">Events</a></li>
                <li><a href="#users">Users</a></li>
                <li><a href="#registrations">Registrations</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <!-- Overview Section -->
            <section id="overview">
                <h2>Overview</h2>
                <div class="overview-cards">
                    <div class="card">Total Events: <span id="totalEvents">0</span></div>
                    <div class="card">Total Users: <span id="totalUsers">0</span></div>
                    <div class="card">Total Registrations: <span id="totalRegistrations">0</span></div>
                </div>
            </section>

            <!-- Event Management Section -->
            <section id="events">
                <h2>Manage Events</h2>
                <button onclick="window.location.href='addEvent.jsp'">Add New Event</button>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Date</th>
                            <th>Location</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="eventTableBody">
                        <!-- Event rows will be populated dynamically -->
                    </tbody>
                </table>
            </section>

            <!-- User Management Section -->
            <section id="users">
                <h2>Manage Users</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="userTableBody">
                        <!-- User rows will be populated dynamically -->
                    </tbody>
                </table>
            </section>

            <!-- Registration Management Section -->
            <section id="registrations">
                <h2>Manage Registrations</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Registration ID</th>
                            <th>User ID</th>
                            <th>Event ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="registrationTableBody">
                        <!-- Registration rows will be populated dynamically -->
                    </tbody>
                </table>
            </section>
        </main>
    </div>

    <!-- Include JavaScript for dynamic data fetching -->
    <script src="dashboard.js"></script>
</body>
</html>
