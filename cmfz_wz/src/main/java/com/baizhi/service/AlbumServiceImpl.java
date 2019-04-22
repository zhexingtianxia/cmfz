package com.baizhi.service;

import com.baizhi.conf.MyAnnotation;
import com.baizhi.dao.AlbumMapper;
import com.baizhi.entity.Album;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@Service
@Transactional
public class AlbumServiceImpl implements AlbumService {
    @Resource
    private AlbumMapper albumMapper;

    @Override
    public List<Album> findByPage(Integer pageNow, Integer pageSize) {
        //开启分页配置
        PageHelper.startPage(pageNow,pageSize);
        List<Album> albums = albumMapper.selectAll();
        PageInfo<Album> pageInfo = new PageInfo<>(albums);
        return albums;
    }

    @Override
    @MyAnnotation("专辑的添加")
    public void add(Album album) {
        album.setId(UUID.randomUUID().toString());
        albumMapper.insert(album);
    }

    @Override
    @MyAnnotation("专辑的删除")
    public void delete(String id) {
        albumMapper.delete(new Album(id,null,null,null,null,null,null,null,null,null,null));
    }

    @Override
    @MyAnnotation("专辑的更新")
    public void update(Album album) {
        albumMapper.updateByPrimaryKeySelective(album);
    }

    @Override
    public Integer count() {
        int i = albumMapper.selectCount(new Album());
        return i;
    }

    @Override
    public Album queryById(String id) {
        Album album = albumMapper.selectByPrimaryKey(new Album(id, null, null, null, null, null, null, null, null, null,null));
        return album;
    }

    @Override
    public List<Album> findAll() {
        List<Album> a = albumMapper.selectAll();
        return a;
    }
}
