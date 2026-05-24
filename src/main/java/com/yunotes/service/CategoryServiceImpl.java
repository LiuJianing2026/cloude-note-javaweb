package com.yunotes.service;

import com.yunotes.dao.CategoryDao;
import com.yunotes.dao.CategoryDaoImpl;
import com.yunotes.entity.Category;

import java.util.Date;
import java.util.List;

public class CategoryServiceImpl implements CategoryService {

    private final CategoryDao categoryDao = new CategoryDaoImpl();

    @Override
    public List<Category> listCategories(Long userId) {
        return categoryDao.findByUserId(userId);
    }

    @Override
    public String addCategory(Long userId, String name) {
        if (name == null || name.trim().isEmpty()) {
            return "分类名称不能为空";
        }
        String trimmedName = name.trim();
        Category existing = categoryDao.findByName(userId, trimmedName);
        if (existing != null) {
            return "分类名称已存在";
        }
        Category category = new Category();
        category.setUserId(userId);
        category.setName(trimmedName);
        category.setCreateTime(new Date());
        int result = categoryDao.insert(category);
        if (result <= 0) {
            return "添加分类失败";
        }
        return null;
    }

    @Override
    public String deleteCategory(Long categoryId, Long userId) {
        categoryDao.clearNotesCategory(categoryId, userId);
        int result = categoryDao.delete(categoryId, userId);
        if (result <= 0) {
            return "删除分类失败或无权限";
        }
        return null;
    }
}