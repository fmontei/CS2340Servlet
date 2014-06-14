$("#start-dropdown li a").click(function(){
    console.log("User selected option: " + $(this).text());
    var selText = $(this).text();
    if (selText === "Create New Itinerary") {
        $("#start-dropdown li a").eq(0).hide();
        $("#new-itinerary-info").css("visibility", "visible");
        $("#create-itinerary").css("visibility", "visible");
        $("#cancel-itinerary").css("visibility", "visible");
    }
});

$("#cancel-itinerary").click(function() {
    console.log("User selected option: " + $(this).text());
    $("#start-dropdown li a").eq(0).show();
    $("#start-dropdown").val("0").show();
    $("#new-itinerary-info").css("visibility", "hidden");
    $("#create-itinerary").css("visibility", "hidden");
    $("#cancel-itinerary").css("visibility", "hidden");
});
