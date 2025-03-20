
package com.tech.blog.servlets;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
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

@MultipartConfig
public class AddPostServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
         response.setContentType("text/html");
         PrintWriter out=response.getWriter();
           
            int cid=Integer.parseInt(request.getParameter("cid"));
            String pTitle=request.getParameter("pTitle");
            String pContent=request.getParameter("pContent");
            String pCode=request.getParameter("pCode");
            Part part=request.getPart("pPic");
            
            HttpSession session=request.getSession();
            User user=(User)session.getAttribute("currentUser");
            
            int userId=user.getId();
            
            Post p=new Post( pTitle,pContent,pCode,part.getSubmittedFileName(),null,cid,userId );
            
            PostDao dao=new PostDao(ConnectionProvider.getConnection());
            
            if(dao.savePost(p))
            {
               
                String path=request.getRealPath("/")+"blog_pics"+File.separator+part.getSubmittedFileName();
                Helper.saveFile(part.getInputStream(), path);
                 out.println("done");
                // out.println(path);
            }
            else
            {
                out.println("error");
            }    
            
        
    }

}