$("#search-button").on("click", function(event){

  var paramsData = {
    range: $("range-box").val(),
    location: $("location-box").val()
  };

  $.ajax({
    url: '/courts',
    method: 'GET',
    dataType: 'json',
    data: paramsData
  })

  .done(function(json){
    var courts = json["courts"]
    var centerCoords = json["user_coordinates"];
    var center = new google.maps.LatLng(centerCoords[0], centerCoords[1]);

    $(document).ready(initializeIndexMap(center, courts))
  });
});


function initializeIndexMap(center, courts){
  debugger;
  var mapProp = {
    center: center,
    zoom: 10,
    mapTypeId:google.maps.MapTypeId.HYBRID,
    mapTypeControl: false,
    streetViewControl: false
  };
  var map=new google.maps.Map(document.getElementById('indexMap'),mapProp);

  var markers = [];
  var markerCount = 0;

  for (var i = 0; i < courts.length; i++) {
    var courtCoords = new google.maps.LatLng(
      courts[i].latitude,
      courts[i].longitude
    );

    markers[i] = new google.maps.Marker({
      position: courtCoords,
      label: (i + 1).toString()
    });

  markers[i].setMap(map);
  }

}
