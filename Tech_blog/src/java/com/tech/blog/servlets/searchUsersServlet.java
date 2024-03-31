package com.tech.blog.servlets;

import com.google.gson.Gson;
import com.tech.blog.dao.Userdao;
import com.tech.blog.entity.user;
import com.tech.blog.helper.conn;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class searchUsersServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("name");
            Userdao ud = new Userdao(conn.getConnection());
            List<user> users = ud.searchUsersByName(name);

            // Convert the list of users to JSON
            Gson gson = new Gson();
            String json = gson.toJson(users);
            out.println(json); // Write JSON response to the PrintWriter
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Set HTTP status code to indicate an error
            out.print("{\"error\": \"" + e.getMessage() + "\"}"); // Return error message in JSON format
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
