<%@ page import="model.Attributes" %>
<% String prevFirstName = Attributes.getAttribute("prevFirstName"); %>
<% String prevLastName = Attributes.getAttribute("prevLastName"); %>
<% String prevUsername = Attributes.getAttribute("prevUsername"); %>
<% String pageName = "Sign Up"; %>

<%@ include file="header.jsp" %>

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

            <form id="create_account_form" action="/CS2340Servlet/createAccount" method="POST" class="form-inline" role="form">
                <b>Enter your Personal Information</b>

                <br />
                <br />

                <div class="form-group">
                    <label class="sr-only" for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="firstName"
                    value="<%=prevFirstName == null ? "" : prevFirstName %>"
                    required="required"
                    placeholder = "Enter First Name" />
                </div>

                <br />
                <br />

                <div class="form-group">
                    <label class="sr-only" for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="lastName"
                    value="<%=prevLastName == null ? "" : prevLastName %>"
                    required="required"
                    placeholder = "Enter Last Name" />
                </div>

                <br />
                <br />
                <br />

                <b>Enter new Account Information</b>

                <br />
                <br />

                <div class="form-group">
                    <label class="sr-only" for="name">Name</label>
                    <input type="text" class="form-control" id="name"
                    name="newUsername"
                    value="<%=prevUsername == null ? "" : prevUsername %>"
                    required="required"
                    placeholder = "Enter Username" />
                </div>

                <br />
                <br />

                <div class="form-group">
                    <label class="sr-only" for="name">Password</label>
                    <input type="password" class="form-control" id="newPassword"
                    name="newPassword"
                    onkeyup="checkPass(document.getElementById('newPassword'),
                    document.getElementById('confirmPassword'),
                    document.getElementById('confirmMessage'));
                    return false;"
                    required="required"
                    placeholder = "Enter Password" />
                </div>

                <br />
                <br />

                <div class="form-group">
                    <label class="sr-only" for="name">Password</label>
                    <input type="password" class="form-control" id="confirmPassword"
                    name="confirmPassword"
                    onkeyup="checkPass(document.getElementById('newPassword'),
                    document.getElementById('confirmPassword'),
                    document.getElementById('confirmMessage'));
                    return false;"
                    required="required"
                    placeholder = "Re-enter Password" />
                </div>

                <br />
                <br />

                <span id="confirmMessage" class="confirmMessage"></span><br /><br />
                <span class="text-danger">${error}</span><br />

                <div class="form-group">
                    <button type="submit" name="submitButton"
                    class="btn btn-default">Submit</button>
                </div>
            </form>

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