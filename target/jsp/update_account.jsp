<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
        response.sendRedirect("/CS2340Servlet/jsp/index.jsp");
    }
%>
<%@ page import="model.Attributes" %>
<% String firstName = Attributes.getAttribute("firstName"); %>
<% String lastName = Attributes.getAttribute("lastName"); %>
<% String username = Attributes.getAttribute("username"); %>


<!DOCTYPE html>
<html>
    <head>
        <title>Account Settings</title>
    </head>
    <body>
        <h1><center>Account Settings</center></h1>
        <a href="/CS2340Servlet/index">Back to Index</a>

        <form id="update_account_form" action="/CS2340Servlet/updateAccount" method="POST">
            <dl>
                <dt><b>Edit your Personal Information:</b>
                <dd><span id="label">First name:</span><br />
                    <input type="text" name="updateFirstName" value="<%=firstName%>" required="required"  />
                <dd><span id="label">Last name:</span><br />
                    <input type="text" name="updateLastName" value="<%=lastName == null ? "" : lastName %>" required="required" />
                    <br /><br />
                <dt><b>Change Password:</b>
                <dd>
                    <div class="fieldWrapper">
                        <label for="oldPassword"><span id="label">Password:</span></label><br />
                        <input name="oldPassword" id="oldPassword" type="password">
                    </div>
                <dd>
                    <div class="fieldWrapper">
                        <label for="confirmOldPassword"><span id="label">Confirm Password:</span></label><br />
                        <input name="confirmOldPassword" id="confirmOldPassword" type="password"><br />
                        <span id="confirmMessage" class="confirmMessage"></span>
                    </div>
            </dl>
            <p id="error">${error}</p>
            <center>
                <input id="submit" type="submit" name="submitButton" text="Submit" />
            </center>
        </form>
    </body>
</html>