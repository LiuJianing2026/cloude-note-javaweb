<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户登录 - 云笔记</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 350px;
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #2196F3;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #1976D2;
        }
        .error-msg {
            color: #e74c3c;
            font-size: 14px;
            margin-bottom: 15px;
            text-align: center;
        }
        .success-msg {
            color: #27ae60;
            font-size: 14px;
            margin-bottom: 15px;
            text-align: center;
        }
        .register-link {
            text-align: center;
            margin-top: 20px;
        }
        .register-link a {
            color: #2196F3;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>用户登录</h2>
        <% if (request.getAttribute("successMsg") != null) { %>
            <div class="success-msg"><%= request.getAttribute("successMsg") %></div>
        <% } %>
        <% if (request.getAttribute("errorMsg") != null) { %>
            <div class="error-msg"><%= request.getAttribute("errorMsg") %></div>
        <% } %>
        <form action="<%=request.getContextPath()%>/login" method="post">
            <div class="form-group">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="form-group">
                <label for="password">密码</label>
                <input type="password" id="password" name="password" required>
            </div>
            <input type="submit" value="登录">
        </form>
        <div class="register-link">
            没有账号？<a href="<%=request.getContextPath()%>/register.jsp">立即注册</a>
        </div>
    </div>
</body>
</html>