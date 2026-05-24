package com.yunotes.filter;

import com.yunotes.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class LoginFilter implements Filter {

    private static final String[] ALLOWED_PATHS = {
        "/login",
        "/register",
        "/logout",
        "/index.jsp",
        "/login.jsp",
        "/register.jsp",
        "/db-test",
        "/test"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        if (isAllowed(path)) {
            chain.doFilter(request, response);
            return;
        }

        if (path.startsWith("/static/")) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loginUser") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isAllowed(String path) {
        for (String allowedPath : ALLOWED_PATHS) {
            if (path.equals(allowedPath) || path.equals(allowedPath + "/")) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void destroy() {
    }
}