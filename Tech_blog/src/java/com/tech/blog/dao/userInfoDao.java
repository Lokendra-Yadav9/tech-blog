package com.tech.blog.dao;

import com.tech.blog.entity.userInfo;
import com.tech.blog.entity.SoftSkill;
import com.tech.blog.entity.TechnicalSkill;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServlet;

public class userInfoDao extends HttpServlet {

    private Connection conn;

    public userInfoDao(Connection conn) {
        this.conn = conn;
    }

//    empty new user inert during the registration 
    public boolean insertEmptyUserInfo(int userId) {
        boolean status = false;
        try {
            // Create SQL query to insert an empty row into the userInfo table
            String sql = "INSERT INTO userinfo (UF_id) VALUES (?)";

            // Create prepared statement
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);

            // Execute the query
            int rowsAffected = pstmt.executeUpdate();

            // Check if the row was inserted successfully
            if (rowsAffected > 0) {
                status = true;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception appropriately
        }
        return status;
    }

    public boolean saveUser(userInfo user) {
        boolean success = false;
        try {
            // Insert user information into the userInfo table
            String queryUserInfo = "INSERT INTO userinfo (UF_id, mobile, occupation, address, higher_Study, twitter, insta, facebook, github, other_site, Linkedin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
            PreparedStatement pstmtUserInfo = conn.prepareStatement(queryUserInfo);
            pstmtUserInfo.setInt(1, user.getId());
            pstmtUserInfo.setLong(2, user.getMobile());
            pstmtUserInfo.setString(3, user.getOccupation());
            pstmtUserInfo.setString(4, user.getAddress());
            pstmtUserInfo.setString(5, user.getHigherStudy());
            pstmtUserInfo.setString(6, user.getTwitter());
            pstmtUserInfo.setString(7, user.getInsta());
            pstmtUserInfo.setString(8, user.getFacebook());
            pstmtUserInfo.setString(9, user.getGithub());
            pstmtUserInfo.setString(10, user.getOther_site());
            pstmtUserInfo.setString(11, user.getLinkedin());
            pstmtUserInfo.executeUpdate();

            // Insert technical skills and levels into the techSkills table
            String queryTechSkills = "INSERT INTO techSkills (user_id, tech_skill, tech_skill_level) VALUES (?, ?, ?)";
            PreparedStatement pstmtTechSkills = conn.prepareStatement(queryTechSkills);
            for (TechnicalSkill techSkill : user.getTechSkills()) {
                pstmtTechSkills.setInt(1, user.getId());
                pstmtTechSkills.setString(2, techSkill.getName());
                pstmtTechSkills.setInt(3, techSkill.getLevel());
                pstmtTechSkills.executeUpdate();
            }

            // Insert soft skills and levels into the softSkills table
            String querySoftSkills = "INSERT INTO softSkills (user_id, soft_skill, soft_skill_level) VALUES (?, ?, ?)";
            PreparedStatement pstmtSoftSkills = conn.prepareStatement(querySoftSkills);
            for (SoftSkill softSkill : user.getSoftSkills()) {
                pstmtSoftSkills.setInt(1, user.getId());
                pstmtSoftSkills.setString(2, softSkill.getName());
                pstmtSoftSkills.setInt(3, softSkill.getLevel());
                pstmtSoftSkills.executeUpdate();
            }

            success = true;
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("An error occurred while updating user. Please try again later." + e.getMessage());
        }
        return success;
    }

