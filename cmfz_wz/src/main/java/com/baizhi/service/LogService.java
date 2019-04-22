package com.baizhi.service;

import com.baizhi.entity.Log;

import java.util.List;

public interface LogService {
    List<Log> findByPage(Integer pageNum, Integer pageSize);
    Integer count();
}
