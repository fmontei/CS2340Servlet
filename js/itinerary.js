$(".dropdown-menu li a").click(function(){
    var selText = $(this).text();
    if (selText === "Create New Itinerary") {
        $("#start-dropdown").hide();
        $("#new-itinerary-info").css("visibility", "visible");
        $("#create-itinerary").css("visibility", "visible");
        $("#cancel-itinerary").css("visibility", "visible");
    }
});

$("#cancel-itinerary").click(function() {
    $("#start-dropdown").show();
    $("#new-itinerary-info").css("visibility", "hidden");
    $("#create-itinerary").css("visibility", "hidden");
    $("#cancel-itinerary").css("visibility", "hidden");
});
