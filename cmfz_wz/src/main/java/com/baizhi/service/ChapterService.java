package com.baizhi.service;

import com.baizhi.entity.Chapter;

import java.util.List;

public interface ChapterService {
    void insert(Chapter chapter);
    void delete(String id);
    void update(Chapter chapter);
    Chapter queryOne(String id);
    List<Chapter>queryByPage(Integer pageNow,Integer pageSize);
    Integer count();
}
