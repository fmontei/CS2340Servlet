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

<%@ include file="footer-centered.jsp" %>

<% } else { %>

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
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <h1 style="z-index: 10; padding-top: 350px; font-size: 64px; font-family: 'Audiowide', cursive; color: white !important;" align="center">
        DESTI<span style="position: relative; top: -8px">&#9679;</span>NATION</h1>
</div>

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

<div id="itinerary-overview">
    <button id="lodging-tab-btn">Lodging</button>
    <button id="events-tab-btn">Events and Places</button>
    <button id="map-tab-btn">Map and Directions</button>
    <button id="budget-tab-btn">Manage Budget</button>
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

<div class="row" id="lodging-page" style="display:none">
    <div class="page-divider-header">
        <div style="display: inline-block">
            <h1><span class="glyphicon glyphicon-home"></span> LODGING</h1>
            <hr class="hr-title" />
        </div>
        <p><span style="font-size: 20px"><b>Find a place to stay:</b></span><br />
            Add a new Lodging below
            <span style="font-size: 20px"><b>Find Events for your First City:</b></span><br />
            To add events for this City, Create a New Event<br /><br />
            <span style="font-size: 20px"><b>Or travel to a New City:</b></span><br />
            To go sightseeing in another city, Add a New City to your Itinerary
        </p><br /><br />
    </div>
    <%@ include file="lodging_panel.jsp" %>
</div>

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
    </div>
    <%@ include file="events_places_panels.jsp" %>
</div>

<div id="map-page" style="display:none;">
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

<div id="budget-page" style="display:none;">
    <div class="page-divider-header">
        <div style="display: inline-block">
            <h1><span class="glyphicon glyphicon-usd"></span> BUDGET</h1>
            <hr class="hr-title" />
        </div>
        <p><span style="font-size: 20px"><b>Create and Manage a Budget for this Trip:</b></span><br />
            Create a Budget below.
        </p><br /><br />
    </div>
    <%@ include file="budget_panel.jsp" %>
</div>


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

    <!-- Facebook Login -->
    <script src="/CS2340Servlet/js/facebookSDK.js"></script>

    <!-- Includes Google Maps Javascript functionality needed by this page -->
    <script src="/CS2340Servlet/js/itinerary_wizard_js.js"></script>

    <!-- Event Search Bar Javascript -->
    <script src="/CS2340Servlet/js/typeahead.bundle.js"></script>
    <script src="/CS2340Servlet/js/event_autocomplete.js"></script>

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

            // Initialize map
            initialize(<%=indexPanelCity.getLatitude()%>,
                <%=indexPanelCity.getLongitude()%>);

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

            // Change city tabs
            var citySelection = "<%=session.getAttribute("changeCityName")%>";
            var cityList = $("#cityList li");
            cityList.each(function(i, li) {
                if ($(li).text() === citySelection) {
                    $(li).addClass("active");
                }
            });
        });

        /* Scrolls to the event from which event search request was issued
            following page reload */

        $(getCurrentPageSection()).show();

        $('html, body').animate({
            scrollTop: $(getCurrentPageSection()).offset().top
        }, 'fast');

        $('#lodging-tab-btn').on("click", function(){
            hideAllTabs();
            $('#lodging-page').show();
        });

        $('#events-tab-btn').on("click", function(){
            hideAllTabs();
            $('#events-places-page').show();
        });

        $('#map-tab-btn').on("click", function(){
            hideAllTabs();
            $('#map-page').show();
        });

        $('#budget-tab-btn').on("click", function(){
            hideAllTabs();
            $('#budget-page').show();
        });

        function getCurrentPageSection() {
            var element = '<%=request.getAttribute("currentSection")%>';
            if (element != null) {
                hideAllTabs();
                var elementID = "#" + element;
                return elementID;
            } else {
                return "#" + "itinerary-header";
            }
        }

        function hideAllTabs() {
            $('#budget-page').hide();
            $('#map-page').hide();
            $('#event-places-page').hide();
            $('#lodging-page').hide();
        }
    </script>

    <script>
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
    </script>
<%}%>
