// Function to check if a post is liked by a user
function isPostLikedByUser(pid, uid) {
    const likedCookie = getCookie("liked_post_" + pid);
//        console.log("isPostLikedByUser get cookies " + likedCookie);
    return likedCookie === "true";
}

// Function to get a cookie by its name
function getCookie(name) {
    const cookies = document.cookie.split(';');
    for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith(name + '=')) {
// Extract and return the cookie value  
            return cookie.substring(name.length + 1).trim(); // Add 1 to skip the '=' character
        }
    }
    return "false"; // Return false if the cookie is not found
}

// Function to set a cookie
function setCookie(name, value, days, secure = true) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
//console.log("set cookies");
    document.cookie = name + "=" + (value || "") + expires + "; path=/; Secure=" + secure;
//        console.log(document.cookie);
}

// Function to delete a cookie by setting its expiration date in the past
function deleteCookie(name) {
//console.log("delete cookies")
    document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
}

// Function to update the like icon UI based on user's like status
function updateLikeStatus(pid, uid) {
// Check if the element exists in the DOM
    const likeIcon = $("#heartIcon_" + pid); // Change the selector to target the heart icon
    if (likeIcon.length === 0) {
//console.log("Element not found for pid: " + pid);
        return;
    }

    const postLiked = isPostLikedByUser(pid, uid);
    if (postLiked) {
//console.log("Liked");
        likeIcon.removeClass("fa-regular").addClass("fa-solid text-danger"); // Add solid heart icon class and make it red
    } else {
//console.log("Unliked");
        likeIcon.removeClass("fa-solid text-danger").addClass("fa-regular"); // Add regular heart icon class
    }
}



// Function to update the like counter UI
function updateLikeCounter(pid, count) {
    const likeCounter = $("#likeCounter_" + pid);
    likeCounter.text(count);
}

// Function to handle user liking or unliking a post
function userLiked(pid, uid) {
    const info = {
        uid: uid,
        pid: pid,
        operation: 'toggleLike'
    };
    $.ajax({
        url: "likedServlet",
        data: info,
        success: function (data, textStatus, jqXHR) {
            if (typeof data === 'object' && data.message) {
                const message = data.message.trim();
                if (jqXHR.status === 200) {
                    if (message === "done") {
//                console.log(message + " done");
                        updateLikeCounter(pid, parseInt($("#likeCounter_" + pid).text()) + 1);
                        // Set a cookie to track that the user has liked this post
                        setCookie("liked_post_" + pid, true, 30); // Assuming the cookie should last for 30 days
                        updateLikeStatus(pid, uid);
                    } else if (message === "undone") {
//                console.log(message + " undone");
                        updateLikeCounter(pid, parseInt($("#likeCounter_" + pid).text()) - 1);
                        // Delete the cookie to indicate that the user has unliked this post
                        deleteCookie("liked_post_" + pid);
                        updateLikeStatus(pid, uid);
                    } else {
                        console.error("Invalid response:", data);
                    }
                } else {
                    console.error("AJAX Error:", textStatus);
                }
            } else {
                console.error("Invalid response:", data);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            console.error("AJAX Error:", errorThrown);
        }
    });
}



//  this is the all about userInfo edit


function goToUserInfoPage() {
// Change the window location to UserInfo.jsp
    window.location.href = "UserInfoEdit.jsp";
}



// userProfile jsp image profile view js 
// Function to open the profile modal
function previewImage(imageSrc) {
    var modal = document.getElementById('profileModal');
    var modalImg = document.getElementById('modalImg');
    modal.style.display = 'block';
    modalImg.src = imageSrc;
}

// Function to close the profile modal
function closeModal() {
    var modal = document.getElementById('profileModal');
    modal.style.display = 'none';
}

// Close the modal if clicked outside of it
window.onclick = function (event) {
    var modal = document.getElementById('profileModal');
    if (event.target == modal) {
        modal.style.display = 'none';
    }
}




// the search bar js and ajax 
function displaySearchResults(users) {
    var searchResults = $('#searchResults');
    // Clear previous search results
    searchResults.empty();
    // Toggle the visibility based on the presence of users
    if (users && users.length > 0) {
// If users are found, display them and remove the 'd-none' class
        users.forEach(function (user) {
            // Safely set text content using .text() to prevent XSS vulnerabilities
            var userContent = $('<p>').text('ID: ' + user.id + ' - ' + user.name);
            var userLink = $('<a>').addClass('user-link').attr('href', 'Userprofile.jsp?userId=' + user.id).append(userContent);
           
            searchResults.append(userLink);
        });
        searchResults.removeClass('d-none').addClass('d-block');
    } else {
// If no users are found, display a message and remove the 'd-block' class
        searchResults.append('<p>No users found</p>');
        searchResults.removeClass('d-block').addClass('d-none');
    }
}



$(document).ready(function () {
    $('#searchForm').submit(function (event) {
        event.preventDefault(); // Prevent default form submission

        // Get the search query from the input field
        var searchQuery = $('#searchInput').val().trim();
        // Make AJAX request to the servlet
        $.ajax({
            url: 'searchUsersServlet',
            type: 'GET',
            data: {name: searchQuery},
            success: function (response) {
                try {
                    // Parse the JSON response
                    var users = JSON.parse(response);
                    // Display the search results
                    displaySearchResults(users);
                } catch (error) {
                    console.error('Error parsing JSON:', error);
                    // Handle error: Display a message or clear the search results
                    displaySearchResults("no user found");
                }
            },
            error: function (xhr, status, error) {
                console.error('Error:', error);
                // Handle error: Display a message or clear the search results
                displaySearchResults([]);
            }
        });
    });
    
    
    
    
    // Click event listener to hide search results when clicking outside
    $(document.body).on('click', function (event) {
// Check if the click event target is not within the search results area or the search input
        if (!$(event.target).closest('#searchResults').length && !$(event.target).is('#searchInput')) {
            $('#searchResults').removeClass('d-block').addClass('d-none');
        }
    });
});




//add more category by do post 

$(document).ready(function () {
    $("#categorySelect").change(function () {
        var selectedValue = $(this).val(); // Get the selected value

        if (selectedValue === "other") {
            // Show form elements
            $("#otherCategoryInput").show();
            $("#otherCategoryDescpInput").show();
            $("#saveCateBtn").show();
        } else {
            // Hide form elements
            $("#otherCategoryInput").hide();
            $("#otherCategoryDescpInput").hide();
            $("#saveCateBtn").hide();
        }
    });




});





