<%@ page import="java.util.List" %>
<%@ page import="database.*" %>

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

<%@ include file="footer-centered.jsp" %>

<% } else { %>

<div class="row-offcanvas row-offcanvas-left">
    <div id="sidebar" class="sidebar">
        <div class="col-md-12">
            <ul class="list-unstyled">
                <li class="nav-header"><a href="#"><h3>Toolbox</h3></a></li>
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
                        <%  List<Place> places = (List<Place>) session.getAttribute("textSearchResults");
                            if (places != null) {
                                int i = 0;
                                for (Place place : places) {
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
                <li class="nav-header" style="margin-top: 40px"><a href="#"><h3>Navigation</h3></a></li>
                <ul class="nav nav-list navbar-navigation">
                    <li><a href="#facebookLogin">Facebook Login<i class="glyphicon glyphicon-chevron-right"></i></a></li>
                    <li><a href="#itineraryOverview">Overview<i class="glyphicon glyphicon-chevron-right"></i></a></li>
                    <li><a href="#mapSection">Map<i class="glyphicon glyphicon-chevron-right"></i></a></li>
                    <li><a href="#lodging">Lodging<i class="glyphicon glyphicon-chevron-right"></i></a></li>
                    <li><a href="#eventsPlaces">Events & Places<i class="glyphicon glyphicon-chevron-right"></i></a></li>
                </ul>
            </ul>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-push-2" style="padding-left: 80px">
            <div id="div-overview">
                <section id="facebookLogin"></section>
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
                <ul class="nav nav-tabs" role="tablist">
                    <li class="active"><a href="#">Your Cities</a></li>
                    <%  List<City> cities = (List<City>) session.getAttribute("cities");
                        if (cities != null) {
                            for (City city : cities) { %>
                            <li><a href="#"><%=city.getName()%></a></li>
                        <%  } %>
                    <%  } %>
                </ul>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Your Itinerary
                    </div>
                    <section id="itineraryOverview"></section>
                    <div class="panel-body" id="itinerary-panel-body">
                        <div class="page-header">
                            <h1><span class="glyphicon glyphicon-move"></span>Overview</h1>
                        </div>
                        <div class="panel panel-primary">
                            <div class="panel-heading" style="height: 40px">
                                <%  Itinerary activeItinerary = (Itinerary) session.getAttribute("activeItinerary");
                                    String itineraryName = activeItinerary.getName();
                                    String itineraryAddress = activeItinerary.getAddress(); %>
                                <span style="float: left">Itinerary Name:&nbsp;&nbsp;&nbsp;<%=itineraryName%></span>
                                <span style="float: right">Address:&nbsp;&nbsp;&nbsp;<%=itineraryAddress%></span>
                            </div>
                            <div class="panel-body">
                            <ol class="pager" style="background-color: white">
                                <li>
                                    <a href="itinerary_overview.jsp">Select Itinerary</a>
                                </li>
                                <li><a href="#"
                                       onclick="showPage1()"
                                       data-toggle="modal"
                                       data-target="#itineraryModal">Create New Itinerary
                                    </a>
                                </li>
                                <li id="li-create-event">
                                    <a id="a-create-event" href="/CS2340Servlet/itinerary?create_event=1">
                                        Create New Event</a>
                                </li>
                                <li id="li-create-city">
                                    <a href="#" data-toggle="modal" data-target="#newCityModal">Add New City</a>
                                </li>
                            </ol>
                            <div class="new-city-message">
                                <h3>Want to travel to a another city?</h3>
                                <p>No problem. Add a <strong>New City</strong> to your itinerary below:</p>
                                <p><a class="btn btn-primary btn-lg" data-toggle="modal"
                                      data-target="#newCityModal" role="button">Add New City</a></p>
                            </div>
                            <ul class="nav nav-pills" style="float: right">
                                <li>
                                    <a href="#" style="color: rgb(66, 139, 202); font-weight: bold">
                                        Currently Viewing: <%=activeItinerary.getName()%>
                                    </a>
                                </li>
                                <li>
                                    <%  List<Place> userEvents = (List<Place>) session.getAttribute("events");
                                        int numEvents = 0;
                                        if (userEvents != null) {
                                            numEvents = userEvents.size();
                                        }
                                    %>
                                    <a href="#">
                                        <span class="badge pull-right"
                                              style="position: relative; top: 2px; background-color: rgb(66, 139, 202)">
                                            <%=numEvents%>
                                        </span>
                                        Events
                                    </a>
                                </li>

                                <li>
                                    <a href="#" id="preferences-trigger">
                                        Preferences
                                    </a>
                                </li>
                            </ul></div>
                        </div>
                        <br />
                        <section id="mapSection"></section>
                        <div class="page-header">
                            <h1><span class="glyphicon glyphicon-globe"></span>Map</h1>
                        </div>
                        <div class="panel-group" id="accordion">
                            <div class="panel panel-default">
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
                                        <b>Start: </b>
                                        <%  Place lodgingSelect = (Place) session.getAttribute("lodgingSelection");%>
                                        <select class="map-event-tooltips" id="start" onchange="calcRoute();">
                                          <option value= '<%=itineraryAddress%>'>Center </option>
                                          <% if (lodgingSelect != null) { %>
                                          <option value= '<%=lodgingSelect.getFormattedAddress()%>' title="<%=lodgingSelect.getName()%>">
                                              Lodging
                                          </option>
                                          <% } %>
                                          <% numEvents = 0;
                                             if (userEvents != null) {
                                               numEvents = userEvents.size();
                                             }
                                             for (int curEventID = 0; curEventID < numEvents; curEventID++) {
                                               Place event = userEvents.get(curEventID); %>
                                          <option value= '<%=event.getFormattedAddress()%>' title="<%=event.getName()%>">
                                              Event <%=curEventID + 1%>
                                          </option>
                                            <% } %>
                                        </select>
                                        <b>End: </b>
                                        <select id="end" onchange="calcRoute();">
                                          <option value= '<%=itineraryAddress%>'>Center </option>
                                          <% if (lodgingSelect != null) { %>
                                          <option value= '<%=lodgingSelect.getFormattedAddress()%>'>Lodging </option>
                                          <% } %>
                                          <% for (int curEventID = 0; curEventID < numEvents; curEventID++) {
                                               Place event = userEvents.get(curEventID); %>
                                          <option value= '<%=event.getFormattedAddress()%>' title="<%=event.getName()%>">Event <%=curEventID + 1%></option>
                                          <% } %>
                                        </select>
                                        <b>Mode of Transit: </b>
                                        <select id="transitMode" onchange="calcRoute()">
                                          <option value= "DRIVING">Car </option>
                                          <option value= "BICYCLING">Bicycle </option>
                                          <option value= "TRANSIT">Public Transit </option>
                                          <option value= "WALKING">Walking </option>
                                        </select>
                                        <div class="center-block popin" id="accordion-map" style="width: 520px; height: 300px; margin-top: 20px"></div>
                                        <div id="directionsPanel"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%@ include file="lodging_panel.jsp" %>
                        <%@ include file="events_places_panels.jsp" %>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </div>

    <%@ include file="new_city.jsp" %>
    <%@ include file="footer.jsp" %>

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

    <!-- Event Search Bar Javascript -->
    <script src="../js/typeahead.bundle.js"></script>
    <script src="../js/event_autocomplete.js"></script>

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

        $(document).ready(function() {
            // Initial view
            $("#div-overview").show();
            $("#itinerary-side-bar").show();

            // Navbar Navigation Color Change
            $('.navbar-navigation li a').click(function(e) {
                var $this = $(this);
                if (!$this.hasClass('active')) {
                    $('.navbar-navigation li a').removeClass('active');
                    $this.addClass('active');
                    var hash = $(this).attr("href");
                    $('html, body').animate({
                        scrollTop: $(hash).offset().top - 10
                    }, 0);
                }
                e.preventDefault();
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

        /* Scrolls to the event from which event search request was issued
            following page reload */
        $('html, body').animate({
            scrollTop: $(parseEventIDFromQueryString()).offset().top
        }, 'slow');

        function parseEventIDFromQueryString() {
            var queryString = '<%=request.getQueryString()%>';
            var beginIndex = queryString.lastIndexOf("=") + 1;
            var eventID = queryString.substring(beginIndex);
            var elementID = "#event-no-" + eventID;
            return elementID;
        }
    </script>

<%}%>
