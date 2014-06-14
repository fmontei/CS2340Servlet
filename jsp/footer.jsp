    </div>
    <div id="footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-3 col-md-2">
                </div>
                <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                    <div  id="footerTopBorder"></div>
                    <p>
                        &copy; 2014 Georgia Tech Summer 2014 CS2340 Team 3. All Rights Reserved.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Facebook login
        (function(d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0];
            if (d.getElementById(id)) return;
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));

        // Dropdown Login Form
        $(function() {
            // Setup drop down menu
            $('.dropdown-toggle').dropdown();

            // Fix input element click problem
            $('.dropdown input, .dropdown label').click(function(e) {
                e.stopPropagation();
            });
        });
    </script>

    <script type="text/javascript" src="/CS2340Servlet/js/toggleVisibility.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="/CS2340Servlet/js/bootstrap.min.js"></script>
    <script src="/CS2340Servlet/js/docs.min.js"></script>

</body>
</html>