
package com.tech.blog.servlets;

import com.tech.blog.dao.Userdao;
import com.tech.blog.entity.message;
import com.tech.blog.entity.user;
import com.tech.blog.helper.conn;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class loginServlet extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet loginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
           
            String user_email=request.getParameter("email");
            String user_password=request.getParameter("password");
            
            Userdao users=new Userdao(conn.getConnection());
            
            user u=users.getuser_by_email_and_password(user_email, user_password);
            
            if(u==null){
                message msg=new message("invalid details! try again..","error","alert-danger");
                HttpSession s=request.getSession();
                s.setAttribute("msg", msg);
                
                response.sendRedirect("login_page.jsp");
            }else{
                HttpSession s=request.getSession();
                s.setAttribute("current_user", u);
                response.sendRedirect("profile.jsp");
            }
            
            out.println("</body>");
            out.println("</html>");
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
