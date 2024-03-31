
package com.tech.blog.servlets;

import com.tech.blog.dao.postDao;
import com.tech.blog.helper.conn;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class deletePostServlet extends HttpServlet {

  
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
           int postId = Integer.parseInt(request.getParameter("postId"));
        
        // Create an instance of PostDao
        postDao pD =new postDao(conn.getConnection());// Assuming you have a constructor
        
        // Call the method to delete the post by its ID
        boolean success = pD.deletePostByPostId(postId);
        
        // Set response content type
        response.setContentType("text/plain");
        
        // Send response back to the client
        if (success) {
            response.getWriter().write("Post deleted successfully");
        } else {
            response.getWriter().write("Failed to delete post");
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
