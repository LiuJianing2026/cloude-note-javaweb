/**
 * 云笔记 - 全局 JavaScript
 */

/**
 * 确认删除对话框
 */
function confirmDelete(message) {
    return confirm(message || '确定要删除吗？');
}

/**
 * 监听所有删除链接
 */
document.addEventListener('DOMContentLoaded', function() {
    // 笔记删除确认
    document.querySelectorAll('.delete-note').forEach(function(link) {
        link.addEventListener('click', function(e) {
            if (!confirmDelete('确定要删除这篇笔记吗？')) {
                e.preventDefault();
            }
        });
    });

    // 分类删除确认
    document.querySelectorAll('.delete-category').forEach(function(link) {
        link.addEventListener('click', function(e) {
            if (!confirmDelete('确定要删除该分类吗？删除后该分类下的笔记将变为未分类状态。')) {
                e.preventDefault();
            }
        });
    });

    // Markdown 工具栏
    initMarkdownToolbar();
});

/**
 * 初始化 Markdown 工具栏
 */
function initMarkdownToolbar() {
    var textarea = document.getElementById('editor-content');
    if (!textarea) return;

    // 粗体按钮
    document.getElementById('btn-bold').addEventListener('click', function() {
        insertMarkdown(textarea, '**', '**', '粗体文本');
    });

    // 斜体按钮
    document.getElementById('btn-italic').addEventListener('click', function() {
        insertMarkdown(textarea, '*', '*', '斜体文本');
    });

    // H1 按钮
    document.getElementById('btn-h1').addEventListener('click', function() {
        insertMarkdown(textarea, '# ', '', '一级标题');
    });

    // H2 按钮
    document.getElementById('btn-h2').addEventListener('click', function() {
        insertMarkdown(textarea, '## ', '', '二级标题');
    });

    // 引用按钮
    document.getElementById('btn-quote').addEventListener('click', function() {
        insertMarkdown(textarea, '> ', '', '引用文本');
    });

    // 代码块按钮
    document.getElementById('btn-code').addEventListener('click', function() {
        insertMarkdown(textarea, '```\n', '\n```', '代码');
    });

    // 无序列表按钮
    document.getElementById('btn-ul').addEventListener('click', function() {
        insertMarkdown(textarea, '- ', '', '列表项');
    });

    // 有序列表按钮
    document.getElementById('btn-ol').addEventListener('click', function() {
        insertMarkdown(textarea, '1. ', '', '列表项');
    });
}

/**
 * 向文本框插入 Markdown 标记
 * @param {HTMLTextAreaElement} textarea - 目标文本框
 * @param {string} prefix - 前缀标记
 * @param {string} suffix - 后缀标记
 * @param {string} placeholder - 占位文本
 */
function insertMarkdown(textarea, prefix, suffix, placeholder) {
    var start = textarea.selectionStart;
    var end = textarea.selectionEnd;
    var selectedText = textarea.value.substring(start, end);
    var textToInsert = prefix + (selectedText || placeholder) + suffix;

    // 插入文本
    textarea.value = textarea.value.substring(0, start) + textToInsert + textarea.value.substring(end);

    // 设置光标位置
    var newCursorPos = start + textToInsert.length;
    textarea.focus();
    textarea.setSelectionRange(newCursorPos, newCursorPos);
}

/**
 * 格式化日期时间
 */
function formatDateTime(dateStr) {
    if (!dateStr) return '';
    var date = new Date(dateStr);
    var year = date.getFullYear();
    var month = String(date.getMonth() + 1).padStart(2, '0');
    var day = String(date.getDate()).padStart(2, '0');
    var hours = String(date.getHours()).padStart(2, '0');
    var minutes = String(date.getMinutes()).padStart(2, '0');
    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
}