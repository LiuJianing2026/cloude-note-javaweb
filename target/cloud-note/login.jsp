<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>云笔记 - 用户登录</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/style.css">
</head>
<body class="auth-page">
    <div class="auth-card">
        <div class="auth-header">
            <h1>云笔记</h1>
            <p>个人知识库管理</p>
        </div>
        <% if (request.getAttribute("successMsg") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("successMsg") %></div>
        <% } %>
        <% if (request.getAttribute("errorMsg") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("errorMsg") %></div>
        <% } %>
        <form action="<%= request.getContextPath() %>/login" method="post" class="auth-form">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" placeholder="请输入用户名" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" placeholder="请输入密码" required>
            </div>
            <button type="submit">登录</button>
        </form>
        <div class="auth-footer">
            没有账号？<a href="<%= request.getContextPath() %>/register.jsp">立即注册</a>
        </div>
    </div>
</body>
</html>