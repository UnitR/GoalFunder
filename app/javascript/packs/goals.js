$(document).ready(function () {

  var btn = document.getElementById('btn');
  var bar = document.getElementById('bar');
  var txt = document.getElementById('text');
  var count = 0;
  // Listen for an event on the button
  // Increase the width of the bar by 10 percent(10%)
  btn.addEventListener('click', () => {
    //  bar.style.width = count + '%';
    bar.style.height = count + '%';
    txt.innerHTML = count + '%';
    if (count === 100) {
      count = 0;
    } else {
      count = count + 10;
    }
  });

  // Handle clicking on the make payment button
  $("#confPayment").on("click", function () {

    var userId = $("#hdnUserId").val();
    var goalId = $("#hdnGoalId").val();
    var amount = $("#paymentAmount").val();
    var url = 'payment_processing/make_payment/';

    // Get the authenticity token to submit a POST request
    var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

    // Perform AJAX request
    $.ajax({
      method: 'POST',
      url: url,
      data: {
        user_id: userId,
        amount: amount,
        goal_id: goalId,
        authenticity_token: AUTH_TOKEN
      },
      dataType: 'json',
      success: function(data) {
        alert("Successfully contributed £" + data.amount + " to goal!");
        $("#paymentModal").modal("hide");
      },
      error: function(data) {
        alert("failure:" + data.responseText);
      }
    });
  });
});