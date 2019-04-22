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
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="main" style="width: 600px;height: 400px;;margin-top: 30px;margin-left: 30px"></div>

<script type="text/javascript">
    $(function () {
        // 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        // 指定图表的配置项和数据
        // 指定图表的配置项和数据
        option = {
            title : {
                text: '持明法洲用户分布图',
                subtext: '仅供参考',
                left: 'center'
            },
            tooltip : {
                trigger: 'item'
            },
            legend: {
                orient: 'vertical',
                left: 'left',
                data:['男','女']
            },
            visualMap: {
                min: 0,
                max: 2500,
                left: 'left',
                top: 'bottom',
                text:['高','低'],           // 文本，默认为数值文本
                calculable : true
            },
            toolbox: {
                show: true,
                orient : 'vertical',
                left: 'right',
                top: 'center',
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
        };

        myChart.setOption(option);
        // 异步加载统计信息
        $.ajax({
            url: "${app}/user/findCount",
            datatype: "json",
            type: "GET",
            success: function (data) {
                myChart.setOption({
                    series : [
                        {
                            name: '男',
                            type: 'map',
                            mapType: 'china',
                            roam: false,
                            label: {
                                normal: {
                                    show: false
                                },
                                emphasis: {
                                    show: true
                                }
                            },
                            data:data.male
                        },
                        {
                            name: '女',
                            type: 'map',
                            mapType: 'china',
                            label: {
                                normal: {
                                    show: false
                                },
                                emphasis: {
                                    show: true
                                }
                            },
                            data:data.female
                        }
                    ]
                })

            }
        })

    })



</script>