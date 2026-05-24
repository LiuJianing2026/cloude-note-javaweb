<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yunotes.entity.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>云笔记 - 首页</title>
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
        .content {
            max-width: 800px;
            margin: 50px auto;
            text-align: center;
            background-color: white;
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .welcome {
            font-size: 28px;
            color: #333;
            margin-bottom: 20px;
        }
        .subtitle {
            color: #666;
            font-size: 16px;
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
    <div class="content">
        <div class="welcome">🎉 欢迎使用云笔记！</div>
        <div class="subtitle">你的个人知识库管理系统</div>
    </div>
</body>
</html>