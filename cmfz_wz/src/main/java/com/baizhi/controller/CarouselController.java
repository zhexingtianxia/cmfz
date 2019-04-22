package com.baizhi.controller;

import com.baizhi.entity.Carousel;
import com.baizhi.service.CarouselService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.*;

@RestController
@RequestMapping("carousel")
public class CarouselController {
    @Autowired
    private CarouselService carouselService;

    @RequestMapping("findByPage")
    public Map<String,Object> findByPage(Integer page,Integer rows){
        List<Carousel> list = carouselService.findByPage(page, rows);
        Map<String,Object> map = new HashMap<>();
        //总条数
        Integer total = carouselService.count();
        map.put("records",total);
        //总页数
        Integer count = total%rows==0?total/rows:total/rows+1;
        map.put("total",count);
        map.put("page",page);
        map.put("rows",list);
        return map;
    }
    @RequestMapping("edit")
    public void edit(MultipartFile aaa, HttpServletRequest request,Carousel carousel) throws IOException {
        if(StringUtils.isEmpty(carousel.getId())){
            //给文件路径属性赋值
            String realPath = request.getSession().getServletContext().getRealPath("/covers");
            carousel.setPath(realPath);
            //给文件创建时间属性赋值
            carousel.setCreateDate(new Date());
            //获取文件后缀
            String originalFilename = aaa.getOriginalFilename();
            String extension = FilenameUtils.getExtension(originalFilename);
            //给文件名属性赋值
            carousel.setFileName(carousel.getTitle()+"."+extension);
            //给超连接属性赋值
            carousel.setHyperlink(realPath+"/"+carousel.getTitle()+"."+extension);
            //上传图片
            aaa.transferTo(new File(realPath+"/"+carousel.getTitle()+"."+extension));
            carouselService.add(carousel);
        }else{
            carouselService.update(carousel);
        }

    }

    @RequestMapping("delete")
    public void delete(String id,HttpServletRequest request){
        Carousel carousel = carouselService.queryById(id);
        System.out.println(carousel.getFileName());
        String realPath = request.getSession().getServletContext().getRealPath("/upload");
        File file = new File(realPath+"/"+carousel.getFileName());
        file.delete();
        carouselService.delete(id);
    }

    @RequestMapping("queryById")
    public Carousel queryById(String id){
        Carousel carousel = carouselService.queryById(id);
        return carousel;
    }

}
