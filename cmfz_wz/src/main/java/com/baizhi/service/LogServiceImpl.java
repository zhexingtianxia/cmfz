package com.baizhi.service;

import com.baizhi.dao.LogMapper;
import com.baizhi.entity.Log;
import com.baizhi.entity.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class LogServiceImpl implements LogService{
    @Resource
    private LogMapper logMapper;

    @Override
    public List<Log> findByPage(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Log> logs = logMapper.selectAll();
        PageInfo<Log> logPageInfo = new PageInfo<>(logs);
        return logs;
    }

    @Override
    public Integer count() {
        return logMapper.selectCount(new Log());
    }
}
