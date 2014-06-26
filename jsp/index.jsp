<%@ page import="database.User" %>

<% String pageName = "Home"; %>
<% String preferredTravelMode = ""; %>

<%@ include file="header.jsp" %>

<%if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {%>

<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <h1 class="page-header">
                Welcome to Trip Planner!
            </h1>
            <p>
                Please login to begin
            </p>
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
                    <div class="panel-body">
                        <p>YOUR CURRENT ITINERARY'S NAME IS: ${ITINERARY_NAME}</p>
                        <div class="btn-group" >
                            <button id="button-createNewItinerary" type="button" class="btn btn-default">
                                <a href="#"
                                   onclick="showPage1()"
                                   data-toggle="modal"
                                   data-target="#itineraryModal">Create New Itinerary
                                </a>
                            </button>
                        </div>
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

        // Stuff
        $("button-createNewItinerary").click(function() {

        });

        // Error Message
        if (error != 'null') {
            $("#errorMessage").modal("show");
        }

    });
</script>

<%@ include file="footer.jsp" %>
