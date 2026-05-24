package com.yunotes.service;

import com.yunotes.dao.UserDao;
import com.yunotes.dao.UserDaoImpl;
import com.yunotes.entity.User;

import java.sql.Timestamp;

public class UserServiceImpl implements UserService {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        return null;
    }

    @Override
    public String register(String username, String password, String confirmPassword) {
        if (username == null || username.trim().isEmpty()) {
            return "用户名不能为空";
        }
        if (password == null || password.trim().isEmpty()) {
            return "密码不能为空";
        }
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            return "确认密码不能为空";
        }
        if (!password.equals(confirmPassword)) {
            return "两次密码不一致";
        }
        User existingUser = userDao.findByUsername(username);
        if (existingUser != null) {
            return "用户名已存在";
        }
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setCreateTime(new Timestamp(System.currentTimeMillis()));
        int result = userDao.insert(newUser);
        if (result <= 0) {
            return "注册失败，请稍后重试";
        }
        return null;
    }

    @Override
    public User getUserById(Long id) {
        return null;
    }

    @Override
    public boolean updateUser(User user) {
        return false;
    }

    @Override
    public boolean deleteUser(Long id) {
        return false;
    }
}