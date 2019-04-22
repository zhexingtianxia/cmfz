package com.baizhi.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Id;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Album {
    @Id
    private String id;

    private String name;

    private Integer rating;

    private String author;

    private String announcer;

    private Integer episodes;

    private String intro;

    private String image;

    private String fileName;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createDate;

    private String status;

}