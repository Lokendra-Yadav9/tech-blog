package com.tech.blog.dao;

import java.sql.*;

public class likeDao {

    Connection con;

    public likeDao(Connection con) {
        this.con = con;
    }

    public boolean insertLike(int uid, int pid) {
        boolean f = false;

        try {
            String query = "INSERT INTO liking (pid, uid) VALUES (?, ?)";
            PreparedStatement psmt = this.con.prepareStatement(query);
            psmt.setInt(1, pid);
            psmt.setInt(2, uid);
            psmt.executeUpdate();
            f = true;

            psmt.close();
        } catch (SQLException e) {
            e.printStackTrace();

        }
        return f;
    }

    public int countLikesOnPost(int pid) {
        int count = 0;
        PreparedStatement psmt = null;

        try {
            String query = "SELECT COUNT(*) AS like_count FROM liking WHERE pid=?";
            psmt = this.con.prepareStatement(query);
            psmt.setInt(1, pid);
            ResultSet set = psmt.executeQuery();
            if (set.next()) {
                count = set.getInt("like_count");
            }
            // Close the ResultSet
            set.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception appropriately (e.g., logging, error message)
        } finally {
            // Close the PreparedStatement in the finally block
            if (psmt != null) {
                try {
                    psmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return count;
    }

    public boolean isLikedByUser(int uid, int pid) {
        boolean isLiked = false;
        try {
            String query = "SELECT COUNT(*) FROM liking WHERE uid = ? AND pid = ?";
            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setInt(1, uid);
            psmt.setInt(2, pid);
            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                isLiked = (count > 0);
            }
            rs.close();
            psmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isLiked;
    }

    public boolean deleteLikedPost(int uid, int pid) {
        boolean f = false;
        try {
            String query = "delete from liking where pid=? and uid=?";
            PreparedStatement psmt = this.con.prepareStatement(query);
            psmt.setInt(1, pid);
            psmt.setInt(2, uid);
            psmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

}
