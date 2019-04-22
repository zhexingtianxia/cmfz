package com.baizhi.service;

import com.baizhi.conf.MyAnnotation;
import com.baizhi.dao.ChapterMapper;
import com.baizhi.entity.Chapter;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class ChapterServiceImpl implements ChapterService{
    @Resource
    private ChapterMapper chapterMapper;

    @Override
    @MyAnnotation("章节的添加")
    public void insert(Chapter chapter) {
        chapter.setId(UUID.randomUUID().toString());
        chapterMapper.insert(chapter);
    }

    @Override
    @MyAnnotation("章节的删除")
    public void delete(String id) {
        chapterMapper.delete(new Chapter(id,null,null,null,null,null,null,null,null,null,null));
    }

    @Override
    @MyAnnotation("章节的更新")
    public void update(Chapter chapter) {
        chapterMapper.updateByPrimaryKeySelective(chapter);
    }

    @Override
    public Chapter queryOne(String id) {
        Chapter chapter = chapterMapper.selectByPrimaryKey(new Chapter(id,null,null,null,null,null,null,null,null,null,null));
        return chapter;
    }

    @Override
    public List<Chapter> queryByPage(Integer pageNum, Integer pageSize) {
        //开启分页配置
        PageHelper.startPage(pageNum,pageSize);
        List<Chapter> chapters = chapterMapper.queryAll();
        PageInfo<Chapter> pageInfo = new PageInfo<>(chapters);
        return chapters;
    }

    @Override
    public Integer count() {
        Integer total = chapterMapper.selectCount(new Chapter());
        return total;
    }
}
