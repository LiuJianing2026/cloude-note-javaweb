package com.yunotes.servlet;

import com.yunotes.entity.Category;
import com.yunotes.entity.User;
import com.yunotes.service.CategoryService;
import com.yunotes.service.CategoryServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final CategoryService categoryService = new CategoryServiceImpl();

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
                listCategories(req, resp, loginUser);
                break;
            case "add":
                addCategory(req, resp, loginUser);
                break;
            case "delete":
                deleteCategory(req, resp, loginUser);
                break;
            default:
                listCategories(req, resp, loginUser);
                break;
        }
    }

    private void listCategories(HttpServletRequest req, HttpServletResponse resp, User loginUser) throws ServletException, IOException {
        List<Category> categories = categoryService.listCategories(loginUser.getId());
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/category-list.jsp").forward(req, resp);
    }

    private void addCategory(HttpServletRequest req, HttpServletResponse resp, User loginUser) throws ServletException, IOException {
        String name = req.getParameter("name");
        String error = categoryService.addCategory(loginUser.getId(), name);
        if (error != null) {
            req.setAttribute("errorMsg", error);
        }
        listCategories(req, resp, loginUser);
    }

    private void deleteCategory(HttpServletRequest req, HttpServletResponse resp, User loginUser) throws ServletException, IOException {
        Long categoryId = Long.parseLong(req.getParameter("id"));
        String error = categoryService.deleteCategory(categoryId, loginUser.getId());
        if (error != null) {
            req.setAttribute("errorMsg", error);
        }
        listCategories(req, resp, loginUser);
    }
}