
<%@page import="com.tech.blog.dao.LikedDao"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user=(User)session.getAttribute("currentUser");
    if(user==null)
    {
     response.sendRedirect("Login.jsp");
    }
%>
<%
    int postID=Integer.parseInt(request.getParameter("post_id"));
    PostDao d=new PostDao(ConnectionProvider.getConnection());
    Post p=d.getPostByPostId(postID);
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=p.getpTitle()%></title>
        
            
<!--           java script
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>-->
         

        
        <!--css-->
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
          <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
          
           <style>
              .banner-background{
                 clip-path: polygon(34% 0, 70% 0, 100% 0, 100% 93%, 62% 100%, 28% 94%, 0 100%, 0 0);
              }
              .post-title{
                  font-weight: 100;
                  font-size: 30px;
              }
              .post-content{
                  font-weight: 100;
                  font-size: 25px;
              }
              .post-date{
                  font-style: italic;
                  font-weight: bold; 
              }
              .post-user-info{
                  font-size: 20px;
              }
              body{
                  background: url(img/bg2.avif);
                  background-size: cover;
                  background-attachment: fixed;
              }
          </style>
          
      <div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v5.0"></script>
    </head>
    <body>
        
         <!--navBar-->
            <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-mortar-board"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="profile.jsp"><span class="fa fa-grav"></span> Just Blog <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                   <span class="fa fa-check-square"></span> Categories
                  </a>
                  <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">Programming Language</a>
                    <a class="dropdown-item" href="#">Project Implementation</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Data Structure</a>
                  </div>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#"><span class="fa fa-phone"></span> Contact</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-pencil-square-o"></span> Do Post</a>
                </li>
              </ul>
                
                 <ul class="navbar-nav mr-right">
                 <li class="nav-item">
                     
                     <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-model"  ><span class="fa fa-user-circle"></span> <%=user.getName()%></a>
                 </li>
                 <li class="nav-item">
                     
                     <a class="nav-link" href="LogoutServlet" ><span class="fa fa-sign-out"></span> Logout</a>
                 </li>
                </ul>
             
            </div>
          </nav>
          <!--end of navBar-->  
         <!--main ccontent of body-->
         
         <!--end of main content-->
          
         <div class="container">
             <div class="row my-4">
                 <div class="col-md-8 offset-md-2">
                     
                     <div class="card">
                         <div class="card-header primary-background text-center text-white">
                             <h4 class="post-title"><%=p.getpTitle()%></h4>
                         </div>
                         <div class="card-body">
                              <img class="card-img-top" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
                              
                              <div class="row my-2">
                                  <div class="col-md-8">
                                       <% UserDao ud=new UserDao(ConnectionProvider.getConnection()); %>
                                       <p class="post-user-info">Posted by : <a href="#!"> <%=ud.getUserByUserId(p.getUserId()).getName() %> </a></p>
                                      
                                  </div>
                                   
                                  <div clss="col-md-4">
                                      <p class="post-date"><%=p.getpDate().toLocaleString()%> </p>
                                  </div>
                              </div>
                              
                              <p class="post-content"> <%=p.getpContent()%> </p>
                              <br>
                              <br>
                              
                              <div class="post-code">
                              <pre><%=p.getpCode()%> </pre>
                              </div>
                              
                         </div>
                          <div class="card-footer primary-background text-center">
                              
                              <% 
                                      LikedDao ld=new LikedDao(ConnectionProvider.getConnection());
                               %>
                              
                               <a href="#!" id="t-up" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>,'like')" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"> <%=ld.countLikeOnPost(p.getPid())%> </span></a>           
                               <!--<a href="#!" id="t-down" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>,'dislike')" class="btn btn-outline-light btn-sm" style="display: none;"><i class="fa fa-thumbs-o-up"></i><span class="dislike-counter"> <%=ld.countLikeOnPost(p.getPid())%> </span></a>-->           
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>           
                        </div>
                            
                           
                               <div class="fb-comments" data-href="http://localhost:9494/TechBlog/show_blog_page.jsp?post_id=28" data-width="" data-numposts="5"></div>
                       
                     </div>
                     
                 </div>
                 
             </div>
         </div>
        
         <!--profile model-->
        
                <!-- Modal -->
                <div class="modal fade" id="profile-model" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                      <div class="modal-body"> 
                          <div class="container text-center " >
                              <img src="pics/<%=user.getProfile()%>" class="img-fluid " style="border-radius:50%;max-width:150px;">
                              <h5 class="modal-title" id="exampleModalLabel"><%=user.getName()%></h5>
                          <div id="profile-details">    
                              <table class="table">
 
                            <tbody>
                                 <tr>
                                <th scope="col">1</th>
                                <th scope="col">Id :</th>
                                <th scope="col"><%=user.getId()%></th>

                              </tr>
                             <tr>
                                <th scope="col">2</th>
                                <th scope="col">Email :</th>
                                <th scope="col"><%=user.getEmail()%></th>

                              </tr>
                              <tr>
                                <th scope="col">3</th>
                                <th scope="col">Password :</th>
                                <th scope="col"><%=user.getPassword()%></th>

                              </tr>
                            <tr>
                                <th scope="col">4</th>
                                <th scope="col">Gender :</th>
                                <th scope="col"><%=user.getGender()%></th>

                              </tr>
                            <tr>
                                <th scope="col">5</th>
                                <th scope="col">About :</th>
                                <th scope="col"><%=user.getAbout()%></th>

                              </tr>
                               <tr>
                                <th scope="col">6</th>
                                <th scope="col">Registered on :</th>
                                <th scope="col"><%= user.getDateTime().toString() %></th>

                              </tr>
                            </tbody>
                          </table>
                        </div>  
                         
                        <!--profile edit-->        
                        <div id="prifile-edit" style="display: none;">
                            <h3 class="mt-2">Please Edit Carefully</h3>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                
                                <table class="table">
                                    
                                    <tr>
                                        <td>Id :</td>
                                        <td><%=user.getId()%></td>
                                        
                                    </tr>
                                    <tr>
                                        <td>Name :</td>
                                        <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"> </td>                        
                                    </tr>
                                    <tr>
                                        <td>Email :</td>
                                        <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"> </td>                        
                                    </tr>
                                    <tr>
                                        <td>Password :</td>
                                        <td><input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>"> </td>                        
                                    </tr>
                                    <tr>
                                        <td>About :</td>
                                        <td><textarea rows="3" class="form-control" name="user_about"><%=user.getAbout()%> </textarea>                        
                                    </tr>
                                    <tr>
                                        <td>Gender :</td>
                                         <td><%=user.getGender()%></td>                        
                                    </tr>
                                     <tr>
                                        <td>Registered on :</td>
                                        <td><%=user.getDateTime()%> </td>                        
                                    </tr>
                                    
                                    <tr>
                                        <td>New Profile :</td>
                                        <td><input type="file" class="form-control" name="user_image" > </td>                        
                                    </tr>
                                   
                                </table>
                                  
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-primary"> Save</button>
                                    </div>
                            </form>
                            
                        </div> 
                 
                        </div>
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                      </div>
                    </div>
                  </div>
                </div>
          <!--end of profile model-->
          
          <!--add Post model--> 
               <!-- Modal -->
                <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Post Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                      <div class="modal-body">
                          <form id="add-post-form" action="AddPostServlet" method="post" enctype="multipart/form-data">
                              
                              <div class="form-group">
                                  
                                  <select class="form-control" name="cid">
                                      <option selected disabled>---Select Category---</option>
                                      <%
                                         PostDao postd=new PostDao(ConnectionProvider.getConnection());
                                         ArrayList<Category> list=postd.getAllCategories();
                                         for(Category c:list)
                                         {
                                       %>
                                          <option value="<%=c.getCid()%>"><%=c.getName()%></option>
                                       <%
                                         }
                                       %>
                                      
                                  </select>
                              
                              </div>
                              
                              
                              
                              <div class="form-group">
                                  <input name="pTitle" type="text" placeholder="Enter Post Title" class="form-control"/>
                              </div>
                              
                              <div class="form-group">
                                <textarea name="pContent" class="form-control" rows="5" placeholder="Enter Post Content" ></textarea>
                              </div>
                              
                              <div class="form-group">
                                <textarea name="pCode" class="form-control" rows="5" placeholder="Enter Post code (if any)" ></textarea>
                              </div>
                              
                              <div class="form-group">
                                  <label> Select your pic.. </label>
                                  <input name="pPic" type="file"  class="form-control"/>
                              </div>
                              
                             
                               <div class="container text-center">
                                 <button type="submit" class="btn btn-outline-primary">Post</button>
                               </div>
                                       
                          </form>
                      </div>

                    </div>
                  </div>
                </div>
          <!--end of post model-->
          
          
          
          
          
           java script
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

        <script>
            
            $(document).ready(function()
            { 
//                $('#edit-profile-btn').on('click',function(event){ 
//                });
                   var flg=0;
                  $('#edit-profile-btn').click(function(){
                     
                     if(flg==0)
                     {
                       $("#profile-details").hide();
                       $("#prifile-edit").show();
                       $(this).text("Back");
                       flg=1;
                     }
                     else
                     {
                         $("#profile-details").show();
                         $("#prifile-edit").hide();
                         $(this).text("Edit");
                         flg=1;
                     }
                     
                     
        
                  });
                 
               
        
            });
            
            
            
            </script>
            
            <!--add post js-->
            <script>
                $(document).ready(function(e)
                {
                    $("#add-post-form").on('submit',function(event)
                    {
                        // this form gets alled when form is submitted
                        event.preventDefault();
                        let form =new FormData(this);
                        //now requesting the server
                        $.ajax({
                           url:"AddPostServlet",
                           type:'POST',
                           data:form,
                           success: function(data,textStatus,jqXHR)
                           {
                               if(data.trim()==='done')
                               {
                                   swal("Good job!","saved successfully","success");
                               }
                               else
                               {
                                   swal("Error!","Somthing went wrong try again..","error");
                               }
                           },
                           error:function(jqXHR,textStatus,errorThrown)
                           {
                                swal("Error!","Somthing went wrong try again..","error");
                           },
                           processData:false,
                           contentType:false
                        });
                        
                    });
                });
                
                
            </script>
            
            
            <script>
                function doLike(pid,uid,op)
                {
                  

                    console.log(pid+","+uid);
                    if(op==='like')
                    {
                        //console.log(pid+","+uid);
                            const d={
                                uid:uid,
                                pid:pid,
                                operation:op
                            };
                        $.ajax({

                           url:"LikeServlet",
                           type:'GET',
                          data: $.param(d),
                           success:function(data,textStatus,jqXHR)
                           {
                               if(data.trim()==="okl")
                               {
                                    let c= $(".like-counter").html();
                                    c++;
                                    $('.like-counter').html(c);
//                                     $("#t-up").hide();
//                                     $('.dislike-counter').html(c);
//                                    $("#t-down").show();
                                }
                                else
                                {
                                    let c= $(".like-counter").html();
                                    c--;
                                    $('.like-counter').html(c);
//                                     $("#t-up").hide();
//                                     $('.dislike-counter').html(c);
//                                    $("#t-down").show();
                                }
                                     // alert(data);
                           },
                           error:function(jqXHR,textStatus,errorThrown)
                           {
                                // alert(data);
                           },
                           processData:false,
                               contentType:false

                        });
                    }
//                    else
//                    {
//                        
//                       // console.log(pid+","+uid);
//                        const d={
//                            uid:uid,
//                            pid:pid,
//                            operation:op
//                        };
//                        $.ajax({
//
//                           url:"LikeServlet",
//                           type:'GET',
//                          data: $.param(d),
//                           success:function(data,textStatus,jqXHR)
//                           {
//                               if(data.trim()==="disliked")
//                               {
//                                    let c= $(".dislike-counter").html();
//                                    c--;
//                                    $('.like-counter').html(c);
//                                     $("#t-up").show();
//                                     $('.dislike-counter').html(c);
//                                    $("#t-down").hide();
//                                }
//                             //    alert(data);
//                           },
//                           error:function(jqXHR,textStatus,errorThrown)
//                           {
//                                // alert(data);
//                           },
//                           processData:false,
//                               contentType:false
//
//                        });
//                    }
                    
                    
                }
                

            </script>
                
    </body>
</html>
