// Hook the display of goal information from the link in payment history
$("#tblPaymentHistory .spnGoalLink").on("click", function() {

    // Get the ID of the relevant goal
    let goalId = $(this).data("goal");
    let url = "/goals/" + goalId;

    // Ajax call to get goal information
    $.ajax({
        url: url,
        method: "GET",
        dataType: "json",
        success: function(data) {

            // Fill out modal details
            $("#spnGoalName").html(data.name);
            $("#spnPayAmount").html(data.amount);
            $("#spnPayDateTime").html(data.created_at);
            $("#spnGoalOwner").html(
                data.goal_owner.user.first_name + ' ' + data.goal_owner.user.last_name);

            // Determine if this is a donation
            let isDonation = data.goal_owner.user.is_organisation ? 'Y' : 'N';
            $("#spnIsDonation").html(isDonation);

            // Display data
            $("#paymentGoalDetailsModal").modal('show');

        },
        error: function(data) {
            alert("Failed to retrieve Goal data: " + data.responseText);
        }
    });
});