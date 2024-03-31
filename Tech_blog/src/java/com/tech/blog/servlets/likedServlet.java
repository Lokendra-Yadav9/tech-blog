package com.tech.blog.servlets;

import com.tech.blog.dao.likeDao;
import com.tech.blog.helper.conn;
import java.io.IOException;
import org.json.JSONObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class likedServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        try {
            String operation = request.getParameter("operation");
            int uid = Integer.parseInt(request.getParameter("uid"));
            int pid = Integer.parseInt(request.getParameter("pid"));

            likeDao dao = new likeDao(conn.getConnection());

            if ("toggleLike".equals(operation)) {
                boolean isLiked = dao.isLikedByUser(uid, pid);
                if (isLiked) {
                    dao.deleteLikedPost(uid, pid);
                    sendResponse(response, HttpServletResponse.SC_OK, "undone");
                } else {
                    dao.insertLike(uid, pid);
                    sendResponse(response, HttpServletResponse.SC_OK, "done");
                }
            } else {
                sendResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid operation");
            }
        } catch (NumberFormatException e) {
            sendResponse(response, HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
        } catch (Exception e) {
            e.printStackTrace();
            sendResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred");
        }
    }

// Method to send JSON response
    private void sendResponse(HttpServletResponse response, int statusCode, String message) throws IOException {
        JSONObject jsonResponse = new JSONObject();
        jsonResponse.put("status", statusCode);
        jsonResponse.put("message", message);
        response.setStatus(statusCode);
        response.getWriter().write(jsonResponse.toString());
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
    }

}
