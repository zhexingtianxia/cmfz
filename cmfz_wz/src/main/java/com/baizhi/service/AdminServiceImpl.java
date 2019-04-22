package com.baizhi.service;

import com.baizhi.conf.MyAnnotation;
import com.baizhi.dao.AdminMapper;
import com.baizhi.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {
    @Resource
    private AdminMapper adminMapper;

    @Override
    public Admin login(Admin admin) {
        Admin login = adminMapper.selectOne(new Admin(null, admin.getUsername(), null));
        if(login==null){
            throw new RuntimeException("用户名不存在!~");
        }else{
            if(!admin.getPassword().equals(login.getPassword())){
                throw new RuntimeException("密码错误！~");
            }else{
                return admin;
            }
        }
    }

}
