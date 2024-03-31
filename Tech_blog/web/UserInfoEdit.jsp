<%-- 
    Document   : UserInfoEdit
    Created on : Mar 23, 2024, 2:13:40 PM
    Author     : LOKENDRA SINGH YADAV
--%>

<%@page import="com.tech.blog.helper.StringUtils"%>
<%@page import="com.tech.blog.entity.SoftSkill"%>
<%@page import="com.tech.blog.entity.TechnicalSkill"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.dao.userInfoDao"%>
<%@page import="com.tech.blog.entity.userInfo"%>
<%@page import="com.tech.blog.dao.Userdao"%>
<%@page import="com.tech.blog.helper.Skills"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Info Edit</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
        <link href="css/StyleSecond.css" rel="stylesheet" type="text/css"/>
        <!--this is for cookies--> 
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.1/cookieconsent.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.1.1/cookieconsent.min.js"></script>


    </head>
    <body>


        <%
            user currentUser = (user) session.getAttribute("current_user");
            if (currentUser != null) {
        %>
        <%@include  file="new_navbar.jsp" %>
        <%        } else {
                response.sendRedirect("login_page.jsp");
            }
        %>


        <%
            // Retrieve the user ID from the request parameter
            int currentUser_id = currentUser.getId();
            // Retrieve user information using the user ID
            Userdao userdao = new Userdao(conn.getConnection());
            userInfoDao userinfodao = new userInfoDao(conn.getConnection());
            userInfo userInfoProfile = userinfodao.getUserInfoByUFid(currentUser_id);

//            user profile in userInfo
            user userprofile = userdao.getuserbyId(currentUser_id);

