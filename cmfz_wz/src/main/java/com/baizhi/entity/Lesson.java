package com.baizhi.entity;

import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Lesson {
    private String id;

    private String name;

    private String label;

    private Date createDate;

    private String userId;

}