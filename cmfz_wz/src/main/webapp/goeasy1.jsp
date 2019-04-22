<%@page isELIgnored="false" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<%@include file="util/util.jsp" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!-- 引入 ECharts 文件 -->
    <script src="http://cdn-hangzhou.goeasy.io/goeasy.js"></script>
    <script src="statics/boot/js/jquery-3.3.1.min.js"></script>
    <script>
        var goEasy = new GoEasy({
            appkey: "BC-d0a878393c224c80a4540efc344339fa"
        });
        //GoEasy-OTP可以对appkey进行有效保护，详情请参考​ ​7.GoEasy-OTP

        $(function(){
            $("#sub").click(function(){
                var formData = new FormData($("#tt")[0]);
                goEasy.publish({
                    channel: "my_channel",
                    message: formData
                });
            })
        })
    </script>
    <title>Document</title>
</head>
<body>
    <form action="">
        <input type="text" name="tt" id="tt">
        <input type="submit" id="sub">
    </form>
</body>
</html>