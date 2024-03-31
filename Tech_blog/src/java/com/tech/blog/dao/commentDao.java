
package com.tech.blog.dao;
import java.sql.*;
import java.util.ArrayList;
import com.tech.blog.entity.Comment;

public class commentDao {
  private   Connection con;

    public commentDao(Connection con) {
        this.con = con;
    }

    public Connection getCon() {
        return con;
    }

    public void setCon(Connection con) {
        this.con = con;
    }
  
    
    public boolean insertComment(int uid, int pid, String commentText) {
    boolean inserted = false;
    PreparedStatement stmt = null;
    
    try {
        String query = "INSERT INTO comments (user_id, post_id, comment_text) VALUES (?, ?, ?)";
        stmt = con.prepareStatement(query);
        stmt.setInt(1, uid);
        stmt.setInt(2, pid);
        stmt.setString(3, commentText);
        int rowsAffected = stmt.executeUpdate();
        inserted = (rowsAffected > 0);
    } catch (SQLException e) {
        // Log the error or handle it appropriately
        e.printStackTrace();
    } finally {
        // Close the PreparedStatement in a finally block to ensure it always gets closed
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                // Log the error or handle it appropriately
                e.printStackTrace();
            }
        }
    }
    return inserted;
}

    
    
    public boolean deleteComment(int commentId) {
        boolean deleted = false;

        try {          
            String query = "DELETE FROM comments WHERE comment_id = ?";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setInt(1, commentId);

            int rowsAffected = stmt.executeUpdate();
            deleted = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        } 
        
        return deleted;
    }
    
    
    
    
    
    public ArrayList<Comment> getAllCommentsByPostId(int postId) {
    ArrayList<Comment> comments = new ArrayList<>();
    try {
//        String query = "SELECT * FROM comments WHERE post_id = ?";
        String query = "SELECT * FROM comments WHERE post_id = ? ORDER BY created_at DESC";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, postId);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            int commentId = rs.getInt("comment_id");
            int userId = rs.getInt("user_id");
            String commentText = rs.getString("comment_text");
            Timestamp timestamp = rs.getTimestamp("created_at");

            // Create a new Comment object
            Comment comment = new Comment(commentId, userId, postId, commentText, timestamp);
            comments.add(comment);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return comments;
}

    
    public int getAllComments (int postId){
        int count =0;
        try {
            String query="select count(*) from comments where post_id=?";
            PreparedStatement psmt=con.prepareStatement(query);
            psmt.setInt(1, postId);
            ResultSet rs=psmt.executeQuery();
               if (rs.next()) {
                count = rs.getInt(1);
            }
            // Close ResultSet, PreparedStatement, and Connection
            rs.close();
          
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return count;
    }
    
    
}
