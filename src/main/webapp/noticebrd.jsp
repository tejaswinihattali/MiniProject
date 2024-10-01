<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%
    // Session check (Equivalent to PHP's session_start and checking login status)
    HttpSession s = request.getSession(false);
    String loggedInUser = (s != null) ? (String) s.getAttribute("username") : null;

    if (loggedInUser == null) {
        // Redirect to login page if user is not logged in
        response.sendRedirect("register.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice Board</title>
    <link rel="stylesheet" href="dashstyle.css">
    <script src="https://kit.fontawesome.com/2edfbc5391.js" crossorigin="anonymous"></script>
    <style>
      .content-table {
        border-collapse: collapse;
        margin: 25px 19px;
        margin-left: 13px;
        font-size: 0.9em;
        min-width: 400px;
        border-radius: 5px 5px 0 0;
        overflow: hidden;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
      }

      .content-table thead tr {
        background-color: #19B3D3;
        color: #ffffff;
        text-align: left;
        font-weight: 900;
      }

      .content-table th,
      .content-table td {
        padding: 15px 15px;
      }

      .content-table tbody tr {
        border-bottom: 1px solid #dddddd;
      }

      .content-table tbody tr:nth-of-type(even) {
        background-color: #f3f3f3;
      }

      .content-table tbody tr:last-of-type {
        border-bottom: 2px solid #82abc7;
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
        <h3>Society<span>NEXUS</span></h3>
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
        <h4><%= loggedInUser %></h4>
    </center>
    <a href="Welcome.jsp"><i class="fas fa-desktop"></i><span>Dashboard</span></a>
    <a href="noticebrd.jsp" class="active"><i class="fas fa-bullhorn"></i><span>Notice Board</span></a>
    <a href="complaint.jsp"><i class="fas fa-envelope-open-text"></i><span>Register Complaint</span></a>
    <a href="payment.jsp"><i class="fas fa-file-invoice-dollar"></i><span>Maintenance Payment</span></a>
    <a href="userphoto.jsp"><i class="fas fa-camera-retro"></i><span>Photo Gallery</span></a>
</div>
<!--sidebar end-->

<div class="content"><br><br><br><br>

<%
    // Database connection
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // JDBC connection details
        String dbUrl = "jdbc:mysql://localhost:3306/sms";
        String dbUser = "root";
        String dbPassword = "root";

        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to the database
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");

        // Query to fetch notices
        String query = "SELECT * FROM notices";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
%>

    <table class="content-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Notice Name</th>
                <th>Notice Type</th>
                <th>Date</th>
                <th>Message</th>
            </tr>
        </thead>
        <tbody>
<%
        // Fetching and displaying data
        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("ID") %></td>
                <td><%= rs.getString("Name") %></td>
                <td><%= rs.getString("Type") %></td>
                <td><%= rs.getDate("Noticedate") %></td>
                <td><%= rs.getString("Message") %></td>
            </tr>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        // Closing resources
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (con != null) try { con.close(); } catch (SQLException ignore) {}
    }
%>
        </tbody>
    </table>
</div>
</body>
</html>
