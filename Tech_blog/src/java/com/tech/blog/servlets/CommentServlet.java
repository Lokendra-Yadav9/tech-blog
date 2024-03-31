package com.tech.blog.servlets;

import com.tech.blog.dao.commentDao;
import com.tech.blog.helper.conn;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                // Get parameters from the request
                int uid = Integer.parseInt(request.getParameter("uid"));
                int pid = Integer.parseInt(request.getParameter("pid"));
                String commentText = request.getParameter("commentText");

                // Insert the comment into the database
                commentDao dao = new commentDao(conn.getConnection());
                boolean success = dao.insertComment(uid, pid, commentText);

                if (success) {
                    // Comment inserted successfully
                    out.println("{\"status\": \"success\", \"message\": \"Comment inserted successfully\"}");
                } else {
                    // Failed to insert comment
                    out.println("{\"status\": \"error\", \"message\": \"Failed to insert comment\"}");
                }

            } catch (Exception e) {
                // Handle other exceptions
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.println("{\"status\": \"error\", \"message\": \"An error occurred: " + e.getMessage() + "\"}");
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
        return "CommentServlet";
    }

}
