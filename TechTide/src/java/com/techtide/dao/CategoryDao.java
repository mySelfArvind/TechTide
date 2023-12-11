package com.techtide.dao;

import com.techtide.entities.Category;
import java.sql.*;
import java.util.ArrayList;

public class CategoryDao {

    private Connection conn;

    public CategoryDao(Connection conn) {
        this.conn = conn;
    }

    public boolean addCategory(Category category) {
        boolean f = false;
        try {
            String query = "insert into category(category,description) values(?,?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, category.getCategory());
            ps.setString(2, category.getDescription());
            ps.execute();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public ArrayList<Category> getAllCategory() {
        ArrayList<Category> list = new ArrayList<>();

        try {
            String query = "select * from category";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt(1));
                category.setCategory(rs.getString(2));
                category.setDescription(rs.getString(3));
                list.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
