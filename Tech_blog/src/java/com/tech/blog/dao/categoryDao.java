
package com.tech.blog.dao;
import com.tech.blog.entity.category;
import java.sql.*;

public class categoryDao {
    Connection con;

    public categoryDao(Connection con) {
        this.con = con;
    }
    
    
    public boolean saveCategory(category cate) {
        try {
            String query = "INSERT INTO categories (name, description) VALUES (?, ?)";

            PreparedStatement psmt = con.prepareStatement(query);
            psmt.setString(1, cate.getName());
            psmt.setString(2, cate.getDescription());

            int rowsAffected = psmt.executeUpdate();

            // Check if the insertion was successful
            if (rowsAffected > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
   
    
    public int getLastCategoryId() {
        int lastCategoryId = 0;
        String query = "SELECT MAX(cid) AS last_cid FROM categories";

        try (Statement statement = con.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            if (resultSet.next()) {
                lastCategoryId = resultSet.getInt("last_cid");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lastCategoryId;
    }
    
}
