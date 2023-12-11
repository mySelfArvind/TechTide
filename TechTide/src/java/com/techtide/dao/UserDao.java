package com.techtide.dao;

import com.techtide.entities.User;
import java.sql.*;

public class UserDao {

    private final Connection conn;

    public UserDao(Connection conn) {
        this.conn = conn;
    }

//    Registration
    public boolean registerUser(User user) {
        boolean f = false;

        try {

            String query = "insert into user(name,email,password,about,gender,reg_date) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getAbout());
            pstmt.setString(5, user.getGender());
            pstmt.setString(6, user.getReg_date().toString());
            pstmt.execute();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

//    Login
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;

        try {
            String query = "select * from user where email=? and password=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt(1));
                user.setName(rs.getString(2));
                user.setEmail(rs.getString(3));
                user.setPassword(rs.getString(4));
                user.setAbout(rs.getString(5));
                user.setGender(rs.getString(6));
                user.setReg_date(rs.getTimestamp(7));
                user.setProfile(rs.getString(8));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

//    checking if user already exist
    public boolean getUserByEmail(String email) {
        boolean f = false;

        try {
            String query = "select * from user where email=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

//    Updating user details
    public boolean updateUserDetails(User user) {
        boolean f = false;

        try {

            String query = "update user set name=?,email=?,password=?,about=?,profile=? where id=?";
            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getAbout());
            ps.setString(5, user.getProfile());
            ps.setInt(6, user.getId());

            ps.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

//    get userName for the post
    public User getUserNameByPostId(int pid) {
        User u = null;

        try {
            String query = "SELECT * FROM USER u LEFT JOIN  blog b ON u.id = b.user_id WHERE b.id=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, pid);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                u = new User();
                u.setId(rs.getInt(1));
                u.setName(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setAbout(rs.getString(4));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return u;
    }
    
    

}
