/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.tech.blog.servlets;

import com.tech.blog.dao.categoryDao;
import com.tech.blog.dao.postDao;
import com.tech.blog.entity.category;
import com.tech.blog.entity.post;
import com.tech.blog.entity.user;
import com.tech.blog.helper.conn;
import com.tech.blog.helper.helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

    @SuppressWarnings("empty-statement")
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

//            int cid=Integer.parseInt(request.getParameter("categoryName"));
//            String pTitle = request.getParameter("pfTitle");
//            String pContent = request.getParameter("pfContent");
//            String pCode = request.getParameter("pfCode");
//            Part part = request.getPart("pfImg");
//            String imgName = (part != null && !"".equals(part.getSubmittedFileName())) ? part.getSubmittedFileName() : "BlogImage.jpg";
//
//            HttpSession session = request.getSession();
//            user currentUser = (user) session.getAttribute("current_user");
//
//            int userId = currentUser.getId();
//
//         
//            post p = new post(pTitle, pContent, pCode, imgName, null, cid, userId);
//
//            postDao pDao = new postDao(conn.getConnection());
//            if (pDao.savePost(p)) {
//                String path = request.getRealPath("/") + "Blog_images" + File.separator + imgName;
//                boolean Save_newImage = helper.Save_newImage(part.getInputStream(), path);
//                if(Save_newImage){
//                out.println("image savesuccessfully");
//                }
//                out.println("done");
//            } else {
//                out.println("found error in save data");
//            }
            int cid = Integer.parseInt(request.getParameter("categoryName"));
            String pTitle = request.getParameter("pfTitle");
            String pContent = request.getParameter("pfContent");
            String pCode = request.getParameter("pfCode");

// Check if the image URL is provided
            String imgUrl = request.getParameter("pfImgURL");
            Part part = request.getPart("pfImg");
            String imgName = null;

            if (part != null && part.getSize() > 0) {
                imgName = part.getSubmittedFileName();
            } else if (imgUrl != null && !imgUrl.isEmpty()) {
                // Extract the image name from the URL (optional, depending on your requirement)
                int index = imgUrl.lastIndexOf('/');
                if (index != -1) {
                    imgName = imgUrl.substring(index + 1);
                }
            }

            HttpSession session = request.getSession();
            user currentUser = (user) session.getAttribute("current_user");

            int userId = currentUser.getId();

// Create the post object with appropriate image URL and name
            String imageUrl = null;
            String pPic = null;

            if (imgUrl != null && !imgUrl.isEmpty()) {
                imageUrl = imgUrl;
            } else if (part != null && part.getSize() > 0) {
                pPic = imgName; // Use the submitted file name as pPic
            }

            if (pPic == null) {
                pPic = "null"; // Set to the string "NULL"
            }

            post p = new post(pTitle, pContent, pCode, pPic, imageUrl, null, cid, userId);

            postDao pDao = new postDao(conn.getConnection());
            if (pDao.savePost(p)) {
                if (part != null && part.getSize() > 0) {
                    // If file is uploaded, save it to "Blog_images" folder
                    String path = request.getRealPath("/") + "Blog_images" + File.separator + imgName;
                    boolean saveImageResult = helper.Save_newImage(part.getInputStream(), path);
                    if (saveImageResult) {
                        out.println("Image saved successfully");
                    } else {
                        out.println("Failed to save image");
                    }
                }
                out.println("Post saved successfully");
            } else {
                out.println("Found error in saving data");
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
