<%@ page import="database.Place" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="page-header">
    <div class="row">
        <div class="col-md-8">
            <h1><span class="glyphicon glyphicon-home"></span> Lodging</h1>
        </div>
        <div class="col-md-4">
            <ul class="nav nav-pills" style="padding-top: 20px">
                <li style="float: right">
                    <a class="alert-danger" href="#main-lodging" id="create-lodging-pill"
                       data-toggle="collapse" data-parent="#accordion">
                        <span class="glyphicon glyphicon-plus-sign"
                              style="position: relative; top: 2px">
                        </span>
                        <b>Add Lodging</b>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<%  Place selection = (Place) session.getAttribute("lodgingSelection");
    Object lodgingObject = session.getAttribute("lodgingResults");
    int numberOfLodgingsFound = 0;
    List<Place> lodgingResults = new ArrayList<Place>();
    if (lodgingObject != null) {
        lodgingResults = (List<Place>) lodgingObject;
        numberOfLodgingsFound = lodgingResults.size();
    }
    if (selection != null) { %>
    <div id="main-lodging">
    <% } else if (session.getAttribute("lodgingResults") != null) { %>
    <div id="main-lodging" class="panel-collapse collapse in">
    <% } else { %>
    <div id="main-lodging" class="panel-collapse collapse">
    <% } %>
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
                    <table class="table table-striped">
                    <% if (selection == null) { %>
                        <div class="row">
                            <form action="/CS2340Servlet/itinerary" method="GET">
                                <div class="form-inline" style="padding-left: 20px; padding-right: 20px">
                                    <input name="lodgingName" type="text"
                                           class="form-control" placeholder="Lodging Name (optional)" />
                                    &nbsp;&nbsp;&nbsp;Radius (miles):&nbsp;&nbsp;&nbsp;
                                    <input name="lodgingRadius" type="number" min="1" max="25"
                                           class="form-control" />
                                    &nbsp;&nbsp;&nbsp;No. Results:&nbsp;&nbsp;&nbsp;
                                    <input name="lodgingFilter" type="number" min="1" max="20"
                                           class="form-control" />
                                </div><br />
                                <div style="padding-left: 20px;">
                                    <input type="submit" class="form-control btn-primary" value="Search"
                                        name="lodgingSubmitButton" style="width: 150px;" />
                                </div>
                            </form>
                        </div><br />
                        <% if (session.getAttribute("lodgingResults") != null) { %>
                            <p>Select a lodging below. This list has been created
                                based on your Itinerary's address, which is:
                                <b><%=((Itinerary) session.getAttribute("activeItinerary")).getAddress()%></b>
                            </p>
                            <thead id="lodging-table-head">
                                <tr>
                                    <th>Name</th>
                                    <th>Address</th>
                                    <th>Rating</th>
                                    <th>Open</th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </thead>
                        <% } %>
                    <% } else { %>
                            <thead>
                                <tr>
                                    <th>Address</th>
                                    <th>Phone</th>
                                    <th>Rating</th>
                                    <th>    </th>
                                </tr>
                            </thead>
                    <% } %>
                            <tbody>
                    <%  if (selection == null) {
                        for (int i = 0; i < numberOfLodgingsFound; i++) {
                            String lodgingIsOpenColor, openClose;
                            lodgingIsOpenColor = (lodgingResults.get(i).isOpenNow()) ? "green" : "red";
                            openClose = (lodgingResults.get(i).isOpenNow()) ? "Open" : "Closed"; %>
                                <tr>
                                    <td>
                                        <a rel="popover"
                                           data-html="true"
                                           data-content="<img src='<%=lodgingResults.get(i).getRatingImage()%>'>
                                                <br /><%=lodgingResults.get(i).getSnippet()%>"
                                           data-title="<%=lodgingResults.get(i).getName()%>">
                                            <%=lodgingResults.get(i).getName()%>
                                        </a>
                                    </td>
                                    <td class="tableg-address"><%=lodgingResults.get(i).getFormattedAddress()%></td>
                                    <td><%=lodgingResults.get(i).getRating()%></td>
                                    <td style="color: <%=lodgingIsOpenColor%>"><%=openClose%></td>
                                    <td><a href="/CS2340Servlet/itinerary?lodging_id=<%=i%>">Select</a></td>
                                    <td><a href='<%=lodgingResults.get(i).getURL()%>' target="_blank">See More</a></td>
                                </tr>
                        <% } %>
                            </tbody>
                    <% } else { %>
                                <tr>
                                    <td class="table-address"><%=selection.getFormattedAddress()%></td>
                                    <td class="table-name"><%=selection.getPhoneNumber()%></td>
                                    <td><%=selection.getRating()%></td>
                                    <td><a href='<%=selection.getURL()%>' target="_blank">See More</a></td>
                                </tr>
                            </tbody>
                    <% } %>
                    </table>
                    <% if (selection == null && lodgingResults.size() > 0) { %>
                        <form action="/CS2340Servlet/itinerary" method="GET">
                            <div class="row">
                                <div class="col-md-8" style="padding-left: 20px">
                                    <input type="submit" class="form-control btn-primary" value="More Results"
                                        name="lodgingGetMoreResults" style="width: 150px;" />
                                </div>
                                <div style="float: right; padding-right: 40px; padding-top: 10px">
                                    <b><%=numberOfLodgingsFound%></b> Results
                                </div>
                            </div>
                        </form>
                    <% } else if (selection != null) { %>
                        <div class="row">
                            <div class="col-md-5">
                                <div class="alert alert-danger pull-left" style="width: 90%">
                                    <label>Check in:</label>
                                    <input type="date" name="lodgingCheckIn" style="margin-left: 20px" />
                                </div>
                            </div>
                            <div class="col-md-7">
                                <div class="alert alert-danger pull-left" style="width: 82%">
                                    <label>Check out:</label>
                                    <input type="date" name="lodgingCheckOut" style="margin-left: 20px" />
                                    <input type="submit" value="Save" name="lodgingDateSubmit" style="margin-left: 30px" />
                                </div>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

<script>
    // Lodging functionality
    var lodging_selection = '<%=session.getAttribute("lodgingSelection")%>';
    if (lodging_selection !== "null") {
        $('#create-lodging-pill').hide();
    }

    $(document).ready(function() {
        $('[rel=popover]').popover({trigger: 'click', placement: 'left'})
    });

</script>