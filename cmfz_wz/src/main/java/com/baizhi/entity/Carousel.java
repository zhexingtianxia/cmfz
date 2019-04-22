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
public class Carousel {
    @Id
    private String id;

    private String title;

    private String path;

    private String description;

    private String status;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createDate;

    private String hyperlink;

    private String fileName;

}