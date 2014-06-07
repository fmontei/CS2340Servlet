<%@ page import="model.Attributes" %>
<% String prevFirstName = Attributes.getAttribute("prevFirstName"); %>
<% String prevLastName = Attributes.getAttribute("prevLastName"); %>
<% String prevUsername = Attributes.getAttribute("prevUsername"); %>

<html>
    <head>
        <title>Login Page</title>
        <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    </head>
    <body>
	<h1>Account Creation</h1>
    <form action="/CS2340Servlet/createAccount" method="POST">
		<dl>
			<dt><b>Enter your Personal Information:</b>
			<dd>First name:
				<input type="text" name="firstName" value=<%=prevFirstName == null ? "" : prevFirstName %>  >
			<dd>Last name:
				<input type="text" name="lastName" value=<%=prevLastName == null ? "" : prevLastName %> >
			<dt><b>Enter new Account Information:</b>
			<dd>Username:
				<input type="text" name="newUsername" value=<%=prevUsername == null ? "" : prevUsername %> >
			<dd>Password:
				<input type="password" name="newPassword" />
			<dd>Confirm Password:
                <input type="password" name="confirmPassword" />
		</dl>
		<p>
			${error}
			<center>
				<input type="submit" name="submitButton" text="Submit" />
			</center>
		</p>
	</form>
    </body>
</html>