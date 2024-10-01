<%@ page import="java.sql.*, java.util.*" %>
<%
    HttpSession s = request.getSession(false);

    if (s == null || s.getAttribute("loggedin") == null || !(Boolean) s.getAttribute("loggedin")) {
        response.sendRedirect("login.html");
        return;
    }

    String username = (String) s.getAttribute("username");

    String dbURL = "jdbc:mysql://localhost:3306/sms";
    String dbUser = "root";
    String dbPass = "root";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");

        String sql = "SELECT Username, Flatno FROM registration WHERE Username='" + username + "'";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

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
    <link rel="stylesheet" href="https://kit.fontawesome.com/2edfbc5391.css" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js"></script>

    <style>
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
        label #sidebar_btn {
            z-index: 1;
            color: #fff;
            position: fixed;
            cursor: pointer;
            left: 300px;
            font-size: 20px;
            margin: 5px 0;
        }
        label #sidebar_btn:hover {
            color: #19B3D3;
        }
        #check:checked ~ .sidebar {
            left: -190px;
        }
        #check:checked ~ .sidebar a span {
            display: none;
        }
        #check:checked ~ .sidebar a {
            font-size: 20px;
            margin-left: 170px;
            width: 80px;
        }
        .content {
            margin-left: 250px;
            overflow: auto;
            background: url(Images/background.png) no-repeat;
            background-position: center;
            background-size: cover;
            height: 100vh;
            transition: 0.5s;
            position: relative; /* Added to position child elements */
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
        .box p span {
            font-size: 20px;
            font-weight: 400;
            color: #818181;
        }
        .box-icon {
            font-size: 40px!important;
            float: right;
            margin-top: 35px!important;
            color: #818181;
            padding-right: 10px;
        }
        #check:checked ~ .content {
            margin-left: 60px;
        }
        #check {
            display: none;
        }
        /* Calendar Styles */
        .calendar-container {
            padding: 10px; 
            background: white;
            border-radius: 8px;
            position: absolute;
            bottom: 20px; 
            left: 50%; 
            transform: translateX(-50%); 
            width: 250px; 
            height: 200px; 
            overflow: hidden; 
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
            z-index: 1000; 
        }

        #calendar {
            max-width: 100%;
            height: 180px; /* Set height for the calendar */
            margin: 0 auto;
            font-size: 12px; /* Smaller font size for calendar */
        }
    </style>

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
          events: 'getEventsServlet',
          selectable: true,
          select: function(info) {
            var title = prompt('Event Title:');
            var description = prompt('Event Description:');
            if (title) {
              calendar.addEvent({
                title: title,
                start: info.startStr,
                end: info.endStr,
                description: description
              });
              // Send AJAX request to add event to the database
              $.ajax({
                url: 'addEventServlet',
                type: 'POST',
                data: {
                  title: title,
                  start: info.startStr,
                  end: info.endStr,
                  description: description
                },
                success: function() {
                  calendar.refetchEvents();
                }
              });
            }
            calendar.unselect();
          }
        });
        calendar.render();
      });
    </script>
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
    <img src="Images/download.png" class="profile_image" alt="">
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

  <!-- Calendar Section -->
  <div class="calendar-container">
    <h2 style="text-align:center; font-size: 16px;">Upcoming Events</h2>
    <div id="calendar"></div>
  </div>

</div>

</body>
</html>

<%
        } else {
            out.println("No records found!");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
