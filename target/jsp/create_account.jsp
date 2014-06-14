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
            <li><a href="jsp/index.jsp">Index</a></li>
            <li><a href="#">Settings</a></li>
            <li><a href="jsp/deleteLoginSession.jsp">Logout</a></li>
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

          <%
            Object prevFirstName, prevLastName, prevUsername;
            if (request.getAttribute("accountCreateSuccess") == "success") {
              prevFirstName = request.getSession().getAttribute("firstName").toString();
              prevLastName = request.getSession().getAttribute("lastName").toString();
              prevUsername = request.getSession().getAttribute("username").toString();
            } else {
              prevFirstName = request.getAttribute("prevFirstName");
              prevFirstName = (prevFirstName != null) ? prevFirstName.toString() : "";
              prevLastName = request.getAttribute("prevLastName");
              prevLastName = (prevLastName != null) ? prevLastName.toString() : "";
              prevUsername = request.getAttribute("prevUsername");
              prevUsername = (prevUsername != null) ? prevUsername.toString() : "";
            }
          %>

          <form id="create_account_form" action="/CS2340Servlet/createAccount" method="POST" class="form-inline" role="form">
            <b>Enter your Personal Information:</b><br />
            <div class="form-group">
              <label class="sr-only" for="firstName">FirstName</label>
              <input type="text" class="form-control" id="firstName" name="firstName"
                value="<%=prevFirstName%>"
                required="required"
                placeholder = "Enter First Name" />
            </div>
            <br />

            <div class="form-group">
              <label class="sr-only" for="lastName">LastName</label>
              <input type="text" class="form-control" id="lastName" name="lastName"
                value="<%=prevLastName%>"
                required="required"
                placeholder = "Enter Last Name" />
            </div>
            <br /><br />

            <b>Enter new Account Information:</b><br />
            <div class="form-group">
              <label class="sr-only" for="userName">Username</label>
              <input type="text" class="form-control"  id="userName"
                name="newUsername"
                value="<%=prevUsername%>"
                required="required"
                placeholder = "Enter Username" />
            </div>
            <br />

            <div class="form-group">
            <label class="sr-only" for="newPassword">Password</label>
            <input type="password" class="form-control" id="newPassword"
              name="newPassword"
              onkeyup="checkPass(document.getElementById('newPassword'),
                document.getElementById('confirmPassword'),
                document.getElementById('confirmMessage'));
                return false;"
              required="required"
              placeholder = "Enter Password" />
            </div>
            <br />

            <div class="form-group">
            <label class="sr-only" for="confirmPassword">Password</label>
            <input type="password" class="form-control" id="confirmPassword"
              name="confirmPassword"
              onkeyup="checkPass(document.getElementById('newPassword'),
                document.getElementById('confirmPassword'),
                document.getElementById('confirmMessage'));
                return false;"
              required="required"
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

    <!-- Asks user if wants to automatically log into application following successful account creation -->
    <script>
      var success = "${accountCreateSuccess}";
      if (success === "success") {
        var response = window.confirm("Account successfully created. Automatically logging you in.");
        if (response) {
          window.location.replace("/CS2340Servlet/jsp/createLoginSession.jsp");
        } else {
          window.location.replace("/CS2340Servlet/jsp/index.jsp");
        }
      }
    </script>

    <!-- Password color change confirmation Javascript -->
    <script src="/CS2340Servlet/js/password_check.js">
    </script>

    <!-- Bootstrap core JavaScript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="/CS2340Servlet/js/bootstrap.min.js"></script>
    <script src="/CS2340Servlet/js/docs.min.js"></script>
  </body>
</html>