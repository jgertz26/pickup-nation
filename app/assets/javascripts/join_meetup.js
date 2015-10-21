var $button;
var meetupId;
var attendeeAction;

$(".join-button").on('click', function(event) {
  event.preventDefault();

  $button = $(this);
  meetupId = this.id.split("-")[1];
  attendeeAction = $button.text();
  $.ajax({
    url: "/meetups/" + meetupId + "/attendees",
    method: 'POST',
    dataType: 'json',
    data: {meetupId: meetupId, attendeeAction: attendeeAction}
  })
  .success(function(attendees){
    if (attendeeAction == "Join Game") {
      $button.removeClass("success");
      $button.addClass("alert");
      $button.text("Leave Game");
      meetupFlash(meetupId, attendees, "joined");
    }
    else {
      $button.removeClass("alert");
      $button.addClass("success");
      $button.text("Join Game");
      meetupFlash(meetupId, attendees, "left");
    }
  });
});

function meetupFlash(meetup, attendees, result) {
  $("#attendee-info-" + meetup).text("Total attendees: " + attendees);
  $(".alert-box").remove();
  $( "#background" ).prepend(
    "<div data-alert class='alert-box'>Successfully " +
    result + " game</div>"
  );
  setTimeout(function() {
     $(".alert-box").fadeOut();
  }, 2200);
}
