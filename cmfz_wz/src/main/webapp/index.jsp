<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>持明法洲后台管理系统</title>
    <link rel="stylesheet" href="./statics/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="./statics/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <script src="./statics/boot/js/jquery-3.3.1.min.js"></script>
    <script src="./statics/boot/js/bootstrap.min.js"></script>
    <script src="./statics/jqgrid/js/trirand/jquery.jqGrid.min(1).js"></script>
    <script src="./statics/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <!-- 配置文件 -->
    <script type="text/javascript" src="./utf8-jsp/ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="./utf8-jsp/ueditor.all.js"></script>
    <script src="./statics/echarts/echarts.min.js"></script>
    <script src="./statics/echarts/china.js"></script>
    <script src="./statics/boot/js/jquery-3.3.1.min.js"></script>
    <script>

    </script>
    <style>
        .page-header{
            margin-top:0px;
        }
        .page-header h1{
            margin-top:0px;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <a class="navbar-text" href="#">持明法洲后台管理系统</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><p class="navbar-text">您好：<span style="color: #2b669a">张三</span></p></li>
            <li><a href="#" class="navbar-link">
                退出登录
                <span class="glyphicon glyphicon-share"></span></a>
            </li>
        </ul>
    </div>
</nav>
<div class="row">
<div class="col-sm-2 ">
    <!--左侧-->
    <!--创建手风琴实例-->
    <div class="panel-group" id="panelgroup">

        <!--创建面板-->
        <div class="panel panel-default ">
            <div class="panel-heading">
                <div class="panel-title">
                    <!--使用连接完成折叠效果-->
                    <a href="#pic" data-toggle="collapse" data-parent="#panelgroup" id="qqqq"><strong>轮播图模块</strong></a>
                </div>
            </div>
            <div class="panel-collapse collapse" id="pic">
                <div class="panel-body">
                    <ul class="nav nav-pills nav-stacked">
                        <li><a href="javascript:$('#centerLayout').load('carousel.jsp')">轮播图列表</a></li>
                    </ul>
                </div>

            </div>
        </div>
        <!--创建另一个面板-->
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="panel-title">
                    <!--使用连接完成折叠效果-->
                    <a href="#special" data-toggle="collapse" data-parent="#panelgroup"><strong>专辑模块</strong></a>
                </div>
            </div>
            <div class="panel-collapse collapse" id="special">
                <div class="panel-body">
                    <ul class="nav nav-pills nav-stacked">
                        <li><a href="javascript:$('#centerLayout').load('album.jsp')">专辑管理</a></li>
                        <li><a href="javascript:$('#centerLayout').load('chapter.jsp')">章节管理</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <!--创建另一个面板-->
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="panel-title">
                    <!--使用连接完成折叠效果-->
                    <a href="#doc" data-toggle="collapse" data-parent="#panelgroup"><strong>文章模块</strong></a>
                </div>
            </div>
            <div class="panel-collapse collapse" id="doc">
                <div class="panel-body">
                    <ul class="nav nav-pills nav-stacked">
                        <li><a href="">文章管理</a></li>
                        <li><a href="">上师管理</a></li>
                    </ul>
                </div>

            </div>
        </div>
        <!--创建另一个面板-->
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="panel-title">
                    <!--使用连接完成折叠效果-->
                    <a href="#user" data-toggle="collapse" data-parent="#panelgroup"><strong>用户模块</strong></a>
                </div>
            </div>

            <div class="panel-collapse collapse" id="user">
                <div class="panel-body">
                    <ul class="nav nav-pills nav-stacked">
                        <li><a href="javascript:$('#centerLayout').load('./user.jsp')">用户管理</a></li>
                        <li><a href="javascript:$('#centerLayout').load('./zhu.jsp')">用户展示</a></li>
                        <li><a href="javascript:$('#centerLayout').load('./china.jsp')">用户图表展示</a></li>
                    </ul>
                </div>

            </div>
        </div>
        <!--创建另一个面板-->
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="panel-title">
                    <!--使用连接完成折叠效果-->
                    <a href="#note" data-toggle="collapse" data-parent="#panelgroup"><strong>日志模块</strong></a>
                </div>
            </div>

            <div class="panel-collapse collapse" id="note">
                <div class="panel-body">
                    <ul class="nav nav-pills nav-stacked">
                        <li><a href="javascript:$('#centerLayout').load('./log.jsp')">日志管理</a></li>
                    </ul>
                </div>

            </div>
        </div>
    </div>
</div>
<!--右侧-->

<div class="col-sm-10" id="centerLayout">
    <!--首页介绍-->
    <div class="page-header">
        <h1>欢迎登陆持明法洲后台管理系统</h1>
    </div>

    <!--巨幕展示-->
    <div class="jumbotron">
        <img src="./img/12345.jpg" class="img-responsive" alt="Cinque Terre">
    </div>
</div>
</div>
<div class="panel-footer">
    <div class="panel-title">
        <h5 style="text-align: center">@百知教育 G1234567Q123.com</h5>
    </div>
</div>
</body>
</html>
