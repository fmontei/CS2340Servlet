<%@ include file="header.jsp" %>
<% String pageName = "Sign Up"; %>
<%
    Object prevFirstName = request.getAttribute("prevFirstName");
    prevFirstName = (prevFirstName != null) ? prevFirstName.toString() : "";
    Object prevLastName = request.getAttribute("prevLastName");
    prevLastName = (prevLastName != null) ? prevLastName.toString() : "";
    Object prevUsername = request.getAttribute("prevUsername");
    prevUsername = (prevUsername != null) ? prevUsername.toString() : "";
%>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li class="active"><a href="#">Sign Up</a></li>
            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">
                Sign Up
            </h1>

            

        </div>
    </div>
</div>

<!-- Asks user if wants to automatically log into application following successful account creation -->
<script>
    var success = "${accountCreateSuccess}";
    if (success === "success") {
        var response = window.confirm("Account successfully created. Automatically logging you in.");
        if (response) {
            window.location.replace("/CS2340Servlet/jsp/createLoginSession.jsp");
        } else {
            window.location.replace("/CS2340Servlet/jsp/index.jsp");
        }
    }
</script>

<!-- Password color change confirmation Javascript -->
<script src="/CS2340Servlet/js/password_check.js">
</script>

<%@ include file="footer.jsp" %>