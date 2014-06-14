<%@ page import="model.Attributes" %>
<%@ page import="model.AccountForm" %>

<% String pageName="Home"; %>

<%@ include file="header.jsp" %>

<%if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {%>

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

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="active"><a href="#">Overview</a></li>
            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">
                Welcome <%=Attributes.getAttribute(Attributes.WELCOME_NAME)%>!
            </h1>
            <fb:login-button id="fbLoginButton" scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>
        </div>
    </div>
</div>

<%}%>

<!-- Facebook SDK Javascript -->
<div id="fb-root"></div>
<script type="text/javascript" src="/CS2340Servlet/js/facebookSDK.js">
</script>

<%@ include file="footer.jsp" %>