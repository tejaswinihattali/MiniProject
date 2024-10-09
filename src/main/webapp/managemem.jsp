<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Member</title>
    <link rel="stylesheet" href="dashstyle.css">
    <script src="https://kit.fontawesome.com/2edfbc5391.js" crossorigin="anonymous"></script>
    <style>
        .content-table {
            border-collapse: collapse;
            margin: 25px 0;
            margin-left: 13px;
            font-size: 0.9em;
            min-width: 400px;
            border-radius: 5px 5px 0 0;
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
        .Table_btn {
            padding: 5px;
            background: #0B87A6;
            text-decoration: none;
            float: right;
            margin-top: -3px;
            margin-right: 40px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            color: #fff;
            transition: 0.5s;
        }
        .Table_btn:hover {
            background: #19B3D3;
        }
        .Table_btn1 {
            padding: 8px;
            background: #0B87A6;
            text-decoration: none;
            float: left;
            margin-top: -1px;
            margin-left: 15px;
            margin-right: 40px;
            border-radius: 5px;
            font-size: 15px;
            font-weight: 600;
            color: #fff;
            transition: 0.5s;
        }
        .Table_btn1:hover {
            background: #19B3D3;
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
            <h4> Admin </h4>
        </center>
        <a href="managemem.jsp" class="active"><i class="fas fa-desktop"></i><span>Manage Members</span></a>
        <a href="addnotice.jsp"><i class="fas fa-bullhorn"></i><span>Add Notice</span></a>
        <a href="viewcomplaints.jsp"><i class="fas fa-envelope-open-text"></i><span>View Complaints</span></a>
        <a href="viewpayment.jsp"><i class="fas fa-file-invoice-dollar"></i><span>View Payments</span></a>
        <a href="picadd.jsp"><i class="fas fa-camera-retro"></i><span>Photo Gallery</span></a>
    </div>
    <!--sidebar end-->

    <div class="content"><br><br><br><br><br><br>
        <a href="insertUser.jsp" class="Table_btn1">Add Member</a><br><br>
        <%
            // Database connection details
            String jdbcURL = "jdbc:mysql://localhost:3306/sms";
            String dbUsername = "root";
            String dbPassword = "root";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Load MySQL JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Establishing the connection
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");

                // Creating a statement
                stmt = conn.createStatement();

                // Execute query to fetch all members
                String query = "SELECT * FROM registration";
                rs = stmt.executeQuery(query);

        %>
        <table class="content-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Flat No.</th>
                    <th>Mobile No.</th>
                    <th>No. of Family Members</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("Id") %></td>
                    <td><%= rs.getString("Username") %></td>
                    <td><%= rs.getString("Email") %></td>
                    <td><%= rs.getString("Flatno") %></td>
                    <td><%= rs.getString("MobileNo") %></td>
                    <td><%= rs.getString("no_of_family_members") %></td>

                    <form action="updateUser.jsp" method="post">
                        <input type="hidden" name="Id" value="<%= rs.getInt("Id") %>">
                        <td><input type="submit" name="edit" class="Table_btn" value="Update"></td>
                    </form>

                    <form action="deleteUser.jsp" method="post">
                        <input type="hidden" name="Id" value="<%= rs.getInt("Id") %>">
                        <td><input type="submit" name="delete" class="Table_btn" value="Delete"></td>
                    </form>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close the resources
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</body>
</html>
