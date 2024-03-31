
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
        <title>page of posts</title>
        <link href="css/myStyle.css" rel="stylesheet" type="text/css">
        <style>
        </style>





    </head>
    <body>

        <%
            user users = (user) session.getAttribute("current_user");

            postDao pD = new postDao(conn.getConnection());
            int cid = Integer.parseInt(request.getParameter("cid"));
            List<post> pdList = null;
            if (cid == 0) {
                pdList = pD.getAllPosts();
            } else {
                pdList = pD.getPostByCatId(cid);
            }

            if (pdList.size() == 0) {
                out.println("<h4 class='display-4 text-center text-light'>Oops! No post's found for this category..</h4>");
            }
        %>
        <div class="container" >
            <div class="row justify-content-start">
                <%
                    for (post pPost : pdList) {

                        String imageSource = "";
                        if (pPost.getpPic() != null && !pPost.getpPic().isEmpty() && !pPost.getpPic().equalsIgnoreCase("null")) {
                            imageSource = "Blog_images/" + pPost.getpPic();
                        } else if (pPost.getImageUrl() != null && !pPost.getImageUrl().isEmpty()) {
                            imageSource = pPost.getImageUrl();
                        } else {
                            imageSource = "default_image.jpg"; // Default image source if both are null
                        }
                %>
                <div class="col-md-6 mt-3">
                    <div class="card p-2">
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
                                //       int postId = Integer.parseInt(request.getParameter("postId"));
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
                            <small class="mb-2"><span class="fa-solid fa-chalkboard-user fa-spin"></span>  Blogger name -<a class="getuserByname" href="Userprofile.jsp?userId=<%= pPost.getUserId()%>" >  <%= pD.GetNameByUserId(pPost.getUserId())%></a></small><br>
                            <small class="mb-2"><span class="fa-solid fa-layer-group"></span>  Blog category - <%= pD.GetCategoryNameByCatId(pPost.getCatid())%></small><br>
                            <small class="mb-2"><span class="fa-regular fa-calendar-check"></span>  Blog posted on - <%= dateFormatter.formatPostDate(pPost.getpDate())%></small>
                        </div>
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

    </body>
</html>







