<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Complaints</title>
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

      .content-table th, .content-table td {
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
        <h4> Admin </h4>
      </center>
      <a href="managemem.jsp"><i class="fas fa-desktop"></i><span>Manage Members</span></a>
      <a href="addnotice.jsp"><i class="fas fa-bullhorn"></i><span>Add Notice</span></a>
      <a href="viewcomplaints.jsp" class="active"><i class="fas fa-envelope-open-text"></i><span>View Complaints</span></a>
      <a href="viewpayment.jsp"><i class="fas fa-file-invoice-dollar"></i><span>View Payments</span></a>
      <a href="photo.jsp"><i class="fas fa-camera-retro"></i><span>Photo Gallery</span></a>
    </div>
    <!--sidebar end--> 
    
    <!-- Fetch and Display Complaints -->
    <div class="content"><br><br><br><br>
    <table class="content-table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Complaint</th>
        </tr>
      </thead>
      <tbody>
      <%
        // Fetch complaints from the database
        String query = "SELECT * FROM combox";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = connection.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
      %>
        <tr>
          <td><%= rs.getString("ID") %></td>
          <td><%= rs.getString("Title") %></td>
          <td><%= rs.getString("complaint") %></td>
        </tr>
      <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
      %>
      </tbody>
    </table>
    </div>
</body>
</html>
