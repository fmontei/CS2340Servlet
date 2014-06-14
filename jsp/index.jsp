<%@ page import="model.Attributes" %>
<%@ page import="model.AccountForm" %>
<%@ page import="model.DataStore" %>
<%@ page import="model.UserAccount" %>

<% String pageName="Home"; %>

<% String preferredTravelMode=""; %>

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

<%
String username = Attributes.getAttribute(Attributes.CURRENT_USER);
UserAccount account = DataStore.findByUserName(username);
preferredTravelMode = account.getPreferredTravelMode();
%>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar visibilityOn" id="index_showOverviewActive">
                <li class="active"><a href="#">Overview</a></li>
                <li><a href="#" onclick="index_showTravelModeActive()">Travel Mode</a></li>
            </ul>
            <ul class="nav nav-sidebar visibilityOff" id="index_showTravelModeActive">
                <li><a href="#" onclick="index_showOverviewActive()">Overview</a></li>
                <li class="active"><a href="#">Travel Mode</a></li>
            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div id="overview" class="visibilityOn">
                <h1 class="page-header">
                    Welcome <%=Attributes.getAttribute(Attributes.WELCOME_NAME)%>!
                </h1>
                <fb:login-button id="fbLoginButton" scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>
            </div>
            <div id="travelMode" class="visibilityOff">
                <h1 class="page-header">
                    Travel Mode
                </h1>
                <form id="" action="/CS2340Servlet/index" method="POST" class="form-inline" role="form">

                    <b>Select your prefered mode of transportation</b>

                    <br />
                    <br />

                    <div class="row">
                        <div class="col-lg-4">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <input type="radio" id="driving"
                                    name="preferredTravelMode"
                                    value="driving">
                                </span>
                                <input type="text" class="form-control" value="Driving" readonly>
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="row">
                        <div class="col-lg-4">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <input type="radio" id="walking"
                                    name="preferredTravelMode"
                                    value="walking" checked>
                                </span>
                                <input type="text" class="form-control" 
                                value="Walking" readonly>
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="row">
                        <div class="col-lg-4">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <input type="radio" id="bicycling"
                                    name="preferredTravelMode"
                                    value="bicycling" checked>
                                </span>
                                <input type="text" class="form-control" 
                                value="Bicycling" readonly>
                            </div>
                        </div>
                    </div>

                    <br />

                    <div class="row">
                        <div class="col-lg-4">
                            <div class="input-group">
                                <span class="input-group-addon">
                                    <input type="radio" id="transit"
                                    name="preferredTravelMode"
                                    value="transit" checked>
                                </span>
                                <input type="text" class="form-control" 
                                value="Transit" readonly>
                            </div>
                        </div>
                    </div>

                    <br />
                    <br />

                    <div class="form-group">
                        <button type="submit" name="submitTravelMode"
                        class="btn btn-default">Save</button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<%}%>

<!-- Index Sidebar Javascript -->
<script type="text/javascript">
    function index_showOverviewActive() {
        turnOnVisibility(['index_showOverviewActive','overview']);
        turnOffVisibility(['index_showTravelModeActive','travelMode']);
    }
    function index_showTravelModeActive() {
        turnOnVisibility(['index_showTravelModeActive','travelMode']);
        turnOffVisibility(['index_showOverviewActive','overview']);


        // Travel Mode Form Javascript
        var preferredTravelMode = "#<%= preferredTravelMode %>"
        $(preferredTravelMode).prop("checked", true);
    }
</script>


<script type="text/javascript">
</script>

<!-- Facebook SDK Javascript -->
<div id="fb-root"></div>
<script type="text/javascript" src="/CS2340Servlet/js/facebookSDK.js">
</script>

<%@ include file="footer.jsp" %>