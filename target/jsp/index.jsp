<%@ page import="model.Attributes" %>

<!DOCTYPE html>
<html>
    <head>
       <meta charset="utf-8" />
       <title><%=Attributes.getAttribute(Attributes.WELCOME_NAME)%>&#39;s Trip Planner</title>
       <link rel="stylesheet" type="text/css" href="/CS2340Servlet/css/style.css">
    </head>
    <body>
        <nav>
            <span id="overviewMessage">
                <%=Attributes.getAttribute(Attributes.WELCOME_NAME)%>&#39;s Trip Planner
            </span>
            <fb:login-button id="fbLoginButton"
                    scope="public_profile,email"
                    onlogin="checkLoginState();">
            </fb:login-button>
            <select id="nav"
                    onChange="doDropdownAction(this); checkLoginState();"
                    onFocus="checkLoginState();">
                <option value="" disabled selected>Navigation</option>
                <option value="/CS2340Servlet/updateAccount">Account Settings</option>
                <option value="/CS2340Servlet/login">Logout</option>
            </select>
            <div id="status">
            </div>
        </nav>
        <header>
            Trip Planner Overview
        </header>

        <script type="text/javascript" src="/CS2340Servlet/js/facebookSDK.js">
        </script>
        <script type="text/javascript">
            function doDropdownAction(nav) {
                return nav.options[nav.selectedIndex].value && (window.location = nav.options[nav.selectedIndex].value);
            }
        </script>
        <div id="fb-root"></div>
        <script type="text/javascript">
           (function(d, s, id) {
               var js, fjs = d.getElementsByTagName(s)[0];
               if (d.getElementById(id)) return;
               js = d.createElement(s); js.id = id;
               js.src = "//connect.facebook.net/en_US/sdk.js";
               fjs.parentNode.insertBefore(js, fjs);
           }(document, 'script', 'facebook-jssdk'));
        </script>
    </body>
</html>