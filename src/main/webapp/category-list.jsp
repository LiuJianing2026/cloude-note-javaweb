<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yunotes.entity.User" %>
<%@ page import="com.yunotes.entity.Category" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>分类管理 - 云笔记</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/style.css">
    <script src="<%= request.getContextPath() %>/static/js/main.js"></script>
</head>
<body class="app-layout">
    <!-- 左侧边栏 -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h1>云笔记</h1>
        </div>
        <div class="user-section">
            <div class="user-avatar">
                <% 
                    User loginUser = (User) session.getAttribute("loginUser");
                    String avatar = "U";
                    if (loginUser != null && loginUser.getUsername() != null && !loginUser.getUsername().isEmpty()) {
                        avatar = String.valueOf(Character.toUpperCase(loginUser.getUsername().charAt(0)));
                    }
                    out.print(avatar);
                %>
            </div>
            <div class="user-name">
                <% 
                    User user = (User) session.getAttribute("loginUser");
                    out.print(user != null && user.getUsername() != null ? user.getUsername() : "");
                %>
            </div>
            <div class="user-email">个人版</div>
        </div>
        <nav class="nav-section">
            <h3>导航</h3>
            <ul class="nav-list">
                <li>
                    <a href="<%= request.getContextPath() %>/note?action=list">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                            <polyline points="14 2 14 8 20 8"/>
                            <line x1="16" y1="13" x2="8" y2="13"/>
                            <line x1="16" y1="17" x2="8" y2="17"/>
                        </svg>
                        全部笔记
                    </a>
                </li>
                <li>
                    <a href="<%= request.getContextPath() %>/category?action=list" class="active">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/>
                        </svg>
                        分类管理
                    </a>
                </li>
            </ul>
            <h3>标签</h3>
            <ul class="nav-list">
                <%
                    List<Category> categories = (List<Category>) request.getAttribute("categories");
                    if (categories != null) {
                        for (Category cat : categories) {
                %>
                <li>
                    <a href="<%= request.getContextPath() %>/note?action=list&categoryId=<%= cat.getId() %>">
                        <span class="category-dot"></span>
                        <%= cat.getName() %>
                    </a>
                </li>
                <%
                        }
                    }
                %>
            </ul>
        </nav>
        <div class="sidebar-footer">
            <button class="btn-new-note" onclick="location.href='<%= request.getContextPath() %>/note?action=toAdd'">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="12" y1="5" x2="12" y2="19"/>
                    <line x1="5" y1="12" x2="19" y2="12"/>
                </svg>
                新建笔记
            </button>
            <a href="<%= request.getContextPath() %>/logout" class="logout-link">退出登录</a>
        </div>
    </aside>

    <!-- 中间笔记列表 -->
    <section class="note-list-panel">
        <div class="list-header">
            <h2>全部笔记</h2>
            <form action="<%= request.getContextPath() %>/note" method="get" class="search-box">
                <input type="hidden" name="action" value="list">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="11" cy="11" r="8"/>
                    <path d="M21 21l-4.35-4.35"/>
                </svg>
                <input type="text" name="keyword" placeholder="搜索笔记...">
            </form>
        </div>
        <div class="notes-container">
            <%
                List<com.yunotes.entity.Note> notes = (List<com.yunotes.entity.Note>) request.getAttribute("notes");
                if (notes != null && !notes.isEmpty()) {
                    for (com.yunotes.entity.Note n : notes) {
            %>
            <article class="note-card" onclick="location.href='<%= request.getContextPath() %>/note?action=detail&id=<%= n.getId() %>'">
                <h3 class="note-card-title"><%= n.getTitle() %></h3>
                <p class="note-card-preview"><%= n.getContent() != null ? n.getContent() : "" %></p>
                <div class="note-card-meta">
                    <span class="note-card-time"><%= n.getUpdateTime() != null ? n.getUpdateTime().toString().substring(0, 16) : "" %></span>
                </div>
            </article>
            <%
                    }
                }
            %>
        </div>
    </section>

    <!-- 右侧分类管理区域 -->
    <section class="editor-panel">
        <div class="category-panel">
            <div class="panel-header">
                <h1>分类管理</h1>
            </div>

            <!-- 新增分类表单 -->
            <div class="category-form">
                <form action="<%= request.getContextPath() %>/category" method="post" class="add-category-form">
                    <input type="hidden" name="action" value="add">
                    <div class="form-row">
                        <input type="text" name="name" placeholder="输入分类名称..." required>
                        <button type="submit" class="btn btn-primary">添加分类</button>
                    </div>
                </form>
            </div>

            <!-- 错误提示 -->
            <% if (request.getAttribute("errorMsg") != null) { %>
            <div class="alert alert-error"><%= request.getAttribute("errorMsg") %></div>
            <% } %>

            <!-- 分类列表 -->
            <div class="category-list">
                <%
                    if (categories != null && !categories.isEmpty()) {
                        for (Category cat : categories) {
                %>
                <div class="category-item">
                    <div class="category-color"></div>
                    <div class="category-info">
                        <span class="category-name"><%= cat.getName() %></span>
                    </div>
                    <div class="category-actions">
                        <a href="<%= request.getContextPath() %>/note?action=list&categoryId=<%= cat.getId() %>" class="action-link">查看笔记</a>
                        <a href="<%= request.getContextPath() %>/category?action=delete&id=<%= cat.getId() %>" class="action-link delete-category">删除</a>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="empty-categories">
                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                        <path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"/>
                    </svg>
                    <h3>暂无分类</h3>
                    <p>创建分类来组织你的笔记</p>
                </div>
                <% } %>
            </div>
        </div>
    </section>
</body>
</html>