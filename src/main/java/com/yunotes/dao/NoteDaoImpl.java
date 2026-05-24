package com.yunotes.dao;

import com.yunotes.entity.Note;
import com.yunotes.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NoteDaoImpl implements NoteDao {

    @Override
    public Note findById(Long id) {
        String sql = "SELECT id, user_id, category_id, title, content, create_time, update_time, is_deleted FROM t_note WHERE id = ? AND is_deleted = 0";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, id);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return extractNote(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }
        return null;
    }

    @Override
    public List<Note> findByUserId(Long userId) {
        String sql = "SELECT id, user_id, category_id, title, content, create_time, update_time, is_deleted FROM t_note WHERE user_id = ? AND is_deleted = 0 ORDER BY update_time DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<Note> notes = new ArrayList<>();
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, userId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                notes.add(extractNote(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, rs);
        }
        return notes;
    }

    @Override
    public int insert(Note note) {
        String sql = "INSERT INTO t_note (user_id, category_id, title, content, create_time, update_time, is_deleted) VALUES (?, ?, ?, ?, ?, ?, 0)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setLong(1, note.getUserId());
            if (note.getCategoryId() != null) {
                pstmt.setLong(2, note.getCategoryId());
            } else {
                pstmt.setNull(2, Types.BIGINT);
            }
            pstmt.setString(3, note.getTitle());
            pstmt.setString(4, note.getContent());
            pstmt.setTimestamp(5, new Timestamp(note.getCreateTime().getTime()));
            pstmt.setTimestamp(6, new Timestamp(note.getUpdateTime().getTime()));
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    note.setId(rs.getLong(1));
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
    public int update(Note note) {
        String sql = "UPDATE t_note SET title = ?, content = ?, update_time = ? WHERE id = ? AND user_id = ? AND is_deleted = 0";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DBUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, note.getTitle());
            pstmt.setString(2, note.getContent());
            pstmt.setTimestamp(3, new Timestamp(note.getUpdateTime().getTime()));
            pstmt.setLong(4, note.getId());
            pstmt.setLong(5, note.getUserId());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, pstmt, null);
        }
        return 0;
    }

    @Override
    public int delete(Long id, Long userId) {
        String sql = "UPDATE t_note SET is_deleted = 1 WHERE id = ? AND user_id = ?";
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

    private Note extractNote(ResultSet rs) throws SQLException {
        Note note = new Note();
        note.setId(rs.getLong("id"));
        note.setUserId(rs.getLong("user_id"));
        long categoryId = rs.getLong("category_id");
        note.setCategoryId(rs.wasNull() ? null : categoryId);
        note.setTitle(rs.getString("title"));
        note.setContent(rs.getString("content"));
        note.setCreateTime(rs.getTimestamp("create_time"));
        note.setUpdateTime(rs.getTimestamp("update_time"));
        note.setIsDeleted(rs.getInt("is_deleted"));
        return note;
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