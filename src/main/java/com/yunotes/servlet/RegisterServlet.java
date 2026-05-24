package com.yunotes.servlet;

import com.yunotes.service.UserService;
import com.yunotes.service.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        String error = userService.register(username, password, confirmPassword);
        if (error != null) {
            req.setAttribute("errorMsg", error);
            req.setAttribute("username", username);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("successMsg", "注册成功，请登录");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}