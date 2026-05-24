package com.yunotes.dao;

import com.yunotes.entity.Category;
import com.yunotes.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDaoImpl implements CategoryDao {

    @Override
    public List<Category> findByUserId(Long userId) {
        String sql = "SELECT id, user_id, name, create_time FROM t_category WHERE user_id = ? ORDER BY name";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Category> categories = new ArrayList<>();
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getLong("id"));
                category.setUserId(rs.getLong("user_id"));
                category.setName(rs.getString("name"));
                category.setCreateTime(rs.getTimestamp("create_time"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }
        return categories;
    }

    @Override
    public Category findByName(Long userId, String name) {
        String sql = "SELECT id, user_id, name, create_time FROM t_category WHERE user_id = ? AND name = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, userId);
            pstmt.setString(2, name);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                Category category = new Category();
                category.setId(rs.getLong("id"));
                category.setUserId(rs.getLong("user_id"));
                category.setName(rs.getString("name"));
                category.setCreateTime(rs.getTimestamp("create_time"));
                return category;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }
        return null;
    }

    @Override
    public int insert(Category category) {
        String sql = "INSERT INTO t_category (user_id, name, create_time) VALUES (?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setLong(1, category.getUserId());
            pstmt.setString(2, category.getName());
            pstmt.setTimestamp(3, new Timestamp(category.getCreateTime().getTime()));
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    category.setId(rs.getLong(1));
                }
            }
            return rows;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, null);
        }
        return 0;
    }

    @Override
    public int delete(Long id, Long userId) {
        String sql = "DELETE FROM t_category WHERE id = ? AND user_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            pstmt.setLong(2, userId);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, null);
        }
        return 0;
    }

    @Override
    public int clearNotesCategory(Long categoryId, Long userId) {
        String sql = "UPDATE t_note SET category_id = NULL WHERE category_id = ? AND user_id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, categoryId);
            pstmt.setLong(2, userId);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, null);
        }
        return 0;
    }

    private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (stmt != null) {
            try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}