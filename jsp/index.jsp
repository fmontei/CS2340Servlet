<%@ page import="model.Attributes" %>

<!DOCTYPE html>
<html>
    <head>
       <title>${currentUser}&#39;s Itinerary</title>
       <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    </head>
    <body>
        <h1 class="indexHeader"><span><%=Attributes.getAttribute(Attributes.CURRENT_USER)%>&#39;s Itinerary</span></h1>
        <script src="/CS2340Servlet/js/facebookLogout.js"></script>
        <script src="/CS2340Servlet/js/facebookSDK.js"></script>

        <fb:login-button id="fbLoginButton" scope="public_profile,email" onlogin="checkLoginState();">
        </fb:login-button>

        <script>
            function doDropdownAction(nav) {
                return nav.options[nav.selectedIndex].value && (window.location = nav.options[nav.selectedIndex].value);
            }
        </script>

        <select id="nav" onchange="doDropdownAction(this);" onfocus="displayFBLogoutOption();">
          <option value="">Navigation</option>
          <option value="/CS2340Servlet/updateAccount">Account Settings</option>

          <option value="/CS2340Servlet/login">Logout</option>
        </select>

        <div id="status">
        </div>
    </body>
</html>