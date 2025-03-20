
package com.tech.blog.helper;

import java.sql.*;
public class ConnectionProvider {
    
    
    private static Connection con;
    public static Connection getConnection()
    {
        try
        {   
            
            if(con==null)
            {
              // driver class load
             Class.forName("com.mysql.jdbc.Driver");
            // Class.forName("com.mysql.cj.jdbc.Driver");
             
             //create a connection
            String url = "jdbc:mysql://localhost:3306/techblog";
            String userName= "root";
            String password= "root";

             con= DriverManager.getConnection(url, userName, password);
            }
            
            
        }
        catch(Exception e)
        {
             e.printStackTrace();
        }
        return con;
    }
}
