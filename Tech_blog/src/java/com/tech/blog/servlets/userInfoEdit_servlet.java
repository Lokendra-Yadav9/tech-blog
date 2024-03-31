package com.tech.blog.servlets;

import com.tech.blog.dao.userInfoDao;
import com.tech.blog.entity.SoftSkill;
import com.tech.blog.entity.TechnicalSkill;
import com.tech.blog.entity.userInfo;
import com.tech.blog.helper.conn;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class userInfoEdit_servlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            String currentUser_id_str = request.getParameter("currentUser_id");
            int UF_id = 0; // Default value in case the parameter is empty or null
            if (currentUser_id_str != null && !currentUser_id_str.isEmpty()) {
                UF_id = Integer.parseInt(currentUser_id_str);
            }
            String occupation = request.getParameter("occupation");
            String address = request.getParameter("address");
            String higherStudy = request.getParameter("higherStudy");
            String other_site = request.getParameter("other_site");
            String github_site = request.getParameter("github_site");
            String twitter_site = request.getParameter("twitter_site");
            String instagram_site = request.getParameter("instagram_site");
            String facebook_site = request.getParameter("facebook_site");
            String linkedin_site = request.getParameter("linkedin_site");
            String mobile_no_str = request.getParameter("mobile_no");
            long mobile_no = 0; // Default value in case the parameter is empty or null
            if (mobile_no_str != null && !mobile_no_str.isEmpty()) {
                mobile_no = Long.parseLong(mobile_no_str);
            }

            // Create lists to store technical skills and their levels
            List<TechnicalSkill> technicalSkills = new ArrayList<>();
            List<Integer> techSkillLevels = new ArrayList<>();

// Retrieve technical skills and their levels from request parameters
            for (int i = 0; i < 5; i++) {
                String skillName = request.getParameter("technical_skill_" + i);
                String skillLevelStr = request.getParameter("intInput_" + i);

                if (skillName != null && !skillName.isEmpty() && skillLevelStr != null && !skillLevelStr.isEmpty()) {
                    int skillLevel = Integer.parseInt(skillLevelStr);
                    TechnicalSkill technicalSkill = new TechnicalSkill(skillName, skillLevel);
                    technicalSkills.add(technicalSkill);
                    techSkillLevels.add(skillLevel);
                }
            }

// Set the technicalSkills list in the userInfo object
            // Create lists to store soft skills and their levels
            List<SoftSkill> softSkills = new ArrayList<>();
            List<Integer> softSkillLevels = new ArrayList<>();

// Retrieve soft skills and their levels from request parameters
            for (int i = 0; i < 5; i++) {
                String skillName = request.getParameter("soft_skill_" + i);
                String skillLevelStr = request.getParameter("softInput_" + i);
                if (skillName != null && !skillName.isEmpty() && skillLevelStr != null && !skillLevelStr.isEmpty()) {
                    int skillLevel = Integer.parseInt(skillLevelStr);
                    SoftSkill softSkill = new SoftSkill(skillName, skillLevel);
                    softSkills.add(softSkill);
                    softSkillLevels.add(skillLevel);
                }
            }

// Set the softSkills list in the userInfo object
            // Create a userInfo object with retrieved information
            userInfo user = new userInfo();
            user.setId(UF_id);
            user.setMobile(mobile_no);
            user.setOccupation(occupation);
            user.setAddress(address);
            user.setHigherStudy(higherStudy);
            user.setOther_site(other_site);
            user.setGithub(github_site);
            user.setTwitter(twitter_site);
            user.setInsta(instagram_site);
            user.setFacebook(facebook_site);
            user.setLinkedin(linkedin_site);
            user.setTechSkills(technicalSkills);
            user.setTechSkillLevels(techSkillLevels);
            user.setSoftSkills(softSkills);
            user.setSoftSkillLevels(softSkillLevels);

            // Save the user information
            userInfoDao ufDao = new userInfoDao(conn.getConnection());
            boolean success;
            if (ufDao.isNewUser(user)) {
                success = ufDao.saveUser(user); // Call saveUser method for new user
                out.println("this is new user");
            } else {
                success = ufDao.updateUser(user); // Call updateUser method for existing user
                out.println("this is old user");
            }

            if (success) {
                UF_id = Integer.parseInt(currentUser_id_str);
                response.sendRedirect("Userprofile.jsp?userId=" + UF_id);
            } else {
                out.println("<h1>Error: User information not saved</h1>");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
