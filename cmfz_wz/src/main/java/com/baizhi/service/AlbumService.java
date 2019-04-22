package com.baizhi.service;

import com.baizhi.entity.Album;

import java.util.List;

public interface AlbumService {
    List<Album> findByPage(Integer pageNow, Integer pageSize);
    void add(Album album);
    void delete(String id);
    void update(Album album);
    Integer count();
    Album queryById(String id);
    List<Album>findAll();
}
