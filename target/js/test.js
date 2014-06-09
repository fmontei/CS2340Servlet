function hideFacebookLogout() {
    var nav = document.getElementById('nav');
    var status = document.getElementById('status').innerHTML;
    if (status === 'Logged out of Facebook.') {
        for (var i = 0; i < nav.length; i++) {
            if (nav.options[i].text == "Logout of Facebook") {
                nav.remove(i);
            }
        }
    }
}

function fbLogout() {
    var answer = confirm("Are you sure you want to logout of Facebook?");
    if (answer == true) {
        FB.logout(function(response) {
            console.log("You have been logged out from Facebook");
            document.getElementById('status').innerHTML =
                "Logged out of Facebook.";
            hideFacebookLogout();
        });
    }
}

function showFacebookLogout() {
    var mav = document.getElementById('nav');
    var status = document.getElementById('status').innerHTML;
    if (status.indexOf('Currently logged into Facebook') > -1) {
        var count = 0;
        for (var i = 0; i < nav.length; i++) {
            if (nav.options[i].text != "Logout of Facebook") {
                count++;
            }
        }
        if (count == nav.length) {
            var option = document.createElement("option");
            option.text = "Logout of Facebook";
            option.value = "";
            option.addEventListener("click", function() { fbLogout(); });
            nav.add(option, nav[nav.length - 1]);
        }
    }
}