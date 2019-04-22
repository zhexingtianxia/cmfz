package com.baizhi.controller;

import com.baizhi.entity.User2;
import com.baizhi.entity.User3;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("findByPage")
    public Map<String,Object>findByPage(Integer rows,Integer page){
        Map<String,Object> map=new HashMap<String, Object>();
        //总条数
        Integer total = userService.findTotal();
        map.put("records",total);
        //总页数
        Integer count=total%rows==0?total/rows:total/rows+1;
        map.put("total",count);
        map.put("page",page);
        map.put("rows",userService.findByPage(page,rows));
        return map;
    }

    @RequestMapping("change")
    public void change(String id){
        userService.update(id);
    }

    @RequestMapping("findCount")
    public Map<String,Object> findCount(){
        Map<String,Object>map = new HashMap<>();
        List<User3> count = userService.findCount();
        List<User2> male = new ArrayList<>();
        List<User2> female = new ArrayList<>();
        for (User3 user3 : count) {
            List<User2> users = user3.getUsers();
            for (User2 user : users) {
                if(user.getGender().equals("男")){
                    male.add(user);
                }else{
                    female.add(user);
                }
            }
        }
        map.put("male",male);
        map.put("female",female);
        return map;
    }

    @RequestMapping("counts")
    public Integer[] counts(){
        Integer a = userService.counts(7);
        Integer b = userService.counts(14);
        Integer c = userService.counts(30);
        Integer d = userService.counts(90);
        Integer e = userService.counts(178);
        Integer f = userService.counts(356);
        Integer[]cc={a,b,c,d,e,f};
        return cc;
    }


}
