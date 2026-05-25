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
    <title>云笔记 - 我的笔记</title>
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
                    <a href="<%= request.getContextPath() %>/note?action=list" class="active">
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
                <input type="text" name="keyword" placeholder="搜索笔记..." value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>">
            </form>
            <div class="category-filter">
                <select name="categoryId" onchange="this.form.submit()">
                    <option value="">全部分类</option>
                    <%
                        if (categories != null) {
                            Long selectedCategoryId = (Long) request.getAttribute("categoryId");
                            for (Category cat : categories) {
                                String selected = (selectedCategoryId != null && selectedCategoryId.equals(cat.getId())) ? "selected" : "";
                    %>
                    <option value="<%= cat.getId() %>" <%= selected %>><%= cat.getName() %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
        </div>
        <div class="notes-container">
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
            <div class="empty-notes">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                    <polyline points="14 2 14 8 20 8"/>
                </svg>
                <h3>暂无笔记</h3>
                <p>点击下方按钮创建你的第一篇笔记</p>
            </div>
            <% } else { %>
                <% for (Note note : notes) { %>
                <article class="note-card" onclick="location.href='<%= request.getContextPath() %>/note?action=detail&id=<%= note.getId() %>'">
                    <h3 class="note-card-title"><%= note.getTitle() %></h3>
                    <p class="note-card-preview"><%= note.getContent() != null ? note.getContent() : "" %></p>
                    <div class="note-card-meta">
                        <span>
                            <%
                                String categoryName = "";
                                if (note.getCategoryId() != null && categoryMap.containsKey(note.getCategoryId())) {
                                    categoryName = categoryMap.get(note.getCategoryId());
                            %>
                            <span class="note-card-category"><%= categoryName %></span>
                            <%
                                }
                            %>
                        </span>
                        <span class="note-card-time"><%= note.getUpdateTime() != null ? note.getUpdateTime().toString().substring(0, 16) : "" %></span>
                    </div>
                    <div class="note-card-actions">
                        <a href="<%= request.getContextPath() %>/note?action=toEdit&id=<%= note.getId() %>">编辑</a>
                        <a href="<%= request.getContextPath() %>/note?action=delete&id=<%= note.getId() %>" class="delete-note">删除</a>
                    </div>
                </article>
                <% } %>
            <% } %>
        </div>
    </section>

    <!-- 右侧预览区域 -->
    <section class="editor-panel">
        <div class="editor-empty">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                <polyline points="14 2 14 8 20 8"/>
                <line x1="16" y1="13" x2="8" y2="13"/>
                <line x1="16" y1="17" x2="8" y2="17"/>
            </svg>
            <h3>选择一篇笔记</h3>
            <p>或新建一篇开始写作</p>
            <button class="btn-new-note" onclick="location.href='<%= request.getContextPath() %>/note?action=toAdd'">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="12" y1="5" x2="12" y2="19"/>
                    <line x1="5" y1="12" x2="19" y2="12"/>
                </svg>
                新建笔记
            </button>
        </div>
    </section>
</body>
</html>