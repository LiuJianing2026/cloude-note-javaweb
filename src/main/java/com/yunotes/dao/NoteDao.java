package com.yunotes.dao;

import com.yunotes.entity.Note;
import java.util.List;

public interface NoteDao {
    Note findById(Long id);
    List<Note> findByUserId(Long userId);
    List<Note> searchNotes(Long userId, String keyword, Long categoryId);
    int insert(Note note);
    int update(Note note);
    int delete(Long id, Long userId);
}