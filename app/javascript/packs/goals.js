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

    $('#confPayment').prop('disabled', true).html('Please wait...');

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
        $("#paymentModal").modal("hide");
        $('#confPayment').prop('disabled', false).html('Proceed to Payment');
        $('#confPayment').innerText = 'Proceed to Payment';
        alert("Successfully contributed £" + data.amount + " to goal!\n" +
                "Developer information: [PayPal Transaction ID: " + data.pp_id + ']');
      },
      error: function(data) {
        alert("failure:" + data.responseText);
      }
    });
  });

  // Handle clicking on the make payment button
  $("#confGoal").on("click", function () {

    // Get Identifiers
    let userId = $("#hdnUserId").val();
    let groupId = $("#hdnGroupId").val();

    // Get the authenticity token to submit a POST request
    let AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

    // Goal params
    let goalName = $("#goalName").val();
    let goalTarget = $("#goalTarget").val();
    let goalTags = $("#goalTags").val();

    let url = 'goals/create';

    $('#confGoal').prop('disabled', true).html('Please wait...');

    // Perform AJAX request
    $.ajax({
      method: 'POST',
      url: url,
      data: {
        user_id: userId,
        group_id: groupId,
        goal_target: goalTarget,
        goal_keywords: goalTags,
        goal_name: goalName
      },
      dataType: 'json',
      success: function(data) {
        $("#goalModal").modal("hide");
        $('#confGoal').prop('disabled', false).html('Proceed to Payment');
        $('#confGoal').innerText = 'Proceed to Payment';
        alert("Successfully created goal " + goalName);
      },
      error: function(data) {
        alert("failure:" + data.responseText);
      }
    });
  });
});