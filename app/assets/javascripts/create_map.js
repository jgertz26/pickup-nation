var courtMarker = null;

$("#show-map-button").click(function( event ) {
  event.preventDefault();
  var streetAddress = $("#court_street_address").val();
  var city = $("#court_city").val();
  var state = $("#court_state").val();
  var zip = $("#court_zip").val();

  var courtParams = {
    name: $("#court_name").val(),
    street_address: streetAddress,
    city: city,
    state: state,
    zip: zip,
    hoop_count: $("#court_hoop_count").val(),
    setting: $("#court_setting").val(),
    hours: $("#court_hours").val(),
    court_type_id: $("#court_court_type_id").val()
  };

  var fullAddress = streetAddress + " " + city + " " + state + " " + zip;

  toggleMap();
  $("#map-error").hide();

  var geocoder = new google.maps.Geocoder();

  var map = new google.maps.Map(document.getElementById('createMap'), {
    zoom: 17,
    center: {lat: -34.397, lng: 150.644},
    mapTypeId:google.maps.MapTypeId.HYBRID,
    streetViewControl: false
  });

  geocoder.geocode({'address': fullAddress}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      var resultCenter = results[0].geometry.location
      map.setCenter(resultCenter);

      $(window).resize(function() {
        google.maps.event.trigger(map, "resize");
        map.setCenter(resultCenter);
      });

      google.maps.event.addListener(map, 'click', function(event) {
        $("#map-buttons").show();
        placeMarker(event.latLng, map);
        courtParams.latitude = event.latLng.lat();
        courtParams.longitude = event.latLng.lng();
        var fullParams = { court: courtParams};

        $("#submit-court-button").click(function( event ) {
          event.preventDefault();

          $.ajax({
            url: '/courts',
            method: 'POST',
            dataType: 'json',
            data: fullParams
          })
          .success(function(court){
            window.location.href = "/courts/" + court.id;
          })
          .fail(function(){
            window.location.href = "/courts/new";
          });

        });

        $("#wrong-address-button").click(function( event ) {
          event.preventDefault();
          toggleMap();
        });

      });

    } else {

        toggleMap();

        if (status == "ZERO_RESULTS") {

          $("#map-error").html("Address not recognized. Try again!");
          $("#map-error").show();

        } else {

          $("#map-error").html(
            "Geocode was not successful for the following reason: " + status
          );
          $("#map-error").show();

      }
    }
  });
});

function placeMarker(location, map) {
  if (courtMarker !== null) {
    courtMarker.setMap(null);
  }

  courtMarker = new google.maps.Marker({
    position: location,
    map: map
  });
}

function toggleMap() {
  $("#map-and-button").slideToggle( "slow" );
  $("form").slideToggle( "slow" );
}
