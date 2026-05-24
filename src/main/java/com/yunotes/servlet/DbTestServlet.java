package com.yunotes.servlet;

import com.yunotes.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

public class DbTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DbTestServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<meta charset=\"UTF-8\">");
        out.println("<title>数据库连接测试</title>");
        out.println("<style>");
        out.println("body { font-family: Arial, sans-serif; text-align: center; margin-top: 100px; background-color: #f5f5f5; }");
        out.println(".container { padding: 40px; background-color: white; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); display: inline-block; }");
        out.println(".success { color: #4CAF50; font-size: 24px; }");
        out.println(".error { color: #f44336; font-size: 16px; }");
        out.println("pre { text-align: left; background-color: #f8f9fa; padding: 15px; border-radius: 5px; max-width: 600px; margin: 20px auto; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<div class=\"container\">");
        
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            out.println("<h1 class=\"success\">数据库连接成功</h1>");
            out.println("<p>恭喜！JDBC 连接 MySQL 数据库成功</p>");
        } catch (SQLException e) {
            out.println("<h1 class=\"success\" style=\"color: #f44336;\">数据库连接失败</h1>");
            out.println("<p>请检查数据库配置和连接信息</p>");
            out.println("<pre class=\"error\">");
            out.println("异常信息: " + e.getMessage());
            out.println("</pre>");
        } finally {
            DBUtil.closeConnection(conn);
        }
        
        out.println("<p><a href=\"index.jsp\">返回首页</a></p>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");
        out.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}