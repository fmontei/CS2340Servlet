<%@ page import="java.util.List" %>
<%@ page import="database.Place" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="page-header">
    <div class="row">
        <div class="col-md-7">
            <h1><span class="glyphicon glyphicon-th"></span>Events & Places</h1>
        </div>
        <div class="col-md-5">
            <ul class="nav nav-pills" style="padding-top: 20px">
                <%  List<Place> events = (List<Place>) session.getAttribute("events");
                    int numberOfEvents = 0;
                    if (events != null) {
                        numberOfEvents = events.size();
                    }
                    if (numberOfEvents > 0) { %>
                <li class="dropdown alert-info" style="float: right;" id="create-event-pill">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <span class="glyphicon glyphicon-sort-by-attributes" style="position: relative; top: 2px"></span>
                        <b>Sort By</b>
                        <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu pull-left">
                        <li role ="presentation" class="dropdown-header">
                            <a role="menuitem" tabindex="-1" href="/CS2340Servlet/itinerary?sort=name">
                                Name
                            </a>
                        </li>
                        <li role="presentation" class="dropdown-header">
                            <a role="menuitem" tabindex="-1" href="/CS2340Servlet/itinerary?sort=start_time">
                                Start Time
                            </a>
                        </li>
                        <li role="presentation" class="dropdown-header">
                            <a role="menuitem" tabindex="-1" href="/CS2340Servlet/itinerary?sort=creation_date">
                                Creation Date
                            </a>
                        </li>
                    </ul>
                </li>
                <% } %>
                <li class="dropdown alert-success" style="float: right; margin-right: 10px" id="create-event-pill">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        <span class="glyphicon glyphicon-plus-sign" style="position: relative; top: 2px"></span>
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
        </div>
    </div>
</div>

<!-- Java functions for this page -->
<%! private boolean apiErrorReturned(HttpSession session, int curEventID) {
        return session.getAttribute("apiSearchError" + curEventID) != null;
    }

    private String getErrorMessage(final HttpSession session, final int curEventID) {
        return session.getAttribute("apiSearchError" + curEventID).toString();
    }

    private String determineURLFromError(final String error) {
        String url;
        if (error.contains("Google"))
            url = "https://developers.google.com/places/documentation/search#PlaceSearchStatusCodes";
        else
            url = "http://www.yelp.com/developers/documentation/v2/errors";
        return url;
    }
%>

