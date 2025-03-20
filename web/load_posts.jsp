

<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikedDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<div class="row">
<%
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    int cid=Integer.parseInt(request.getParameter("cid"));
    List<Post> posts=null;
    
    if(cid==0)
    {
      posts=d.getAllPosts();
    }
    else
    {
       posts=d.getPostByCatId(cid);
    }
    if(posts.isEmpty())
    {
   %>
    <div class="card text-center">
        <img class="card-img-top" src="blog_pics/No_post.png" alt="Card image cap">
        <p> No Posts in this Category..</p>
    </div>


        
   <%     
    }
       
    for(Post p:posts)
    {
%>
<div class="col-md-6 mt-2">
    <div class="card">
        <img class="card-img-top" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
        <div class="card-body">
              <b> <%=p.getpTitle()%> </b>
              <p> <%=p.getpContent()%> </p>
        </div>   
         <div class="card-footer primary-background text-center">
           <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light btn-sm">Read More</a> 
         </div>
    </div>
</div>
<%
    }
%>
</div>















