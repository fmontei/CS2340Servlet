<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />

    <!-- Stylesheets -->
    <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    <link href="/CS2340Servlet/css/bootstrap.min.css" rel="stylesheet">
    <link href="/CS2340Servlet/css/dashboard.css" rel="stylesheet">

    <!-- Jquery Javascript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

</head>
<body>

<%
if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/CS2340Servlet/jsp/index.jsp">
                    Trip Planner
                </a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" href="#" data-toggle="dropdown">Login <strong class="caret"></strong></a>
                        <div class="dropdown-menu" style="padding: 15px;">
                            <!--Login form-->
                            <form action="/CS2340Servlet" method="POST" accept-charset="UTF-8">

                                <input id="user_username" style="margin-bottom: 15px;" type="text" name="username" size="30" placeholder="Username" required="required"/>

                                <input id="user_password" style="margin-bottom: 15px;" type="password" name="password" size="30" placeholder="Password" required="required"/>
                                
                                <input class="btn btn-primary" style="clear: left; width: 100%; height: 32px; font-size: 13px;" type="submit" name="loginButton" value="Login" />

                            </form>
                        </div>
                    </li>
                    <li>
                        <a href="#" data-toggle="modal" data-target="#signUpForm">Sign Up</a>
                        <!-- href="/CS2340Servlet/jsp/create_account.jsp"  -->
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="signUpForm" tabindex="-1" role="dialog" aria-labelledby="signUpLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="signUpLabel">Sign Up</h4>
                </div>
                <div class="modal-body">
                    <form action="/CS2340Servlet/index" method="POST" class="form-inline" role="form">
                        <b>Enter your Personal Information</b>

                        <br />
                        <br />

                        <div class="form-group">
                            <label class="sr-only" for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="firstName"
                            required="required"
                            placeholder = "Enter First Name" />
                        </div>

                        <br />
                        <br />

                        <div class="form-group">
                            <label class="sr-only" for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="lastName"
                            required="required"
                            placeholder = "Enter Last Name" />
                        </div>

                        <br />
                        <br />
                        <br />

                        <b>Enter new Account Information</b>

                        <br />
                        <br />

                        <div class="form-group">
                            <label class="sr-only" for="name">Name</label>
                            <input type="text" class="form-control" id="name"
                            name="newUsername"
                            required="required"
                            placeholder = "Enter Username" />
                        </div>

                        <br />
                        <br />

                        <div class="form-group">
                            <label class="sr-only" for="name">Password</label>
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
                        <br />

                        <div class="form-group">
                            <label class="sr-only" for="name">Password</label>
                            <input type="password" class="form-control" id="confirmPassword"
                            name="confirmPassword"
                            onkeyup="checkPass(document.getElementById('newPassword'),
                            document.getElementById('confirmPassword'),
                            document.getElementById('confirmMessage'));
                            return false;"
                            required="required"
                            placeholder = "Re-enter Password" />
                        </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" name="signUpButton" class="btn btn-primary">Sign Up</button>
                </div> 
                    </form>
            </div>
        </div>
    </div>

<% } else { %>

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
                    <%=session.getAttribute("welcomeName")%>&#39;s Trip Planner
                </a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="/CS2340Servlet/jsp/index.jsp">Home</a></li>
                    <li><a href="/CS2340Servlet/jsp/update_account.jsp">Settings</a></li>
                    <li><a href="/CS2340Servlet/jsp/deleteLoginSession.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </div>


<% } %>
    
    <!-- wrapper div -->
    <div id="wrapper">


<script>
</script>

<!-- Password color change confirmation Javascript -->
<script src="/CS2340Servlet/js/password_check.js"></script>