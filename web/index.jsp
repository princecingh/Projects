<%-- 
    Document   : index
    Created on : 14-Feb-2025, 7:41:33 am
    Author     : princ
--%>

<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
          <!--css-->
          <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
          <link href="css/myStyle.css" rel="stylesheet" type="text/css"/>
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
          <style>
              .banner-background{
                 clip-path: polygon(34% 0, 70% 0, 100% 0, 100% 93%, 62% 100%, 28% 94%, 0 100%, 0 0);
              }
          </style>
    </head>
    <body>
        <%@include file="normal_navbar.jsp"%>
        
        <!--banner-->
        <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background text-white  banner-background">
                <div classs="container">
                    <h3 class="display-3">Welcome to TechBlog</h3>
                    <p>
                        A programming language is a system of notation for writing computer programs.[1] Programming languages are described in terms of their syntax (form) and semantics (meaning), usually defined by a formal language. Languages usually provide features such as a type system, variables, and mechanisms for error handling. An implementation of a programming language is required in order to execute programs, namely an interpreter or a compiler. An interpreter directly executes the source code, while a compiler produces an executable program.
                    </p>
                    <button class="btn btn-outline-light btn-lg"><span class="fa fa-user-plus"></span> Start its Free!!</button>
                    <a href="login_page.jsp" class="btn btn-outline-light btn-lg"><span class="fa fa-user-circle fa-spin"></span> login</a>
                    
                </div>
                
            </div>
            
        </div>
        
        <!--cards-->
        <div class="container">
            
            <div class="row mb-2">
                
                <div class="col-md-4">
                    <div class="card">
                   
                    <div class="card-body">
                      <h5 class="card-title">Java Programming</h5>
                      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                      <a href="#" class="btn primary-background text-white"> Read more</a>
                    </div>
                  </div>
                    
                </div>
                <div class="col-md-4">
                    <div class="card">
                   
                    <div class="card-body">
                      <h5 class="card-title">Java Programming</h5>
                      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                      <a href="#" class="btn primary-background text-white"> Read more</a>
                    </div>
                  </div>
                    
                </div>
                <div class="col-md-4">
                    <div class="card">
                   
                    <div class="card-body">
                      <h5 class="card-title">Java Programming</h5>
                      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                      <a href="#" class="btn primary-background text-white"> Read more</a>
                    </div>
                  </div>
                    
                </div>
                    
                
            </div>
            <div class="row">
                
                <div class="col-md-4">
                    <div class="card">
                   
                    <div class="card-body">
                      <h5 class="card-title">Java Programming</h5>
                      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                      <a href="#" class="btn primary-background text-white"> Read more</a>
                    </div>
                  </div>
                    
                </div>
                <div class="col-md-4">
                    <div class="card">
                   
                    <div class="card-body">
                      <h5 class="card-title">Java Programming</h5>
                      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                      <a href="#" class="btn primary-background text-white"> Read more</a>
                    </div>
                  </div>
                    
                </div>
                <div class="col-md-4">
                    <div class="card">
                   
                    <div class="card-body">
                      <h5 class="card-title">Java Programming</h5>
                      <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
                      <a href="#" class="btn primary-background text-white"> Read more</a>
                    </div>
                  </div>
                    
                </div>
                    
                
            </div>
            
        </div>

        
        
        
        
        
        
        
        
        
        
        <!--java script-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

    </body>
</html>
