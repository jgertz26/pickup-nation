$(".join-button").on( "click", function(event) {
  event.preventDefault();

  var buttonType = this.classList[2];
  var meetupId = this.id.split("-")[1]

  debugger;
  if (buttonType == "success") {

    $(this).removeClass("success")
    $(this).addClass("alert")
    $.ajax({
      url: "/meetups/" + meetupId + "/attendees",
      method: 'POST',
      dataType: 'json',
      data: {meetup_id: meetupId}
    })

  }

});
