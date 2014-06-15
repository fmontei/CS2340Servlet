<%@ page import="model.UserAccount" %>

<% String pageName = "Home"; %>
<% String preferredTravelMode = ""; %>

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
    UserAccount account = (UserAccount) session.getAttribute("currentUser");
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
                    Welcome <%=request.getSession().getAttribute("welcomeName")%>!
                </h1>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Facebook Login
                    </div>
                    <div class="panel-body">
                        <fb:login-button id="fbLoginButton" scope="public_profile,email"
                                         onlogin="checkLoginState();">
                        </fb:login-button>
                    </div>
                </div>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Active Itinerary
                    </div>
                    <div class="panel panel-body">

                        <div class="btn-group" id="start-dropdown">
                            <button type="button" class="btn btn-info">What would you like to do?</button>
                            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Create New Itinerary</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                            </ul>
                        </div>

                        <div style="float: right;" class="visibilityOff">
                            <div class="btn-group" >
                                <button type="button" class="btn btn-success" id="create-itinerary">Create</button>
                            </div>
                            <div class="btn-group" >
                                <button type="button" class="btn btn-danger" id="cancel-itinerary">Cancel</button>
                            </div>
                        </div><br /><br />

                        <div id="new-itinerary-info" class="visibilityOff">
                            <div class="input-group">
                                <span class="input-group-addon">Name your Itinerary:</span>
                                <input type="text" class="form-control" placeholder="Name">
                            </div><br />

                            <div class="input-group">
                                <span class="input-group-addon">Address:</span>
                                <input type="text" class="form-control" placeholder="Street">
                                <span class="input-group-addon">City:</span>
                                <input type="text" class="form-control" placeholder="City">
                                <span class="input-group-addon">State:</span>
                                <input type="text" class="form-control" placeholder="State">
                                <span class="input-group-addon">Zip Code:</span>
                                <input type="text" class="form-control" placeholder="Zip Code">
                                <span class="input-group-addon">Country:</span>
                                <input type="text" class="form-control" placeholder="Country">
                            </div><br />

                            <div class="input-group">
                                <span class="input-group-addon">Mode of Transportation:</span>
                                <input type="text" class="form-control" placeholder="Transportation">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="travelMode" class="visibilityOff">
                <h1 class="page-header">
                    Travel Mode
                </h1>
                <form id="" action="/CS2340Servlet/index" method="POST" class="form-inline" role="form">

                    <b>Select your preferred mode of transportation</b>

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

<!-- Facebook SDK Javascript -->
<div id="fb-root"></div>
<script type="text/javascript" src="/CS2340Servlet/js/facebookSDK.js">
</script>

<%@ include file="footer.jsp" %>