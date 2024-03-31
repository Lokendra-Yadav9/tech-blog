package com.tech.blog.dao;

import com.tech.blog.entity.category;
import com.tech.blog.entity.post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class postDao {

    private final Connection con;

    public postDao(Connection con) {
        this.con = con;
    }

    public ArrayList<category> getAllCategories() {
        ArrayList<category> list = new ArrayList<>();
        try {
            String query = "select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set = st.executeQuery(query);

            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");

                category c = new category(cid, name, description);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean savePost(post p) {
        boolean f = false;
        try {
            String query = "INSERT INTO posts (pTitle, pContent, pCode, catid, pPic,imageUrl, userId) VALUES (?,?,?,?,?,?,?)";

            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setString(1, p.getpTitle());
            psmt.setString(2, p.getpContent());
            psmt.setString(3, p.getpCode());
            psmt.setInt(4, p.getCatid());
            psmt.setString(5, p.getpPic());
            psmt.setString(6, p.getImageUrl());
            psmt.setInt(7, p.getUserId());

            psmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<post> getAllPosts() {
        List<post> Allpost = new ArrayList<>();
        try {
            String query = "SELECT * FROM posts ORDER BY pDate DESC";
            PreparedStatement psmt = con.prepareStatement(query);
            ResultSet set = psmt.executeQuery();
            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                Timestamp pDate = set.getTimestamp("pDate");
                String pPic = set.getString("pPic"); 
                String imageUrl = set.getString("imageUrl"); 
                int catid = set.getInt("catid");
                int userId = set.getInt("userId");

                post p = new post(pid, pTitle, pContent, pCode, pPic,imageUrl, pDate, catid, userId);
                Allpost.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Allpost;
    }

    
    

    public List<post> getPostByCatId(int catId) {
        List<post> catePost = new ArrayList<>();

        try {
            String query = "select * from posts where catid=?";
            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setInt(1, catId);
            ResultSet set = psmt.executeQuery();
            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                Timestamp pDate = set.getTimestamp("pDate");
                String pPic = set.getString("pPic"); 
                String imageUrl = set.getString("imageUrl"); 
                int catid = set.getInt("catid");
                int userId = set.getInt("userId");

                post p = new post(pid, pTitle, pContent, pCode, pPic,imageUrl, pDate, catid, userId);
                catePost.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return catePost;
    }
    
    
    
    
    
    
    public List<post> getPostByuserId(int userId,int post_id) {
        List<post> catePost = new ArrayList<>();

        try {
            String query = "select * from posts where userId=? and pid=?";
            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setInt(1, userId);
            psmt.setInt(2, post_id);
            ResultSet set = psmt.executeQuery();
            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                Timestamp pDate = set.getTimestamp("pDate");
                String pPic = set.getString("pPic"); 
                String imageUrl = set.getString("imageUrl"); 
                int catid = set.getInt("catid");
//                int userId = set.getInt("userId");

                post p = new post(pid, pTitle, pContent, pCode, pPic,imageUrl, pDate, catid, userId);
                catePost.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return catePost;
    }

    public String GetNameByUserId(int id) {
        String name = null;
        try {
            String Query = "SELECT name FROM user WHERE id = ?";
            PreparedStatement psmt = con.prepareStatement(Query);
            psmt.setInt(1, id);
            ResultSet set = psmt.executeQuery();
            while (set.next()) {
                name = set.getString("name");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return name;
    }

    public String GetCategoryNameByCatId(int id) {
        String category = null;
        try {
            String Query = "SELECT name FROM categories WHERE cid = ?";
            PreparedStatement psmt = con.prepareStatement(Query);
            psmt.setInt(1, id);
            ResultSet set = psmt.executeQuery();
            while (set.next()) {
                category = set.getString("name");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return category;
    }
    
    public post GetFullPostByPid(int postid){
        post sPost=null;
        try{
        String query="select * from posts where pid=?";
        PreparedStatement psmt = con.prepareStatement(query);
            psmt.setInt(1, postid);
            ResultSet set = psmt.executeQuery();
            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                Timestamp pDate = set.getTimestamp("pDate");
                String pPic = set.getString("pPic"); 
                String imageUrl = set.getString("imageUrl"); 
                int catid = set.getInt("catid");
                int userId = set.getInt("userId");

                sPost = new post(pid, pTitle, pContent, pCode, pPic,imageUrl, pDate, catid, userId);
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        
        return sPost;
    }

    
    
    
    
//    for the user Info page
    
    public List<post> getAllPostsUserId(int userid) {
        List<post> Allpost = new ArrayList<>();
        try {
            String query = "SELECT * FROM posts where userId=? ORDER BY pDate DESC";
            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setInt(1, userid);
            ResultSet set = psmt.executeQuery();
            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                Timestamp pDate = set.getTimestamp("pDate");
                String pPic = set.getString("pPic"); 
                String imageUrl = set.getString("imageUrl"); 
                int catid = set.getInt("catid");

                post p = new post(pid, pTitle, pContent, pCode, pPic,imageUrl, pDate, catid, userid);
                Allpost.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Allpost;
    }
    
    
     public List<post> getPostByCatIdOrUserId(int catId,int userId) {
        List<post> catePost = new ArrayList<>();

        try {
            String query = "select * from posts where catid=? and userId=?";
            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setInt(1, catId);
            psmt.setInt(2, userId);
            ResultSet set = psmt.executeQuery();
            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                Timestamp pDate = set.getTimestamp("pDate");
                String pPic = set.getString("pPic"); 
                String imageUrl = set.getString("imageUrl"); 
                int catid = set.getInt("catid");

                post p = new post(pid, pTitle, pContent, pCode, pPic,imageUrl, pDate, catid, userId);
                System.out.println(userId);
                System.out.println(userId);
                catePost.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return catePost;
    }
    
    
     
       public int getAllPostsCountUserId(int userid) {
        int Allpost = 0;
        try {
            String query = "SELECT count(*) FROM posts where userId=?";
            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setInt(1, userid);
            ResultSet set = psmt.executeQuery();
            
            if(set.next()){
                Allpost = set.getInt(1);
            }
            
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Allpost;
    }
       
       public boolean deletePostByPostId(int postId) {
        boolean success = false;
        PreparedStatement stmt = null;

        try {
            // Prepare the SQL statement
            String sql = "DELETE FROM posts WHERE pid = ?";
            stmt = con.prepareStatement(sql);

            // Set the post ID parameter
            stmt.setInt(1, postId);

            // Execute the query
            int rowsAffected = stmt.executeUpdate();

            // Check if any rows were affected
            if (rowsAffected > 0) {
                success = true; // Post deleted successfully
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            if (stmt != null) {
                try {
                    stmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return success;
    }
}
