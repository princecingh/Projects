
package com.tech.blog.servlets;

import com.tech.blog.dao.LikedDao;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author princ
 */
public class LikeServlet extends HttpServlet {
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
    {
         response.setContentType("text/html");
         PrintWriter out=response.getWriter();
           
           String operation=request.getParameter("operation");
            int pid=Integer.parseInt(request.getParameter("pid"));
            int uid=Integer.parseInt(request.getParameter("uid"));
            
            LikedDao ldao=new LikedDao(ConnectionProvider.getConnection());
            boolean prevLikedOrNot=ldao.isLikedByUser(pid, uid);
            if(prevLikedOrNot == true)
            { 
                out.println(prevLikedOrNot);
                operation="dislike";
                
            }
             
            if("like".equals(operation))
            {
               boolean f= ldao.insertLike(pid, uid);
               if(f==true)
               {
                  out.println("okl");
               }
            }
            else
            {
                boolean f= ldao.deleteLike(pid, uid);
               if(f==true)
               {
                  out.println("disliked");
               }
            }
            
            
        
    }
}