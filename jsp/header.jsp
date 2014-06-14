<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title><%= pageName %></title>

    <!-- Stylesheets -->
    <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    <link href="/CS2340Servlet/css/bootstrap.min.css" rel="stylesheet">
    <link href="/CS2340Servlet/css/dashboard.css" rel="stylesheet">
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
                        <a href="/CS2340Servlet/jsp/create_account.jsp">Sign Up</a>
                    </li>
                </ul>
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
                    <%=Attributes.getAttribute(Attributes.WELCOME_NAME)%>&#39;s Trip Planner
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
    
    <div id="wrapper">