package com.baizhi.entity;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Counter {
    private String id;

    private String name;

    private Integer count;

    private Date createDate;

    private Date lastUse;

    private String userId;

    private String lessonId;

}