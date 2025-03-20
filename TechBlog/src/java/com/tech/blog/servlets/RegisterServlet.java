
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class RegisterServlet extends HttpServlet
{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
          
         resp.setContentType("text/html");
         PrintWriter out=resp.getWriter();
         
         // fectch all form data;
          
         String check=req.getParameter("user_check");
         
         if(check==null)
         {
              out.println("Box not checked");
         }
         else
         {
            // when check i.e agree term and condition is checked get all the other details;
            String name=req.getParameter("user_name");
            String email=req.getParameter("user_email");
            String password=req.getParameter("user_password");
            String about=req.getParameter("user_about");
            String gender=req.getParameter("user_gender");
            
                //out.println();
            // create user object and set all data to that object;
            User user=new User(name,email,password,about,gender);
            
            //create a userDao object;
            
            UserDao dao=new UserDao(ConnectionProvider.getConnection());
            
            if(dao.saveUser(user))
            {
                //returns true if its successful
                
                out.println("Done");
            }
            else
            {
                out.println("error..");
            }
            
             
         }
        
        
        
    }
    
}
