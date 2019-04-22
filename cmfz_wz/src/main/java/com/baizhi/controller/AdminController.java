package com.baizhi.controller;

import com.baizhi.entity.Admin;
import com.baizhi.entity.User;
import com.baizhi.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private AdminService adminService;

    @RequestMapping("login")
    @ResponseBody
    public Map<String,Object> login(Admin admin, HttpServletRequest request){
        Map<String,Object>map = new HashMap<>();
        HttpSession session = request.getSession();
        try {
            Admin login = adminService.login(admin);
            session.setAttribute("admin",login);
            map.put("loginStatus",true);
            map.put("message","");
        } catch (Exception e) {
            map.put("loginStatus",false);
            map.put("message",e.getMessage());
        }
        return map;
    }
}
