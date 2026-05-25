<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>云笔记 - 用户注册</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/style.css">
</head>
<body class="auth-page">
    <div class="auth-card">
        <div class="auth-header">
            <h1>云笔记</h1>
            <p>创建账号，开始记录</p>
        </div>
        <% if (request.getAttribute("errorMsg") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("errorMsg") %></div>
        <% } %>
        <form action="<%= request.getContextPath() %>/register" method="post" class="auth-form">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>" placeholder="请输入用户名" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" placeholder="请输入密码" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">确认密码</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="请再次输入密码" required>
            </div>
            <button type="submit">注册</button>
        </form>
        <div class="auth-footer">
            已有账号？<a href="<%= request.getContextPath() %>/login.jsp">立即登录</a>
        </div>
    </div>
</body>
</html>