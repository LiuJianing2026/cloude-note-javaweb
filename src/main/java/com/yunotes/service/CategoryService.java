package com.yunotes.service;

import com.yunotes.entity.Category;
import java.util.List;

public interface CategoryService {
    List<Category> listCategories(Long userId);
    String addCategory(Long userId, String name);
    String deleteCategory(Long categoryId, Long userId);
}