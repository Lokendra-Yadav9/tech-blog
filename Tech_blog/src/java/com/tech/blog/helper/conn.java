
package com.tech.blog.helper;
import java.sql.*;
public class conn {
    private  static Connection con;
    public static Connection getConnection()
    {
        try{
            
            if(con==null){
            //driver  class load
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            //create connection
            con=DriverManager.getConnection("jdbc:mysql://localhost:3306/techBlog", "root", "Lokendra12");   
            }
            
        }catch(Exception e){
          e.printStackTrace();
        }
        
        return con;
    }
}
