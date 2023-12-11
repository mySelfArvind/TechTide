package com.techtide.dao;

import java.sql.*;

public class LikeDao {

    private final Connection conn;

    public LikeDao(Connection conn) {
        this.conn = conn;
    }

//    get totallike for specified post
    public int getTotalLikeByPostId(int postId) {
        int totalLike = 0;
        try {
            String query = "select count(*) from techtide.like where post_id=?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                totalLike = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return totalLike;
    }

//    like post
    public boolean doLike(int uid, int pid) {
        boolean f = false;

        try {
            String query = "insert into techtide.like(user_id, post_id) values(?,?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, uid);
            ps.setInt(2, pid);

            ps.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

//    check if user already liked a post
    public boolean checkIfLikedByUser(int postId, int userId) {
        boolean f = false;

        try {
            String query = "select * from techtide.like where post_id=? and user_id=?";
            PreparedStatement ps = this.conn.prepareStatement(query);
            ps.setInt(1, postId);
            ps.setInt(2, userId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

//    dislike or remove the like from post
    public boolean dislikePost(int postId, int userId) {
        boolean f = false;
        try {
            String query = "delete from techtide.like where post_id=? and user_id=?";
            PreparedStatement ps = this.conn.prepareStatement(query);
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ps.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }
}
