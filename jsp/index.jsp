<%@ page import="model.Attributes" %>

<!DOCTYPE html>
<html>
    <head>
       <title><%=Attributes.getAttribute(Attributes.CURRENT_USER)%>&#39;s Itinerary</title>
       <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    </head>
    <body>
        <h1 class="indexHeader"><span><%=Attributes.getAttribute(Attributes.CURRENT_USER)%>&#39;s Itinerary</span></h1>

        <fb:login-button id="fbLoginButton" scope="public_profile,email" onlogin="checkLoginState();">
        </fb:login-button>

        <select id="nav" onChange="doDropdownAction(this); checkForLogoutAction(this);"
                         onFocus="displayFBLogoutOption();">
            <option value="">Navigation</option>
            <option value="/CS2340Servlet/updateAccount">Account Settings</option>
            <option value="/CS2340Servlet/login">Logout</option>
        </select>

        <div id="status">
        </div>

        <script type="text/javascript">
            function doDropdownAction(nav) {
                return nav.options[nav.selectedIndex].value && (window.location = nav.options[nav.selectedIndex].value);
            }
        </script>
        <script type="text/javascript" src="/CS2340Servlet/js/facebookLogout.js"></script>
        <script type="text/javascript" src="/CS2340Servlet/js/facebookSDK.js"></script>
    </body>
</html>