<%@ page import="model.Attributes" %>
<%@ page import="model.AccountForm" %>
<% String prevFirstName = Attributes.getAttribute("prevFirstName"); %>
<% String prevLastName = Attributes.getAttribute("prevLastName"); %>
<% String prevUsername = Attributes.getAttribute("prevUsername"); %>

<!DOCTYPE html>
<html>
    <head>
      <meta charset="utf-8" />
      <title>Trip Planner</title>

      <!-- Stylesheets -->
      <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
      <link href="/CS2340Servlet/css/bootstrap.min.css" rel="stylesheet">
      <link href="/CS2340Servlet/css/dashboard.css" rel="stylesheet">

    </head>
    <body>

    <%if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {%>

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
              Trip Planner
            </a>
          </div>
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
              <li class="dropdown">
                <a class="dropdown-toggle" href="#" data-toggle="dropdown">Login <strong class="caret"></strong></a>
                <div class="dropdown-menu" style="padding: 15px;">
                  <!--Login form-->
                  <form action="/CS2340Servlet/login" method="POST" accept-charset="UTF-8">

                    <input id="user_username" style="margin-bottom: 15px;" type="text" name="username" size="30" placeholder="Username" required="required"/>

                    <input id="user_password" style="margin-bottom: 15px;" type="password" name="password" size="30" placeholder="Password" required="required"/>
                   
                    <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="loginButton" value="Login" />

                  </form>
                </div>
              </li>
              <li>
                <!-- <a href="/CS2340Servlet/jsp/create_account.jsp">Sign Up</a> -->
                <a href="#" data-toggle="modal" data-target="#myModal">Sign Up</a>
                <!-- Button trigger modal -->
                <!-- <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
                  Launch demo modal
                </button>
 -->
                <!-- Modal -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Sign Up</h4>
                      </div>
                      <div class="modal-body">

                        <form id="create_account_form" action="/CS2340Servlet/createAccount" method="POST">

                            <!-- <dt><b>Enter your Personal Information:</b> -->
                            <!-- <dd><span id="label">First name:</span><br /> -->
                              <input type="text" name="firstName" style="margin-bottom: 15px;" size="30" required="required" placeholder="First Name"/>
                              <br/>
                            <!-- <dd><span id="label">Last name:</span><br /> -->
                              <input type="text" name="lastName" style="margin-bottom: 15px;" size="30" required="required" placeholder="Last Name"/>
                              <br/>
                              <!-- <br /><br /> -->
                            <!-- <dt><b>Enter new Account Information:</b> -->
                            <!-- <dd><span id="label">Username:</span><br /> -->
                              <input type="text" name="newUsername" style="margin-bottom: 15px;" size="30" required="required" placeholder="Username"/>
                              <br/>
                                  <!-- <dd> -->
                                      <!-- <div class="fieldWrapper"> -->
                                          <!-- <label for="newPassword"><span id="label">Password:</span></label><br /> -->
                                          <input name="newPassword" style="margin-bottom: 15px;" size="30" id="newPassword" type="password" required="required" placeholder="Password"><br/>
                                      <!-- </div> -->
                                  <!-- <dd> -->
                                      <!-- <div class="fieldWrapper"> -->
                                          <!-- <label for="confirmPassword"><span id="label">Confirm Password:</span></label><br /> -->
                                          <input name="confirmPassword" style="margin-bottom: 15px;" size="30" id="confirmPassword" onkeyup="checkPass(); return false;" type="password" required="required" placeholder="Confirm Password"><br />
                                          <span id="confirmMessage" class="confirmMessage"></span>
                                      <!-- </div> -->
                          <!-- </dl> -->
                              <p id="error">${error}</p>

                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <input id="submit" type="submit" name="submitButton" text="Sign Up" class="btn btn-primary"/>
                        <!-- <button type="button" class="btn btn-primary">Save changes</button> -->
                      </div>

                        </form>
                    </div>
                  </div>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>

      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
            </ul>
          </div>
          <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">
              Welcome to Trip Planner!
            </h1>
            <p>
              Please login to begin
            </p>
            <span class="error">
              ${error}
            </span>
          </div>
        </div>
      </div>

    <%} else {%>

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
              <%=session.getAttribute("userid")%>&#39;s Trip Planner
            </a>
          </div>
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
              <li>
                <fb:login-button id="fbLoginButton" scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>
              </li>
              <li><a href="#">Dashboard</a></li>
              <li><a href="/CS2340Servlet/updateAccount">Settings</a></li>
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
              <li><a href="#">Reports</a></li>
              <li><a href="#">Analytics</a></li>
              <li><a href="#">Export</a></li>
            </ul>
          </div>
          <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">
              Welcome <%=session.getAttribute("userid")%>!
            </h1>
          </div>
        </div>
      </div>

    <%}%>

        <!-- Old stuff -->

        <!-- <nav>
            <span id="overviewMessage">
                <%=Attributes.getAttribute(Attributes.CURRENT_USER)%>&#39;s Trip Planner
            </span>
            <fb:login-button id="fbLoginButton" scope="public_profile,email" onlogin="checkLoginState();">
            </fb:login-button>
            <select id="nav" onChange="doDropdownAction(this); checkLoginState();" onFocus="checkLoginState();">
                <option value="">Navigation</option>
                <option value="/CS2340Servlet/updateAccount">Account Settings</option>
                <option value="/CS2340Servlet/login">Logout</option>
            </select>
            <div id="status">
            </div>
        </nav>
        <header>
            Trip Planner Overview
        </header> -->

        <!-- Facebook SDK Javascript -->
        <script type="text/javascript" src="/CS2340Servlet/js/facebookSDK.js">
        </script>

        <!-- Old, check for facebook logout -->
<!-- 
        <script type="text/javascript">
            function doDropdownAction(nav) {
               return nav.options[nav.selectedIndex].value && (window.location = nav.options[nav.selectedIndex].value);
            }
        </script>
 -->

        <div id="fb-root"></div>

        <script type="text/javascript">
            // Facebook login
            (function(d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id)) return;
                js = d.createElement(s); js.id = id;
                js.src = "//connect.facebook.net/en_US/sdk.js";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));

            // Dropdown Login Form
            $(function() {
              // Setup drop down menu
              $('.dropdown-toggle').dropdown();
             
              // Fix input element click problem
              $('.dropdown input, .dropdown label').click(function(e) {
                e.stopPropagation();
              });
            });
        </script>

        <!-- Bootstrap core JavaScript -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="/CS2340Servlet/js/bootstrap.min.js"></script>
        <script src="/CS2340Servlet/js/docs.min.js"></script>

    </body>
</html>