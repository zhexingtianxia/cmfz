package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.service.AlbumService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/album")
public class AlbumController {
    @Autowired
    private AlbumService albumService;

    @ResponseBody
    @RequestMapping("/findByPage")
    public Map<String,Object> findByPage(Integer page,Integer rows){
        Map<String,Object>map = new HashMap<>();
        List<Album> albums = albumService.findByPage(page, rows);
        Integer count = albumService.count();
        map.put("rows",albums);
        //总条数
        map.put("records",count);
        //总页数
        Integer total = count%rows==0?count/rows:count/rows+1;
        map.put("total",total);
        map.put("page",page);
        return map;
    }

    @ResponseBody
    @RequestMapping("/edit")
    public void edit(MultipartFile aa, Album album, HttpServletRequest request) throws IOException {
        if(StringUtils.isEmpty(album.getId())){
            String realPath = request.getSession().getServletContext().getRealPath("/upload");
            //给创建日期属性赋值
            album.setCreateDate(new Date());
            //获取文件原始名
            String originalFilename = aa.getOriginalFilename();
            //通过原始名获取文件后缀
            String extension = FilenameUtils.getExtension(originalFilename);
            //给image属性赋值
            album.setImage(realPath+"/"+album.getName()+"."+extension);
            //给fileName属性赋值
            album.setFileName(album.getName()+"."+extension);
            aa.transferTo(new File(realPath+"/"+album.getName()+"."+extension));
            albumService.add(album);
        }else{
            albumService.update(album);
        }
    }

    @ResponseBody
    @RequestMapping("/queryById")
    public Album queryById(String id){
        Album album = albumService.queryById(id);
        return album;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public void delete(String id,HttpServletRequest request){
        Album album = albumService.queryById(id);
        String fileName = album.getFileName();
        String realPath = request.getSession().getServletContext().getRealPath("/covers");
        File file = new File(realPath + "/" + fileName);
        file.delete();
        albumService.delete(id);

    }
    @ResponseBody
    @RequestMapping("/queryAll")
    public List<Album>queryAll(){
        List<Album> all = albumService.findAll();
        return all;
    }

}
