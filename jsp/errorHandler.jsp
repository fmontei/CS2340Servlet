<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error Handler</title>
</head>
<body>
    Error message:
    <%
        out.println(exception.toString());
    %>
</body>
</html>
