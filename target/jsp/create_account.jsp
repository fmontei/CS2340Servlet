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

	<script type="text/javascript">
        function checkPass()
        {
            var pass1 = document.getElementById('newPassword');
            var pass2 = document.getElementById('confirmPassword');
            var message = document.getElementById('confirmMessage');
            var goodColor = "#66cc66";
            var badColor = "#ff6666";
            if (pass1.value == pass2.value) {
                pass2.style.backgroundColor = goodColor;
                message.style.color = goodColor;
                message.innerHTML = "Passwords Match!"
            } else {
                pass2.style.backgroundColor = badColor;
                message.style.color = badColor;
                message.innerHTML = "Passwords Do Not Match!"
            }
        }
	</script>

    <form id="create_account_form" action="/CS2340Servlet/createAccount" method="POST">
		<dl>
			<dt><b>Enter your Personal Information:</b>
			<dd><span id="label">First name:</span><br />
				<input type="text" name="firstName" value="<%=prevFirstName == null ? "" : prevFirstName %>"  />
			<dd><span id="label">Last name:</span><br />
				<input type="text" name="lastName" value="<%=prevLastName == null ? "" : prevLastName %>" />
				<br /><br />
			<dt><b>Enter new Account Information:</b>
			<dd><span id="label">Username:</span><br />
				<input type="text" name="newUsername" value=<%=prevUsername == null ? "" : prevUsername %> >
            <dd>
                <div class="fieldWrapper">
                    <label for="newPassword"><span id="label">Password:</span></label><br />
                    <input name="newPassword" id="newPassword" type="password">
                </div>
            <dd>
                <div class="fieldWrapper">
                    <label for="confirmPassword"><span id="label">Confirm Password:</span></label><br />
                    <input name="confirmPassword" id="confirmPassword" onkeyup="checkPass(); return false;" type="password"><br />
                    <span id="confirmMessage" class="confirmMessage"></span>
                </div>
		</dl>
        <p id="error">${error}</p>
        <center>
            <input id="submit" type="submit" name="submitButton" text="Submit" />
        </center>
	</form>
    </body>
</html>