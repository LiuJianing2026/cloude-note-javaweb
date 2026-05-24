<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yunotes.entity.User" %>
<%@ page import="com.yunotes.entity.Note" %>
<%@ page import="com.yunotes.entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>云笔记 - 笔记列表</title>
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
            max-width: 1000px;
            margin: 30px auto;
            padding: 0 20px;
        }
        .toolbar {
            margin-bottom: 20px;
        }
        .btn {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 14px;
        }
        .btn:hover {
            background-color: #45a049;
        }
        .btn-secondary {
            background-color: #2196F3;
        }
        .btn-secondary:hover {
            background-color: #1976D2;
        }
        .search-card {
            background-color: white;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .search-form {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .search-form input,
        .search-form select {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .search-form input[type="text"] {
            flex: 1;
        }
        .search-form select {
            min-width: 150px;
        }
        .error-msg {
            color: #f44336;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
        }
        .note-table {
            width: 100%;
            background-color: white;
            border-collapse: collapse;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }
        .note-table th, .note-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .note-table th {
            background-color: #f5f5f5;
            font-weight: bold;
            color: #333;
        }
        .note-table tr:hover {
            background-color: #f9f9f9;
        }
        .note-title {
            font-weight: bold;
            color: #2196F3;
        }
        .note-actions a {
            margin-right: 10px;
            color: #666;
            text-decoration: none;
        }
        .note-actions a:hover {
            color: #2196F3;
        }
        .category-tag {
            display: inline-block;
            padding: 3px 8px;
            background-color: #e3f2fd;
            color: #1976D2;
            border-radius: 4px;
            font-size: 12px;
        }
        .empty-msg {
            text-align: center;
            padding: 50px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            color: #999;
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
        <% if (request.getAttribute("errorMsg") != null) { %>
        <div class="error-msg"><%= request.getAttribute("errorMsg") %></div>
        <% } %>

        <div class="search-card">
            <form action="<%= request.getContextPath() %>/note" method="get" class="search-form">
                <input type="hidden" name="action" value="list">
                <input type="text" name="keyword" placeholder="搜索笔记标题或内容" value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>">
                <select name="categoryId">
                    <option value="">全部分类</option>
                    <%
                        List<Category> categories = (List<Category>) request.getAttribute("categories");
                        Long selectedCategoryId = (Long) request.getAttribute("categoryId");
                        if (categories != null) {
                            for (Category cat : categories) {
                                String selected = (selectedCategoryId != null && selectedCategoryId.equals(cat.getId())) ? "selected" : "";
                    %>
                    <option value="<%= cat.getId() %>" <%= selected %>><%= cat.getName() %></option>
                    <%
                            }
                        }
                    %>
                </select>
                <button type="submit" class="btn">查询</button>
                <a href="<%= request.getContextPath() %>/note?action=toAdd" class="btn">+ 新建笔记</a>
            </form>
        </div>

        <div style="margin-bottom: 15px;">
            <a href="<%= request.getContextPath() %>/category" class="btn btn-secondary">管理分类</a>
        </div>

        <%
            List<Note> notes = (List<Note>) request.getAttribute("notes");
            Map<Long, String> categoryMap = new HashMap<>();
            if (categories != null) {
                for (Category cat : categories) {
                    categoryMap.put(cat.getId(), cat.getName());
                }
            }

            if (notes == null || notes.isEmpty()) {
        %>
        <div class="empty-msg">
            <p>暂无笔记</p>
            <p><a href="<%= request.getContextPath() %>/note?action=toAdd" style="color: #2196F3;">点击创建第一篇笔记</a></p>
        </div>
        <% } else { %>
        <table class="note-table">
            <thead>
                <tr>
                    <th>标题</th>
                    <th>分类</th>
                    <th>更新时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <% for (Note note : notes) { %>
                <tr>
                    <td class="note-title"><%= note.getTitle() %></td>
                    <td>
                        <%
                            String categoryName = "未分类";
                            if (note.getCategoryId() != null && categoryMap.containsKey(note.getCategoryId())) {
                                categoryName = categoryMap.get(note.getCategoryId());
                            }
                        %>
                        <span class="category-tag"><%= categoryName %></span>
                    </td>
                    <td><%= note.getUpdateTime() != null ? note.getUpdateTime().toString().substring(0, 19) : "" %></td>
                    <td class="note-actions">
                        <a href="<%= request.getContextPath() %>/note?action=detail&id=<%= note.getId() %>">查看</a>
                        <a href="<%= request.getContextPath() %>/note?action=toEdit&id=<%= note.getId() %>">编辑</a>
                        <a href="<%= request.getContextPath() %>/note?action=delete&id=<%= note.getId() %>" onclick="return confirm('确定要删除这篇笔记吗？')">删除</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</body>
</html>