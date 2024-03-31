package com.tech.blog.servlets;

import com.tech.blog.dao.followDao;
import com.tech.blog.helper.conn;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class followServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String followerIdString = request.getParameter("followerId");
            String followedIdString = request.getParameter("followedId");
            String action = request.getParameter("action");

            if (followerIdString != null && followedIdString != null && action != null) {
                int followerId = Integer.parseInt(followerIdString);
                int followedId = Integer.parseInt(followedIdString);

                followDao folDao = new followDao(conn.getConnection());

                try {
                    if (action.equals("follow")) {
                        if (folDao.saveFollow(followerId, followedId)) {
                            out.print("save follow");
                            response.getWriter().write("Follow action saved successfully");
                        } else {
                            response.getWriter().write("Failed to save follow action");
                        }
                    } else if (action.equals("unfollow")) {
                        if (folDao.unfollow(followerId, followedId)) {
                            out.print("delete, unfollow");
                            response.getWriter().write("Unfollow action saved successfully");
                        } else {
                            response.getWriter().write("Failed to save unfollow action");
                        }
                    } else {
                        response.getWriter().write("Invalid action");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write("Error: " + e.getMessage());
                }
            } else {
                response.getWriter().write("Missing parameters");
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
