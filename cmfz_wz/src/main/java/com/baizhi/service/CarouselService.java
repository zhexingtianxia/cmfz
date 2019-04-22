package com.baizhi.service;


import com.baizhi.entity.Carousel;

import java.util.List;

public interface CarouselService {
    List<Carousel> findByPage(Integer pageNow,Integer pageSize);
    void add(Carousel carousel);
    void delete(String id);
    void update(Carousel carousel);
    Integer count();
    Carousel queryById(String id);
}
