var indexdata = $("#indexMap")[0].dataset;

var userCoords = indexdata.user.split(",");
var center = new google.maps.LatLng(userCoords[0], userCoords[1]);

var courtLats = indexdata.lats.split(",");
var courtLons = indexdata.lons.split(",");
var zoom = parseInt(indexdata.zoom);

$(document).ready(initializeIndexMap(center, courtLats, courtLons, zoom));

function initializeIndexMap(center, lats, lons, zoom){
  var mapProp = {
    center: center,
    zoom: zoom,
    mapTypeId:google.maps.MapTypeId.HYBRID,
    mapTypeControl: false,
    streetViewControl: false
  };

  var map=new google.maps.Map(document.getElementById('indexMap'),mapProp);

  var markers = [];

  for (var i = 0; i < lats.length; i++) {
    var courtCoords = new google.maps.LatLng(lats[i], lons[i]);

    markers[i] = new google.maps.Marker({
      position: courtCoords,
      label: (i + 1).toString()
    });

    markers[i].setMap(map);
  }
}