//            user info
//            userInfo userInfo = userinfodao.getUserInfoByUFid(currentUser_id);
            // Display user information
            if (userprofile != null) {
                // Display user's name, email, qualifications, or any other information
        %>


        <section style="background-color: #eee;">
            <div class="container py-2">
                <form action="userInfoEdit_servlet" method="post">
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="card mb-4">
                                <div class="card-body text-center">
                                    <%
                                        String gender = userprofile.getGender();
                                        // out.print(gender);
                                        if (gender != null) {
                                            if (gender.equals("male")) {
                                    %>  
                                    <img style="width: 150px;height: 150px; object-fit: cover; border: 1px solid #2196f3; border-radius: 50%;" class="img-fluid" src="maProfile/<%= userprofile.getProfile_pic()%>"> 
                                    <%
                                    } else {
                                    %>
                                    <img style="width: 150px;height: 150px; object-fit: cover; border: 1px solid #2196f3; border-radius: 50%;" class="img-fluid" src="feProfile/<%= userprofile.getProfile_pic()%>">
                                    <%
                                            }
                                        }
                                    %>
                                    <input type="hidden" name="currentUser_id" style="display: none;" value="<%= currentUser_id%>">
                                    <h5 class="my-3 display-6 fs-2" style="font-weight: 600;"><%= userprofile.getName()%> <i class="fa-solid fa-circle-check text-info" title="vip profile"></i></h5>
                                    <p class="text-muted mb-1" style="font-size: 1.5rem; font-weight: 500;">
                                        <%= userInfoProfile.getOccupation() != null && !userInfoProfile.getOccupation().equals("null") ? userInfoProfile.getOccupation() : "your occupation"%>
                                    </p>
                                    <p class="text-muted mb-4" style="font-size: 1rem;">
                                        <%= userInfoProfile.getAddress() != null && !userInfoProfile.getAddress().equals("null") ? userInfoProfile.getAddress() : "your Address"%>
                                    </p>

                                    <div class="d-flex justify-content-center mb-2">
                                        <button type="submit" class="btn btn-primary">Save Info</button>
                                        <button type="cancel" id="cancelBtn" class="btn btn-outline-primary ms-1">Cancel</button>
                                    </div>
                                </div>
                            </div>
                            <div class="card mb-4 mb-lg-0">
                                <div class="card-body p-0">
                                    <ul class="list-group list-group-flush rounded-3">
                                        <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                            <i class="fas fa-globe fa-lg text-warning"></i>
                                            <input type="text" name="other_site" class="siteLinks" placeholder="Personal Website" value="<%= userInfoProfile.getOther_site() != null && !userInfoProfile.getOther_site().equals("null") ? userInfoProfile.getOther_site() : "your personal site"%>">
                                        </li>

                                        <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                            <i class="fab fa-github fa-lg" style="color: #333333;"></i>
                                            <!--<input  type="text" name="github_site" class="siteLinks" placeholder="github Website">-->
                                            <input type="text" id="github_site" name="github_site" class="siteLinks" placeholder="GitHub link" value="<%= userInfoProfile.getGithub() != null && !userInfoProfile.getGithub().equals("null") ? userInfoProfile.getGithub() : "GitHub link"%>" oninput="validateSocialLink(this.value, 'github_site', /^https?:\/\/(www\.)?github\.com\/[a-zA-Z0-9_-]+(\/)?$/)">

                                        </li>

                                        <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                            <i class="fab fa-twitter fa-lg" style="color: #55acee;"></i>
                                            <!--<input  type="text" name="twitter_site" class="siteLinks" placeholder="twitter link" >-->
                                            <input type="text" id="twitter_site" name="twitter_site" class="siteLinks" placeholder="Twitter link" value="<%= userInfoProfile.getTwitter() != null && !userInfoProfile.getTwitter().equals("null") ? userInfoProfile.getTwitter() : "Twitter link"%>" oninput="validateSocialLink(this.value, 'twitter_site', /^https?:\/\/(www\.)?twitter\.com\/[a-zA-Z0-9_]+(\/)?$/)">
                                        </li>

                                        <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                            <i class="fab fa-instagram fa-lg" style="color: #ac2bac;"></i>
                                            <!--<input  type="text" name="instagram_site" class="siteLinks" placeholder="instagram link" >-->
                                            <input type="text" id="instagram_site" name="instagram_site" class="siteLinks" placeholder="Instagram link" value="<%= userInfoProfile.getInsta() != null && !userInfoProfile.getInsta().equals("null") ? userInfoProfile.getInsta() : "Instagram link"%>" oninput="validateSocialLink(this.value, 'instagram_site', /^https?:\/\/(www\.)?instagram\.com\/[a-zA-Z0-9_]+(\/)?$/)">
                                        </li>

                                        <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                            <i class="fab fa-facebook-f fa-lg" style="color: #3b5998;"></i>
                                            <!--<input  type="text" name="facebook_site" class="siteLinks" placeholder="Facebook link" >-->
                                            <input type="text" id="facebook_site" name="facebook_site" class="siteLinks" placeholder="Facebook link" value="<%= userInfoProfile.getFacebook() != null && !userInfoProfile.getFacebook().equals("null") ? userInfoProfile.getFacebook() : "Facebook link"%>" oninput="validateSocialLink(this.value, 'facebook_site', /^https?:\/\/(www\.)?facebook\.com\/[a-zA-Z0-9_]+(\/)?$/)">
                                        </li>

                                        <li class="list-group-item d-flex justify-content-between align-items-center p-3">
                                            <i class="fab fa-linkedin-in fa-lg" style="color: #3b5998;"></i>
                                            <!--<input  type="text" name="Linkedin_site" class="siteLinks" placeholder="Linkedin link" >-->
                                            <input type="text" id="linkedin_site" name="linkedin_site" class="siteLinks" placeholder="LinkedIn link" value="<%=userInfoProfile.getLinkedin() != null && !userInfoProfile.getLinkedin().equals("null") ? userInfoProfile.getLinkedin() : "LinkedIn link"%>" oninput="validateSocialLink(this.value, 'linkedin_site', /^https?:\/\/(www\.)?linkedin\.com\/[a-zA-Z0-9_]+(\/)?$/)">
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-8">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Full Name</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0"><%= userprofile.getName()%></p>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Email</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0"><%= userprofile.getEmail()%></p>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Mobile</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0">
                                                <input type="text" name="mobile_no" class="form-control" placeholder="Enter your mobile no." value="<%= userInfoProfile.getMobile() != 0 ? userInfoProfile.getMobile() : ""%>">
                                            </p>

                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">About</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0"><%= userprofile.getAbout()%></p>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Occupation</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0" id="occupationInput" style="display: flex; align-items: center; justify-content: space-between;">
                                                <!-- Occupation -->
                                                <select name="occupation" id="intOccupation" class="occupation select">
                                                    <option value="<%= userInfoProfile != null ? userInfoProfile.getOccupation() : ""%>" selected="true" disabled="true">Select Occupation</option>
                                                    <% for (String occupation : Skills.OCCUPATIONS) {%>
                                                    <option <%= userInfoProfile != null && occupation.equals(userInfoProfile.getOccupation()) ? "selected" : ""%>><%= occupation%></option>
                                                    <% }%>
                                                    <option value="other">Other</option> 
                                                </select>
                                                <input type="text" id="otherOccupation" class="otherOccupation otherSoftSkill" name="otherOccupation" style="display: none; margin-right: 3rem;" placeholder="Enter Other Occupation" value="<%= userInfoProfile != null ? userInfoProfile.getOccupation() : ""%>">
                                            </p>
                                            </p>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Address</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0"><input type="text" name="address" class="form-control" placeholder="Your address"  value="<%= userInfoProfile.getAddress() != null && !userInfoProfile.getAddress().equals("null") ? userInfoProfile.getAddress() : "your current Address"%>"></p>
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="col-sm-3">
                                            <p class="mb-0">Highest Qualification</p>
                                        </div>
                                        <div class="col-sm-9">
                                            <p class="text-muted mb-0"><input type="text" name="higherStudy" class="form-control" placeholder="Your Highest Study"   value="<%= userInfoProfile.getHigherStudy() != null && !userInfoProfile.getHigherStudy().equals("null") ? userInfoProfile.getHigherStudy() : "your highest Qualification"%>" ></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="card mb-4 mb-md-0">
                                        <div class="card-body">
                                            <p class="mb-4"><span class="text-primary font-italic me-1">Tech Skill's</span> With Status
                                            </p>
                                            <div class="px-2" style="display: flex; align-items: center;justify-content: space-between;">
                                                <p class="px-5">Choose Skill's</p>
                                                <p>Mark level(100)</p>
                                            </div>



                                            <%

                                                List<TechnicalSkill> savedTechSkills = userInfoProfile.getTechSkills();

                                                for (int i = 0; i < 5; i++) {
                                                    String savedSkill = "";
                                                    int savedSkillLevel = 0;
                                                    if (i < savedTechSkills.size()) {
                                                        TechnicalSkill skill = savedTechSkills.get(i);
                                                        savedSkill = skill.getName();
                                                        savedSkillLevel = skill.getLevel();
                                                    }
                                            %>
                                            <p class="my-3 px-3" class="techInputClass" id="techInput<%= i%>" style="display: flex; align-items: center;justify-content: space-between;">
                                                <select name="technical_skill_<%= i%>" id="inttechSkill<%= i%>" class="technicalSkill select">
                                                    <option value="<%= savedSkill%>" selected="true" disabled="true"><%= savedSkill.isEmpty() ? "Select Technical Skill" : savedSkill%></option>
                                                    <% for (String skill : Skills.TECHNICAL_SKILLS) {%>
                                                    <option <%= skill.equals(savedSkill) ? "selected" : ""%>><%= skill%></option>
                                                    <% }%>
                                                    <option value="other">Other</option> <!-- Add an "Other" option -->
                                                </select>
                                                <input type="text" class="otherTechnicalSkill" id="otherTechnicalSkill<%= i%>" name="otherTechnicalSkill_<%= i%>" style="display: none;" placeholder="Enter Other Skill">
                                                <input type="number" class="intInput" id="intInput<%= i%>" value="<%= savedSkillLevel%>" name="intInput_<%= i%>" min="0" max="100">
                                            </p>
                                            <% } %>







                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card mb-4 mb-md-0">
                                        <div class="card-body">
                                            <p class="mb-4"><span class="text-primary font-italic me-1">Soft Skill's</span> With Status
                                            </p>
                                            <div class="px-2" style="display: flex; align-items: center;justify-content: space-between;">
                                                <p class="px-5">Choose Skill's</p>
                                                <p>Mark level(100)</p>
                                            </div>


                                            <%
                                                List<SoftSkill> savedSoftSkills = userInfoProfile.getSoftSkills();

                                                for (int i = 0; i < 5; i++) {
                                                    String savedSkill = "";
                                                    int savedSkillLevel = 0;
                                                    if (i < savedSoftSkills.size()) {
                                                        SoftSkill skill = savedSoftSkills.get(i);
                                                        savedSkill = skill.getName();
                                                        savedSkillLevel = skill.getLevel();
                                                    }
                                            %>
                                            <p class="my-3 px-3" class="softInputClass" id="softInput<%= i%>" style="display: flex; align-items: center;justify-content: space-between;">
                                                <select name="soft_skill_<%= i%>" id="intsoftSkill<%= i%>" class="softSkill select">
                                                    <option value="<%= savedSkill%>" selected="true" disabled="true"><%= savedSkill.isEmpty() ? "Select Soft Skill" : savedSkill%></option>
                                                    <% for (String skill : Skills.SOFT_SKILLS) {%>
                                                    <option <%= skill.equals(savedSkill) ? "selected" : ""%>><%= skill%></option>
                                                    <% }%>
                                                    <option value="other">Other</option> <!-- Add an "Other" option -->
                                                </select>
                                                <input type="text" class="otherSoftSkill" id="otherSoftSkill<%= i%>" name="otherSoftSkill_<%= i%>" style="display: none;" placeholder="Enter Other Skill">
                                                <input type="number" class="intInput" id="intInput<%= i%>" value="<%= savedSkillLevel%>" name="softInput_<%= i%>" min="0" max="100">
                                            </p>
                                            <% } %>








                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </section>

        <%
            }
        %>

        <!--footer connect-->
        <div class="mt-5">   
            <%@include file="MyFooter.jsp" %>
        </div>






        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>


        <!--jQuery cdn-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>


        <!--sweet alert-->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


        <script src="js/MyJs.js" type="text/javascript"></script>
        <!--<script src="js/comment.js" type="text/javascript"></script>-->

        <script>
            document.querySelectorAll('.technicalSkill').forEach(function (select, index) {
                var otherTechnicalSkillInput = document.getElementById('otherTechnicalSkill' + index);
                var intTechnicalSkillInput = document.getElementById('inttechSkill' + index);
                select.addEventListener('change', function () {
                    if (this.value === 'other') {
                        otherTechnicalSkillInput.style.display = 'block';
                        otherTechnicalSkillInput.style.width = '40%';
                        intTechnicalSkillInput.style.width = '25%';
                    } else {
                        otherTechnicalSkillInput.style.display = 'none';
                        otherTechnicalSkillInput.value = ''; // Clear the input if it was filled previously
                    }
                });
            });


            document.querySelectorAll('.softSkill').forEach(function (select, index) {
                var otherSoftSkillInput = document.getElementById('otherSoftSkill' + index);
                var intSoftSkillInput = document.getElementById('intSoftSkill' + index);
                select.addEventListener('change', function () {
                    if (this.value === 'other') {
                        otherSoftSkillInput.style.display = 'block';
                        otherSoftSkillInput.style.width = '40%';
                        intSoftSkillInput.style.width = '25%';
                    } else {
                        otherSoftSkillInput.style.display = 'none';
                        otherSoftSkillInput.value = ''; // Clear the input if it was filled previously
                    }
                });
            });


            // Get references to the select element and the "Other" input field
            const occupationSelect = document.getElementById('intOccupation');
            const otherOccupationInput = document.getElementById('otherOccupation');

// Add an event listener to the select element
            occupationSelect.addEventListener('change', function () {
                // Check if the selected value is "other"
                if (this.value === 'other') {
                    // If "other" is selected, display the "Other" input field
                    otherOccupationInput.style.display = 'block';
                    occupationSelect.style.width = '40%';
                    otherOccupationInput.style.width = '50%';
                } else {
                    // If any other option is selected, hide the "Other" input field
                    otherOccupationInput.style.display = 'none';
                    // Clear the value of the "Other" input field
                    otherOccupationInput.value = '';
                }
            });


            document.getElementById('cancelBtn').addEventListener('click', function () {
                // Redirect the user to the desired cancel URL
                window.location.href = "cancel_url_here";
            });


            function validateSocialLink(link, inputId, regex) {
                // Check if the input matches the provided regex pattern
                if (regex.test(link)) {
                    // Set the border color to green to indicate a valid link
                    document.getElementById(inputId).style.borderColor = "green";
                } else {
                    // Set the border color to red to indicate an invalid link
                    document.getElementById(inputId).style.borderColor = "red";
                }
            }



        </script>




    </body>
</html>
