package com.baizhi.service;

import com.baizhi.conf.MyAnnotation;
import com.baizhi.dao.CarouselMapper;
import com.baizhi.entity.Carousel;
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
public class CarouselServiceImpl implements CarouselService{
    @Resource
    private CarouselMapper carouselMapper;

    @Override
    public List<Carousel> findByPage(Integer pageNow,Integer pageSize) {
        PageHelper.startPage(pageNow,pageSize);//开启分页配置
        List<Carousel> carousels = carouselMapper.select(new Carousel());
        PageInfo<Carousel> pageInfo = new PageInfo<>(carousels);//pageInfo中保存了所有的分页信息
        return carousels;
    }

    @Override
    @MyAnnotation("轮播图的添加")
    public void add(Carousel carousel) {
        carousel.setId(UUID.randomUUID().toString());
        carouselMapper.insert(carousel);
    }

    @Override
    @MyAnnotation("轮播图的删除")
    public void delete(String id) {
        carouselMapper.delete(new Carousel(id,null,null,null,null,null,null,null));
    }

    @Override
    @MyAnnotation("轮播图的更新")
    public void update(Carousel carousel) {
        carouselMapper.updateByPrimaryKeySelective(carousel);
    }

    @Override
    public Integer count() {
        int i = carouselMapper.selectCount(new Carousel());
        return i;
    }

    @Override
    public Carousel queryById(String id) {
        Carousel carousel = carouselMapper.selectOne(new Carousel(id,null,null,null,null,null,null,null));
        return carousel;
    }


}
