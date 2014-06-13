<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
        response.sendRedirect("/CS2340Servlet/jsp/index.jsp");
    }
%>
<%@ page import="model.Attributes" %>
<% String firstName = Attributes.getAttribute("firstName"); %>
<% String lastName = Attributes.getAttribute("lastName"); %>
<% String username = Attributes.getAttribute("username"); %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Update Account Settings</title>

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
            Update Account Settings
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

          <form id="update_account_form" action="/CS2340Servlet/updateAccount" method="POST" class="form-inline" role="form">
            <b>Update Your Personal Information:</b><br />
            <div class="form-group">
              <label class="sr-only" for="name">Name</label>
              <input type="text" class="form-control" id="name"
                name="updateFirstName"
                value="<%=firstName == null ? "" : firstName %>"
                required="required"
                placeholder = "Enter First Name" />
            </div>
            <br />

            <div class="form-group">
              <label class="sr-only" for="name">Name</label>
              <input type="text" class="form-control" id="name"
                name="updateLastName"
                value="<%=lastName == null ? "" : lastName %>"
                required="required"
                placeholder = "Enter Last Name" />
            </div>
            <br />

            <span class="help-block" style="padding-top:10px">
                  If you wish to change your password, please enter your new password below.<br />
                  However, if you do not want to change your password, you do not have to re-enter it.<br />
            </span>

            <b>Update Account Information:</b><br />
            <div class="form-group">
            <label class="sr-only" for="password">Password</label>
            <input type="password" class="form-control" id="oldPassword"
              name="oldPassword"
              onkeyup="checkPass(document.getElementById('oldPassword'),
                document.getElementById('confirmOldPassword'),
                document.getElementById('confirmMessage'));
                return false;"
              placeholder = "Enter Password" />
            </div>
            <br />

            <div class="form-group">
            <label class="sr-only" for="password">Password</label>
            <input type="password" class="form-control" id="confirmOldPassword"
              name="confirmOldPassword"
              onkeyup="checkPass(document.getElementById('oldPassword'),
                document.getElementById('confirmOldPassword'),
                document.getElementById('confirmMessage'));
                return false;"
              placeholder = "Re-enter Password" />
            </div>
            <br />

            <span id="confirmMessage" class="confirmMessage"></span><br /><br />
            <span class="text-danger">${error}</span><br />

            <div class="form-group">
              <button type="submit" name="submitButton"
                class="btn btn-default">Submit</button>
            </div>
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