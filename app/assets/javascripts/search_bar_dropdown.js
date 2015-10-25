$("#discover-nav-button").click(function( event ) {
  event.preventDefault()
  if ($(".search-container").length > 1 ) {

    var backgroundColor = $(".search-container:last").css( "background-color" );
    if (backgroundColor == "rgb(100, 100, 100)") {
      $(".search-container:last").css({
        "background-color": "rgba(0, 0, 0, 0)",
        "box-shadow": "none"
      });
    }
    else {
      $('html, body').animate({
        scrollTop: $(".search-container:last").offset().top
      }, 400);
      $(".search-container:last").css({
        "background-color": "rgb(100, 100, 100)",
        "box-shadow": "0px 0px 10px #2e8bad"
      });
    }
  }

  else {
    $('#dropdown-search').slideToggle( "slow" );
  }
});
