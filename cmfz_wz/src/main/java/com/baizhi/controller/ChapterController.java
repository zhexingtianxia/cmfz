package com.baizhi.controller;

import com.baizhi.entity.Album;
import com.baizhi.entity.Chapter;
import com.baizhi.service.AlbumService;
import com.baizhi.service.ChapterService;
import com.baizhi.util.AudioUtil;
import it.sauronsoftware.jave.EncoderException;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.*;

@RestController
@RequestMapping("chapter")
public class ChapterController {
    @Autowired
    private ChapterService chapterService;

    @Autowired
    private AlbumService albumService;

    @RequestMapping("findByPage")
    public Map<String,Object>findByPage(Integer page,Integer rows){
        Map<String, Object> map = new HashMap<>();
        //分页查询所有数据
        List<Chapter> chapters = chapterService.queryByPage(page, rows);
        map.put("rows",chapters);

        //查询总记录数
        Integer count = chapterService.count();
        map.put("records",count);

        //计算总页数
        Integer total = count%rows==0?count/rows:count/rows+1;
        map.put("total",total);

        map.put("page",page);
        return map;
    }

    @RequestMapping("insert")
    public void insert(Chapter chapter, MultipartFile aaa, HttpServletRequest request) throws IOException, EncoderException {

        if (StringUtils.isEmpty(chapter.getId())) {
            chapter.setId(UUID.randomUUID().toString());

            //设置章节名称
            String originalFilename = aaa.getOriginalFilename();
            String fileName = FilenameUtils.getName(originalFilename);
            chapter.setFileName(fileName);

            //设置文件地址
            String realPath = request.getSession().getServletContext().getRealPath("/chapters");
            chapter.setPath(realPath);


            //文件上传
            aaa.transferTo(new File(realPath+"/"+fileName));
            File f = new File(realPath+"/"+fileName);
            //用工具类获取文件时长
            long audioLength = AudioUtil.getAudioLength(f);
            String length = audioLength/60+"分"+audioLength%60+"秒";
            //设置文件时长
            chapter.setLength(length);
            //设置文件大小
            long size = aaa.getSize()/1024/1024;
            chapter.setSize(size+"MB");
            //设置创建日期
            chapter.setCreateDate(new Date());
            //设置初始播放次数
            chapter.setPlayTimes(0);
            //设置初始下载次数
            chapter.setDownloadTimes(0);
            //设置所属专辑
            String albumId = chapter.getAlbumId();
            Album album = albumService.queryById(albumId);
            chapter.setAlbum(album);
            chapter.setAlbumId(albumId);

            //更改专辑的章节数
            album.setEpisodes(album.getEpisodes()+1);
            albumService.update(album);

            chapterService.insert(chapter);
        }else{
            chapterService.update(chapter);
        }
    }
    @RequestMapping("delete")
    public void delete(String id,HttpServletRequest request){
        Chapter chapter = chapterService.queryOne(id);
        String realPath = request.getSession().getServletContext().getRealPath("/chapters");
        String fileName = chapter.getFileName();
        File file = new File(realPath+"/"+fileName);
        file.delete();
        chapterService.delete(id);
    }

    @RequestMapping("queryById")
    public Chapter queryById(String id){
        Chapter chapter = chapterService.queryOne(id);
        return chapter;
    }

    @RequestMapping("download")
    public void download(String id, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String realPath = request.getSession().getServletContext().getRealPath("/chapters");
        String fileName = chapterService.queryOne(id).getFileName();
        FileInputStream fileInputStream = new FileInputStream(new File(realPath, fileName));
        ServletOutputStream outputStream = response.getOutputStream();
        response.setHeader("content-disposition","attachment;fileName="+ URLEncoder.encode(fileName,"UTF-8"));
        IOUtils.copy(fileInputStream,outputStream);
        IOUtils.closeQuietly(fileInputStream);
        IOUtils.closeQuietly(outputStream);
    }
}
