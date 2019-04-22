package com.baizhi.controller;

import com.baizhi.entity.Log;
import com.baizhi.service.LogService;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("log")
public class LogController {
    @Resource
    private LogService logService;

    @RequestMapping("findByPage")
    public Map<String,Object> findByPage(Integer page, Integer rows){
        Map<String,Object>map = new HashMap<>();
        List<Log> logs = logService.findByPage(page, rows);
        //总条数
        Integer total = logService.count();
        map.put("records",total);
        //总页数
        Integer count = total%rows==0?total/rows:total/rows+1;
        map.put("total",count);
        map.put("page",page);
        map.put("rows",logs);
        return map;
    }

}
