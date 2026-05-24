
package com.yunotes.dao;

import com.yunotes.entity.User;

public interface UserDao {
    User findById(Long id);
    User findByUsername(String username);
    User findByEmail(String email);
    int insert(User user);
    int update(User user);
    int delete(Long id);
}
