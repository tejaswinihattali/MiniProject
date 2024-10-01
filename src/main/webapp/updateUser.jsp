<%@ page import="java.sql.*" %>
<%@ include file="db_conn.jsp" %>
<%
    // Get the ID from the form (POST method)
    String Id = request.getParameter("Id");
    String query = "SELECT * FROM registration WHERE Id=?";
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        ps = connection.prepareStatement(query);
        ps.setString(1, Id);
        rs = ps.executeQuery();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update User</title>
    <style>
        .Add_btn {
            padding: 5px;
            background: #0B87A6;
            text-decoration: none;
            margin-top: -1px;
            margin-right: 2px;
            border-radius: 8px;
            font-size: 15px;
            font-weight: 600;
            color: #fff;
            transition: 0.5s;
        }

        .Add_btn:hover {
            background: #19B3D3;
        }

        .container {
            background: #b7f7d7;
            width: 550px;
            height: 320px;
            margin-top: 90px;
            margin-left: 400px;
            text-align: center;
            padding: 20px 0;
            box-shadow: 0 0 20px 0px rgba(0,0,0,0.1);
        }

        form input {
            width: 100%;
            height: 40px;
            margin-bottom: 10px;
            padding: 0 10px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>Update Member</h1>
        <%
            if (rs != null && rs.next()) {
        %>
        <form action="updateUser.jsp" method="POST">
            <input type="hidden" name="Id" value="<%= rs.getString("Id") %>">
            <input type="text" placeholder="Username" name="username" value="<%= rs.getString("Username") %>" required>
            <input type="email" placeholder="E-mail" name="email" value="<%= rs.getString("Email") %>" required>
            <input type="text" placeholder="Flat-No." name="flatno" value="<%= rs.getString("Flatno") %>" required>
            <input type="tel" placeholder="Mobile Number" name="mobno" value="<%= rs.getString("MobileNo") %>" required>
            <button type="submit" name="update" class="Add_btn">Update data</button>
        </form>
        <%
            }
        %>

        <%
            // Handle form submission for update
            if (request.getParameter("update") != null) {
                String Username = request.getParameter("username");
                String email = request.getParameter("email");
                String flatno = request.getParameter("flatno");
                String mobileno = request.getParameter("mobno");

                String updateQuery = "UPDATE registration SET Username = ?, Email = ?, Flatno = ?, MobileNo = ? WHERE Id = ?";
                PreparedStatement updatePS = null;

                try {
                    updatePS = connection.prepareStatement(updateQuery);
                    updatePS.setString(1, Username);
                    updatePS.setString(2, email);
                    updatePS.setString(3, flatno);
                    updatePS.setString(4, mobileno);
                    updatePS.setString(5, Id);

                    int rowsUpdated = updatePS.executeUpdate();
                    if (rowsUpdated > 0) {
                        out.println("<script>alert('Updated Successfully..!!');</script>");
                        response.sendRedirect("managemem.jsp");
                    } else {
                        out.println("<script>alert('Not updated...Please try again.!!');</script>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

</body>
</html>
