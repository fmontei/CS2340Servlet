<%@ page errorPage="errorHandler.jsp" %>
<%@ page import="java.util.List" %>
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
                        <div class="indexCarousel">
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
                        <div class="indexCarousel">
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
                        <div class="indexCarousel">
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

<!-- Jquery Javascript -->
<script src="/CS2340Servlet/js/jquery.js"></script>
<script src="/CS2340Servlet/js/bootstrap.min.js"></script>

<%@ include file="footer-centered.jsp" %>

<% } else { %>
<%  Itinerary activeItinerary = (Itinerary) session.getAttribute("activeItinerary");
    List<City> cities = (List<City>) session.getAttribute("cities");
    String cityAddress = "";
    City indexPanelCity = (City) session.getAttribute("activeCity");
    List<Place> userEvents = (indexPanelCity != null) ? indexPanelCity.getEvents() : null;
    int numEvents = 0;
    if (userEvents != null) {
        numEvents = userEvents.size();
    }
%>

<body style="overflow-x: hidden">
    <div id="itinerary-header">
        <nav class="navbar navbar-default" role="navigation">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">DESTI</a>
                </div>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">Link</a></li>
                        <li><a href="#">Link</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                                <li class="divider"></li>
                                <li><a href="#">One more separated link</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form class="navbar-form navbar-left" role="search">
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Search">
                        </div>
                        <button type="submit" class="btn btn-default">Submit</button>
                    </form>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="#">Link</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <span class="caret"></span></a>
                            <ul class="dropdown-menu" role="menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                                <li id="fbLoginButton" scope="public_profile,email" onclick="fb_login();"><a href="#">Facebook Login</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="row" id="landing-title">
            <h1 id="landing-title-h1">
                DESTI<span style="position: relative; top: -8px">&#9679;</span>NATION
            </h1>
        </div>
        <div class="container" id="landing-cards">
            <div class="row">
                <div class="col-md-3">
                    <span class="landing-card-subtitle" style="margin-left: 27%; margin-top: -1%">Map</span>
                    <div class="landing-card" style="height: 200px; background-color: rgb(243, 156, 18); color: rgb(243, 156, 18);">
                        <span style="position: absolute; bottom: 0; left: 5%; color: white; display: none">
                        </span>
                    </div>
                </div>
                <div class="col-md-2" >
                    <span class="landing-card-subtitle">Lodging</span>
                    <div class="landing-card" style="height: 200px; background-color: rgb(139, 0, 0); color: rgb(139, 0, 0)">
                        <span style="position: absolute; bottom: 0; left: 5%; color: white; display: none">
                            From the Lodging panel:<br /><br />
                            <ul style="margin-right: 10%">
                                <li>Find a Lodging using Yelp or Google</li>
                                <li>Add what you find to your Itinerary</li>
                                <li>Set check-in and check-out times for your Lodging</li>
                            <%  if (indexPanelCity.getLodging() == null) { %>
                            <br />You currently have no lodging for your Itinerary. Click here to create one.
                            <%  } %>
                            </ul>
                        </span>
                    </div>
                </div>
                <div class="col-md-2">
                    <span class="landing-card-subtitle">Itinerary</span>
                    <div class="landing-card" style="height: 200px; background-color: rgb(4, 75, 144); color: rgb(4, 75, 144)">
                        <span style="position: absolute; bottom: 0; left: 5%; color: white; display: none">
                            From the Itinerary panel:<br /><br />
                            <ul style="margin-right: 10%">
                                <li><b>Discover</b><br /> Search for Places using Yelp or Google</li>
                                <li><b>Stay informed</b><br /> Browse reviews, ratings and more</li>
                                <li><b>Spread out</b><br /> Add another City to your Itinerary</li>
                                <li><b>Interact</b><br /> Send messages to your friends via Facebook</li>
                            </ul>
                        </span>
                    </div>
                </div>
                <div class="col-md-2">
                    <span class="landing-card-subtitle">Events & Places</span>
                    <div class="landing-card" style="height: 200px; background-color: rgb(26, 188, 156); color: rgb(26, 188, 156)">
                        <span style="position: absolute; bottom: 0; left: 5%; color: white; display: none">
                            From the Events & Places panel:
                            <ul style="margin-right: 10%">
                                <li>Quickly find restaurants, airports, and more</li>
                                <li>Endless search possibilities with Google or Yelp</li>
                                <li>Update event times on the fly</li>
                                <li>Neatly organize your events using different views</li>
                                <li>Sort events by name, creation date or time</li>
                            </ul>
                        </span>
                    </div>
                </div>
                <div class="col-md-3">
                    <span class="landing-card-subtitle" style="margin-top: -1%">About</span>
                    <div class="landing-card" style="height: 200px; background-color: rgb(47, 47, 47); color: rgb(47, 47, 47)">
                        <span style="position: absolute; bottom: 0; left: 5%; color: white; display: none">
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="itinerary-overview">
        <ul class="nav nav-pills" style="float: right">
            <li>
                <a href="#" style="color: rgb(66, 139, 202); font-weight: bold">
                    Active Itinerary: <%=activeItinerary.getName()%>
                </a>
            </li>
            <li>
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
        </ul>
        <div class="page-divider-header">
            <div style="display: inline-block">
                <h1><span class="glyphicon glyphicon-tags"></span> YOUR ITINERARY</h1>
                <hr class="hr-title" />
            </div>
            <p><span style="font-size: 20px"><b>Find a place to stay:</b></span><br />
                Add a new Lodging below<br /><br />
                <span style="font-size: 20px"><b>Find Events for your First City:</b></span><br />
                To add events for this city, Create a New Event<br /><br />
                <span style="font-size: 20px"><b>Or travel to a New City:</b></span><br />
                To go sightseeing in another city, Add a New City to your Itinerary
            </p><br /><br />
            <div class="container" style="width: 80% !important">
                <ul class="nav nav-tabs" id="cityList" role="tablist">
                    <li><a href="#">Your Cities</a></li>
                    <%  if (cities != null) {
                            indexPanelCity = (City) session.getAttribute("activeCity");
                            cityAddress = (indexPanelCity != null) ? indexPanelCity.getAddress() : "";
                            if (cities != null) {
                                for (City city : cities) { %>
                    <li><a href="/CS2340Servlet/itinerary?city_id=<%=city.getID()%>"><%=city.getName()%></a></li>
                            <%  } %>
                        <%  } %>
                    <%  } %>
                </ul>
                <div style="height: 40px">
                    <span style="float: left">Active City:&nbsp;&nbsp;&nbsp;<%=indexPanelCity.getName()%></span>
                    <span style="float: right">Address:&nbsp;&nbsp;&nbsp;<%=cityAddress%></span>
                </div>
            </div>
        </div>
        <div>
            <ol class="pager">
                <li>
                    <a href="/CS2340Servlet/jsp/itinerary_overview.jsp">Select Itinerary</a>
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
            </ol><br /><br />

            <div class="table" >
                <table style="table-layout: fixed; width: 100%">
                    <thead>
                        <tr>
                            <th></th>
                            <th></th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>
                            <div class="new-city-message" data-toggle="modal"
                                 data-target="#newCityModal" role="button">
                                <h3>Add new <b>City</b></h3>
                                <p>Add a <strong>New City</strong> to your Itinerary</p>
                            </div>
                        </td>
                        <td>
                            <div class="new-lodging-message" data-toggle="modal"
                                 data-target="#eventAjaxModal" role="button">
                                <h3>Find a <b>Lodging</b></h3>
                                <p>Add a <strong>New Lodging</strong> to your City</p>
                            </div>
                        </td>
                        <td>
                            <div class="new-event-message" data-toggle="modal"
                                 data-target="#eventAjaxModal" role="button">
                                <h3>Add New <strong>Event</strong></h3>
                                <p>Add a <strong>New Event</strong> to your City</p>
                            </div>
                        </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <%@ include file="eventAndLodgingModals.jsp" %>
        </div>
    </div>

<!--<<<<<< HEAD
    <div class="row" id="lodging-page">
        <div class="page-divider-header">
            <div style="display: inline-block">
                <h1><span class="glyphicon glyphicon-home"></span> LODGING</h1>
                <hr class="hr-title" />
            </div>
            <p><span style="font-size: 20px"><b>Find a place to stay:</b></span><br />
                Add a new Lodging below, including a hotel, motel or apartment<br /><br />
                <span style="font-size: 20px"><b>How it works:</b></span><br />
                You specify a radius from your city's central location, and
                results within that radius are returned<br />
                Afterward, you can specify your check-in and check-out times for your Lodging
            </p><br /><br />
-->
    <div id="itinerary-nav-tabs-div" style="background-color: rgb(4, 71, 137);border:none;font-weight:bold;">
        <button id="lodging-tab-btn" class="itinerary-nav-tabs" onclick='showLodging()'>Lodging</button>
        <button id="events-tab-btn" class="itinerary-nav-tabs" onclick='showEvents()'>Events and Places</button>
        <button id="map-tab-btn" class="itinerary-nav-tabs" onclick='showMap()'>Map and Directions</button>
        <button id="budget-tab-btn" class="itinerary-nav-tabs" onclick='showBudget()'>Manage Budget</button>
    </div>

    <div id="lodging-page" class="itinerary-sections">
        <div class="page-divider-header">
            <div style="display: inline-block">
                <h1><span class="glyphicon glyphicon-home"></span> LODGING</h1>
                <hr class="hr-title" />
            </div>
            <%@ include file="lodging_panel.jsp" %>
        </div>
    </div>

<!--<<<<<< HEAD
    <div id="event-places-page">
        <div class="page-divider-header">
            <div style="display: inline-block">
                <h1><span class="glyphicon glyphicon-th"></span> EVENTS & PLACES</h1>
                <hr class="hr-title" />
            </div>
            <p><span style="font-size: 20px"><b>Find Events for your First City:</b></span><br />
                To add events for this city, Create a New Event<br /><br />
                <span style="font-size: 20px"><b>Or travel to a New City:</b></span><br />
                To go sightseeing in another city, Add a New City to your Itinerary
            </p><br /><br />
=======-->
    <div id="event-places-page" class="itinerary-sections">
        <div class="page-divider-header">
            <div style="display: inline-block">
                <h1><span class="glyphicon glyphicon-th"></span> EVENTS & PLACES</h1>
                <hr class="hr-title" />
            </div>
            <%@ include file="events_places_panels.jsp" %>
        </div>
    </div>


    <div id="map-page" class="itinerary-sections">
        <div class="page-divider-header">
            <div style="display: inline-block; margin-bottom: 20px">
                <h1><span class="glyphicon glyphicon-globe"></span> MAP</h1>
                <hr class="hr-title" />
            </div><br />
        </div>
        <div align="center">
            <b>Start: </b>
            <%  Place lodgingSelect = (indexPanelCity != null) ? indexPanelCity.getLodging() : null; %>
            <select class="map-event-tooltips" id="start" onchange="calcRoute();" style="margin-bottom: 40px">
              <option value= '<%=cityAddress%>'>Center </option>
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
              <option value= '<%=cityAddress%>'>Center </option>
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
            <div class="row popin" style="max-width: 90%; min-height: 500px">
                <div class="col-md-12" id="mainMapWrapper">
                    <div id="main-map" style="height: 500px"></div>
                </div>
                <div class="hideAway" id="directionsPanelWrapper" style="overflow: auto">
                    <div id="directionsPanel"></div>
                </div>
            </div>
        </div>
    </div>

    <div id="budget-page" class="itinerary-sections">
        <%@ include file="budget_panel.jsp" %>
    </div>

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

    <!--Jquery-->
    <script src="/CS2340Servlet/js/jquery.js"></script>

    <!-- Bootstrap Javascript -->
    <script src="/CS2340Servlet/js/bootstrap.min.js"></script>

    <!-- Facebook Login -->
    <script src="/CS2340Servlet/js/facebookSDK.js"></script>

    <!-- Includes Google Maps Javascript functionality needed by this page -->
    <script src="/CS2340Servlet/js/itinerary_wizard_js.js"></script>

    <!-- Event Search Bar Javascript -->
    <script src="/CS2340Servlet/js/typeahead.bundle.js"></script>
    <script src="/CS2340Servlet/js/event_autocomplete.js"></script>

    <!-- Index Javascript -->
    <script type="text/javascript">
        // Landing page title functionality
        var landingTitle = document.getElementById("landing-title-h1");
        var landingCard = document.getElementsByClassName("landing-card");
        for (var i = 0; i < landingCard.length; i++) {
            landingCard[i].addEventListener("mouseover", function () {
                landingTitle.style.opacity = 1;
                landingTitle.style.textShadow = "4px 4px #000000";
                $(landingTitle).slideDown('slow');
                this.style.opacity = 0.95;
                this.style.backgroundColor = "black";
                $(this).stop().animate({
                    height: '+500px'
                }, 1000, function() {
                    var hiddenText = this.getElementsByTagName("span")[0];
                    hiddenText.style.display = "";
                });
            }, true);
            landingCard[i].addEventListener("mouseout", function () {
                landingTitle.style.opacity = 0.8;
                landingTitle.style.textShadow = "";
                this.style.opacity = 0.9;
                this.style.backgroundColor = this.style.color;
                var hiddenText = this.getElementsByTagName("span")[0];
                hiddenText.style.display = "none";
                $(this).stop().animate({
                    height: '200px'
                }, 1000);
            }, true);
        }

        // Change city tabs
        var citySelection = "<%=indexPanelCity.getName()%>";
        console.log("City selected: " + citySelection);
        var cityList = $("#cityList li");
        cityList.each(function(i, li) {
            if ($(li).text() === citySelection) {
                $(li).addClass("active");
            }
        });

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

        $(document).ready (function () {
            $(window).scroll (function () {
                var sT = $(this).scrollTop();
                var $overview = $("#itinerary-overview");
                var $overview_offset = $overview.offset().top - 50;
                var $lodging = $("#lodging-page");
                var $lodging_offset = $lodging.offset().top - 50;
                if (sT < $overview_offset && sT < $lodging_offset) {
                    $('#fixed-nav').removeClass('navbar-default');
                    $('#fixed-nav').addClass('navbar-inverse');
                } else if (sT >= $overview_offset && sT < $lodging_offset) {
                    $('#fixed-nav').removeClass('navbar-inverse');
                    $('#fixed-nav').addClass('navbar-default');
                } else if (sT >= $lodging_offset) {
                    $('#fixed-nav').removeClass('navbar-default');
                    $('#fixed-nav').removeClass('navbar');
                    $('#fixed-nav').addClass('navbar-custom');
                } else {

                }
            });
        });

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
            var error = '<%= request.getAttribute("error")%>';
            if (error != 'null') {
                $("#errorMessage").modal("show");
            }
        });

        $('form.ajax').on('submit', function () {
            var that = $(this),
                    url = that.attr('action'),
                    method = that.attr('method'),
                    data = {};

            that.find('[name]').each(function (index, value) {
                var that = $(this),
                        name = that.attr('name'),
                        value = that.val();

                data[name] = value;
            });

            $.ajax({
                url: url,
                type: method,
                data: data,
                success: function (json) {
                    console.log(json);
                    $("#ajax-event-table").append(json);
                }
            });

            return false;
        });

        /* Scrolls to the event from which event search request was issued
         following page reload */
        $(getDefaultPageSection()).show();

        $('html, body').animate({
            scrollTop: $(getCurrentPageSection()).offset().top
        }, 'fast');

        function hideAllTabs() {
            document.getElementById("budget-page").style.display="none";
            document.getElementById("map-page").style.display="none";
            document.getElementById("event-places-page").style.display="none";
            document.getElementById("lodging-page").style.display="none";
        }

        function showBudget() {
            hideAllTabs();
            document.getElementById('budget-page').style.display='block';
        }

        function showMap() {
            hideAllTabs();
            document.getElementById('map-page').style.display='block';
            // Initialize map
            initialize(<%=indexPanelCity.getLatitude()%>,
                    <%=indexPanelCity.getLongitude()%>);
        }

        function showEvents() {
            hideAllTabs();
            document.getElementById('event-places-page').style.display='block';
        }

        function showLodging() {
            hideAllTabs();
            document.getElementById('lodging-page').style.display='block';
        }

        function getDefaultPageSection() {
            var element = '<%=request.getAttribute("defaultSection")%>';
            if (element != null) {
                var elementID = "#" + element;
                return elementID;
            } else {
                return "#" + "itinerary-header";
            }
        }

        function getCurrentPageSection() {
            var element = '<%=request.getAttribute("currentSection")%>';
            if (element != null) {
                var elementID = "#" + element;
                return elementID;
            } else {
                return "#" + "itinerary-header";
            }
        }
    </script>
</body>

<%@ include file="footer.jsp" %>

<%}%>
