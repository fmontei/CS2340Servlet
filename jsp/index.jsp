<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="database.User" %>
<%@ page import="database.Event" %>
<%@ page import="database.Itinerary" %>
<%@ page import="database.SQLPreferenceQuery" %>
<%@ page import="database.Preference" %>
<%@ page import="database.NearbyPlace" %>

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
%>

    <div class="container">
        <div class="row">
            <div class="col-md-2 sidebar" id="itinerary-side-bar">
                <ul class="list-unstyled">
                    <li class="nav-header"> <a href="#" data-toggle="collapse" data-target="#userMenu">
                        <h4>User <i class="glyphicon glyphicon-chevron-down"></i></h4>
                    </a>
                        <ul style="list-style: none;" class="collapse in" id="userMenu">
                            <li class="active"><a href="#"><i class="glyphicon glyphicon-home"></i> Home</a>
                            </li>
                            <li><a href="#"><i class="glyphicon glyphicon-envelope"></i> Messages <span class="badge badge-info">4</span></a>
                            </li>
                            <li><a href="#"><i class="glyphicon glyphicon-cog"></i> Settings</a>
                            </li>
                            <li><a href="#"><i class="glyphicon glyphicon-comment"></i> Shoutbox</a>
                            </li>
                            <li><a href="#"><i class="glyphicon glyphicon-user"></i> Staff List</a>
                            </li>
                            <li><a href="#"><i class="glyphicon glyphicon-flag"></i> Transactions</a>
                            </li>
                            <li><a href="#"><i class="glyphicon glyphicon-exclamation-sign"></i> Rules</a>
                            </li>
                            <li><a href="#"><i class="glyphicon glyphicon-off"></i> Logout</a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-header"> <a href="#" data-toggle="collapse" data-target="#preferences-menuitem">
                        <h4>Preferences <i class="glyphicon glyphicon-chevron-right"></i></h4>
                    </a>
                        <%  Preference preference = (Preference) session.getAttribute("activePreferences"); %>
                        <%  int maxDistance;
                            float minRating;
                            String priceCategory, attractionType, foodType;
                            maxDistance = 0;
                            minRating = 0;
                            priceCategory = attractionType = foodType = "";
                            if (preference != null) {
                                maxDistance = preference.getMaxDistance();
                                minRating = preference.getMinimumRating();
                                priceCategory = preference.getPriceCategory();
                                attractionType = preference.getPreferredAttractionType();
                                foodType = preference.getPreferredFoodType();
                            }
                        %>
                        <ul style="list-style-type: square;" class="collapse" id="preferences-menuitem">
                            <h4>Information &amp; Stats  <a href="#">edit</a></h4>
                            <li><b>Max Distance:</b> <%=maxDistance%></li>
                            <li><b>Rating:</b>  <%=minRating%></li>
                            <li><b>Price</b> : <%=priceCategory%></li>
                            <li><b>Attraction:</b>  <%=attractionType%></li>
                            <li><b>Food:</b>  <%=foodType%></li>
                        </ul>
                    </li>
                    <li class="nav-header">
                        <a href="#" data-toggle="collapse" data-target="#google-search-menuitem">
                            <h4>Keyword Search<i class="glyphicon glyphicon-chevron-right"></i></h4>
                        </a>

                        <ul style="list-style: none; padding-left: 0" class="collapse" id="google-search-menuitem">
                            <li>
                                <div id="google-textsearch">
                                    <form class="form-inline" role="form" action="/CS2340Servlet/itinerary" method="POST">
                                        <div class="form-group">
                                            <input name="google-textsearch-query" type="text"
                                                   class="form-control"
                                                   placeholder="Keyword Search"
                                                   style="width: 70%" />
                                            <input name="google-textsearch-submit"
                                                   type="image"
                                                   value="trialSubmit"
                                                   src="../images/search.png"
                                                   class="form-control" />
                                        </div>
                                    </form>
                                </div>
                            </li>
                                <%  ArrayList<TextSearchPlace> places =
                                        (ArrayList<TextSearchPlace>) session.getAttribute("textSearchResults");
                                    if (places != null) {
                                        int i = 0;
                                        for (TextSearchPlace place : places) {
                                            String placeName = place.getName();
                                            String address = place.getFormattedAddress();
                                            int priceLevel = place.getPriceLevel();
                                            double rating = place.getRating();
                                            boolean openNow = place.isOpenNow();
                                            String openOrClosed = (openNow) ? "Open" : "Closed";
                                            String color = (openNow) ? "rgb(0, 153, 0)" : "red";
                                %>
                                <li data-container="body"
                                    data-toggle="popover"
                                    data-placement="right"
                                    data-content="Price level: <%=priceLevel%> | Rating: <%=rating%>">
                                    <a class="popLink" href="javascript:void(0);" style="font-size: 10px;">
                                        <b><%=++i%>.<%=placeName%></b> | <%=address%> | <span style="color: <%=color%>"><%=openOrClosed%></span>
                                    </a>
                                </li>
                                <%      } %>
                                <%  }     %>

                        </ul>
                    </li>
                </ul>
            </div>

            <div class="col-md-10 col-md-push-2">
                <div id="div-overview">
                    <h1 class="page-header" id="page-header">
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
                                <li id="li-create-event-breadcrumb">
                                    <a id="a-create-event" href="#"
                                       id="a-create-event-breadcrumb">
                                        Create New Event</a>
                                </li>
                            </ol>

                            <ul class="nav nav-pills">
                                <li>
                                    <a href="#" class="alert-success" style="color: rgb(66, 139, 202); font-weight: bold">
                                        Currently Viewing: ${ITINERARY_NAME}
                                    </a>
                                </li>
                                <li>
                                    <%  ArrayList<Event> events = (ArrayList<Event>) session.getAttribute("events");
                                        int numberOfEvents = 0;
                                        if (events != null) {
                                            numberOfEvents = events.size();
                                        }
                                    %>
                                    <a href="#">
                                        <span class="badge pull-right"
                                              style="position: relative; top: 2px; background-color: rgb(66, 139, 202)">
                                            <%=numberOfEvents%>
                                        </span>
                                        Events
                                    </a>
                                </li>




                                <li>
                                    <a href="#" id="preferences-trigger">
                                        Preferences
                                    </a>
                                </li>
                                <li class="dropdown alert-success" style="float: right" id="create-event-pill">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
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
                                <li style="float: right">
                                    <a href="/CS2340Servlet/itinerary?add_lodging=true" class="alert-danger" id="create-lodging-pill">
                                        <span class="glyphicon glyphicon-plus-sign"
                                              style="position: relative; top: 2px">
                                        </span>
                                        <b>Add Lodging</b>
                                    </a>
                                </li>
                            </ul>
                            <br />

                            <div class="panel-group" id="accordion">
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <a data-toggle="collapse"
                                           data-parent="#accordion"
                                           href="#collapseOne"
                                           id="parentCollapse">
                                            View Map
                                        </a>
                                    </div>
                                    <div id="collapseOne" class="panel-collapse collapse in">
                                        <div class="panel-body">
                                            <div class="center-block" id="accordion-map" style="width: 520px; height: 300px;"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <% NearbyPlace selection = (NearbyPlace) session.getAttribute("lodgingSelection");
                                String lodgingIsOpenColor = "";
                                String openClose = "";
                                if (selection != null) {
                                    lodgingIsOpenColor = (selection.isOpenNow()) ? "green" : "red";
                                    openClose = (selection.isOpenNow()) ? "Open" : "Closed";
                                }
                            %>

                            <div id="main-lodging">
                                <div class="panel panel-danger">
                                    <div class="panel-heading">
                                        <% if (selection == null) { %>
                                        New Lodging
                                        <% } else { %>
                                        <b>Lodging: <%=selection.getName()%></b>
                                        <% } %>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row" style="padding-left: 20px">
                                            <% if (selection == null) { %>
                                            <p>Select a lodging below. This list has been created
                                                based on your Itinerary's address.
                                            </p>
                                            <% } %>
                                            <table class="table table-striped">
                                            <% if (selection == null) { %>
                                                <thead id="lodging-table-head">
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Address</th>
                                                        <th>Rating</th>
                                                        <th>Open</th>
                                                        <th>Select</th>
                                                    </tr>
                                                </thead>
                                            <% } else { %>
                                                <thead>
                                                    <tr>
                                                        <th>Name</th>
                                                        <th>Address</th>
                                                        <th>Rating</th>
                                                        <th>Open</th>
                                                    </tr>
                                                </thead>
                                            <% } %>
                                                <tbody>
                            <%  if (selection == null) {
                                    Object lodgingObject = session.getAttribute("lodgingResults");
                                    int numberOfLodgingsFound = 0;
                                    List<NearbyPlace> lodgingResults = new ArrayList<NearbyPlace>();
                                    if (lodgingObject != null) {
                                        lodgingResults = (List<NearbyPlace>) lodgingObject;
                                        numberOfLodgingsFound = lodgingResults.size();
                                    }
                                    for (int i = 0; i < numberOfLodgingsFound; i++) {
                                        lodgingIsOpenColor = (lodgingResults.get(i).isOpenNow()) ? "green" : "red";
                                        openClose = (lodgingResults.get(i).isOpenNow()) ? "Open" : "Closed";
                            %>
                                                    <tr>
                                                        <td class="lodging-name"><%=lodgingResults.get(i).getName()%></td>
                                                        <td class="lodging-address"><%=lodgingResults.get(i).getFormattedAddress()%></td>
                                                        <td class="lodging-rating"><%=lodgingResults.get(i).getRating()%></td>
                                                        <td class="lodging-open-closed" style="color: <%=lodgingIsOpenColor%>"><%=openClose%></td>
                                                        <td><a href="/CS2340Servlet/itinerary?lodging_id=<%=i%>">Select</a></td>
                                                    </tr>
                                    <% } %>
                                                </tbody>
                                                <tfoot>
                                                    <div class="row">
                                                        <form class="form-inline" role="form" action="/CS2340Servlet/itinerary?lodging_id=" method="POST">
                                                            <div class="form-group" style="padding-left: 20px; padding-right: 40px">
                                                                <input name="lodgingSelection" type="text" class="form-control" placeholder="Lodging Name" />
                                                            </div>
                                                            <div class="form-group center-block" style="width: 30%; padding-top: 10px">
                                                                <input name="submitLodgingButton" type="submit" class="form-control btn-primary" />
                                                            </div>
                                                        </form>
                                                    </div>
                                                </tfoot>
                                <% } else { %>
                                                    <tr>
                                                        <td class="lodging-name"><%=selection.getName()%></td>
                                                        <td class="lodging-address"><%=selection.getFormattedAddress()%></td>
                                                        <td class="lodging-rating"><%=selection.getRating()%></td>
                                                        <td class="lodging-open-closed" style="color: <%=lodgingIsOpenColor%>"><%=openClose%></td>
                                                    </tr>
                                                </tbody>
                                <% } %>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <% for (int i = 0; i < numberOfEvents; i++) { %>
                            <% String color = (i % 2 == 0) ? "info" : "success"; %>
                            <div id="event-no-<%=i%>">
                                <div class="panel panel-<%=color%>">
                                    <div class="panel-heading">
                                        <%
                                            String isEventSet = (String) session.getAttribute("isEvent" + i + "Set");
                                            String temp = "true";
                                            if (isEventSet != null && isEventSet.equals(temp)) { %>

                                            <p>
                                                Event no. <%=i + 1%>: <%= session.getAttribute("eventName" + i) %>
                                            </p>

                                        <% } else { %>
                                            New Event no. <%=i + 1%>
                                        <% } %>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">

                                            <form class="form-inline" role="form" action="/CS2340Servlet/itinerary?event_id=<%=i%>" method="POST">
                                                <% if (session.getAttribute("eventName"+i) != null) { %>
                                                    <div class="form-group" style="padding-left: 20px">
                                                        <input name="eventName<%=i%>" type="text" class="form-control" placeholder="Event Name" value='<%=session.getAttribute("eventName"+i)%>'/>
                                                    </div>
                                                    <div class="form-group" style="padding-left: 15px">
                                                        <input name="eventType<%=i%>" type="text" class="form-control typeahead" placeholder="Event Type" value='<%=session.getAttribute("eventType"+i)%>'/>
                                                    </div>
                                                    <div class="form-group" style="padding-left: 15px">
                                                        Start: <input name="eventStartTime<%=i%>" type="time" class="form-control" value='<%=session.getAttribute("eventStartTime"+i)%>'/>
                                                    </div>
                                                    <div class="form-group" style="padding-left: 15px">
                                                        End: <input name="eventEndTime<%=i%>" type="time" class="form-control" value='<%=session.getAttribute("eventEndTime"+i)%>'/>
                                                    </div>
                                                    <div class="form-group" style="float: right; padding-right: 15px">
                                                        <input name="searcEventButton" type="submit" class="form-control btn-primary" value="Search"
                                                               onclick="changeValueToGoogleCode(document.getElementById('eventType' + '<%=i%>'))" />
                                                    </div>
                                                <% } else { %>
                                                    <div class="form-group" style="padding-left: 20px">
                                                        <input name="eventName<%=i%>" type="text" class="form-control" placeholder="Event Name"/>
                                                    </div>
                                                    <div class="form-group" style="padding-left: 15px">
                                                        <input name="eventType<%=i%>" id="eventType<%=i%>" type="text" class="form-control typeahead" placeholder="Event Type" />
                                                    </div>
                                                    <div class="form-group" style="padding-left: 15px">
                                                        Start: <input name="eventStartTime<%=i%>" type="time" class="form-control" />
                                                    </div>
                                                    <div class="form-group" style="padding-left: 15px">
                                                        End: <input name="eventEndTime<%=i%>" type="time" class="form-control" />
                                                    </div>
                                                    <div class="form-group" style="float: right; padding-right: 15px">
                                                        <input name="searcEventButton" type="submit" class="form-control btn-primary" value="Search"
                                                                onclick="changeValueToGoogleCode(document.getElementById('eventType' + '<%=i%>'))" />
                                                    </div>
                                                <% } %>
                                        </div>

                                        <% if (isEventSet != null && isEventSet.equals(temp)) { %>
                                            <div class="row" style="padding-top:20px; padding-left:5px">
                                                <div class="col-md-6">
                                                    <div class="input-group">
                                                        Event Location:
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row" style="padding-top:20px; padding-left:5px">
                                                <div class="col-md-6">
                                                    <input type="text" class="form-control" value="<%= session.getAttribute("eventLocation" + i) %>" readonly>
                                                </div>
                                                <div class="col-md-1">
                                                    <div class="input-group">
                                                        <a href="<%= session.getAttribute("eventBusinessURL" + i) %>" class="btn btn-default" target="_blank"> See More </a>
                                                    </div>
                                                </div>
                                            </div>

                                        <%
                                        } else {
                                            if (session.getAttribute("businesses") != null) {
                                                List<NearbyPlace> businesses = (List<NearbyPlace>) session.getAttribute("businesses");
                                                int numberOfBusinessesShown = 0;
                                                for (NearbyPlace business : businesses) {

                                                    final String businessName = business.getName();
                                                    final double businessRating = business.getRating();
                                                    String businessURL = "unknown";

                                                    Itinerary activeItinerary = (Itinerary) session.getAttribute("activeItinerary");
                                                    final int preferenceID = activeItinerary.getPreferenceID();
                                                    SQLPreferenceQuery query = new SQLPreferenceQuery();
                                                    Preference activePreferences = query.getPreferencesByID(preferenceID);
                                                    final int unknownRating = 0;
                                                    if (businessRating >= activePreferences.getMinimumRating()
                                                            || businessRating == unknownRating) {
                                        %>
                                            <div class="row" style="padding-top:20px; padding-left:5px">
                                                <div class="col-md-6">
                                                    <div class="input-group">
                                                        <span class="input-group-addon">
                                                            <input type="radio" name="eventLocation<%=i%>" value="<%= businessName %>,<%= businessURL %>">
                                                        </span>
                                                        <input type="text" class="form-control" value="<%= businessName %> <%= businessRating == 0 ? "N/A" : businessRating %>" readonly>
                                                    </div>
                                                </div>
                                                <div class="col-md-1">
                                                    <div class="input-group">
                                                        <a href="<%= businessURL %>" class="btn btn-default" target="_blank"> See More </a>
                                                    </div>
                                                </div>
                                            </div>
                                        <%
                                                        numberOfBusinessesShown++;
                                                    }
                                                }
                                        %>

                                            <div class="row" style="padding-top:20px; padding-left:5px">
                                                <div class="col-md-6">
                                                    <div class="input-group">
                                                        <input name="selectBusinessButton" type="submit" class="btn btn-primary" value="Select Location"/>
                                                        <br/>
                                                        Businesses: <%= businesses.size() %>
                                                        Shown: <%= numberOfBusinessesShown %>
                                                    </div>
                                                </div>
                                            </div>

                                        <%
                                            }
                                        }
                                        %>
                                            </form>

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

<!-- Includes Google Maps Javascript functionality needed by this page -->
<script src="/CS2340Servlet/js/itinerary_wizard_js.js"></script>

<!-- Index Javascript -->
<script type="text/javascript">

    // Sidebar Functionality
    $('[data-toggle=collapse]').click(function(){
        $(this).find("i").toggleClass("glyphicon-chevron-right glyphicon-chevron-down");
    });

    $('.collapse').on('show', function (e) {
        $('.collapse').each(function(){
            if ($(this).hasClass('in')) {
                $(this).collapse('toggle');
            }
        });
    });

    var error = '<%= request.getAttribute("error")%>';

    // Lodging functionality
    var lodging_selection = '<%=session.getAttribute("lodgingSelection")%>';
    var lodging_results = '<%=session.getAttribute("lodgingResults")%>';
    if (lodging_selection === "null" && lodging_results === "null") {
        $("#lodging-table-head").hide();
    } else {
        $("#create-lodging-pill").hide();
    }

    $("#create-lodging-pill").click(function() {
        $("#lodging-table-head").fadeIn("slow");
    });

    $(document).ready(function() {
        // Initial view
        $("#div-overview").show();
        $("#div-travelMode").hide();
        $("#itinerary-side-bar").show();

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

        // Details button for new event location search
        $('.popover-dismiss').popover({
            trigger: 'focus'
        });

        // Error Message
        if (error != 'null') {
            $("#errorMessage").modal("show");
        }

        // Automatically collapse the accordion-map
        $("#collapseOne").collapse("hide");
        $("#parentCollapse").one("click", function(){
            initialize();
        });
    });
</script>

<!-- Event Search Bar Javascript -->
<script src="../js/typeahead.bundle.js"></script>
<script src="../js/event_autocomplete.js"></script>

<%@ include file="footer.jsp" %>
