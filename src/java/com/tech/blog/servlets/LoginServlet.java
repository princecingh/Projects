/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author princ
 */
public class LoginServlet extends HttpServlet{
    
     @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          
         resp.setContentType("text/html");
         PrintWriter out=resp.getWriter();
         //login 
         
         String userEmail=req.getParameter("user_email");
         String userPassword=req.getParameter("user_password");
         
         UserDao dao=new UserDao(ConnectionProvider.getConnection());
         
         User u=dao.getUserByEmailAndPassword(userEmail, userPassword);
         
         if(u==null)
         {
            // login ERROE
            Message msg=new Message("Invalid Details ! try with another","error","alert-danger");
            HttpSession s= req.getSession();
             s.setAttribute("msg",msg);
            
             resp.sendRedirect("login_page.jsp");
         }
         else
         {
             HttpSession s= req.getSession();
             s.setAttribute("currentUser",u);
             
             resp.sendRedirect("profile.jsp");
         }
        
    
    }
}
