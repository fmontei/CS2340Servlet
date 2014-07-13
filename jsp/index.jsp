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
                            <fb:login-button id="fbLoginButton" scope="public_profile,email" onlogin="checkLoginState();">
                            </fb:login-button>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>

</div>

<%  Itinerary activeItinerary = (Itinerary) session.getAttribute("activeItinerary");
    String itineraryName = activeItinerary.getName();
    List<City> cities = (List<City>) session.getAttribute("cities");
    String cityAddress = "";
    City indexPanelCity = null;
    List<Place> userEvents = (indexPanelCity != null) ? indexPanelCity.getEvents() : null;
    int numEvents = 0;
    if (userEvents != null) {
        numEvents = userEvents.size();
    }
%>

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
        <h1>YOUR ITINERARY</h1>
        <p><span style="font-size: 20px"><b>Find Events for your First City:</b></span><br />
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
                <a href="jsp/itinerary_overview.jsp">Select Itinerary</a>
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
        <div class="row">
            <div class="col col-md-6">
                <div class="new-city-message">

                    <h3>Want to travel to another <b>City?</b></h3>
                    <p>Add a <strong>New City</strong> to your Itinerary below:</p>
                    <p style="margin-top: 73px; opacity: .9"><a class="btn btn-primary btn-lg" data-toggle="modal"
                                                                data-target="#newCityModal" role="button">Add New City</a></p>
                </div>
            </div>
            <div class="col col-md-6">
                <div class="new-event-message">

                    <h3>Need to find a <b>Place</b> to eat or somewhere to go sightseeing?</h3>
                    <p>Add a <strong>New Event</strong> to your City below:</p>
                    <p style="margin-top: 73px; opacity: .9"><a class="btn btn-primary btn-lg" data-toggle="modal"
                                                                data-target="#eventAjaxModal" role="button">Add New Event</a></p>
                </div>

            </div>
        </div>

        <%@ include file="new_city.jsp" %>
    </div>
</div>


<div id="event-places-page">
    <div class="page-divider-header">
        <h1><span class="glyphicon glyphicon-th"></span> EVENTS & PLACES</h1>
        <hr class="hr-title" />
        <p><span style="font-size: 20px"><b>Find Events for your First City:</b></span><br />
            To add events for this city, Create a New Event<br /><br />
            <span style="font-size: 20px"><b>Or travel to a New City:</b></span><br />
            To go sightseeing in another city, Add a New City to your Itinerary
        </p><br /><br />
    </div>

    <%@ include file="events_places_panels.jsp" %>
</div>



<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-push-2" style="padding-left: 80px">
            <div id="div-overview">
                <section id="facebookLogin"></section>

                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Facebook Login
                    </div>
                    <div class="panel-body">
                        <fb:login-button id="fbLoginButton" scope="public_profile,email" onlogin="checkLoginState();">
                        </fb:login-button>
                    </div>
                </div>




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
                                    <%  Place lodgingSelect = (indexPanelCity != null) ? indexPanelCity.getLodging() : null; %>
                                    <select class="map-event-tooltips" id="start" onchange="calcRoute();">
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
                                    <div class="center-block popin" id="accordion-map" style="width: 520px; height: 300px; margin-top: 20px"></div>
                                    <div id="directionsPanel"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%@ include file="lodging_panel.jsp" %>

            </div>
        </div>
    </div>
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

            // Change city tabs
            var citySelection = "<%=request.getAttribute("changeCityName")%>";
            var cityList = $("#cityList li");
            cityList.each(function(i, li) {
                if ($(li).text() === citySelection) {
                    $(li).addClass("active");
                }
            });

            $('form.ajax').on('submit', function() {
                var that = $(this),
                    url = that.attr('action'),
                    method = that.attr('method'),
                    data = {};

                that.find('[name]').each(function(index, value) {
                    var that = $(this),
                        name = that.attr('name'),
                        value = that.val();

                    data[name] = value;
                });

                $.ajax({
                    url: url,
                    type: method,
                    data: data,
                    success: function(json) {
                        console.log(json);
                        $("#ajax-event-table").append(json);
                    }
                });

                return false;
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
