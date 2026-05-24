<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yunotes.entity.User" %>
<%@ page import="com.yunotes.entity.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>云笔记 - 分类管理</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .header {
            background-color: #2196F3;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header h1 {
            margin: 0;
            font-size: 24px;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .user-info span {
            font-size: 16px;
        }
        .user-info a {
            color: white;
            text-decoration: none;
            padding: 8px 15px;
            background-color: rgba(255,255,255,0.2);
            border-radius: 4px;
        }
        .user-info a:hover {
            background-color: rgba(255,255,255,0.3);
        }
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .card {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .card-title {
            margin: 0 0 15px 0;
            font-size: 18px;
            color: #333;
        }
        .form-inline {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        .form-inline input {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        .btn-primary:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #9e9e9e;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #757575;
        }
        .error-msg {
            color: #f44336;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
        }
        .category-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .category-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px;
            border-bottom: 1px solid #eee;
        }
        .category-item:last-child {
            border-bottom: none;
        }
        .category-item:hover {
            background-color: #f9f9f9;
        }
        .category-name {
            font-size: 16px;
            color: #333;
        }
        .category-actions a {
            color: #f44336;
            text-decoration: none;
            font-size: 14px;
        }
        .category-actions a:hover {
            text-decoration: underline;
        }
        .empty-msg {
            text-align: center;
            padding: 30px;
            color: #999;
        }
        .nav-links {
            margin-bottom: 20px;
        }
        .nav-links a {
            color: #2196F3;
            text-decoration: none;
            margin-right: 15px;
        }
        .nav-links a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>云笔记</h1>
        <div class="user-info">
            <span>欢迎你，<%= ((User) session.getAttribute("loginUser")).getUsername() %></span>
            <a href="<%= request.getContextPath() %>/logout">退出登录</a>
        </div>
    </div>
    <div class="container">
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/note?action=list">返回笔记列表</a>
        </div>
        <div class="card">
            <h2 class="card-title">添加分类</h2>
            <% if (request.getAttribute("errorMsg") != null) { %>
            <div class="error-msg"><%= request.getAttribute("errorMsg") %></div>
            <% } %>
            <form action="<%= request.getContextPath() %>/category" method="post" class="form-inline">
                <input type="hidden" name="action" value="add">
                <input type="text" name="name" placeholder="请输入分类名称" required>
                <button type="submit" class="btn btn-primary">添加</button>
            </form>
        </div>
        <div class="card">
            <h2 class="card-title">我的分类</h2>
            <%
                List<Category> categories = (List<Category>) request.getAttribute("categories");
                if (categories == null || categories.isEmpty()) {
            %>
            <div class="empty-msg">暂无分类</div>
            <% } else { %>
            <ul class="category-list">
                <% for (Category category : categories) { %>
                <li class="category-item">
                    <span class="category-name"><%= category.getName() %></span>
                    <span class="category-actions">
                        <a href="<%= request.getContextPath() %>/category?action=delete&id=<%= category.getId() %>" onclick="return confirm('确定要删除该分类吗？删除后该分类下的笔记将变为未分类状态。')">删除</a>
                    </span>
                </li>
                <% } %>
            </ul>
            <% } %>
        </div>
    </div>
</body>
</html>