<%@ page import="database.User" %>
<%@ page import="database.Itinerary" %>
<%@ page import="database.DataManager" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%@ include file="header.jsp" %>

<%
    User user = (User) session.getAttribute("currentUser");
    int userID = user.getID();
    List<Itinerary> itineraries = DataManager.getItineraryByUserID(userID);
    if (itineraries == null) {
        itineraries = new ArrayList<Itinerary>();
    }
%>

<script>
    // If the user has no itineraries, automatically load the modal dialog.
    // This is a tentative feature.
    window.onload = function() {
        var numberOfItineraries = <%=itineraries.size()%>;
        if (numberOfItineraries === 0) {
            $("#itineraryModal").modal("show");
            showPage1();
        }
    };
</script>

<div class="container">
    <h1>Your Current Itineraries:</h1>
    <ul class = "pager">
        <li><a href="#"
               onclick="showPage1()"
               data-toggle="modal"
               data-target="#itineraryModal">Create New Itinerary</a>
        </li>
        <li><a href="index.jsp">Index</a></li>
    </ul>
    <ul class="nav nav-pills nav-stacked" style="height: 400px; overflow: scroll">
        <li>
            <h3><a href="#"><strong>Itinerary Name</strong>
                <span class="pull-right" style="margin-right: 110px"><strong>Creation Date</strong></span>
            </a></h3>
        </li>
        <% for (int i = 0; i < itineraries.size(); i++) { %>
        <% String className = (i % 2 == 0) ? "active" : ""; %>
        <li class="<%=className%>">
            <a href="/CS2340Servlet/index?itinerary_id=<%=itineraries.get(i).getID()%>">
                <form action="/CS2340Servlet/itinerary" method="POST">
                    <button type="submit"
                            value="<%=itineraries.get(i).getID()%>"
                            name="deleteItinerary"
                            class="badge pull-right btn btn-default"
                            style="background-color: darkred; color: ghostwhite; border: none">
                        Delete
                    </button>
                </form>
                <span class="badge pull-right"
                      style="background-color: #b9def0; color: #3276b1; margin-right: 100px">
                      <%=itineraries.get(i).getCreationDate()%>
                </span>
                <%=itineraries.get(i).getName()%>
            </a>
        </li>
        <% } %>
    </ul>
</div>

<%@ include file="footer.jsp" %>