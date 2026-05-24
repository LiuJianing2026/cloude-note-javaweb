<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yunotes.entity.Note" %>
<%@ page import="com.yunotes.entity.User" %>
<%
    Note note = (Note) request.getAttribute("note");
    boolean isEdit = (note != null && note.getId() != null);
    String pageTitle = isEdit ? "编辑笔记" : "新建笔记";
    String formAction = isEdit ? "update" : "add";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>云笔记 - <%= pageTitle %></title>
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
        .form-card {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .form-title {
            margin: 0 0 20px 0;
            font-size: 20px;
            color: #333;
        }
        .error-msg {
            color: #f44336;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #ffebee;
            border-radius: 4px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
        }
        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }
        .form-group textarea {
            min-height: 300px;
            resize: vertical;
            font-family: Arial, sans-serif;
        }
        .form-actions {
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 12px 24px;
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
        <div class="form-card">
            <h2 class="form-title"><%= pageTitle %></h2>
            <% if (request.getAttribute("errorMsg") != null) { %>
            <div class="error-msg"><%= request.getAttribute("errorMsg") %></div>
            <% } %>
            <form action="<%= request.getContextPath() %>/note" method="post">
                <input type="hidden" name="action" value="<%= formAction %>">
                <% if (isEdit) { %>
                <input type="hidden" name="id" value="<%= note.getId() %>">
                <% } %>
                <div class="form-group">
                    <label for="title">标题</label>
                    <input type="text" id="title" name="title" value="<%= note != null ? (note.getTitle() != null ? note.getTitle() : "") : "" %>" required>
                </div>
                <div class="form-group">
                    <label for="content">内容</label>
                    <textarea id="content" name="content"><%= note != null && note.getContent() != null ? note.getContent() : "" %></textarea>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">保存</button>
                    <a href="<%= request.getContextPath() %>/note?action=list" class="btn btn-secondary">取消</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>