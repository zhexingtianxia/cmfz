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
    <script src="./statics/echarts/echarts.min.js"></script>
    <title>Document</title>
</head>
<body>
    <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
    <div id="main" style="width: 600px;height:400px;"></div>
    <script type="text/javascript">
        <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
        <div id="statistics_main" style="width: 600px;height: 400px;;margin-top: 30px;margin-left: 30px"></div>

            <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('statistics_main'));

        // 指定图表的配置项和数据
        var option = {
            title: {
                text: '持名法州App活跃用户'
            },
            tooltip: {},
            legend: {
                data:['用户数量']
            },
            xAxis: {
                data: []
            },
            yAxis: {},
            series: [{
                name: '数量',
                type: 'bar',
                data: []
            }]
        };

        myChart.setOption(option);


        // Map<String,Object> map = new HashMap<String,Object>();
        // map.put("intervals",new String[]{"7天","15天"});
        // map.put("counts",new int[]{5,10});'
        // return map;

        [{"intervals":["7天","15天"]},{}]



        // 异步加载统计信息
        $.post("${pageContext.request.contextPath }/statistics/activeUser",function(data){
            console.log(data);
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption({
                xAxis: {
                    data: data.intervals
                },
                series: [{
                    // 根据名字对应到相应的系列
                    name: '活跃用户',
                    data: data.counts
                }]
            });
        },"json");
    </script>
</body>
</html>