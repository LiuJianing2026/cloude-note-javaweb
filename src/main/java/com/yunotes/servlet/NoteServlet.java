package com.yunotes.servlet;

import com.yunotes.entity.Note;
import com.yunotes.entity.User;
import com.yunotes.service.NoteService;
import com.yunotes.service.NoteServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/note")
public class NoteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final NoteService noteService = new NoteServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        if (loginUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listNotes(req, resp, loginUser);
                break;
            case "detail":
                viewDetail(req, resp, loginUser);
                break;
            case "toAdd":
                toAdd(req, resp);
                break;
            case "add":
                addNote(req, resp, loginUser);
                break;
            case "toEdit":
                toEdit(req, resp, loginUser);
                break;
            case "update":
                updateNote(req, resp, loginUser);
                break;
            case "delete":
                deleteNote(req, resp, loginUser);
                break;
            default:
                listNotes(req, resp, loginUser);
                break;
        }
    }

    private void listNotes(HttpServletRequest req, HttpServletResponse resp, User loginUser) throws ServletException, IOException {
        List<Note> notes = noteService.listNotes(loginUser.getId());
        req.setAttribute("notes", notes);
        req.getRequestDispatcher("/note-list.jsp").forward(req, resp);
    }

    private void viewDetail(HttpServletRequest req, HttpServletResponse resp, User loginUser) throws ServletException, IOException {
        Long noteId = Long.parseLong(req.getParameter("id"));
        Note note = noteService.getNoteById(noteId, loginUser.getId());
        if (note == null) {
            req.setAttribute("errorMsg", "笔记不存在或无权限查看");
            List<Note> notes = noteService.listNotes(loginUser.getId());
            req.setAttribute("notes", notes);
            req.getRequestDispatcher("/note-list.jsp").forward(req, resp);
            return;
        }
        req.setAttribute("note", note);
        req.getRequestDispatcher("/note-detail.jsp").forward(req, resp);
    }

    private void toAdd(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/note-edit.jsp").forward(req, resp);
    }

    private void addNote(HttpServletRequest req, HttpServletResponse resp, User loginUser) throws ServletException, IOException {
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        Note note = new Note();
        note.setUserId(loginUser.getId());
        note.setTitle(title);
        note.setContent(content);

        String error = noteService.addNote(note);
        if (error != null) {
            req.setAttribute("errorMsg", error);
            req.setAttribute("note", note);
            req.getRequestDispatcher("/note-edit.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/note?action=list");
    }

    private void toEdit(HttpServletRequest req, HttpServletResponse resp, User loginUser) throws ServletException, IOException {
        Long noteId = Long.parseLong(req.getParameter("id"));
        Note note = noteService.getNoteById(noteId, loginUser.getId());
        if (note == null) {
            req.setAttribute("errorMsg", "笔记不存在或无权限修改");
            List<Note> notes = noteService.listNotes(loginUser.getId());
            req.setAttribute("notes", notes);
            req.getRequestDispatcher("/note-list.jsp").forward(req, resp);
            return;
        }
        req.setAttribute("note", note);
        req.getRequestDispatcher("/note-edit.jsp").forward(req, resp);
    }

    private void updateNote(HttpServletRequest req, HttpServletResponse resp, User loginUser) throws ServletException, IOException {
        Long noteId = Long.parseLong(req.getParameter("id"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        Note note = new Note();
        note.setId(noteId);
        note.setUserId(loginUser.getId());
        note.setTitle(title);
        note.setContent(content);

        String error = noteService.updateNote(note);
        if (error != null) {
            req.setAttribute("errorMsg", error);
            req.setAttribute("note", note);
            req.getRequestDispatcher("/note-edit.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/note?action=list");
    }

    private void deleteNote(HttpServletRequest req, HttpServletResponse resp, User loginUser) throws ServletException, IOException {
        Long noteId = Long.parseLong(req.getParameter("id"));
        String error = noteService.deleteNote(noteId, loginUser.getId());
        if (error != null) {
            req.setAttribute("errorMsg", error);
            List<Note> notes = noteService.listNotes(loginUser.getId());
            req.setAttribute("notes", notes);
            req.getRequestDispatcher("/note-list.jsp").forward(req, resp);
            return;
        }
        resp.sendRedirect(req.getContextPath() + "/note?action=list");
    }
}