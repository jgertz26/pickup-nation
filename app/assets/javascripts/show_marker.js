
$(document).ready(function(){
  var path = window.location.pathname
  var courtId = path.slice(path.lastIndexOf('/') + 1)

  $.ajax({
    url: path,
    method: 'GET',
    dataType: 'json'
  })

  .done(function(court){

    var courtLocation=new google.maps.LatLng(court.latitude, court.longitude);
    google.maps.event.addDomListener(window, 'load', initializeShowMap(courtLocation));

  })

})

function initializeShowMap(location){

  var mapProp = {
    center: location,
    zoom:17,
    mapTypeId:google.maps.MapTypeId.HYBRID,
    mapTypeControl: false,
    streetViewControl: false
  };

  var map=new google.maps.Map(document.getElementById('googleMap'),mapProp);

  var marker=new google.maps.Marker({
    position:location,
    });

  marker.setMap(map);
}
