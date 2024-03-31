$(document).ready(function() {
    $('#follow').click(function() {
        // Extract follower and followed IDs (replace these with actual values)
        var followerId = 1; // Replace with the logged-in user's ID
        var followedId = 2; // Replace with the ID of the user being followed
        
        // Send AJAX request to FollowServlet
        $.ajax({
            url: 'FollowServlet',
            type: 'POST',
            data: { followerId: followerId, followedId: followedId },
            success: function(response) {
                // Update button text to indicate following
                $('#follow').text('Following');
                // Disable button to prevent multiple follows
                $('#follow').prop('disabled', true);
            },
            error: function(xhr, status, error) {
                // Handle error
                console.error(xhr.responseText);
            }
        });
    });
});
