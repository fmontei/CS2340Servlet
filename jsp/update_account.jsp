<%@ page import="model.Attributes" %>

<% 
String firstName = Attributes.getAttribute("firstName");
String lastName = Attributes.getAttribute("lastName");
String username = Attributes.getAttribute("username"); 
String pageName = "Account Settings";
%>

<%@ include file="session.jsp" %>
<%@ include file="header.jsp" %>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar">
                <li id="showLink1Active1" class="active" style="display:block;"><a href="#">Personal Information</a></li>
                <li id="showLink1Active2" style="display:block;"><a href="#changePassword" onclick="toggle_visibility(['showLink1Active1','showLink1Active2','showLink2Active1','showLink2Active2','personalInformation','changePassword'])">Change Password</a></li>
                <li id="showLink2Active1" style="display:none;"><a href="#" onclick="toggle_visibility(['showLink1Active1','showLink1Active2','showLink2Active1','showLink2Active2','personalInformation','changePassword'])">Personal Information</a></li>
                <li id="showLink2Active2" class="active" style="display:none;"><a href="#changePassword">Change Password</a></li>
            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">
                Account Settings
            </h1>

            <form id="update_account_form" action="/CS2340Servlet/updateAccount" method="POST" class="form-inline" role="form">

                <div id="personalInformation" style="display:block;">
                    <b>Update Personal Information</b>

                    <br />
                    <br />

                    <div class="form-group">
                        <label class="sr-only" for="name">Name</label>
                        <input type="text" class="form-control" id="name"
                        name="updateFirstName"
                        value="<%=firstName == null ? "" : firstName %>"
                        required="required"
                        placeholder = "Enter First Name" />
                    </div>

                    <br />
                    <br />

                    <div class="form-group">
                        <label class="sr-only" for="name">Name</label>
                        <input type="text" class="form-control" id="name"
                        name="updateLastName"
                        value="<%=lastName == null ? "" : lastName %>"
                        required="required"
                        placeholder = "Enter Last Name" />
                    </div>
                    <br />
                </div>

                <div id="changePassword" style="display:none;">
                    <b>Change Password</b>

                    <br />
                    <br />

                    <div class="form-group">
                        <label class="sr-only" for="password">Password</label>
                        <input type="password" class="form-control" id="oldPassword"
                        name="oldPassword"
                        onkeyup="checkPass(document.getElementById('oldPassword'),
                        document.getElementById('confirmOldPassword'),
                        document.getElementById('confirmMessage'));
                        return false;"
                        placeholder = "Enter New Password" />
                    </div>

                    <br />
                    <br />

                    <div class="form-group">
                        <label class="sr-only" for="password">Password</label>
                        <input type="password" class="form-control" id="confirmOldPassword"
                        name="confirmOldPassword"
                        onkeyup="checkPass(document.getElementById('oldPassword'),
                        document.getElementById('confirmOldPassword'),
                        document.getElementById('confirmMessage'));
                        return false;"
                        placeholder = "Re-enter New Password" />
                    </div>
                    <br />
                </div>

                <span id="confirmMessage" class="confirmMessage"></span><br /><br />
                <span class="text-danger">${error}</span><br />
                <div class="form-group">
                    <button type="submit" name="submitButton"
                    class="btn btn-default">Save</button>
                </div>

            </form>

        </div>
    </div>
</div>

<!-- Password confirmation Javascript -->
<script src="/CS2340Servlet/js/password_check.js">
</script>


<script type="text/javascript">
    function toggle_visibility(ids) {
        var element;
        for (var i = 0; i < ids.length; i++) {
            element = document.getElementById(ids[i]);
           if(element.style.display == 'block')
              element.style.display = 'none';
           else
              element.style.display = 'block';
        };
    }
</script>

<%@ include file="footer.jsp" %>