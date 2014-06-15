<%@ page import="model.Attributes" %>
<%@ include file="session.jsp" %>
<%@ include file="header.jsp" %>

<%
    String firstName = session.getAttribute("firstName").toString();
    String lastName = session.getAttribute("lastName").toString();
    String pageName = "Account Settings";
%>


<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul class="nav nav-sidebar visibilityOn" id="updateAccount_showPersonalInformationActive">

                <!-- Show link 1 active -->
                <li class="active"><a href="#">Personal Information</a></li>
                <li><a href="#" onclick="updateAccount_showChangePasswordActive()">Change Password</a></li>
                <li><a href="#" onclick="updateAccount_showDeleteAccountActive()">Delete Your Account</a></li>

            </ul>
            <ul class="nav nav-sidebar visibilityOff" id="updateAccount_showChangePasswordActive">

                <!-- Show link 2 active -->
                <li><a href="#" onclick="updateAccount_showPersonalInformationActive()">Personal Information</a></li>
                <li class="active"><a href="#">Change Password</a></li>
                <li><a href="#" onclick="updateAccount_showDeleteAccountActive()">Delete Your Account</a></li>

            </ul>
            <ul class="nav nav-sidebar visibilityOff" id="updateAccount_showDeleteAccountActive" style="display:none;">

                <!-- Show link 3 active -->
                <li><a href="#" onclick="updateAccount_showPersonalInformationActive()">Personal Information</a></li>
                <li><a href="#" onclick="updateAccount_showChangePasswordActive()">Change Password</a></li>
                <li class="active"><a href="#">Delete Your Account</a></li>

            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">
                Account Settings
            </h1>

            <form id="update_account_form" action="/CS2340Servlet/updateAccount" method="POST" class="form-inline" role="form">

                <div id="personalInformation" class="visibilityOn">
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

                <div id="changePassword" class="visibilityOff">
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

                <div id="saveButton" class="visibilityOn">
                    <span id="confirmMessage" class="confirmMessage"></span><br /><br />
                    <span class="text-danger">${error}</span><br />
                    <div class="form-group">
                        <button type="submit" name="submitButton"
                        class="btn btn-default">Save</button>
                    </div>
                </div>

                <div id="deleteAccount" class="visibilityOff">
                    <div class="form-group">
                        <button type="submit" name="deleteButton" class="btn btn-default" onclick="return confirm('Are you sure you want to delete your account?')">Delete Account</button>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>

<!-- Password confirmation Javascript -->
<script src="/CS2340Servlet/js/password_check.js">
</script>

<!-- Update Account Sidebar Javascript -->
<script type="text/javascript">
    function updateAccount_showPersonalInformationActive() {
        turnOnVisibility(['updateAccount_showPersonalInformationActive','personalInformation','saveButton']);
        turnOffVisibility(['updateAccount_showChangePasswordActive','updateAccount_showDeleteAccountActive','changePassword','deleteAccount']);
        hidePasswordError();
    }
    function updateAccount_showChangePasswordActive() {
        turnOnVisibility(['updateAccount_showChangePasswordActive','changePassword','saveButton']);
        turnOffVisibility(['updateAccount_showPersonalInformationActive','updateAccount_showDeleteAccountActive','personalInformation','deleteAccount']);
        showPasswordError();
    }
    function updateAccount_showDeleteAccountActive() {
        turnOnVisibility(['updateAccount_showDeleteAccountActive','deleteAccount']);
        turnOffVisibility(['updateAccount_showPersonalInformationActive','updateAccount_showChangePasswordActive','personalInformation','changePassword','saveButton']);
        hidePasswordError();
    }
</script>

<%@ include file="footer.jsp" %>