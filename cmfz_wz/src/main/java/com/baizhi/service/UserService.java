package com.baizhi.service;

import com.baizhi.entity.User;
import com.baizhi.entity.User3;

import java.util.List;

public interface UserService {
    List<User>findByPage(Integer pageNum,Integer pageSize);
    Integer findTotal();
    User findOne(String id);
    void update(String id);
    Integer counts(Integer end);
    List<User3> findCount();
}
