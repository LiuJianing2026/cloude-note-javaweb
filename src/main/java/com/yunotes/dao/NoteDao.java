
package com.yunotes.dao;

import com.yunotes.entity.Note;
import java.util.List;

public interface NoteDao {
    Note findById(Long id);
    List<Note> findByUserId(Long userId);
    List<Note> findByCategory(Long userId, String category);
    int insert(Note note);
    int update(Note note);
    int delete(Long id);
}
