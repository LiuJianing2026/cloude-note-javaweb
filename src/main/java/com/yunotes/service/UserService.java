package com.yunotes.service;

import com.yunotes.entity.User;

public interface UserService {
    User login(String username, String password);
    String register(String username, String password, String confirmPassword);
    User getUserById(Long id);
    boolean updateUser(User user);
    boolean deleteUser(Long id);
}