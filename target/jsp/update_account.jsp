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
            <ul class="nav nav-sidebar">
                <li id="li-personalInformation" class="active"><a href="#personalInformation" id="a-personalInformation">Personal Information</a></li>
                <li id="li-changePassword"><a href="#changePassword" id="a-changePassword">Change Password</a></li>
                <li id="li-deleteAccount"><a href="#deleteAccount" id="a-deleteAccount">Delete Your Account</a></li>

            </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">
                Account Settings
            </h1>

            <form id="update_account_form" action="/CS2340Servlet/updateAccount" method="POST" class="form-inline" role="form">

                <div id="div-personalInformation">
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

                <div id="div-changePassword">
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

                <div id="div-saveButton">
                    <span id="confirmMessage" class="confirmMessage"></span><br /><br />
                    <span class="text-danger">${error}</span><br />
                    <div class="form-group">
                        <button type="submit" name="submitButton"
                        class="btn btn-default">Save</button>
                    </div>
                </div>

                <div id="div-deleteAccount">
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
    $(document).ready(function() {
        $("#div-personalInformation").show();
        $("#div-saveButton").show();
        $("#div-changePassword").hide();
        $("#div-deleteAccount").hide();
        $("#a-personalInformation").click(function() {
            $("#li-personalInformation").addClass("active");
            $("#li-changePassword").removeClass("active");
            $("#li-deleteAccount").removeClass("active");
            $("#div-personalInformation").show();
            $("#div-saveButton").show();
            $("#div-changePassword").hide();
            $("#div-deleteAccount").hide();
        });
        $("#a-changePassword").click(function() {
            $("#li-personalInformation").removeClass("active");
            $("#li-changePassword").addClass("active");
            $("#li-deleteYourAccount").removeClass("active");
            $("#div-personalInformation").hide();
            $("#div-saveButton").show();
            $("#div-changePassword").show();
            $("#div-deleteAccount").hide();
        });
        $("#a-deleteAccount").click(function() {
            $("#li-personalInformation").removeClass("active");
            $("#li-changePassword").removeClass("active");
            $("#li-deleteAccount").addClass("active");
            $("#div-personalInformation").hide();
            $("#div-saveButton").hide();
            $("#div-changePassword").hide();
            $("#div-deleteAccount").show();
        });
    });
</script>

<%@ include file="footer.jsp" %>