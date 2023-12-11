package com.techtide.dao;

import com.techtide.entities.Blog;
import java.sql.*;
import java.util.ArrayList;

public class BlogDao {

    private final Connection conn;

    public BlogDao(Connection conn) {
        this.conn = conn;
    }

    public boolean addBlog(Blog blog) {
        boolean f = false;
        try {
            String query = "insert into blog(title,content,image,post_date,cat_id,user_id) values(?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, blog.getTitle());
            ps.setString(2, blog.getContent());
            ps.setString(3, blog.getImage());
            ps.setTimestamp(4, blog.getPostDate());
            ps.setInt(5, blog.getCat_id());
            ps.setInt(6, blog.getUser_id());

            ps.execute();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

//    get all the posts
    public ArrayList<Blog> getAllBlogs() {
        ArrayList<Blog> list = new ArrayList<>();

        try {
            String query = "select * from blog order by rand(),post_date desc";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt(1));
                b.setTitle(rs.getString(2));
                b.setContent(rs.getString(3));
                b.setImage(rs.getString(4));
                b.setPostDate(rs.getTimestamp(5));
                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
//    get specific posts by its category id;

    public ArrayList<Blog> getBlogsByCategoryId(int cat_id) {
        ArrayList<Blog> list = new ArrayList<>();

        try {
            String query = "select * from blog where cat_id=? order by post_date desc";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, cat_id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt(1));
                b.setTitle(rs.getString(2));
                b.setContent(rs.getString(3));
                b.setImage(rs.getString(4));
                b.setPostDate(rs.getTimestamp(5));
                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

//    get all the post for the post owner
    public ArrayList<Blog> getAllBlogsForBlogOwner(int uid, int cid) {
        ArrayList<Blog> list = new ArrayList<>();

        try {
            String query;
            PreparedStatement ps;
            if (cid == 0) {
                query = "select * from blog where user_id=? order by post_date desc ";
                ps = conn.prepareStatement(query);
                ps.setInt(1, uid);
            } else {
                query = "select * from blog where user_id=? and cat_id=? order by post_date desc";
                ps = conn.prepareStatement(query);
                ps.setInt(1, uid);
                ps.setInt(2, cid);
            }
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Blog b = new Blog();
                b.setId(rs.getInt(1));
                b.setTitle(rs.getString(2));
                b.setContent(rs.getString(3));
                b.setImage(rs.getString(4));
                b.setPostDate(rs.getTimestamp(5));
                list.add(b);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Blog getBlogByBlogId(int bid) {
        Blog b = null;

        try {
            String query = "select * from blog where id=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, bid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                b = new Blog();
                b.setTitle(rs.getString(2));
                b.setContent(rs.getString(3));
                b.setImage(rs.getString(4));
                b.setPostDate(rs.getTimestamp(5));
                b.setCat_id(rs.getInt(6));
                b.setUser_id(rs.getInt(7));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return b;
    }

}
