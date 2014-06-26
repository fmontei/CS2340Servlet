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
