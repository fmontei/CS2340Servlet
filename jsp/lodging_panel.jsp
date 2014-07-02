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

    String lodgingIsOpenColor = "";
    String openClose = "";
    if (selection != null) {
        lodgingIsOpenColor = (selection.isOpenNow()) ? "green" : "red";
        openClose = (selection.isOpenNow()) ? "Open" : "Closed";
                                                                        %>
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
                    <% if (selection == null) { %>
                    <p>Select a lodging below. This list has been created
                        based on your Itinerary's address.
                    </p>
                    <% } %>
                    <table class="table table-striped">
                        <% if (selection == null) { %>
                            <div class="row">
                                <div class="form-group" style="padding-left: 20px; padding-right: 40px">
                                    <input name="lodgingSelection" type="text"
                                           class="form-control" placeholder="Lodging Name" />
                                </div>
                                <div class="form-group center-block" style="width: 30%; padding-top: 10px">
                                    <a href="/CS2340Servlet/itinerary?add_lodging=true">
                                        <input type="submit" class="form-control btn-primary" />
                                    </a>
                                </div>
                            </div>
                            <% if (session.getAttribute("lodgingResults") != null) { %>
                                <thead id="lodging-table-head">
                                    <tr>
                                        <th>Name</th>
                                        <th>Address</th>
                                        <th>Rating</th>
                                        <th>Open</th>
                                        <th>Select</th>
                                    </tr>
                                </thead>
                            <% } %>
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
                            List<Place> lodgingResults = new ArrayList<Place>();
                            if (lodgingObject != null) {
                                lodgingResults = (List<Place>) lodgingObject;
                                numberOfLodgingsFound = lodgingResults.size();
                            }
                            for (int i = 0; i < numberOfLodgingsFound; i++) {
                                lodgingIsOpenColor = (lodgingResults.get(i).isOpenNow()) ? "green" : "red";
                                openClose = (lodgingResults.get(i).isOpenNow()) ? "Open" : "Closed"; %>

                            <tr>
                                <td class="lodging-name"><%=lodgingResults.get(i).getName()%></td>
                                <td class="lodging-address"><%=lodgingResults.get(i).getFormattedAddress()%></td>
                                <td class="lodging-rating"><%=lodgingResults.get(i).getRating()%></td>
                                <td class="lodging-open-closed" style="color: <%=lodgingIsOpenColor%>"><%=openClose%></td>
                                <td><a href="/CS2340Servlet/itinerary?lodging_id=<%=i%>">Select</a></td>
                            </tr>
                        <% } %>
                        </tbody>
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

<script>
    // Lodging functionality
    var lodging_selection = '<%=session.getAttribute("lodgingSelection")%>';
    if (lodging_selection !== "null") {
        $('#create-lodging-pill').hide();
    }
</script>