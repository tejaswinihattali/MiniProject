<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
    // Check if the form has been submitted
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String user = request.getParameter("username");
        String adcode = request.getParameter("admincode");

        // Validate the username and admin code
        if ("Admin".equals(user) && "100".equals(adcode)) {
%>
            <script>
                alert('Welcome, You are logged in...!');
                window.location.href = 'managemem.jsp'; // Redirect to the management page
            </script>
<%
        } else {
%>
            <script>
                alert('Sorry, Please enter valid details.!!');
            </script>
<%
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <script src="https://kit.fontawesome.com/2edfbc5391.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="style1.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background: #007bff;
            color: white;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .navbar img.logo {
            width: 50px;
            height: 50px;
        }
        .page {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0 auto;
        }
        .form-container1 {
            background: #fff;
            width: 300px;
            height: auto;
            position: relative;
            text-align: center;
            padding: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        .adminfbtn h1 {
            font-size: 25px;
            margin-bottom: 10px;
            color: #007bff;
        }
        .form-container1 .admimg {
            width: 130px;
            height: 100px;
            border-radius: 100px;
            margin-bottom: 15px;
        }
        .form-container1 input {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: border-color 0.3s;
        }
        .form-container1 input:focus {
            border-color: #007bff;
        }
        .btn-losi {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
            width: 100%;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        .btn-losi:hover {
            background-color: #0056b3;
        }
        hr {
            margin: 20px 0;
            border: 1px solid #ddd;
        }
        #rules {
            padding: 20px;
            background-color: #fff;
            margin: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        footer {
            background: #007bff;
            color: white;
            padding: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="page">
    <div class="navbar">
        <img src="Images/shlogo.jpg" class="logo" alt="Logo">
        <h1>Society<span style="font-family: 'Merienda', cursive; color:rgb(20, 76, 80);">NEXAS</span></h1>
        <nav>
            <ul>
                <li><a href="" class="active">Home</a></li>
                <li><a href="#rules">Rules & Regulations</a></li>
            </ul>
        </nav>
        <a href="register.jsp" class="btn">User Login</a>
    </div>
    <div class="row">
        <div class="col-1">
            <img src="Images/building1.jpg" alt="Building Image">
        </div>
        <div class="col-2">
            <div class="form-container1">
                <div class="adminfbtn">
                    <h1>Admin Login</h1>
                </div>
                <img src="Images/adminlogin.jpg" class="admimg" alt="Admin Login Image">
                <form action="Adminlogin.jsp" method="POST">
                    <input type="text" placeholder="Username" name="username" required>
                    <input type="password" placeholder="Admin Code" name="admincode" required>
                    <button type="submit" class="btn-losi" name="logina">Login</button>
                </form>
            </div>
        </div>
    </div>
</div>
<hr>
<div id="rules">
    <h1>Rules and Regulations</h1>
    <hr>
    <ul>
        <li>Members and residents are required to keep their flats/homes and nearby premises clean and habitable.</li>
        <li>The residents should also maintain proper cleanliness etiquette while using common areas, parking lot, etc., and not throw litter from their balconies and windows.</li>
        <li>Members must regularly pay the maintenance charges and all other dues necessitated by the society.</li>
        <li>Keeping pets is allowed after submitting the required NOC to the society. But if pets like dogs are creating any kind of disturbance to other society members, then the pets won’t be allowed.</li>
        <li>Every member of the society should park their vehicles in their respective allotted parking spaces only.</li>
        <li>After using the community hall for any event or function, it should be cleaned and no damages should be caused.</li>
        <li>No member can occupy the area near their front doors, corridors, passage for their personal usage.</li>
        <li>Salesmen, vendors, or any other sellers are not allowed to enter the premises.</li>
        <li>Wastage and over usage of water are not allowed.</li>
        <li>Smoking in lobbies, passage is not allowed. If any irresponsible person is found smoking in the no smoking zone, he/she shall be charged with a penalty.</li>
    </ul>
</div>
<hr>
<footer>
    <div class="main-content">
        <h2>About Us</h2>
        <p>SocietyNEXAS is a web app where society members can get all the updates related to their society. The members also get notified with notices and events held in society and can see information about members in society. Members can also post complaints regarding any issue in society.</p>
    </div>
    <div class="copyright">
        <h3>Copyright @2021 | Designed with HTML, CSS, PHP.</h3>
    </div>
</footer>
</body>
</html>