<%  String errorMessage = "";
    for (int curEventID = 0; curEventID < numberOfEvents; curEventID++) {
    String eventPanelColor = (curEventID % 2 == 0) ? "info" : "success";
    Place event = events.get(curEventID); %>
    <div id="event-no-<%=curEventID%>">
        <div class="panel panel-<%=eventPanelColor%>">
            <div class="panel-heading">
                <%  if (event.getName() != null) { %>
                <p>
                    <b><%= event.getName() %></b><span style="float: right"><i>Event no. <%=curEventID + 1%></i></span>
                </p>
                <% } else { %>
                <form action="/CS2340Servlet/itinerary?remove_place_id=<%=curEventID%>" method="POST">
                    <button type="submit" class="close" aria-hidden="true">&times;</button>
                </form>
                New Place no. <%=curEventID + 1%>
                <% } %>
            </div>
            <%  if (event.getName() == null) { %>
            <div class="panel-body">
                <form class="form-inline" role="form" action="/CS2340Servlet/itinerary?event_id=<%=curEventID%>" method="POST">
                    <div class="row">
                        <div class="form-group" style="padding-left: 20px">
                            <input name="eventName<%=curEventID%>" type="text" class="form-control" placeholder="Place Name (optional)"/>
                        </div>
                        <div class="form-group" style="padding-left: 15px">
                            <input name="eventType<%=curEventID%>" id="eventType<%=curEventID%>" type="text"
                                   class="form-control typeahead" placeholder="Place Type" required="required" />
                        </div>
                        <div class="form-group" style="padding-left: 15px">
                            Radius (miles):  <input name="eventRadius<%=curEventID%>"
                                                    type="number" min="1" max="25" step="1" class="form-control" required="required"
                                                    value='<%=session.getAttribute("eventEndTime"+curEventID)%>'/>
                        </div><br />
                        <div class="form-group" style="float: left; padding-left: 20px; padding-top: 10px">
                            <input name="getEventsWithGoogleButton" type="submit" class="form-control btn-primary" value="Google Search"
                                   onclick="changeValueToGoogleCode(document.getElementById('eventType' + '<%=curEventID%>'))" />
                            <input name="getEventsWithYelpButton" type="submit" class="form-control btn-danger" value="Yelp Search"
                                   onclick="changeValueToGoogleCode(document.getElementById('eventType' + '<%=curEventID%>')); " />
                        </div>
                    </div><br />
                    <%  if (apiErrorReturned(session, curEventID)) { %>
                    <div class="alert alert-danger" role="alert" style="text-align: left">
                        <% errorMessage = getErrorMessage(session, curEventID); %>
                        <a href="<%=determineURLFromError(errorMessage)%>" target="_blank"
                           class="alert-link"><%=errorMessage%></a>
                            <a data-toggle="collapse"
                               data-parent="#accordion"
                               href="#text-search-collapse<%=curEventID%>"
                               id="parentCollapse">
                                Recommendations
                            </a>
                    </div>
                    <% } %>
                    <%  List<Place> businesses = (List<Place>) session.getAttribute("businesses" + curEventID);
                        if (businesses != null) { %>
                    <div class="panel panel-<%=eventPanelColor%>">
                        <div class="panel-heading">
                            <p>Search Parameters: <%=session.getAttribute("eventQueryString" + curEventID)%><br />
                                The results of your search are listed below.</p>
                        </div>
                        <div class="panel-body">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <%  String apiIcon = (event.getAPI() != null) ? event.getAPI() : "google";
                                            String apiWidth = apiIcon.equals("google") ? "90px" : "50px";
                                            String apiHeight = apiIcon.equals("google") ? "25px" : "40px"; %>
                                        <img src="../images/<%=apiIcon%>.png" width="<%=apiWidth%>" height="<%=apiHeight%>" />&nbsp;&nbsp;Results
                                    </tr>
                                    <tr>
                                        <th>Name</th>
                                        <th>Address</th>
                                        <th>Rating</th>
                                        <th>Open</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%  for (int j = 0; j  < businesses.size(); j++) {
                                    String openOrClosedColor = (businesses.get(j).isOpenNow()) ? "green" : "red";
                                    String openOrClosed = (businesses.get(j).isOpenNow()) ? "Open" : "Closed";
                                    String businessURL = businesses.get(j).getURL();
                                    businessURL = (businessURL != null) ? businessURL :
                                            "/CS2340Servlet/itinerary?detail_search&place_id=" + j + "&event_id=" + curEventID;%>
                                    <tr >
                                        <td style="max-width: 150px;">
                                            <a  rel="popover"
                                                data-html="true"
                                                data-content="<img src='<%=businesses.get(j).getRatingImage()%>'>
                                                    <br /><%=businesses.get(j).getSnippet()%>"
                                                data-title="<%=businesses.get(j).getName()%>">
                                                <%=businesses.get(j).getName()%>
                                            </a>
                                        </td>
                                        <td style="max-width: 250px;"><%=businesses.get(j).getFormattedAddress()%></td>
                                        <td><%=businesses.get(j).getRating()%></td>
                                        <td style="color: <%=openOrClosedColor%>"><%=openOrClosed%></td>
                                        <td><a href="/CS2340Servlet/itinerary?select_business&place_id=<%=j%>&event_id=<%=curEventID%>">Select</a></td>
                                        <td><a href='<%=businessURL%>' target="_blank">See More</a></td>
                                    </tr>
                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <% } %>
                </form>
                <!-- Form for Google Text Search, underneath the Recommendations label following Google error code -->
                <form role="form" action="/CS2340Servlet/itinerary?event_id=<%=curEventID%>" method="POST">
                    <div id="text-search-collapse<%=curEventID%>" class="panel-collapse collapse">
                        <div class="alert alert-danger" role="alert" style="text-align: left">
                            <ol>
                                <%  final String recommendation = (errorMessage.contains("Google")) ? "Try a Yelp Search instead."
                                        : "Try a Google Search instead."; %>
                                <li><%=recommendation%></li>
                                <li>Try a Google Keyword Search instead:&nbsp;&nbsp;&nbsp;
                                    <input name="collapse-textsearch-query" type="text" placeholder="Keyword Search" />
                                    <input name="collapse-textsearch-submit" type="submit" />
                                </li>
                            </ol>
                        </div>
                    </div>
                </form>
            </div>
            <% } else { %>
            <div class="panel-body" style="max-height: 250px">
                <form class="form-inline" role="form" action="/CS2340Servlet/itinerary?event_id=<%=curEventID%>" method="POST">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Address</th>
                                <th>Phone Number</th>
                                <th>Rating</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="table-address"><%=event.getFormattedAddress()%></td>
                                <td><%=event.getPhoneNumber()%></td>
                                <td><%=event.getRating()%></td>
                                <td><a href='<%=event.getURL()%>' target="_blank">See More</a></td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-md-5">
                            <div class="alert alert-<%=eventPanelColor%> pull-left" style="width: 90%">
                                <label>Start:</label><input type="date" name="eventStartTime" style="margin-left: 20px" />
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="alert alert-<%=eventPanelColor%> pull-left" style="width: 74%">
                                <label>End:</label><input type="date" name="eventEndTime" style="margin-left: 20px" />
                                <input type="submit" value="Save" name="eventDateSubmit" style="margin-left: 30px" />
                            </div>
                        </div>
                    </div>
                    <ol class="breadcrumb" style="background-color: white; float: right;">
                        <li><a href="<%=event.getURL()%>" target="_blank">Website</a></li>
                        <li><a href="#">Reviews</a></li>
                        <li><a href="<%=event.getCoordinates().format()%>">Find On Map</a></li>
                        <li><a href="#">Edit</a></li>
                        <li><a href="/CS2340Servlet/itinerary?delete_event&event_id=<%=curEventID%>">Delete</a></li>
                    </ol>
                </form>
            </div>
            <% } %>
        </div>
    </div>

    <% } %>

    <script>
        $(document).ready(function() {
            $('[rel=popover]').popover({trigger: 'click', placement: 'left'})
        });
    </script>
