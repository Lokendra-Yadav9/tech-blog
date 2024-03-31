package com.tech.blog.servlets;

import com.tech.blog.dao.categoryDao;
import com.tech.blog.entity.category;
import com.tech.blog.helper.conn;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddCategoryServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String categoryName = request.getParameter("otherCategory");
            String categoryDescription = request.getParameter("otherCategoryDescp");

            category cate = new category();
            cate.setName(categoryName);
            cate.setDescription(categoryDescription);

            // Assuming you have a method to save the category in your DAO
            categoryDao cateDao = new categoryDao(conn.getConnection()); // Initialize your DAO class

            boolean categorySaved = cateDao.saveCategory(cate);

            if (categorySaved) {
                // Get the ID of the newly inserted category
                int lastCategoryId = cateDao.getLastCategoryId();
                int newCategoryId = lastCategoryId + 1;

                // Return the ID of the newly inserted category as the response
                response.setContentType("text/plain");
                response.getWriter().write(String.valueOf(newCategoryId));
            } else {
                // Handle failure to save category
                response.setContentType("text/plain");
                response.getWriter().write("failure");
            }
        } catch (Exception e) {
            // Handle other exceptions
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request.");
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
    }

}
