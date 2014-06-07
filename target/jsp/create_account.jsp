<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    </head>
    <body>
    <script>
        alert('Hello, World!')
    </script>
	<h1>Account Creation</h1>
    <form action="/CS2340Servlet/createAccount" method="POST">
		<dl>
			<dt><b>Enter your Personal Information:</b>
			<dd>First name:
				<input type="text" name="firstName" />
			<dd>Last name:
				<input type="text" name="lastName" />

			<dt><b>Enter new Acount Information:</b>
			<dd>Username:
				<input type="text" name="newUsername" />
			<dd>Password:
				<input type="password" name="newPassword" />
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