package com.yunotes.dao;

import com.yunotes.entity.Category;
import java.util.List;

public interface CategoryDao {
    List<Category> findByUserId(Long userId);
    Category findByName(Long userId, String name);
    int insert(Category category);
    int delete(Long id, Long userId);
    int clearNotesCategory(Long categoryId, Long userId);
}