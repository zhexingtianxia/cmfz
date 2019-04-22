package com.baizhi.controller;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
@RequestMapping("code")
public class CodeController {
    @Autowired
    private DefaultKaptcha defaultKaptcha;

    @RequestMapping("getImage")
    @ResponseBody
    public void getImage(HttpSession session, HttpServletResponse response) throws IOException {
        String text = defaultKaptcha.createText();
        session.setAttribute("code",text);
        BufferedImage image = defaultKaptcha.createImage(text);
        ServletOutputStream outputStream = response.getOutputStream();
        ImageIO.write(image,"png",outputStream);
    }

    @RequestMapping("checkCode")
    @ResponseBody
    public Boolean checkCode(HttpSession session, String code){
        String c = (String) session.getAttribute("code");
        if(c.equalsIgnoreCase(code)){
            return true;
        }else{
            return false;
        }
    }
}
