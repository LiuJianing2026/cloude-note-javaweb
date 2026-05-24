package com.yunotes.service;

import com.yunotes.dao.NoteDao;
import com.yunotes.dao.NoteDaoImpl;
import com.yunotes.entity.Note;

import java.util.Date;
import java.util.List;

public class NoteServiceImpl implements NoteService {

    private final NoteDao noteDao = new NoteDaoImpl();

    @Override
    public List<Note> listNotes(Long userId) {
        return noteDao.findByUserId(userId);
    }

    @Override
    public List<Note> searchNotes(Long userId, String keyword, Long categoryId) {
        return noteDao.searchNotes(userId, keyword, categoryId);
    }

    @Override
    public Note getNoteById(Long id, Long userId) {
        Note note = noteDao.findById(id);
        if (note == null) {
            return null;
        }
        if (!note.getUserId().equals(userId)) {
            return null;
        }
        return note;
    }

    @Override
    public String addNote(Note note) {
        if (note.getTitle() == null || note.getTitle().trim().isEmpty()) {
            return "标题不能为空";
        }
        Date now = new Date();
        note.setCreateTime(now);
        note.setUpdateTime(now);
        int result = noteDao.insert(note);
        if (result <= 0) {
            return "添加笔记失败";
        }
        return null;
    }

    @Override
    public String updateNote(Note note) {
        Note existingNote = noteDao.findById(note.getId());
        if (existingNote == null) {
            return "笔记不存在或无权限修改";
        }
        if (!existingNote.getUserId().equals(note.getUserId())) {
            return "笔记不存在或无权限修改";
        }
        if (note.getTitle() == null || note.getTitle().trim().isEmpty()) {
            return "标题不能为空";
        }
        note.setUpdateTime(new Date());
        int result = noteDao.update(note);
        if (result <= 0) {
            return "修改笔记失败";
        }
        return null;
    }

    @Override
    public String deleteNote(Long id, Long userId) {
        Note existingNote = noteDao.findById(id);
        if (existingNote == null) {
            return "笔记不存在或无权限删除";
        }
        if (!existingNote.getUserId().equals(userId)) {
            return "笔记不存在或无权限删除";
        }
        int result = noteDao.delete(id, userId);
        if (result <= 0) {
            return "删除笔记失败";
        }
        return null;
    }
}