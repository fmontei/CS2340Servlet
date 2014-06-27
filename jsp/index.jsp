<%@ page import="database.User" %>
<%@ page import="database.Event" %>
<%@ page import="java.util.ArrayList" %>

<% String pageName = "Home"; %>
<% String preferredTravelMode = ""; %>

<%@ include file="header.jsp" %>

<%if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {%>

<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <br /><br /><br />
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel"
                 style="width: 1000px; height: 400px; margin: 0 auto">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner">
                    <div class="item active">
                        <div class="customCarousel">
                            <img src="http://www.listofimages.com/wp-content/uploads/2013/07/city-urban-photography-effects-landscape.jpg"
                                 alt="" />
                            <h2>
                                <span>Welcome to Trip Planner!</span>
                            </h2>
                            <div class="carouselLogin">
                                <button type="button" class="btn btn-default navbar-btn">Login</button>
                            </div>
                            <div class="carouselRegister">
                                <button type="button" class="btn btn-default navbar-btn">Register</button>
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="customCarousel">
                            <img src="http://3.bp.blogspot.com/-bj_PsFI4lDA/UEOyL6Tab0I/AAAAAAAAALM/lNAotGu8b9U/s1600/Ariel-New-York-City.jpg" alt="" />
                            <h2>
                                <span>Welcome to Trip Planner!</span>
                            </h2>
                            <div class="carouselLogin">
                                <button type="button" class="btn btn-default navbar-btn">Login</button>
                            </div>
                            <div class="carouselRegister">
                                <button type="button" class="btn btn-default navbar-btn">Register</button>
                            </div>
                        </div>
                    </div>

                    <div class="item">
                        <div class="customCarousel">
                            <img src="http://sumsphere.files.wordpress.com/2012/09/2652009650_2c14a9cf7d_b.jpg?w=848" alt="" />
                            <h2>
                                <span>Welcome to Trip Planner!</span>
                            </h2>
                            <div class="carouselLogin">
                                <button type="button" class="btn btn-default navbar-btn">Login</button>
                            </div>
                            <div class="carouselRegister">
                                <button type="button" class="btn btn-default navbar-btn">Register</button>
                            </div>
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
            </div>
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
                                <a id="a-create-event" href="#"
                                   id="create-event-breadcrumb">
                                    Create New Event</a>
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
                            <li class="dropdown alert-success" style="float: right">
                                <a href="#" class="dropdown-toggle"data-toggle="dropdown" id="create-event-pill">
                                    <span class="glyphicon glyphicon-plus-sign"
                                          style="position: relative; top: 2px"></span>
                                    <b>Add Event</b>
                                    <span class="caret"></span>
                                </a>
                                <ul class="dropdown-menu pull-left">
                                    <li role ="presentation" class="dropdown-header">
                                        <a role="menuitem" tabindex="-1" href="/CS2340Servlet/itinerary?create_event=1">
                                            Create <b>ONE</b>
                                        </a>
                                    </li>
                                    <li role="presentation" class="dropdown-header">
                                        <a role="menuitem" tabindex="-1" href="/CS2340Servlet/itinerary?create_event=2">
                                            Create <b>TWO</b>
                                        </a>
                                    </li>
                                    <li role="presentation" class="dropdown-header">
                                        <a role="menuitem" tabindex="-1" href="/CS2340Servlet/itinerary?create_event=3">
                                            Create <b>THREE</b>
                                        </a>
                                    </li>
                                    <li role="presentation" class="dropdown-header">
                                        <a role="menuitem" tabindex="-1" href="/CS2340Servlet/itinerary?create_event=5">
                                            Create <b>FIVE</b>
                                        </a>
                                    </li>
                                    <li role="presentation" class="dropdown-header">
                                        <a role="menuitem" tabindex="-1" href="/CS2340Servlet/itinerary?create_event=10">
                                            Create <b>TEN</b>
                                        </a>
                                    </li>
                                    <li role="presentation" class="dropdown-header">
                                        <a role="menuitem" tabindex="-1" href="/CS2340Servlet/itinerary?create_event=20">
                                            Create <b>TWENTY</b>
                                        </a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                        <br />

                        <%  ArrayList<Event> events = (ArrayList<Event>) session.getAttribute("events");
                            int numberOfEvents = 0;
                            if (events != null) {
                                numberOfEvents = events.size();
                            }
                            for (int i = 0; i < numberOfEvents; i++) { %>
                        <div id="event-no-<%=i%>">
                            <div class="panel panel-primary" style="background-color: rgb(208, 213, 239)">
                                <div class="panel-heading">
                                    New Event no. <%=i + 1%>
                                </div>
                                <div class="panel-body">
                                    <div class="row">

                                        <form class="form-inline" role="form" action="/CS2340Servlet/itinerary?event_id=<%=i%>" method="POST">
                                            <div class="form-group" style="padding-left: 20px">
                                                <input name="eventName" type="text" class="form-control" placeholder="Event Name" />
                                            </div>
                                            <div class="form-group" style="padding-left: 20px">
                                                <input name="eventType" type="text" class="form-control" placeholder="Event Type" />
                                            </div>
                                            <div class="form-group" style="padding-left: 20px">
                                                Start: <input name="eventStartTime" type="time" class="form-control" />
                                            </div>
                                            <div class="form-group" style="padding-left: 20px">
                                                End: <input name="eventEndTime" type="time" class="form-control" />
                                            </div>
                                            <div class="form-group" style="float: right; padding-right: 20px">
                                                <input name="updateEventButton" type="submit" class="form-control btn-primary" />
                                            </div>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>

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
        $("#create-event-pill").click(function() {

        });

        // Error Message
        if (error != 'null') {
            $("#errorMessage").modal("show");
        }
    });
</script>

<%@ include file="footer.jsp" %>
