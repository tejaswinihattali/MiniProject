<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photo Add</title>
    <link rel="stylesheet" href="dashstyle.css">
    <script src="https://kit.fontawesome.com/2edfbc5391.js" crossorigin="anonymous"></script>
    <style>
        .Table_btn {
            padding: 5px;
            background: #0B87A6;
            text-decoration: none;
            padding-bottom: 5px;
            margin-top: 25px;
            margin-right: 616px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            color: #fff;
            transition: 0.5s;
            transition-property: background;
        }
        .Table_btn:hover {
            background: #19B3D3;
        }
        .content h2 {
            position: relative;
            padding: 0 180px 10px;
            margin-bottom: 45px;
            font-size: 35px;
        }
        .main {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
            min-height: 55vh;
        }
        .alb {
            width: 200px;
            height: 200px;
            padding: 20px;
        }
        .alb img {
            width: 114%;
            height: 130%;
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
        <a href="manageMembers.jsp"><i class="fas fa-desktop"></i><span>Manage Members</span></a>
        <a href="addNotice.jsp"><i class="fas fa-bullhorn"></i><span>Add Notice</span></a>
        <a href="viewComplaints.jsp" class="active"><i class="fas fa-envelope-open-text"></i><span>View Complaints</span></a>
        <a href="viewPayments.jsp"><i class="fas fa-file-invoice-dollar"></i><span>View Payments</span></a>
        <a href="photoGallery.jsp"><i class="fas fa-camera-retro"></i><span>Photo Gallery</span></a>
    </div>
    <!--sidebar end-->

    <div class="content">
        <br><br><br><br>
        <h2>Upload your Anonymous photos..!!</h2>

        <div class="main">

            <%-- Handling Error Display --%>
            <%
                String error = request.getParameter("error");
                if (error != null) {
                    out.println("<p>" + error + "</p>");
                }
            %>

            <form action="picadd.jsp" method="POST" enctype="multipart/form-data" style="padding-left: 383px;">
                <input type="file" name="my_image">
                <input type="submit" class="Table_btn" name="upload" value="Upload">
            </form>

            <%-- Fetching Images from the Database --%>
            <%
                String jdbcURL = "jdbc:mysql://localhost:3306/sms";
                String dbUsername = "root";
                String dbPassword = "root";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sms","root","root");
                    stmt = conn.createStatement();
                    String sql = "SELECT * FROM images ORDER BY id DESC";
                    rs = stmt.executeQuery(sql);

                    if (rs != null) {
                        while (rs.next()) {
            %>
            <div class="alb">
                <img src="Images/<%= rs.getString("image_url") %>">
            </div>
            <%
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>

        </div>
    </div>
</body>
</html>
