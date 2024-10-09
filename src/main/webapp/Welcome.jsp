<%@ page import="java.sql.*, java.util.*" %>
<%
    // Start session
    HttpSession s = request.getSession(false);

    // Check if user is logged in
    if (s == null || s.getAttribute("loggedin") == null || !(Boolean) s.getAttribute("loggedin")) {
        response.sendRedirect("register.jsp");
        return;
    }

    String username = (String) s.getAttribute("username");

    // Database connection parameters
    String dbURL = "jdbc:mysql://localhost:3306/sms";
    String dbUser = "root";
    String dbPass = "root";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        // Establish connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");

        // Execute query to retrieve user details
        String sql = "SELECT Username, Flatno FROM registration WHERE Username='" + username + "'";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

        // Check if the user details are found
        if (rs.next()) {
            String userName = rs.getString("Username");
            String flatNo = rs.getString("Flatno");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome Dashboard</title>
    <link rel="stylesheet" href="dashstyle.css">
    <script src="https://kit.fontawesome.com/2edfbc5391.js" crossorigin="anonymous"></script>
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js'></script>

    <style>
        /* Existing Styles */
        body {
            margin: 0;
            padding: 0;
            font-family: "Roboto", sans-serif;
        }
        header {
            position: fixed;
            background: #22242A;
            padding: 20px;
            width: 100%;
            height: 30px;
        }
        .left_area h3 {
            color: #fff;
            margin: 0;
            text-transform: uppercase;
            font-size: 22px;
            font-weight: 900;
        }
        .left_area span {
            color: #19B3D3;
        }
        .logout_btn {
            padding: 5px;
            background: #19B3D3;
            text-decoration: none;
            float: right;
            margin-top: -30px;
            margin-right: 40px;
            border-radius: 2px;
            font-size: 15px;
            font-weight: 600;
            color: #fff;
            transition: 0.5s;
            transition-property: background;
        }
        .logout_btn:hover {
            background: #0B87A6;
        }
        .sidebar {
            background: #2f323a;
            margin-top: 70px;
            padding-top: 30px;
            position: fixed;
            left: 0;
            width: 250px;
            height: 100%;
            transition: 0.5s;
            transition-property: left;
        }
        .sidebar .profile_image {
            width: 100px;
            height: 100px;
            border-radius: 100px;
            margin-bottom: 10px;
        }
        .sidebar h4 {
            color: #ccc;
            margin-top: 0;
            margin-bottom: 20px;
        }
        .sidebar a {
            color: #fff;
            display: block;
            width: 100%;
            line-height: 60px;
            text-decoration: none;
            padding-left: 40px;
            box-sizing: border-box;
        }
        .sidebar a:hover {
            background: #19B3D3;
        }
        .sidebar.active {
            background: #19B3D3;
        }
        .sidebar i {
            padding-right: 10px;
        }
        .content {
            margin-left: 250px;
            overflow: auto;
            background: url(./Images/background.png) no-repeat;
            background-position: center;
            background-size: cover;
            height: 100vh;
            transition: 0.5s;
        }
        .content h1 {
            padding-top: 65px;
            padding-left: 10px;
        }
        .col-div-3 {
            width: 25%;
            float: left;
        }
        .box {
            width: 85%;
            height: 100px;
            background-color: #272c4a;
            margin-left: 10px;
            padding: 10px;
            cursor: pointer;
        }
        .box p {
            font-size: 35px;
            color: white;
            font-weight: bold;
            line-height: 30px;
            padding-left: 10px;
            margin-top: 20px;
            display: inline-block;
        }
        .box-icon {
            font-size: 40px!important;
            float: right;
            margin-top: 35px!important;
            color: #818181;
            padding-right: 10px;
        }
        /* Calendar Styles */
        #calendar {
            position: fixed; /* Make the calendar fixed */
            bottom: 20px; /* Distance from the bottom */
            right: 20px; /* Distance from the right */
            width: 300px; /* Set a width for the calendar */
            border: 1px solid #ccc;
            border-radius: 10px;
            overflow: hidden;
        }
        .fc-toolbar-title {
            font-size: 12px;
        }
        .fc-daygrid-day-number {
            font-size: 10px;
        }
        .fc-header-toolbar {
            font-size: 10px;
        }
    </style>
</head>
<body>
<input type="checkbox" id="check">
<!--header area start-->
<header>
    <label for="check">
        <i class="fas fa-bars" id="sidebar_btn"></i>
    </label>
    <div class="left_area">
        <h3>Society<span>NEXAS</span></h3>
    </div>
    <div class="right_area">
        <a href="logout.jsp" class="logout_btn">Logout</a>
    </div>
</header>
<!--header area end-->

<!--sidebar start-->
<div class="sidebar">
    <center>
        <img src="./Images/download.png" class="profile_image" alt="">
        <h4><%= username %></h4>
    </center>
    <a href="Welcome.jsp" class="active"><i class="fas fa-desktop"></i><span>Dashboard</span></a>
    <a href="noticebrd.jsp"><i class="fas fa-bullhorn"></i><span>Notice Board</span></a>
    <a href="complaint.jsp"><i class="fas fa-envelope-open-text"></i><span>Register Complaint</span></a>
    <a href="payment.jsp"><i class="fas fa-file-invoice-dollar"></i><span>Maintenance Payment</span></a>
    <a href="userphoto.jsp"><i class="fas fa-camera-retro"></i><span>Photo Gallery</span></a>
</div>
<!--sidebar end-->

<div class="content"> 
    <h1>Welcome to Dashboard</h1>

    <div class="col-div-3">
        <div class="box">
            <p><%= userName %><br><span>Your Username</span></p>
            <i class="far fa-user fa-2x"></i>
        </div>
    </div>

    <div class="col-div-3">
        <div class="box">
            <p><%= flatNo %><br><span>Your Flat No.</span></p>
            <i class="fas fa-home fa-2x"></i>
        </div>
    </div>

    <div class="col-div-3">
        <div class="box">
            <p>Tejaswini<br><span>Society Secretary</span></p>
            <i class="fas fa-user-tie fa-2x"></i>
        </div>
    </div>

    <!-- FullCalendar -->
    <div id="calendar"></div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: '/your_project_path/events', // Call the servlet to fetch events
            editable: true,
            selectable: true,
            select: function(info) {
                var title = prompt('Enter Event Title');
                var description = prompt('Enter Event Description');
                if (title) {
                    // Send AJAX request to add event
                    $.ajax({
                        url: '/your_project_path/addEvent', // Change to your servlet path
                        method: 'POST',
                        data: {
                            title: title,
                            start: info.startStr,
                            end: info.endStr,
                            description: description
                        },
                        success: function() {
                            calendar.refetchEvents(); // Refresh events
                        }
                    });
                }
                calendar.unselect();
            },
            eventClick: function(info) {
                if (confirm('Are you sure you want to delete this event?')) {
                    // Send AJAX request to delete the event
                    $.ajax({
                        url: '/your_project_path/deleteEvent', // Change to your servlet path
                        method: 'POST',
                        data: {
                            id: info.event.id
                        },
                        success: function() {
                            info.event.remove(); // Remove event from the calendar
                        }
                    });
                }
            }
        });
        calendar.render();
    });
</script>
</body>
</html>

<%
        } else {
            out.println("User details not found.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close database resources
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
