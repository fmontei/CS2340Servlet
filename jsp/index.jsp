<%@ page import="database.User" %>

<% String pageName = "Home"; %>
<% String preferredTravelMode = ""; %>

<%@ include file="header.jsp" %>

<%if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {%>

<div class="container">
    <div class="row">
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
        <div class="col-md-10 col-md-offset-1">
            <div id="div-overview">
                <h1 class="page-header">
                    Welcome <%=request.getSession().getAttribute("welcomeName")%>!
                </h1>

                <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                    <!-- Indicators -->
                    <ol class="carousel-indicators">
                        <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                        <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                    </ol>

                    <!-- Wrapper for slides -->
                    <div class="carousel-inner">
                        <div class="item active">
                            <img src="http://static.guim.co.uk/sys-images/Guardian/Pix/pictures/2014/4/11/1397210130748/Spring-Lamb.-Image-shot-2-011.jpg" alt="..."
                                 style="width: 400px; height: 270px; display: block; margin-left: auto; margin-right: auto">
                            <div class="carousel-caption">
                                Jimmy Nguyen
                            </div>
                        </div>

                        <div class="item">
                            <img src="http://www5.pcmag.com/media/images/397260-mobile-threat-monday-top-image.jpg?thumb=y" alt="..."
                                 style="width: 400px; height: 270px; display: block; margin-left: auto; margin-right: auto">
                            <div class="carousel-caption">
                                Johnathan Kester
                            </div>
                        </div>

                        <div class="item">
                            <img src="http://images.gizmag.com/hero/ibm_human_brain.jpg" alt="..."
                                 style="width: 400px; height: 270px; display: block; margin-left: auto; margin-right: auto">
                            <div class="carousel-caption">
                                Joseph Umujaren
                            </div>
                        </div>
                    </div>

                    <!-- Controls -->
                    <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left"></span>
                    </a>
                    <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right"></span>
                    </a>
                </div><br />

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
                    <div class="panel-body" id="itinerary-panel-body">
                        <ol class="breadcrumb">
                            <li>
                                <a href="itinerary_overview.jsp">Select Itinerary</a>
                            </li>
                            <li><a href="#"
                                   onclick="showPage1()"
                                   data-toggle="modal"
                                   data-target="#itineraryModal">Create New Itinerary
                                </a>
                            </li>
                            <li>
                                <a id="a-create-event" href="#">Create New Event</a>
                            </li>
                        </ol>

                        <ul class="nav nav-pills">
                            <li class="active">
                                <a href="#">
                                    Currently Viewing: ${ITINERARY_NAME}
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <span class="badge pull-right">0</span>
                                    Events
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Map
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    Preferences
                                </a>
                            </li>
                            <li class="alert-success" style="float: right">
                                <a href="#">
                                    <span class="glyphicon glyphicon-plus-sign"
                                          style="position: relative; top: 2px"></span>
                                    <b> Add Event</b>
                                </a>
                            </li>
                        </ul>
                        <br />
                        <p>Use a for loop using jsp code that for every event in the database, shows
                        vital statistics about the event that was created. Or something like that.
                        Can initiate an event creation using a wizard, or, better yet, a side panel
                        that looked like our overview panel that has a bunch of drop downs, and finally
                        a search button or something.</p>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%}%>


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

        // Create New Event
        $("#a-create-event").click(function() {
            //$("#itinerary-panel-body").append('<p id="foo">Some HTML</p>');
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
