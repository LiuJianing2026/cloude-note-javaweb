
package com.yunotes.service;

import com.yunotes.entity.Note;
import java.util.List;

public interface NoteService {
    Note getNoteById(Long id);
    List<Note> getNotesByUserId(Long userId);
    List<Note> getNotesByCategory(Long userId, String category);
    boolean createNote(Note note);
    boolean updateNote(Note note);
    boolean deleteNote(Long id);
}
