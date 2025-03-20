 
package com.tech.blog.dao;
import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author princ
 */
public class PostDao {
    
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Category> getAllCategories()
    {
        ArrayList<Category> list=new ArrayList<>();
        
        try
        {
            String Query="select * from categories";
            Statement st=this.con.createStatement();
            ResultSet set=st.executeQuery(Query);
            
            while(set.next())
            {
                int cid=set.getInt("cid");
                String name=set.getString("name");
                String description=set.getString("description");
                
                Category c=new Category(cid,name,description);
                list.add(c);
            }
            
        }
        catch(Exception e)
        {
           e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean savePost(Post p)
    {
        boolean flg=false;
        
        try
        {
             String query="insert into posts(pTitle,pContent,pCode,pPic,catId,UserId) values(?,?,?,?,?,?)";
             PreparedStatement pstmt=con.prepareStatement(query);
             
             pstmt.setString(1, p.getpTitle());
             pstmt.setString(2, p.getpContent());
             pstmt.setString(3, p.getpCode());
             pstmt.setString(4, p.getpPic());
             pstmt.setInt(5,p.getCatId());
             pstmt.setInt(6,p.getUserId());
             
             pstmt.executeUpdate();
             flg=true;
             
             
             
             
             
        }
        catch(Exception e)
        {
             e.printStackTrace();
        }
                return flg;
    }
    
//     get all the post//
    public List<Post> getAllPosts() 
    {
        List<Post> list=new ArrayList<>();
         try
        {
            String query="select * from posts order by pid desc";
            Statement st=this.con.createStatement();
            ResultSet set=st.executeQuery(query);
            
            while(set.next())
            {
                 int pid=set.getInt("pid") ;
                 String pTitle=set.getString("pTitle");
                 String  pContent=set.getString("pContent");
                 String pCode=set.getString("pCode");
                 String pPic=set.getString("pPic");
                 Timestamp pDate=set.getTimestamp("pDate");
                 int catId=set.getInt("catId");
                 int userId=set.getInt("userId");
                Post p=new Post( pid,  pTitle,  pContent,  pCode,  pPic, pDate, catId, userId);
                list.add(p);
            }
            
        }
        catch(Exception e)
        {
           e.printStackTrace();
        }
        
        return list;
    }
    
//    get post by catid
    public List<Post> getPostByCatId(int catId)
    {
        List<Post> list=new ArrayList<>();
        
         try
        {
            String query="select * from posts where catId=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1,catId);
            ResultSet set=pstmt.executeQuery();
            
            while(set.next())
            {
                 int pid=set.getInt("pid") ;
                 String pTitle=set.getString("pTitle");
                 String  pContent=set.getString("pContent");
                 String pCode=set.getString("pCode");
                 String pPic=set.getString("pPic");
                 Timestamp pDate=set.getTimestamp("pDate");
                // int catId=set.getInt("catId");
                 int userId=set.getInt("userId");
                 Post p=new Post( pid,  pTitle,  pContent,  pCode,  pPic, pDate, catId, userId);
                list.add(p);
            }
            
        }
        catch(Exception e)
        {
           e.printStackTrace();
        }
        return list;
    }
    
    
    
     public Post getPostByPostId(int postId)
    {
        Post p=null;
        
         try
        {
            String query="select * from posts where pid=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1,postId);
            ResultSet set=pstmt.executeQuery();
            
            if(set.next())
            {
//                 int pid=set.getInt("pid") ;
                 String pTitle=set.getString("pTitle");
                 String  pContent=set.getString("pContent");
                 String pCode=set.getString("pCode");
                 String pPic=set.getString("pPic");
                 Timestamp pDate=set.getTimestamp("pDate");
                 int catId=set.getInt("catId");
                 int userId=set.getInt("userId");
                  p=new Post( postId,  pTitle,  pContent,  pCode,  pPic, pDate, catId, userId);
              
            }
            
        }
        catch(Exception e)
        {
           e.printStackTrace();
        }
        return p;
    }
    
}
