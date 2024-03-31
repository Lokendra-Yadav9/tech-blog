
<%@page import="com.tech.blog.dao.commentDao"%>
<%@page import="com.tech.blog.entity.user"%>
<%@page import="com.tech.blog.dao.likeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entity.post"%>
<%@page import="com.tech.blog.helper.conn"%>
<%@page import="com.tech.blog.dao.postDao"%>
<%@page import="com.tech.blog.helper.dateFormatter"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Post Container</title>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
        <style>
            .buttons {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                /*background-color: rgb(20, 20, 20);*/
                background-color: #1B3C73!important;
                border: none;
                font-weight: 600;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.164);
                cursor: pointer;
                transition-duration: 0.3s;
                overflow: hidden;
                position: relative;
                gap: 2px;
            }

            .svgIcon {
                width: 12px;
                transition-duration: 0.3s;
            }

            .svgIcon path {
                fill: white;
            }

            .buttons:hover {
                transition-duration: 0.3s;
                background-color: red!important;
                align-items: center;
                gap: 0;
            }

            .bin-top {
                transform-origin: bottom right;
            }
            .buttons:hover .bin-top {
                transition-duration: 0.5s;
                transform: rotate(160deg);
            }

        </style>

    </head>
    <body>

        <%
            user users = (user) session.getAttribute("current_user");
            int userId = 0;

            // Check if the current_user attribute is not null
            if (users != null) {
                userId = Integer.parseInt(request.getParameter("userId"));
//                  out.println( userId);
            } else {

                out.println("User session not found. Please log in.");
            }

            postDao pD = new postDao(conn.getConnection());
            int cid = Integer.parseInt(request.getParameter("cid"));
            // List to hold posts
            List<post> pdList = null;
            if (cid == 0) {
                // Retrieve all posts by the user
                pdList = pD.getAllPostsUserId(userId);
            } else {
                // Retrieve posts by category ID and user ID
                pdList = pD.getPostByCatIdOrUserId(cid, userId);
            }

            if (pdList.size() == 0) {
                out.println("<h4 class='display-4 text-center text-light'>Oops! No posts found of this user in this categories.</h4>");
            }
        %>




        <div class="container" >
            <div class="row justify-content-start">
                <%                    for (post pPost : pdList) {
                
                         String imageSource = "";
                        if (pPost.getpPic() != null && !pPost.getpPic().isEmpty()) {
                            imageSource = "Blog_images/" + pPost.getpPic();
                        } else if (pPost.getImageUrl() != null && !pPost.getImageUrl().isEmpty()) {
                            imageSource = pPost.getImageUrl();
                        } else {
                            imageSource = "default_image.jpg"; // Default image source if both are null
                        }

                %>
                <div class="col-md-6 mt-3">
                    <div class="card p-2" id="post_<%= pPost.getPid()%>">
                        <%= imageSource %>
                        <img src="<%= imageSource %>" class="card-img-top" alt="Blog Images" style="width: 100%; height: 20vw; object-fit: contain;">
                        <div class="card-body">
                            <h5 class="card-title mb-3 display-5" style="font-size: 2rem;font-weight:500 ; text-transform: capitalize;"><%= pPost.getpTitle()%></h5>
                            <div class="card-text read-more my-2" style="max-height: 300px; overflow-x: hidden; overflow-y: auto;border: 1px solid #cccccc; border-radius: 3px;">
                                <p class="truncated"><%= pPost.getpContent().substring(0, 200)%></p>
                                <p class="full p-2" style="display: none;"><%= pPost.getpContent()%></p>
                                <button class="read-more-btn btn btn-link">Read more</button>
                            </div>

                        </div>
                        <!--<div class="bg-white rounded-top">-->
                        <div class="container  bg-white"> 
                            <style>
                                .btn:focus,
                                .btn:active {
                                    outline: none !important;
                                    box-shadow: none !important;
                                }
                                a{
                                    text-decoration: none !important;
                                }
                                a:focus,
                                a:active {
                                    outline: none !important;
                                    box-shadow: none !important;
                                }
                            </style>
                            <%
                                likeDao dao = new likeDao(conn.getConnection());
                                commentDao cd = new commentDao(conn.getConnection());
//                                int postId = Integer.parseInt(request.getParameter("postId"));
%>
                            <div class="d-flex justify-content-around align-items-center p-2">



                                <a href="#!" onclick="userLiked(<%= pPost.getPid()%>, <%= users.getId()%>)" class="text-center btn-sm" style="text-decoration: none;">

                                    <%
                                        boolean isLikedByUser = dao.isLikedByUser(users.getId(), pPost.getPid());
                                        String heartIconClass = isLikedByUser ? "fa-solid text-danger" : "fa-regular";
                                    %>

                                    <i id="heartIcon_<%= pPost.getPid()%>" class="fa-heart fa-2x <%= heartIconClass%>" style="font-size: 1.6em;"></i><br>
                                    <span id="likeCounter_<%= pPost.getPid()%>"><%= dao.countLikesOnPost(pPost.getPid())%></span>
                                </a>








                                <a href="displayServlet.jsp?postId=<%= pPost.getPid()%>" class="btn btn-success">View Full Blog</a>

                                <a href="displayServlet.jsp?postId=<%= pPost.getPid()%>" class="text-center btn-sm">
                                    <i class="fa-regular fa-comment fa-2x" style="color: #101010;font-weight: 300;font-size: 1.6em;"></i><br>
                                    <span><%= cd.getAllComments(pPost.getPid())%></span>
                                </a>
                            </div>

                        </div>

                        <!--</div>-->

                        <div class="card-footer bg-body-secondary text-dark text-small">
                            <small class="mb-2"><span class="fa-solid fa-chalkboard-user fa-spin"></span>  Blogger name -<a class="getuserByname" href="Userprofile.jsp?userId=<%= pPost.getUserId()%>"> <%= pD.GetNameByUserId(pPost.getUserId())%></a></small><br>
                            <small class="mb-2"><span class="fa-solid fa-layer-group"></span>  Blog category - <%= pD.GetCategoryNameByCatId(pPost.getCatid())%></small><br>
                            <small class="mb-2"><span class="fa-regular fa-calendar-check"></span>  Blog posted on - <%= dateFormatter.formatPostDate(pPost.getpDate())%></small>
                        </div>

                        <%
                            if (users.getId() == userId) {
                        %>
                        <div class="card-footer bg-body-light d-flex justify-content-center align-items-center">
                            <a style="cursor: pointer;" onclick="deletePost(<%= pPost.getPid()%>)"> 
                                <button class="buttons">
                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        fill="none"
                                        viewBox="0 0 69 14"
                                        class="svgIcon bin-top"
                                        >
                                    <g clip-path="url(#clip0_35_24)">
                                    <path
                                        fill="black"
                                        d="M20.8232 2.62734L19.9948 4.21304C19.8224 4.54309 19.4808 4.75 19.1085 4.75H4.92857C2.20246 4.75 0 6.87266 0 9.5C0 12.1273 2.20246 14.25 4.92857 14.25H64.0714C66.7975 14.25 69 12.1273 69 9.5C69 6.87266 66.7975 4.75 64.0714 4.75H49.8915C49.5192 4.75 49.1776 4.54309 49.0052 4.21305L48.1768 2.62734C47.3451 1.00938 45.6355 0 43.7719 0H25.2281C23.3645 0 21.6549 1.00938 20.8232 2.62734ZM64.0023 20.0648C64.0397 19.4882 63.5822 19 63.0044 19H5.99556C5.4178 19 4.96025 19.4882 4.99766 20.0648L8.19375 69.3203C8.44018 73.0758 11.6746 76 15.5712 76H53.4288C57.3254 76 60.5598 73.0758 60.8062 69.3203L64.0023 20.0648Z"
                                        ></path>
                                    </g>
                                    <defs>
                                    <clipPath id="clip0_35_24">
                                        <rect fill="white" height="14" width="69"></rect>
                                    </clipPath>
                                    </defs>
                                    </svg>

                                    <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        fill="none"
                                        viewBox="0 0 69 57"
                                        class="svgIcon bin-bottom"
                                        >
                                    <g clip-path="url(#clip0_35_22)">
                                    <path
                                        fill="black"
                                        d="M20.8232 -16.3727L19.9948 -14.787C19.8224 -14.4569 19.4808 -14.25 19.1085 -14.25H4.92857C2.20246 -14.25 0 -12.1273 0 -9.5C0 -6.8727 2.20246 -4.75 4.92857 -4.75H64.0714C66.7975 -4.75 69 -6.8727 69 -9.5C69 -12.1273 66.7975 -14.25 64.0714 -14.25H49.8915C49.5192 -14.25 49.1776 -14.4569 49.0052 -14.787L48.1768 -16.3727C47.3451 -17.9906 45.6355 -19 43.7719 -19H25.2281C23.3645 -19 21.6549 -17.9906 20.8232 -16.3727ZM64.0023 1.0648C64.0397 0.4882 63.5822 0 63.0044 0H5.99556C5.4178 0 4.96025 0.4882 4.99766 1.0648L8.19375 50.3203C8.44018 54.0758 11.6746 57 15.5712 57H53.4288C57.3254 57 60.5598 54.0758 60.8062 50.3203L64.0023 1.0648Z"
                                        ></path>
                                    </g>
                                    <defs>
                                    <clipPath id="clip0_35_22">
                                        <rect fill="white" height="57" width="69"></rect>
                                    </clipPath>
                                    </defs>
                                    </svg>
                                </button>
                            </a>
                        </div>
                                
                        <%
                            }
                        %>
                    </div>
                </div>
                <% }%>
            </div>
        </div>


        <script src="js/comment.js" type="text/javascript"></script>

        <script src="js/MyJs.js" type="text/javascript"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

        <script>
                              $(document).ready(function () {

                                  $('.read-more-btn').click(function () {
                                      var cardText = $(this).closest('.card').find('.card-text');
                                      var truncated = cardText.find('.truncated');
                                      var full = cardText.find('.full');

                                      if (truncated.is(':visible')) {
                                          truncated.hide();
                                          full.show();
                                          $(this).text('Read less');
                                      } else {
                                          truncated.show();
                                          full.hide();
                                          $(this).text('Read more');
                                      }
                                  });
                              });

        </script>

        <script>
            // JavaScript function to delete the post
            function deletePost(postId) {
                // Confirm with the user before deleting the post
                if (confirm("Are you sure you want to delete this post?")) {
                    // Make AJAX request to delete the post
                    $.ajax({
                        url: 'deletePostServlet', // Replace with the URL of your servlet or controller
                        type: 'POST',
                        data: {postId: postId},
                        success: function (response) {
                            // Remove the post from the UI
                            $('#post_' + postId).remove(); // Assuming each post has a unique ID
                            var postCountElement = $('#postCount'); // Assuming you have a post count element
                            var postCount = parseInt(postCountElement.text());
                            postCountElement.text(postCount - 1);
                        },
                        error: function (xhr, status, error) {
                            // Handle error
                            console.error(xhr.responseText);
                        }
                    });
                }
            }
        </script>

    </body>
</html>
