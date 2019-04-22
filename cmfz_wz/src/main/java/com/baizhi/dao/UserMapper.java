package com.baizhi.dao;

import com.baizhi.entity.User;
import com.baizhi.entity.User2;
import com.baizhi.entity.User3;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface UserMapper extends Mapper<User> {
    Integer counts(Integer end);
    List<User3>findCount();
}