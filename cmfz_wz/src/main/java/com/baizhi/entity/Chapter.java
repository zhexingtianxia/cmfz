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
public class Chapter {
    @Id
    private String id;

    private String name;

    private String path;

    private String size;

    private String length;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd hh.mm.ss",timezone = "GMT+8")
    private Date createDate;

    private Integer playTimes;

    private Integer downloadTimes;

    private String fileName;

    private Album album;
    private String albumId;
}