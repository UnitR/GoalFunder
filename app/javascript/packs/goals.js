$(document).ready(function () {

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
        let contrib = $('#persContribution').html();
        contrib = 1*contrib + 1*amount;
        $('#persContribution').html(Math.round(contrib));
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
        alert("Successfully created goal " + goalName);
        refreshBody();
      },
      error: function(data) {
        alert("failure:" + data.responseText);
      }
    });
  });

  $("td.grp-list").on('click', function (e) {

    // Obtain the selected group id
    let groupId = e.target.dataset.group;

    // Obtain group information through an ajax request
    $.ajax({
      method: 'GET',
      url: `/groups/${groupId}`,
      dataType: 'json',
      success: function(data) {
        $("#headingGroupName").html(data.group_name);
        let progressBar = $('#bar');
        if (data.funded_amount > 100) {
          progressBar.css('height', '100%');
          progressBar.show();
        }
        else if (data.funded_amount == 0) {
          progressBar.css('height', '0%');
          progressBar.hide();
        }
        else {
          progressBar.css('height', data.funded_amount + '%');
          progressBar.show();
        }
        $("#progressText").html(`${Math.round(data.funded_amount)}%`);
        $("#hdnGroupId").val(groupId);
        $("#persContribution").html(data.pers_contrib);
        $(".hdnGoalId").val(data.group_goal.id);
      },
      error: function(data) {
        alert(data.innerText);
      }
    });
  });
});