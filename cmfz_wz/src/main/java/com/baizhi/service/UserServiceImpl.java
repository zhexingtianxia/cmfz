package com.baizhi.service;

import com.baizhi.conf.MyAnnotation;
import com.baizhi.dao.UserMapper;
import com.baizhi.entity.User;
import com.baizhi.entity.User3;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService{
    @Resource
    private UserMapper userMapper;

    @Override
    public List<User> findByPage(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<User> users = userMapper.selectAll();
        PageInfo<User> userPageInfo = new PageInfo<>(users);
        return users;
    }

    @Override
    public Integer findTotal() {
        return userMapper.selectCount(new User());
    }

    @Override
    public User findOne(String id) {
        return userMapper.selectByPrimaryKey(id);
    }

    @Override
    @MyAnnotation("用户状态的更新")
    public void update(String id) {
        User user = new User();
        user.setId(id);
        User one = userMapper.selectOne(user);
        if(one.getStatus().equals("正常")){
            one.setStatus("冻结");
        }else{
            one.setStatus("正常");
        }
        userMapper.updateByPrimaryKeySelective(one);
    }

    @Override
    public Integer counts(Integer end) {
        return userMapper.counts(end);
    }

    @Override
    public List<User3> findCount() {
        return userMapper.findCount();
    }
}
