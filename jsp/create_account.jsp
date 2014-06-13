<%@ page import="model.Attributes" %>
<% String prevFirstName = Attributes.getAttribute("prevFirstName"); %>
<% String prevLastName = Attributes.getAttribute("prevLastName"); %>
<% String prevUsername = Attributes.getAttribute("prevUsername"); %>

<html>
  <head>
    <title>Account Creation</title>

    <!-- Stylesheets -->
    <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    <link href="/CS2340Servlet/css/bootstrap.min.css" rel="stylesheet">
    <link href="/CS2340Servlet/css/dashboard.css" rel="stylesheet">
  </head>
  <body>

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">
            Account Settings
          </a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="index.jsp">Index</a></li>
            <li><a href="#">Settings</a></li>
            <li><a href="deleteLoginSession.jsp">Logout</a></li>
          </ul>
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="#">Overview</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">
            Account Settings
          </h1>

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
              <dd><span id="label">Password:</span><br />
                <input name="newPassword" id="newPassword" type="password">
              <dd><span id="label">Confirm Password:</span><br />
                <input name="confirmPassword" id="confirmPassword"
                 onkeyup="checkPass(document.getElementById('newPassword'),
                          document.getElementById('confirmPassword'),
                          document.getElementById('confirmMessage'));
                          return false;"
                 type="password"><br />
                <span id="confirmMessage" class="confirmMessage"></span>
              </dl>
              <span class="error">${error}</span>
              <center>
                  <input id="submit" type="submit" name="submitButton" text="Submit" />
              </center>
          </form>

        </div>
      </div>
    </div>

    <!-- Password confirmation Javascript -->
    <script src="/CS2340Servlet/js/password_check.js">
    </script>

    <!-- Bootstrap core JavaScript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="/CS2340Servlet/js/bootstrap.min.js"></script>
    <script src="/CS2340Servlet/js/docs.min.js"></script>
  </body>
</html>