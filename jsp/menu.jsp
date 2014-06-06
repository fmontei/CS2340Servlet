<%@ page import="model.Attributes" %>

<!DOCTYPE html>
<html>
    <head>
       <title>Greetings, ${currentUser}</title>
       <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    </head>
    <body>
        <h1 class="header">Greetings, <span><%=Attributes.getAttribute(Attributes.CURRENT_USER)%></span>!</h1>
		<a href="/CS2340Servlet/login">Back</a> <br />
		<a href="/CS2340Servlet/settings">Account Settings</a>
    </body>
</html>