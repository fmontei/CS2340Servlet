function displayFBLogoutOption() {
    var nav = document.getElementById('nav');
    var status = document.getElementById('status').innerHTML;
    if (status.indexOf('Currently logged into Facebook') > -1) {
        var count = 0;
        for (var i = 0; i < nav.length; i++) {
            if (nav.options[i].text != "Logout of Facebook") {
                count++;
            }
        }
        if (count == nav.length) {
            console.log("Displaying FB Logout button");
            var option = document.createElement("option");
            option.text = "Logout of Facebook";
            option.value = "";
            nav.add(option, nav[nav.length - 1]);
        }
    }
}

function checkForLogoutAction(nav) {
    if (nav.options[nav.selectedIndex].text === "Logout of Facebook") {
        console.log("Attempting to logout of Facebook");
        fbLogout();
    }
}

function fbLogout() {
    var answer = confirm("Are you sure you want to logout of Facebook?");
    if (answer == true) {
        FB.logout(function(response) {
            console.log("You have been logged out from Facebook");
            document.getElementById('status').innerHTML =
                "Logged out of Facebook.";
            hideFBLogoutOption();
        });
    }
}

function hideFBLogoutOption() {
    var nav = document.getElementById('nav');
    var status = document.getElementById('status').innerHTML;
    if (status === 'Logged out of Facebook.') {
        for (var i = 0; i < nav.length; i++) {
            if (nav.options[i].text == "Logout of Facebook") {
                console.log("Hiding FB Logout button");
                nav.remove(i);
            }
        }
    }
}