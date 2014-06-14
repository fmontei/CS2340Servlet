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

                <!-- Show link 1 active -->
                <li id="showLink1Active1" class="active" style="display:block;"><a href="#">Personal Information</a></li>
                <li id="showLink1Active2" style="display:block;"><a href="#" onclick="showLink2Active()">Change Password</a></li>
                <li id="showLink1Active3" style="display:block;"><a href="#" onclick="showLink3Active()">Delete Your Account</a></li>

                <!-- Show link 2 active -->
                <li id="showLink2Active1" style="display:none;"><a href="#" onclick="showLink1Active()">Personal Information</a></li>
                <li id="showLink2Active2" class="active" style="display:none;"><a href="#">Change Password</a></li>
                <li id="showLink2Active3" style="display:none;"><a href="#" onclick="showLink3Active()">Delete Your Account</a></li>

                <!-- Show link 3 active -->
                <li id="showLink3Active1" style="display:none;"><a href="#" onclick="showLink1Active()">Personal Information</a></li>
                <li id="showLink3Active2" style="display:none;"><a href="#" onclick="showLink2Active()">Change Password</a></li>
                <li id="showLink3Active3" class="active" style="display:none;"><a href="#">Delete Your Account</a></li>
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

                <div id="saveButton">
                    <span id="confirmMessage" class="confirmMessage"></span><br /><br />
                    <span class="text-danger">${error}</span><br />
                    <div class="form-group">
                        <button type="submit" name="submitButton"
                        class="btn btn-default">Save</button>
                    </div>
                </div>

                <div id="deleteAccount" style="display:none;">
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


<script type="text/javascript">
    function turnOnVisibility(ids) {
        var element;
        for (var i = 0; i < ids.length; i++) {
            element = document.getElementById(ids[i]);
            element.style.display = 'block';
        };
    }
    function turnOffVisibility(ids) {
        var element;
        for (var i = 0; i < ids.length; i++) {
            element = document.getElementById(ids[i]);
            element.style.display = 'none';
        };
    }
    function showLink1Active() {
        turnOnVisibility(['showLink1Active1','showLink1Active2','showLink1Active3','personalInformation','saveButton']);
        turnOffVisibility(['showLink2Active1','showLink2Active2','showLink2Active3','showLink3Active1','showLink3Active2','showLink3Active3','changePassword','deleteAccount']);
    }
    function showLink2Active() {
        turnOnVisibility(['showLink2Active1','showLink2Active2','showLink2Active3','changePassword','saveButton']);
        turnOffVisibility(['showLink1Active1','showLink1Active2','showLink1Active3','showLink3Active1','showLink3Active2','showLink3Active3','personalInformation','deleteAccount']);
    }
    function showLink3Active() {
        turnOnVisibility(['showLink3Active1','showLink3Active2','showLink3Active3','deleteAccount']);
        turnOffVisibility(['showLink1Active1','showLink1Active2','showLink1Active3','showLink2Active1','showLink2Active2','showLink2Active3','personalInformation','changePassword','saveButton']);
    }
</script>

<%@ include file="footer.jsp" %>