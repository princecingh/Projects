
package com.tech.blog.entities;
import java.sql.*;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private String about;
    private String gender;
    private Timestamp dateTime;
    private String profile;

   
    //constructors
    public User(){}
    public User(int id, String name, String email, String password, String about, String gender, Timestamp dateTime) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.about = about;
        this.gender = gender;
        this.dateTime = dateTime;
    }

    public User(String name, String email, String password, String about, String gender) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.about = about;
        this.gender = gender;
       
    }
    
    //getter AND setter

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setDateTime(Timestamp dateTime) {
        this.dateTime = dateTime;
    }
    
    public void setProfile(String profile) {
        this.profile = profile;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getAbout() {
        return about;
    }

    public String getGender() {
        return gender;
    }

    public Timestamp getDateTime() {
        return dateTime;
    }
    public String getProfile() {
        return profile;
    }

   
     
    
    
}
