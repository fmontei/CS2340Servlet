<%@ page import="model.AccountForm" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    </head>
    <body>
	<h1>Login</h1>
        <form action="/CS2340Servlet/login" method="POST">
			<table>
				<thead>
					<span class="error">${error}</span>
				</thead>
				<tbody>
					<tr>
						<td>Name:</td>
						<td><input type="text" name="username" /></td>
					</tr>
					<tr>
						<td>Password:</td>
						<td><input type="password" name="password" autocomplete="off" /></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" value="Login" name="loginButton" style="width:99%;" /></td>
					</tr>
					<tr>
						<td></td>
						<td><input type="submit" value="Create New Account" name="createAccountButton" style="width:99%;" /></td>
					</tr>
				</tbody>
			</table>
        </form>
		<p>Number of Accounts: <%=AccountForm.getUserAccounts().size()%></p>
    </body>
</html>