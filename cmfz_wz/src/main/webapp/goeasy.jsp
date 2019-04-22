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
    <script>
        var goEasy = new GoEasy({
            appkey: "BC-d0a878393c224c80a4540efc344339fa"
        });
        goEasy.subscribe({
            channel: "my_channel",
            onMessage: function (message) {
                alert("Channel:" + message.channel + " content:" + message.content);
            }
        });
    </script>
    <title>Document</title>
</head>
<body>
    Hello, world!
</body>
</html>