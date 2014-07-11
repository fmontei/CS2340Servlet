<div id="newCityModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="newCityModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form id="new_city_form" action="/CS2340Servlet/itinerary?create_new_city" method="get" class="form-inline" role="form">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h2 class="modal-title">Add New City</h2>
                </div>
                <div class="modal-body">
                    <h4>Add a New City to Your Current Itinerary</h4><br />
                    <p>Enter an address for your new City's location:</p>
                    <label>Address *
                        <div class="input-group" style="width: 500px">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-search"></span>
                            </span>
                            <input type="text" class="form-control"
                                   id="cityUserInputAddress"
                                   required="required"
                                   placeholder = "Address" />
                            <span class="input-group-btn">
                                <button onclick="codeAddress(document.getElementById('cityUserInputAddress'))"
                                        class="btn btn-default" type="button">Find</button>
                            </span>
                        </div>
                    </label><br /><hr />
                    <div id="city-myMap" style="width: 99%; height: 300px;"></div><br />
                    <input class="alert-success" id="cityAddress" name="cityAddress" onkeydown="return false;" style="width: 55%" />
                    <input class="alert-info" id="cityCoordinates" name="cityCoordinates" onkeydown="return false;" style="width: 44%" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                    <button type="submit" name="createNewCityBtn" class="btn btn-primary">Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $('#newCityModal').on('shown.bs.modal', function (e) {
        initializeNewCityMap();
    });

    var geocoder;
    var map;
    var directionsDisplay;
    var directionsService;

    function initializeNewCityMap() {
        directionsDisplay = new google.maps.DirectionsRenderer();
        geocoder = new google.maps.Geocoder();
        var latlng = new google.maps.LatLng(-34.397, 150.644);
        var mapOptions = {
            zoom: 8,
            center: latlng
        };
        map = new google.maps.Map(document.getElementById("city-myMap"), mapOptions);
    }
</script>