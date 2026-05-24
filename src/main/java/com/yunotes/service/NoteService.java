package com.yunotes.service;

import com.yunotes.entity.Note;
import java.util.List;

public interface NoteService {
    List<Note> listNotes(Long userId);
    Note getNoteById(Long id, Long userId);
    String addNote(Note note);
    String updateNote(Note note);
    String deleteNote(Long id, Long userId);
}