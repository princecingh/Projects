
package com.tech.blog.dao;
import com.tech.blog.entities.User;
import java.io.Console;
import static java.lang.System.console;
import java.sql.*;
public class UserDao {
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }
    //method to insert user to data base
    
    public boolean saveUser(User user)
    {
        boolean flag=false;
        try
        {
             String query="insert into user(name,email,password,gender,about,profile) values(?,?,?,?,?,?)";
             
             PreparedStatement pstmt = this.con.prepareStatement(query);
             String abt;
             if(user.getAbout().length()==0)
             {
                 abt="hey! I am using Techblog";
                 
             }
             else
             {
                 abt=user.getAbout();
             }
             
             
             String dp;
             if(user.getProfile() == null || user.getProfile().length() == 0)
             {
                 dp="default.png";
                 
             }
             else
             {
                 dp=user.getProfile();
             }
             
             
             
             pstmt.setString(1,user.getName());
             pstmt.setString(2,user.getEmail());
             pstmt.setString(3,user.getPassword());
             pstmt.setString(4,user.getGender());
             pstmt.setString(5,abt);
             pstmt.setString(6,dp);
             
            
             
             pstmt.executeUpdate();
             flag=true;
             
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return flag;
    }
    
    //get user by email and password:
    public User getUserByEmailAndPassword(String email,String password)
    {
         User user=null;
        
         try
         {
             String query="select * from user where email=? and password=?";
             PreparedStatement pstmt = this.con.prepareStatement(query);
             
            
             pstmt.setString(1,email);
             pstmt.setString(2,password);
             ResultSet set=pstmt.executeQuery();
             
             if(set.next())
             {
                 user=new User();
                 user.setId(set.getInt("id"));
                 user.setName(set.getString("name"));
                 user.setEmail(set.getString("email"));
                 user.setPassword(set.getString("password"));
                 user.setGender(set.getString("gender"));
                 user.setAbout(set.getString("about"));
                 user.setDateTime(set.getTimestamp("rdate"));
                 user.setProfile(set.getString("profile"));
                 
                // return user;
                 
             }
             
           
             
         }
         catch(Exception e)
         {
             e.printStackTrace();
         }
                 
        return user;
    } 
    
    public boolean updateUser(User user)
    {
         boolean flag=false;
        try
        {
             String query="update user set name=? , email=? , password=? , about=? , profile=? where id=?";
               PreparedStatement p = this.con.prepareStatement(query);
               
              String dp;
             if(user.getProfile() == null || user.getProfile().length() == 0)
             {
                 dp="default.png";
                 
             }
             else
             {
                 dp=user.getProfile();
             }
               
               p.setString(1,user.getName());
               p.setString(2,user.getEmail());
               p.setString(3,user.getPassword());
               p.setString(4,user.getAbout());
               p.setString(5,dp);
               p.setInt(6,user.getId());
              
               
               p.executeUpdate();
               
               flag=true;
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return flag;
    }
    
    public User getUserByUserId(int userId)
    {
        User user=new User();
        try
        {
         String query="select * from user where id=?";
         PreparedStatement p = this.con.prepareStatement(query);
         p.setInt(1,userId);
         ResultSet set=p.executeQuery();
         
          if(set.next())
             {
                
                 user.setId(set.getInt("id"));
                 user.setName(set.getString("name"));
                 user.setEmail(set.getString("email"));
                 user.setPassword(set.getString("password"));
                 user.setGender(set.getString("gender"));
                 user.setAbout(set.getString("about"));
                 user.setDateTime(set.getTimestamp("rdate"));
                 user.setProfile(set.getString("profile"));
                 
                // return user;
                 
             }
         
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return user;
    }
    
    
}
