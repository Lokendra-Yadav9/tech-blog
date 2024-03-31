



function toggleCommentSection() {
    $("#commentSection").toggle();
}

// Function to submit the comment via AJAX
// Function to submit the comment via AJAX
function submitComment(uid, pid) {
    var commentText = $("#commentText").val().trim();
    if (commentText === '') {
        console.error("Comment text is empty");
        return;
    }

    var data = {
        uid: uid,
        pid: pid,
        commentText: commentText
    };

    $.ajax({
        type: "POST",
        url: "CommentServlet",
        data: data,
        success: function (response) {
            console.log("Comment submitted successfully:", response);
            // Clear the comment textarea after submission
            
            $("#commentText").val('');
        },
        error: function (xhr, status, error) {

            console.error("Error submitting comment:", error);
        }
    });
}

