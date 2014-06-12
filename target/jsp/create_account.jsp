<%@ page import="model.Attributes" %>
<% String prevFirstName = Attributes.getAttribute("prevFirstName"); %>
<% String prevLastName = Attributes.getAttribute("prevLastName"); %>
<% String prevUsername = Attributes.getAttribute("prevUsername"); %>

<html>
    <head>
        <title>Account Creation</title>
        <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    </head>
    <body>
	<h1 id="accountHeader">Account Creation</h1>
    <form id="create_account_form" action="/CS2340Servlet/createAccount" method="POST">
		<dl>
			<dt><b>Enter your Personal Information:</b>
			<dd><span id="label">First name:</span><br />
				<input type="text" name="firstName" value="<%=prevFirstName == null ? "" : prevFirstName %>" required="required"  />
			<dd><span id="label">Last name:</span><br />
				<input type="text" name="lastName" value="<%=prevLastName == null ? "" : prevLastName %>" required="required" />
				<br /><br />
			<dt><b>Enter new Account Information:</b>
			<dd><span id="label">Username:</span><br />
				<input type="text" name="newUsername" value="<%=prevUsername == null ? "" : prevUsername %>" required="required" />
            <dd>
                <div class="fieldWrapper">
                    <label for="newPassword"><span id="label">Password:</span></label><br />
                    <input name="newPassword" id="newPassword" type="password" required="required">
                </div>
            <dd>
                <div class="fieldWrapper">
                    <label for="confirmPassword"><span id="label">Confirm Password:</span></label><br />
                    <input name="confirmPassword" id="confirmPassword"
                        onkeyup="checkPass(document.getElementById('newPassword'),
                                          document.getElementById('confirmPassword'),
                                          document.getElementById('confirmMessage'));
                                          return false;"
                        type="password"
                        required="required"><br />
                    <span id="confirmMessage" class="confirmMessage"></span>
                </div>
		</dl>
        <p id="error">${error}</p>
        <center>
            <input id="submit" type="submit" name="submitButton" text="Submit" />
        </center>
	</form>

	<script src="/CS2340Servlet/js/password_check.js">
    </script>
    </body>
</html>