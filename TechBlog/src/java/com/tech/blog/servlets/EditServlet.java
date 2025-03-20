/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author princ
 */
@MultipartConfig
public class EditServlet  extends HttpServlet{
    
     @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          
         resp.setContentType("text/html");
         PrintWriter out=resp.getWriter();
         
         String userEmail= req.getParameter("user_email");
         String userName= req.getParameter("user_name");
         String userPassword= req.getParameter("user_password");
         String userAbout= req.getParameter("user_about");
         Part part=req.getPart("user_image");
         String imageName=part.getSubmittedFileName();
        
         
         HttpSession s=req.getSession();
         User user=(User)s.getAttribute("currentUser");
         
         user.setEmail(userEmail);
         user.setName(userName);
         user.setPassword(userPassword);
         user.setAbout(userAbout);
         String oldProfile=user.getProfile();
         user.setProfile(imageName);
   
         
         UserDao userDao=new UserDao(ConnectionProvider.getConnection());
         
         boolean ans = userDao.updateUser(user);
         
         if(ans)
         {
//             out.println("updated to DB");
             
             String oldProfilePath=req.getRealPath("/")+"pics"+File.separator+oldProfile;
             String path=req.getRealPath("/")+"pics"+File.separator+user.getProfile();
             
             if(oldProfile!="default.png")
             {
                 Helper.deleteFile(oldProfilePath);
             }
                 if(Helper.saveFile(part.getInputStream(), path))
                 {
                     // out.println("Profile Updated");
                       Message msg=new Message("Profile details Updated","success","alert-success");
         
                       s.setAttribute("msg",msg);
                 }
             
             
             
             
             
         }
         else
         {
           //  out.println("not updated");
              Message msg=new Message("Somthing went wrong","eror","alert-danger");
         
              s.setAttribute("msg",msg);
         }
         
          resp.sendRedirect("profile.jsp");
    }
}
