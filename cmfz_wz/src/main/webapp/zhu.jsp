<%@page pageEncoding="UTF-8" isELIgnored="false"%>
<%@include file="util/util.jsp"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
</head>
<script src="./statics/echarts/echarts.min.js"></script>
<script src="./statics/echarts/china.js"></script>
<script src="./statics/boot/js/jquery-3.3.1.min.js"></script>
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 600px;height: 400px;;margin-top: 30px;margin-left: 30px"></div>

<script type="text/javascript">
    $(function () {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        // 指定图表的配置项和数据
        // 指定图表的配置项和数据
        option = {
            title: {
                text: '持明法洲APP活跃用户'
            },
            tooltip: {},
            legend: {
                name:'活跃用户'
            },
            xAxis: {
                data: ["7天","15天","一个月","90天","半年","一年"]
            },
            yAxis: {},

        };

        myChart.setOption(option);
        // 异步加载统计信息
        $.ajax({
            url: "${app}/user/counts",
            datatype: "json",
            type: "GET",
            success: function (data) {
                myChart.setOption({
                    series: [{
                        // 根据名字对应到相应的系列
                        name: '活跃用户',
                        type:"bar",
                        data: data
                    }]
                })

            }
        })

    })



</script>

</body>
</html>