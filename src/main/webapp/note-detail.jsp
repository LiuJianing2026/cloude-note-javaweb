<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.yunotes.entity.Note" %>
<%@ page import="com.yunotes.entity.User" %>
<%@ page import="com.yunotes.entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%
    Note note = (Note) request.getAttribute("note");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    Map<Long, String> categoryMap = new HashMap<>();
    if (categories != null) {
        for (Category cat : categories) {
            categoryMap.put(cat.getId(), cat.getName());
        }
    }
    String categoryName = "未分类";
    if (note.getCategoryId() != null && categoryMap.containsKey(note.getCategoryId())) {
        categoryName = categoryMap.get(note.getCategoryId());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= note.getTitle() %> - 云笔记</title>
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
                    <a href="<%= request.getContextPath() %>/category?action=list">
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
                List<Note> notes = (List<Note>) request.getAttribute("notes");
                if (notes != null && !notes.isEmpty()) {
                    for (Note n : notes) {
            %>
            <article class="note-card <%= n.getId().equals(note.getId()) ? "selected" : "" %>" onclick="location.href='<%= request.getContextPath() %>/note?action=detail&id=<%= n.getId() %>'">
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

    <!-- 右侧阅读区域 -->
    <section class="editor-panel">
        <div class="document-reader">
            <!-- 标题 -->
            <h1 class="reader-title"><%= note.getTitle() %></h1>

            <!-- 元信息 -->
            <div class="reader-meta">
                <span class="reader-category"><%= categoryName %></span>
                <span>创建于 <%= note.getCreateTime() != null ? note.getCreateTime().toString().substring(0, 16) : "" %></span>
                <span>更新于 <%= note.getUpdateTime() != null ? note.getUpdateTime().toString().substring(0, 16) : "" %></span>
            </div>

            <!-- 内容 -->
            <div class="reader-content">
                <%= note.getContent() != null ? note.getContent() : "" %>
            </div>

            <!-- 操作按钮 -->
            <div class="reader-actions">
                <a href="<%= request.getContextPath() %>/note?action=list" class="btn btn-secondary">返回列表</a>
                <a href="<%= request.getContextPath() %>/note?action=toEdit&id=<%= note.getId() %>" class="btn btn-primary">编辑笔记</a>
                <a href="<%= request.getContextPath() %>/note?action=delete&id=<%= note.getId() %>" class="btn btn-danger delete-note">删除笔记</a>
            </div>
        </div>
    </section>
</body>
</html>