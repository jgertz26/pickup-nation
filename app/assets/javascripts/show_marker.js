

$(document).ready(function(){
  var path = window.location.pathname;

  if (/^\/courts\/(\d)+$/.test(path)) {

    var showdata = $("#showMap")[0].dataset;
    var latitude = showdata.lat;
    var longitude = showdata.lon;

    var courtLocation=new google.maps.LatLng(latitude, longitude);

   initializeShowMap(courtLocation)
  };
});

function initializeShowMap(location){

  var mapProp = {
    center: location,
    zoom:17,
    mapTypeId:google.maps.MapTypeId.HYBRID,
    mapTypeControl: false,
    streetViewControl: false
  };

  var map=new google.maps.Map(document.getElementById('showMap'),mapProp);

  var marker=new google.maps.Marker({
    position:location,
    });

  marker.setMap(map);
}
