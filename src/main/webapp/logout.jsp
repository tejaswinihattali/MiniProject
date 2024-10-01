<%@ page import="java.util.*" %>
<%
    // Invalidate the session to log the user out
    HttpSession s = request.getSession(false);
    if (s != null) {
        s.invalidate();  // Clear the session
    }
    // Redirect to login page
    response.sendRedirect("register.html");
%>
