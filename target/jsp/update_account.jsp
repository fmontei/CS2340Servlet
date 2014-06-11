<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
        response.sendRedirect("/CS2340Servlet/jsp/index.jsp");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Account Settings</title>
    </head>
    <body>
        <h1>Account Settings</h1>
        <a href="/CS2340Servlet/index">Back to Index</a>
    </body>
</html>