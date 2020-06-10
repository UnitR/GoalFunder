import consumer from "./consumer"

consumer.subscriptions.create("PaymentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {

    let oDataContent = JSON.parse(data.content)
    if (parseInt($('#hdnGoalId').val()) != oDataContent.goal_id) {
      // Incorrect ID
      return;
    }

    // Get progress element and update
    let progressBar = $('#bar');

    // if progress bar is not defined, return
    if (!progressBar)
      return;

    let progress = Math.round(oDataContent.funded)

    if (progress > 100) {
      progressBar.css('height', '100%');
    }
    else {
      progressBar.css('height', progress + '%');
    }
    $('#progressText').html(`${progress}%`);
  }
});
