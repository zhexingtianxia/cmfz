package com.baizhi.conf;

import com.baizhi.dao.LogMapper;
import com.baizhi.entity.Admin;
import com.baizhi.entity.Log;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Aspect
@Component
public class MyAspect {
    @Resource
    private LogMapper logMapper;

    @Pointcut("@annotation(myAnnotation)")
    public void pointcut(MyAnnotation myAnnotation){}

    @Around("pointcut(myAnnotation)")
    public Object around(ProceedingJoinPoint proceedingJoinPoint,MyAnnotation myAnnotation){
        Log log =  new Log();
        log.setId(UUID.randomUUID().toString());
        // 什么人
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        if(admin!=null){
            log.setAdmin(admin.getUsername());
        }else{
            log.setAdmin("");
        }

        // 什么时间
        Date date = new Date();
        log.setTime(date);
        // 什么操作
//        String methodName = proceedingJoinPoint.getSignature().getName();
        String method = myAnnotation.value();
        log.setMethod(method);


        HSSFWorkbook workbook = new HSSFWorkbook();

        // 获取表  参数：表名
        Sheet sheet = workbook.createSheet("user");
        // 设置时间格式
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        // 获取行  参数：下标
        String[] columns = {"id","admin","time","method","success"};
        Row row = sheet.createRow(0);
        for(int i=0;i<columns.length;i++){
            Cell cell = row.createCell(i);
            cell.setCellValue(columns[i]);
        }
        List<Log> logs = logMapper.selectAll();
        for(int i=0;i<logs.size();i++){
            Row logrow = sheet.createRow(i+1);
            logrow.createCell(0).setCellValue(logs.get(i).getId());
            logrow.createCell(1).setCellValue(logs.get(i).getAdmin());
            logrow.createCell(2).setCellValue(logs.get(i).getTime());

            // 首先对事件格式化  再进行设置
            String fo = sdf.format(logs.get(i).getTime());
            logrow.createCell(2).setCellValue(fo);

            logrow.createCell(3).setCellValue(logs.get(i).getMethod());
            logrow.createCell(4).setCellValue(logs.get(i).getSuccess());
        }

        try {
            Object proceed = proceedingJoinPoint.proceed();
            // 成功标记
            log.setSuccess(1);
            // 记录日志
            logMapper.insert(log);
            workbook.write(new File("F:/final_project/logs.xls"));
            return proceed;
        } catch (Throwable throwable) {
            throwable.printStackTrace();
            // 失败标记
            log.setSuccess(0);
            // 记录日志
            logMapper.insert(log);
            return null;
        }
    }
}
