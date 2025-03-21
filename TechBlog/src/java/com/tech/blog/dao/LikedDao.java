
package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class LikedDao {
    
    
     private Connection con;

    public LikedDao(Connection con) {
        this.con = con;
    }
    
    
    public boolean insertLike(int pid , int uid)
    {
         boolean f=false;
        try
        {
            String q="insert into liked(pid,uid) values(?,?)";
            PreparedStatement p=con.prepareStatement(q);
            
            p.setInt(1, pid);
            p.setInt(2, uid);
            
            p.executeUpdate();
            
            f=true;
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
    }
    
    
    public int countLikeOnPost(int pid)
    {
        int count=0;
        
        try
        {
            String q="select count(*) from Liked where pid=?";
            PreparedStatement p=con.prepareStatement(q);
            p.setInt(1, pid);
            ResultSet set=p.executeQuery();
            
            if(set.next())
            {
                count=set.getInt("count(*)");
            }
        } 
        catch(Exception e)
        {
            e.printStackTrace();
        }     
        
        return count;
    }
    
    public boolean isLikedByUser(int pid,int uid)
    {
         boolean f=false;
        try
        {
            String q="select count(*) from liked where pid=? and uid=?";
            PreparedStatement p=con.prepareStatement(q);
            
            p.setInt(1, pid);
            p.setInt(2, uid);
            
            ResultSet set= p.executeQuery();
            
            if(set.next())
            {
                int count=set.getInt("count(*)");
                if(count>0)
                {
                    f=true;
                }
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
        
    }
    public boolean deleteLike(int pid,int uid)
    {
         boolean f=false;
        try
        {
            String q="delete from liked where pid=? and uid=?";
            PreparedStatement p=con.prepareStatement(q);
            
            p.setInt(1, pid);
            p.setInt(2, uid);
            
           p.executeUpdate();
            
            
              f=true;
            
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return f;
        
    }
    
    
}
