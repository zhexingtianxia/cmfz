package com.baizhi.dao;

import com.baizhi.entity.Chapter;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface ChapterMapper extends Mapper<Chapter> {
    List<Chapter> queryAll();
    Chapter queryOne(String id);
}