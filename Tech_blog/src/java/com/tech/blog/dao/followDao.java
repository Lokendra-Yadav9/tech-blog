package com.tech.blog.dao;

import java.sql.*;

public class followDao {

    private Connection conn;

    public followDao(Connection conn) {
        this.conn = conn;
    }

    // Method to save a follower relationship in the database
    public boolean saveFollow(int followerId, int followedId) {
        try {
            // Prepare SQL statement
            String sql = "INSERT INTO follower (follower_id, followed_id) VALUES (?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);

            // Set the parameters
            statement.setInt(1, followerId);
            statement.setInt(2, followedId);

            // Execute the query
            int rowsInserted = statement.executeUpdate();

            // Check if the follower relationship was successfully inserted
            if (rowsInserted > 0) {
                return true; // Success
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false; // Failed to save the follower relationship
    }

    public boolean isFollow(int followerId, int followedId) {
        boolean isfollow = false;
        ResultSet resultSet = null;
        PreparedStatement psmt = null;
        try {
            // Establish database connection

            // Prepare SQL query to check if the follower follows the followed user
            String query = "SELECT * FROM follower WHERE follower_id = ? AND followed_id = ?";
            psmt = conn.prepareStatement(query);
            psmt.setInt(1, followerId);
            psmt.setInt(2, followedId);

            // Execute the query
            resultSet = psmt.executeQuery();

            // If any result found, set isfollow to true
            if (resultSet.next()) {
                isfollow = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC objects in reverse order of their creation to avoid resource leaks
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (psmt != null) {
                    psmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return isfollow;
    }

    public boolean unfollow(int followerId, int followedId) {
        boolean success = false;
        PreparedStatement psmt = null;

        try {

            // Prepare SQL query to delete the follow relationship
            String query = "DELETE FROM follower WHERE follower_id = ? AND followed_id = ?";
            psmt = conn.prepareStatement(query);
            psmt.setInt(1, followerId);
            psmt.setInt(2, followedId);

            // Execute the query
            int rowsAffected = psmt.executeUpdate();

            // Check if any rows were deleted
            if (rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC objects in reverse order of their creation to avoid resource leaks
            try {
                if (psmt != null) {
                    psmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return success;
    }

    public int countFollowers(int userId) {
        int count = 0;
                PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            

            // Prepare SQL query to count followers for the user
            String query = "SELECT COUNT(*) FROM follower WHERE followed_id = ?";
            preparedStatement = conn.prepareStatement(query);
            preparedStatement.setInt(1, userId);

            // Execute the query
            resultSet = preparedStatement.executeQuery();

            // Retrieve the count from the result set
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC objects in reverse order of their creation to avoid resource leaks
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return count;
    }

}
