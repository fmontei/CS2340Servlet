function showPage1() {
    $("#form_page_1").show();
    $("#form_page_2").hide();
    $("#form_page_3").hide();
    $("#form_page_4").hide();
}

function showPage2() {
    // Check if page 1 fields are empty
    var check = checkIfPreviousPageHasEmptyFields(1);
    if (!check) return;
    $("#form_page_1").hide();
    $("#form_page_2").show();
    $("#form_page_3").hide();
    $("#form_page_4").hide();
}

function showPage3() {
    // Check if page 2 fields are empty
    var check = checkIfPreviousPageHasEmptyFields(2);
    if (!check) return;
    $("#form_page_1").hide();
    $("#form_page_2").hide();
    $("#form_page_3").show();
    $("#form_page_4").hide();
    initialize();
}

function showPage4() {
    // Check if page 3 fields are empty
    var check = checkIfPreviousPageHasEmptyFields(3);
    if (!check) return;
    $("#form_page_1").hide();
    $("#form_page_2").hide();
    $("#form_page_3").hide();
    $("#form_page_4").show();
}

function checkIfPreviousPageHasEmptyFields(pageNum) {
    var pageID = "form_page_" + pageNum;
    var elements = document.getElementById(pageID).getElementsByTagName("input");
    for (var i = 0; i < elements.length; i++) {
        if (elements[i].value === "") {
            document.getElementById("createItineraryButton").click();
            return false;
        }
    }
    return true;
}

var geocoder;
var map, accordion_map;
function initialize() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(-34.397, 150.644);
    var mapOptions = {
        zoom: 8,
        center: latlng
    };
    map = new google.maps.Map(document.getElementById("myMap"), mapOptions);
    accordion_map = new google.maps.Map(document.getElementById("accordion-map"),
        mapOptions);
}

function codeAddress() {
    var address = document.getElementById("itineraryAddress").value;
    geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            var marker = new google.maps.Marker({
                map: map,
                position: results[0].geometry.location
            });
            setFormattedAddress(results[0].formatted_address);
            setCoordinates(results[0].geometry.location);
        } else {
            alert("Address could not be found for the following reason: " + status);
        }
    });
};

function setFormattedAddress(formattedAddress) {
    $("#formattedAddress").text("Starting Address currently set to: " + formattedAddress);
}

function setCoordinates(coordinates) {
    $("#coordinates").text(coordinates);
    $("#coordinates-hidden").val(coordinates);
}
