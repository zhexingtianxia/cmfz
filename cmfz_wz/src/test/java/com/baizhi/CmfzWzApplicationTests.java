package com.baizhi;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import com.baizhi.dao.AdminMapper;
import com.baizhi.dao.CarouselMapper;
import com.baizhi.entity.Admin;
import com.baizhi.entity.Album;
import com.baizhi.entity.Carousel;
import com.baizhi.service.AdminService;
import com.baizhi.service.AlbumService;
import com.baizhi.service.CarouselService;
import io.goeasy.GoEasy;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest()
public class CmfzWzApplicationTests {
    @Autowired
    private AdminService adminService;
    @Autowired
    private CarouselService carouselService;
    @Resource
    private CarouselMapper carouselMapper;
    @Autowired
    private AlbumService albumService;

    @Test
    public void contextLoads() {
        List<Carousel> byPage = carouselService.findByPage(1, 3);
        for (Carousel carousel : byPage) {
            System.out.println(carousel);
        }
    }
    @Test
    public void test1(){
        List<Carousel> carousels = carouselMapper.select(new Carousel());
        for (Carousel carousel : carousels) {
            System.out.println(carousel);
        }
    }
    @Test
    public void test2(){
        Admin login = adminService.login(new Admin("1","wangzhe","123456"));
        System.out.println(login);
    }

    @Test
    public void test3(){
        Carousel carousel = carouselService.queryById("4d5c59fc-369e-49b3-a80b-84ed9d8fa9c9");
        System.out.println(carousel);
    }
    @Test
    public void test4(){
        carouselMapper.updateByPrimaryKeySelective(new Carousel("2","吉娃娃",null,null,null,null,null,null));
        Carousel carousel = carouselService.queryById("2");
        System.out.println(carousel);
    }
    @Test
    public void test5(){
        albumService.update(new Album("2","小王",null,null,null,null,null,null,null,null,null));
        Album album = albumService.queryById("2");
        System.out.println(album);
    }

    @Test
    public void sendMessage() {
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAIf5XC02utmyYv", "a6uBdei5ukKn7jXcZOXWyGjXGGZMCl");
        IAcsClient client = new DefaultAcsClient(profile);

        CommonRequest request = new CommonRequest();
        //request.setProtocol(ProtocolType.HTTPS);
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("RegionId", "cn-hangzhou");
        request.putQueryParameter("PhoneNumbers", "17737297716");
        request.putQueryParameter("SignName", "小甜心");
        request.putQueryParameter("TemplateCode", "SMS_163432395");
        request.putQueryParameter("TemplateParam", "{\"code\":\"871024\"}");
        try {
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testGoeasy(){
        GoEasy goEasy = new GoEasy("http://rest-hangzhou.goeasy.io","BC-d0a878393c224c80a4540efc344339fa");
        goEasy.publish("my_channel","Hello, Goeasy");
    }

}
