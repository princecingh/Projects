<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>

<%
    User user=(User)session.getAttribute("currentUser");
    if(user==null)
    {
     response.sendRedirect("Login.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile page</title>
         <!--css-->
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
          <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
          <style>
              .banner-background{
                 clip-path: polygon(34% 0, 70% 0, 100% 0, 100% 93%, 62% 100%, 28% 94%, 0 100%, 0 0);
              }
/*              body{
                  background: url(img/bg.avif);
                  background-size: cover;
                  background-attachment: fixed;
              }*/
          </style>
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
                    <a class="nav-link" href="#"><span class="fa fa-grav"></span> Just Blog <span class="sr-only">(current)</span></a>
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
          
                            <%
                                Message m=(Message)session.getAttribute("msg");
                                if(m!=null)
                                {
                            %>   
                            <div class="alert <%=m.getCssClass()%> text-center" role="alert">
                               <%=m.getContent()%>
                            </div>
                            <%
                                session.removeAttribute("msg");
                                }
                             %>
          <!--main body of the page-->
          <main>
              <div class="container">
                  <div class="row mt-4">
                      <!--first col-->
                      <div class="col-md-4">
                           <!--categories-->
                           
                            <a href="#" onclick="getPosts(0,this)" class=" c-link list-group-item list-group-item-action active">
                              All Posts
                            </a>
                            <%
                               PostDao d=new PostDao(ConnectionProvider.getConnection());
                               ArrayList<Category> list1=d.getAllCategories();
                               for(Category cc:list1)
                               {
                            %>
                               <a href="#" onclick="getPosts(<%=cc.getCid()%>,this)" class=" c-link list-group-item list-group-item-action disabled"><%=cc.getName()%></a>   
                               
                            <%
                                }
                            %>
     
                      </div>
                      <!--seccond col-->
                      <div class="col-md-8" >
                           <!--post-->
                           <div class="container text-center" id="loader">
                               <i class="fa fa-refresh fa-4x fa-spin"></i>
                               <h3 class="mt-2">Loading...</h3>
                           </div>
                           
                           <div class="container-fluid" id="post-container">
                               
                           </div>
                      </div>
                      
                  </div>
              </div>
          </main>
           
          
          <!--end of main body of the page-->
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
          
          
          
          
          
           <!--java script-->
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
            
            <!--loading post using ajax-->
             <script>
                 
                 function getPosts(catId,temp)
                 {   
                     $(".c-link").removeClass('active');
                     $.ajax({
                      url:"load_posts.jsp",
                      data:{cid:catId},
                      success:function(data,textStatus,jqXHR)
                      {
                          
                          $("#loader").hide();
                          $("#post-container").html(data);
                          $(temp).addClass('active');
                      }
             
                   });
                 }
                
                $(document).ready(function (e)
                {
                    let allPostRef=$('.c-link')[0]
                    getPosts(0,allPostRef);
                });
            </script>
                
          
        
        
        
    </body>
</html>
