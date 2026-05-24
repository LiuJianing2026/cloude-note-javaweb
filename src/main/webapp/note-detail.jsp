<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yunotes.entity.Note" %>
<%@ page import="com.yunotes.entity.User" %>
<%
    Note note = (Note) request.getAttribute("note");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>云笔记 - 笔记详情</title>
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
        .detail-card {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .note-title {
            margin: 0 0 20px 0;
            font-size: 24px;
            color: #333;
        }
        .note-meta {
            color: #999;
            font-size: 14px;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .note-content {
            line-height: 1.8;
            color: #333;
            white-space: pre-wrap;
            min-height: 200px;
        }
        .note-actions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
            display: flex;
            gap: 10px;
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
            background-color: #2196F3;
            color: white;
        }
        .btn-primary:hover {
            background-color: #1976D2;
        }
        .btn-danger {
            background-color: #f44336;
            color: white;
        }
        .btn-danger:hover {
            background-color: #d32f2f;
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
        <div class="detail-card">
            <h1 class="note-title"><%= note.getTitle() %></h1>
            <div class="note-meta">
                创建时间：<%= note.getCreateTime() != null ? note.getCreateTime().toString().substring(0, 19) : "" %> |
                更新时间：<%= note.getUpdateTime() != null ? note.getUpdateTime().toString().substring(0, 19) : "" %>
            </div>
            <div class="note-content"><%= note.getContent() != null ? note.getContent() : "" %></div>
            <div class="note-actions">
                <a href="<%= request.getContextPath() %>/note?action=list" class="btn btn-secondary">返回列表</a>
                <a href="<%= request.getContextPath() %>/note?action=toEdit&id=<%= note.getId() %>" class="btn btn-primary">编辑</a>
                <a href="<%= request.getContextPath() %>/note?action=delete&id=<%= note.getId() %>" class="btn btn-danger" onclick="return confirm('确定要删除这篇笔记吗？')">删除</a>
            </div>
        </div>
    </div>
</body>
</html>