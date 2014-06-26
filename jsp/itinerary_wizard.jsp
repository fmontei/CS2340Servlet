<!-- Itinerary Wizard Javascript -->
<script src="/CS2340Servlet/js/itinerary_wizard_js.js"></script>

<div id="itineraryModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="itineraryModal" aria-hidden="true">
    <div class="modal-dialog" >
        <div class="modal-content">
            <form id="itinerary_form" action="/CS2340Servlet/itinerary" method="POST" class="form-inline" role="form">

                <div id="form_page_1">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Itinerary Creation (1/4)</h4>
                    </div>
                    <div class="modal-body">
                        <h4>First, let's create a name for your Itinerary</h4><br />
                        <p>Enter a name for the Itinerary:</p>
                        <label>Itinerary Name *
                            <div class="input-group" style="width: 500px">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-user"></span>
                                </span>
                                <input type="text" class="form-control" id="itineraryName" name="itineraryName"
                                       required="required"
                                       placeholder = "Itinerary Name" />
                            </div>
                        </label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                        <button onclick="showPage2()" type="button" class="btn btn-primary">Next</button>
                    </div>
                </div>

                <div id="form_page_2">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Itinerary Creation (2/4)</h4>
                    </div>
                    <div class="modal-body">
                        <h4>Now, let's set your Preferences</h4><br />
                        <p>Enter your preferences:</p>
                        <label>Rating Preference *
                            <div class="input-group" style="width: 500px">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-star"></span>
                                </span>
                                <input type="number" class="form-control" id="minRating" name="minRating"
                                       required="required"
                                       min="1"
                                       max="4"
                                       step="0.5"
                                       placeholder = "Enter a number between 1 and 4" />
                            </div>
                        </label><br /><br />
                        <label>Price Preference *
                            <div class="input-group" style="width: 500px">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-usd"></span>
                                </span>
                                <input type="text" class="form-control" id="priceCategory" name="priceCategory"
                                       required="required"
                                       placeholder = "Enter value between $ and $$$$" />
                            </div>
                        </label><br /><br />
                        <label>Distance Preference *
                            <div class="input-group" style="width: 500px">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-road"></span>
                                </span>
                                <input type="number" class="form-control" id="maxDistance" name="maxDistance"
                                       required="required"
                                       min="1"
                                       max="100"
                                       placeholder = "Enter a number between 1 and 100" />
                            </div>
                        </label><br /><br />
                        <label>Food Preference *
                            <div class="input-group" style="width: 500px">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-glass"></span>
                                </span>
                                <input type="text" class="form-control" id="preferredFoodType" name="preferredFoodType"
                                       required="required"
                                       placeholder = "e.g. Seafood" />
                            </div>
                        </label><br /><br />
                        <label>Attraction Preference *
                            <div class="input-group" style="width: 500px">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-pushpin"></span>
                                </span>
                                <input type="text" class="form-control" id="preferredAttrType" name="preferredAttrType"
                                       required="required"
                                       placeholder = "e.g. Museum" />
                            </div>
                        </label>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                        <button onclick="showPage1()" type="button" class="btn btn-primary">Previous</button>
                        <button onclick="showPage3(document.getElementById('myMap'))" type="button" class="btn btn-primary">Next</button>
                    </div>
                </div>

                <div id="form_page_3">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Itinerary Creation (3/4)</h4>
                    </div>
                    <div class="modal-body">
                        <h4>Next, let's designate your Itinerary's Address</h4><br />

                        <p>Enter an address for the Itinerary's location:</p>
                        <label>Address *
                            <div class="input-group" style="width: 500px">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-search"></span>
                                </span>
                                <input type="text" class="form-control" id="itineraryAddress" name="itineraryAddress"
                                       required="required"
                                       placeholder = "Address" />
                                <span class="input-group-btn">
                                    <button onclick="codeAddress()" class="btn btn-default" type="button">Find</button>
                                </span>
                            </div>
                        </label><br /><hr />

                        <div id="myMap" style="width: 520px; height: 300px;"></div><br />
                        <span class="label label-primary" id="formattedAddress"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                        <button onclick="showPage2()" type="button" class="btn btn-primary">Previous</button>
                        <button onclick="showPage4()" type="submit" class="btn btn-primary">Next</button>
                    </div>
                </div>

                <div id="form_page_4">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title">Itinerary Creation (4/4)</h4>
                    </div>
                    <div class="modal-body">
                        <h4>Finally, let's specify your Transportation Style</h4><br />
                        <label>Transportation Style *
                            <div class="input-group" style="width: 500px">
                                <span class="input-group-addon">
                                        <span class="glyphicon glyphicon-plane"></span>
                                </span>
                                <input type="text" class="form-control" id="itineraryTransportation" name="itineraryTransportation"
                                       required="required"
                                       placeholder = "Transportation Style" />
                            </div>
                        </label><br /><br />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                        <button onclick="showPage3(document.getElementById('myMap'))" type="button" class="btn btn-primary">Previous</button>
                        <button type="submit" class="btn btn-success" name="createItineraryButton" id="createItineraryButton">Create</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


