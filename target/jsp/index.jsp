<%@ page import="database.User" %>

<% String pageName = "Home"; %>
<% String preferredTravelMode = ""; %>

<%@ include file="header.jsp" %>

<%if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {%>

<div class="container">
    <div class="row">
<!--         <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
            </ul>
        </div> -->
        <div class="col-md-10 col-md-offset-1">
            <h1 class="page-header">
                Welcome to Trip Planner!
            </h1>
            <p>
                Please login to begin
            </p>
        </div>
    </div>
</div>

<%} else {%>

<%
    User account = (User) session.getAttribute("currentUser");
    //preferredTravelMode = account.getPreferredTravelMode();
%>

<div class="container">
    <div class="row">
<<<<<<< HEAD
<!--         <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li id="li-overview" class="active"><a href="#Overview" id="a-overview">Overview</a></li>
                <li id="li-travelMode"><a href="#TravelMode" id="a-travelMode">Travel Mode</a></li>
=======
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar visibilityOn" id="index_showOverviewActive">
                <li class="active"><a href="#">Overview</a></li>
                <li><a href="#" onclick="index_showTravelModeActive()">Travel Mode</a></li>
                <li><a href="#" onclick="index_showMapActive()">Map</a></li>
            </ul>
            <ul class="nav nav-sidebar visibilityOff" id="index_showTravelModeActive">
                <li><a href="#" onclick="index_showOverviewActive()">Overview</a></li>
                <li class="active"><a href="#">Travel Mode</a></li>
                <li><a href="#" onclick="index_showMapActive()">Map</a></li>
            </ul>
            <ul class="nav nav-sidebar visibilityOff" id="index_showMapActive">
                <li><a href="#" onclick="index_showOverviewActive()">Overview</a></li>
                <li><a href="#" onclick="index_showTravelModeActive()">Travel Mode</a></li>
                <li class="active"><a href="#">Map</a></li>
>>>>>>> upstream/revision
            </ul>
        </div> -->
        <div class="col-md-10 col-md-offset-1">
            <div id="div-overview">
                <h1 class="page-header">
                    Welcome <%=request.getSession().getAttribute("welcomeName")%>!
                </h1>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Facebook Login
                    </div>
                    <div class="panel-body">
                        <fb:login-button id="fbLoginButton" scope="public_profile,email" onlogin="checkLoginState();">
                        </fb:login-button>
                    </div>
                </div>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Itineraries
                    </div>
                    <div class="panel-body">
                        <p>Print itineraries here</p>
                        <div class="btn-group" >
                            <button id="button-createNewItinerary" type="button" class="btn btn-default">Create New Itinerary</button>
                        </div>




                        <!-- <div class="btn-group" id="start-dropdown">
                            <button type="button" class="btn btn-info">What would you like to do?</button>
                            <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                                <span class="caret"></span>
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Create New Itinerary</a></li>
                                <li class="divider"></li>
                                <li><a onclick="index_showMapActive()"
                                       style="cursor:  pointer">
                                    View Map for Itinerary</a>
                                </li>
                            </ul>
                        </div>

                        <div style="float: right;">
                            <div class="btn-group" >
                                <button type="button" class="btn btn-success" id="create-itinerary">Create</button>
                            </div>
                            <div class="btn-group" >
                                <button type="button" class="btn btn-danger" id="cancel-itinerary">Cancel</button>
                            </div>
                        </div><br /><br />

                        <div id="new-itinerary-info">
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
                        </div> -->
                    </div>
                </div>
            </div>
            <div id="div-travelMode">
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

            <div id="map" class="visibilityOff">
                <h1 class="page-header">
                    Itinerary Map
                </h1>

                <div class="panel-group">
                  <div class="panel panel-default">
                    <div class="panel-heading">
                    </div>
                    <div class="panel-body">
                      <div id="map-canvas"></div>
                    </div>
                  </div>
                </div>
            </div>

        </div>
    </div>
</div>

<%}%>

<<<<<<< HEAD
<!-- Error Message -->
<div class="modal fade" id="errorMessage" tabindex="-1" role="dialog" aria-labelledby="errorMessageTitle" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="errorMessageTitle">Error</h4>
            </div>
            <div class="modal-body">
                <span class="text-danger">
                    ${error}
                </span>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
=======
<!-- Google Maps Javascript -->
<div id="map-canvas"></div>
<script type="text/javascript"
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBwnaM0fAa8jqx3O7ZdABTaWmbOW3Uft2Y">
</script>

<script type="text/javascript">
    var map;
    function initialize() {
        var mapOptions = {
            center: new google.maps.LatLng(33.755, -84.390),
            zoom: 12
        };
        map = new google.maps.Map(document.getElementById("map-canvas"),
            mapOptions);
        google.maps.event.addListener(map, 'click', function(event) {
            placeMarker(event.latLng);
        });
    }

    function placeMarker(location) {
        var marker = new google.maps.Marker({
            position: location,
            map: map
        });
    }
</script>

<!-- Index Sidebar Javascript -->
<script type="text/javascript">
    function index_showOverviewActive() {
        turnOnVisibility(['index_showOverviewActive','overview']);
        turnOffVisibility(['index_showTravelModeActive','travelMode']);
        turnOffVisibility(['index_showMapActive', 'map']);
    }
    function index_showTravelModeActive() {
        turnOnVisibility(['index_showTravelModeActive','travelMode']);
        turnOffVisibility(['index_showOverviewActive','overview']);
        turnOffVisibility(['index_showMapActive', 'map']);

        // Travel Mode Form Javascript
        var preferredTravelMode = "#<%= preferredTravelMode %>"
        $(preferredTravelMode).prop("checked", true);
    }
    function index_showMapActive() {
        turnOnVisibility(['index_showMapActive', 'map']);
        turnOffVisibility(['index_showOverviewActive','overview']);
        turnOffVisibility(['index_showTravelModeActive','travelMode']);
    }
</script>

>>>>>>> upstream/revision

<!-- Index Javascript -->
<script type="text/javascript">
    var error = '<%= request.getAttribute("error")%>';
    $(document).ready(function() {
        // Initial view
        $("#div-overview").show();
        $("#div-travelMode").hide();

        // Sidebar
        $("#a-overview").click(function() {
            $("#li-overview").addClass("active");
            $("#li-travelMode").removeClass("active");
            $("#div-overview").show();
            $("#div-travelMode").hide();
        });
        $("#a-travelMode").click(function() {
            $("#li-overview").removeClass("active");
            $("#li-travelMode").addClass("active");
            $("#div-overview").hide();
            $("#div-travelMode").show();
        });

        // Stuff
        $("button-createNewItinerary").click(function() {

        });

        // Error Message
        if (error != 'null') {
            $("#errorMessage").modal("show");
        }

    });
</script>


<%@ include file="footer.jsp" %>
