window.fbAsyncInit = function() {
    FB.init({
        appId      : '331815693633978',
        cookie     : true,  // enable cookies to allow the server to access
                        // the session
        xfbml      : true,  // parse social plugins on this page
        version    : 'v2.0' // use version 2.0
    });

    FB.getLoginStatus(function(response) {
    statusChangeCallback(response);
    });
};

checkLoginState = function() {
    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
    });
}

statusChangeCallback = function(response) {
    console.log(response);
    if (response.status === 'connected') {
        FB.api('/me', function(response) {
            console.log('Successful login for: ' + response.name);
            displayFBLogoutOption();
            document.getElementById('status').innerHTML =
            'Currently logged into Facebook as '.italics() + response.name;
        });
    } else if (response.status === 'not_authorized') {
        document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
        document.getElementById('status').innerHTML = 'Logged ' +
        'out of Facebook.';
    }
    if (isLogoutOfFacebookClicked()) {
        console.log("Logging out of Facebook");
        fbLogout();
    }
}

function displayFBLogoutOption() {
    var nav = document.getElementById('nav');
    if (isFBLogoutButtonNotDisplayed(nav)) {
        console.log("Displaying FB Logout button");
        createFBLogoutOption(nav);
    }
}

function isFBLogoutButtonNotDisplayed(nav) {
    var count = 0;
    for (var i = 0; i < nav.length; i++) {
        if (nav.options[i].text != "Logout of Facebook") {
            count++;
        }
    }
    return nav.length === count;
}

function createFBLogoutOption(nav) {
    var option = document.createElement("option");
    option.text = "Logout of Facebook";
    option.value = "";
    nav.add(option, nav[nav.length - 1]);
}

function isLogoutOfFacebookClicked() {
    var nav = document.getElementById("nav");
    return nav.options[nav.selectedIndex].text === "Logout of Facebook";
}

function fbLogout() {
    var answer = confirm("Are you sure you want to logout of Facebook?");
    if (answer == true) {
        FB.logout(function(response) {
            console.log("User has been logged out from Facebook");
            document.getElementById('status').innerHTML =
                "Logged out of Facebook.";
            hideFBLogoutOption();
        });
    }
    else {
        resetSelection();
    }
}

function resetSelection() {
    var nav = document.getElementById("nav");
    nav.selectedIndex = 0;
}

function hideFBLogoutOption() {
    var nav = document.getElementById('nav');
    for (var i = 0; i < nav.length; i++) {
        if (nav.options[i].text === "Logout of Facebook") {
            console.log("Hiding FB Logout button");
            nav.remove(i);
            break;
        }
    }
}
