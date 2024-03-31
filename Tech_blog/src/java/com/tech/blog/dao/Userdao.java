package com.tech.blog.dao;

import com.tech.blog.entity.user;
import com.tech.blog.helper.conn;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServlet;

public class Userdao extends HttpServlet {

    private Connection con;

    public Userdao(Connection con) {
        this.con = con;
    }

    public boolean Saveuser(user users) {
        boolean f = false;
        try {
            String query = "INSERT INTO user (name, email, password, about, gender) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psmt = this.con.prepareStatement(query);
            psmt.setString(1, users.getName());
            psmt.setString(2, users.getEmail());
            psmt.setString(3, users.getPassword());
            psmt.setString(4, users.getAbout());
            psmt.setString(5, users.getGender());

            psmt.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public user getuser_by_email_and_password(String email, String password) {
        user user_tech = null;
        String query = "select * from user where email=? and password=?";
        try {
            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setString(1, email);
            psmt.setString(2, password);

            ResultSet set = psmt.executeQuery();

            if (set.next()) {
                user_tech = new user();

                String name = set.getString("name");
                user_tech.setName(name);
//                String email=set.getString("email");
                user_tech.setEmail(email);
                user_tech.setId(set.getInt("id"));
                user_tech.setPassword(password);
                user_tech.setGender(set.getString("gender"));
                String about = set.getString("about");
                user_tech.setAbout(about);
                user_tech.setProfile_pic(set.getString("user_profile"));
                user_tech.setDatesTime(set.getTimestamp("registration_date"));

            } else {

            }

        } catch (SQLException ex) {
            Logger.getLogger(Userdao.class.getName()).log(Level.SEVERE, null, ex);
        }

        return user_tech;
    }

    public boolean updateUser_details(user users) {
        boolean f = false;

        try {

            String query = "UPDATE user SET name=?, email=?, password=?, about=?, user_profile=?, gender=? WHERE id=?";
            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setString(1, users.getName());
            psmt.setString(2, users.getEmail());
            psmt.setString(3, users.getPassword());
            psmt.setString(4, users.getAbout());

            psmt.setString(5, users.getProfile_pic());
            psmt.setString(6, users.getGender());
            psmt.setInt(7, users.getId());

            psmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
    
    
    

    public String getProfilePicUrl(int userId) {
        String profilePicUrl = null;
        try {
            String query = "SELECT user_profile FROM user WHERE id = ?";
            PreparedStatement statement = con.prepareStatement(query);
            statement.setInt(1, userId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                profilePicUrl = resultSet.getString("user_profile");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return profilePicUrl;
    }

    
    
    public String getUserName(int userId) {
    String userName = null;
    try {
        String query = "SELECT name FROM user WHERE id = ?";
        PreparedStatement statement = con.prepareStatement(query);
        statement.setInt(1, userId);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            userName = resultSet.getString("name");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return userName;
}
    public int getUserIdByEmail(String Email) {
    int userid = 0;
    try {
        String query = "SELECT id FROM user WHERE email = ?";
        PreparedStatement statement = con.prepareStatement(query);
        statement.setString(1, Email);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            userid = resultSet.getInt("id");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return userid;
}
    
    
    
    public String getGenderByUserId(int userId) {
    String userName = null;
    try {
        String query = "SELECT gender FROM user WHERE id = ?";
        PreparedStatement statement = con.prepareStatement(query);
        statement.setInt(1, userId);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            userName = resultSet.getString("gender");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return userName;
}

    
    public user getuserbyId(int UserId){
        user usersPosted=null;
        try {
            PreparedStatement psmt=this.con.prepareStatement("select * from user where id=?");
             psmt.setInt(1, UserId);
            ResultSet rs= psmt.executeQuery();
            while(rs.next()){
                usersPosted=new user();
                usersPosted.setId(UserId);
                usersPosted.setName(rs.getString("name"));
                usersPosted.setEmail(rs.getString("email"));
                usersPosted.setAbout(rs.getString("about"));
                usersPosted.setGender(rs.getString("gender"));
                usersPosted.setProfile_pic(rs.getString("user_profile"));
                usersPosted.setDatesTime(rs.getTimestamp("registration_date"));                
            }   

        } catch (Exception e) {
            e.printStackTrace();
        }       
        return usersPosted;
    }
    
    
    
     public List<user> searchUsersByName(String name) {
        List<user> users = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
           
            String query = "SELECT * FROM user WHERE name LIKE ?";
            statement=con.prepareStatement(query);
            statement.setString(1, "%" + name + "%");
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                // Retrieve user data from the result set and create User objects
                user users_name = new user();
                users_name.setId(resultSet.getInt("id"));
                users_name.setName(resultSet.getString("name"));
                // Populate other user attributes as needed
                // Add the user to the list
                users.add(users_name);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception or log it
        } finally {
            // Close JDBC objects in reverse order of their creation to avoid resource leaks
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
                // Handle the exception or log it
            }
        }

        return users;
    }
}
