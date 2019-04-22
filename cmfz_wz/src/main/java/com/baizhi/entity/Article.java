package com.baizhi.entity;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
    private String id;

    private String name;

    private String content;

    private String pic;

    private Date createDate;

    private Integer readTimes;

    private String teacherId;

}