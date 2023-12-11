package com.techtide.entities;

import java.sql.*;

public class Blog {

    private int id;
    private String title;
    private String content;
    private String image;
    private Timestamp postDate;
    private int cat_id;
    private int user_id;

    public Blog() {
    }

    public Blog(int id, String title, String content, String image, Timestamp postDate, int cat_id, int user_id) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.image = image;
        this.postDate = postDate;
        this.cat_id = cat_id;
        this.user_id = user_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Timestamp getPostDate() {
        return postDate;
    }

    public void setPostDate(Timestamp postDate) {
        this.postDate = postDate;
    }

    public int getCat_id() {
        return cat_id;
    }

    public void setCat_id(int cat_id) {
        this.cat_id = cat_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    @Override
    public String toString() {
        return "Blog{" + "id=" + id + ", title=" + title + ", content=" + content + ", image=" + image + ", postDate=" + postDate + ", cat_id=" + cat_id + ", user_id= " + user_id + '}';
    }
}