    public boolean updateUser(userInfo user) {
        boolean success = false;
        try {
            // Update user information in the userinfo table
            String queryUserInfo = "UPDATE userinfo SET mobile=?, occupation=?, address=?, higher_Study=?, twitter=?, insta=?, facebook=?, github=?, other_site=?, Linkedin=? WHERE UF_id=?";
            PreparedStatement pstmtUserInfo = conn.prepareStatement(queryUserInfo);
            pstmtUserInfo.setLong(1, user.getMobile());
            pstmtUserInfo.setString(2, user.getOccupation());
            pstmtUserInfo.setString(3, user.getAddress());
            pstmtUserInfo.setString(4, user.getHigherStudy());
            pstmtUserInfo.setString(5, user.getTwitter());
            pstmtUserInfo.setString(6, user.getInsta());
            pstmtUserInfo.setString(7, user.getFacebook());
            pstmtUserInfo.setString(8, user.getGithub());
            pstmtUserInfo.setString(9, user.getOther_site());
            pstmtUserInfo.setString(10, user.getLinkedin());
            pstmtUserInfo.setInt(11, user.getId());
            pstmtUserInfo.executeUpdate();

            // Delete existing technical skills for the user
            String deleteTechSkillsQuery = "DELETE FROM techSkills WHERE user_id=?";
            PreparedStatement pstmtDeleteTechSkills = conn.prepareStatement(deleteTechSkillsQuery);
            pstmtDeleteTechSkills.setInt(1, user.getId());
            pstmtDeleteTechSkills.executeUpdate();

            // Insert updated technical skills and levels into the techSkills table
            String queryTechSkills = "INSERT INTO techSkills (user_id, tech_skill, tech_skill_level) VALUES (?, ?, ?)";
            PreparedStatement pstmtTechSkills = conn.prepareStatement(queryTechSkills);
            for (TechnicalSkill techSkill : user.getTechSkills()) {
                pstmtTechSkills.setInt(1, user.getId());
                pstmtTechSkills.setString(2, techSkill.getName());
                pstmtTechSkills.setInt(3, techSkill.getLevel());
                pstmtTechSkills.executeUpdate();
            }

            // Delete existing soft skills for the user
            String deleteSoftSkillsQuery = "DELETE FROM softSkills WHERE user_id=?";
            PreparedStatement pstmtDeleteSoftSkills = conn.prepareStatement(deleteSoftSkillsQuery);
            pstmtDeleteSoftSkills.setInt(1, user.getId());
            pstmtDeleteSoftSkills.executeUpdate();

            // Insert updated soft skills and levels into the softSkills table
            String querySoftSkills = "INSERT INTO softSkills (user_id, soft_skill, soft_skill_level) VALUES (?, ?, ?)";
            PreparedStatement pstmtSoftSkills = conn.prepareStatement(querySoftSkills);
            for (SoftSkill softSkill : user.getSoftSkills()) {
                pstmtSoftSkills.setInt(1, user.getId());
                pstmtSoftSkills.setString(2, softSkill.getName());
                pstmtSoftSkills.setInt(3, softSkill.getLevel());
                pstmtSoftSkills.executeUpdate();
            }

            success = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    public userInfo getUserInfoByUFid(int User_id) {
        userInfo user = null;
        try {
            // Query to retrieve user information from the userinfo table
            String queryUserInfo = "SELECT * FROM userinfo WHERE UF_id=?";
            PreparedStatement pstmtUserInfo = conn.prepareStatement(queryUserInfo);
            pstmtUserInfo.setInt(1, User_id);
            ResultSet rsUserInfo = pstmtUserInfo.executeQuery();

            // If user information exists, populate the userInfo object
            if (rsUserInfo.next()) {
                user = new userInfo();
                user.setId(rsUserInfo.getInt("UF_id"));
                user.setMobile(rsUserInfo.getLong("mobile"));
                user.setOccupation(rsUserInfo.getString("occupation"));
                user.setAddress(rsUserInfo.getString("address"));
                user.setHigherStudy(rsUserInfo.getString("higher_Study"));
                user.setTwitter(rsUserInfo.getString("twitter"));
                user.setInsta(rsUserInfo.getString("insta"));
                user.setFacebook(rsUserInfo.getString("facebook"));
                user.setGithub(rsUserInfo.getString("github"));
                user.setOther_site(rsUserInfo.getString("other_site"));
                user.setLinkedin(rsUserInfo.getString("Linkedin"));

                List<TechnicalSkill> techSkills = getTechnicalSkills(User_id);
                user.setTechSkills(techSkills);

                // Retrieve soft skills of the user
                List<SoftSkill> softSkills = getSoftSkills(User_id);
                user.setSoftSkills(softSkills);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean isNewUser(userInfo user) {
        boolean isNew = false;
        try {
            String query = "SELECT UF_id FROM userinfo WHERE UF_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, user.getId());
            ResultSet rs = pstmt.executeQuery();
            isNew = !rs.next(); // If rs.next() returns false, it means the user ID does not exist in the database
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isNew;
    }

    public List<TechnicalSkill> getTechnicalSkills(int user_id) {
        List<TechnicalSkill> techSkills = new ArrayList<>();
        try {
            String queryTechSkills = "SELECT * FROM techskills WHERE user_id = ?";
            PreparedStatement pstmtTechSkills = conn.prepareStatement(queryTechSkills);
            pstmtTechSkills.setInt(1, user_id);
            ResultSet rsTechSkills = pstmtTechSkills.executeQuery();
            while (rsTechSkills.next()) {
                String skillName = rsTechSkills.getString("tech_skill"); // Retrieve skill name
                int skillLevel = rsTechSkills.getInt("tech_skill_level"); // Retrieve skill level
                TechnicalSkill techSkill = new TechnicalSkill(skillName, skillLevel);
                techSkills.add(techSkill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return techSkills;
    }

    public List<SoftSkill> getSoftSkills(int user_id) {
        List<SoftSkill> softSkills = new ArrayList<>();
        try {
            String querySoftSkills = "SELECT * FROM softskills WHERE user_id = ?";
            PreparedStatement pstmtSoftSkills = conn.prepareStatement(querySoftSkills);
            pstmtSoftSkills.setInt(1, user_id);
            ResultSet rsSoftSkills = pstmtSoftSkills.executeQuery();
            while (rsSoftSkills.next()) {
                String skillName = rsSoftSkills.getString("soft_skill"); // Retrieve skill name
                int skillLevel = rsSoftSkills.getInt("soft_skill_level"); // Retrieve skill level
                SoftSkill softSkill = new SoftSkill(skillName, skillLevel);
                softSkills.add(softSkill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return softSkills;
    }

}
