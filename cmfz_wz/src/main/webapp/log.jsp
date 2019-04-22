<%@page isELIgnored="false" contentType="text/html; UTF-8" pageEncoding="UTF-8" %>
<%@include file="util/util.jsp" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>持明法洲后台管理系统</title>
<link rel="stylesheet" href="./statics/boot/css/bootstrap.min.css">
<link rel="stylesheet" href="./statics/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
<script src="./statics/boot/js/jquery-3.3.1.min.js"></script>
<script src="./statics/boot/js/bootstrap.min.js"></script>
<script src="./statics/jqgrid/js/trirand/jquery.jqGrid.min(1).js"></script>
<script src="./statics/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
<script>
    $(function () {
        $("#loglist").jqGrid({
            url:"${app}/log/findByPage",//用来加载远程数据
            datatype:"json",//用来指定返回数据类型
            cellEdit:false,//开启单元格编辑
            autowidth:true,//自适应父容器
            styleUI:"Bootstrap",
            pager:"#pager",//用来指定分页的工具栏
            page:1,
            rowNum:3,//用来指定每页显示条数
            toolbar:['true','top'],
            //rownumbers:true,
            // rowList:[2,4,6,8,10],//用来指定下拉列表中每页显示条数
            viewrecords:true,//是否显示总记录数
            // sortname:"age",//使用哪个列作为排序列
            editurl:"${app}/group/edit",//用来指定编辑（增删改）时的url
            colNames:["id","用户名","操作时间","操作名","状态"],//表格标题
            colModel:[
                {name:"id"},
                {name:"admin",editable:true},
                {name:"time",editable:true},
                {name:"method",editable:true},
                {name:"success",editable:true}
            ],
        }).jqGrid("navGrid","#pager", {edit: false, add: false, del: false, search: false, refresh: false});
    });
</script>

<div class="page-header">
    <h1>日志管理</h1>
</div>
<ul class="nav nav-pills">
    <li class="active"><a href="#list" data-toggle="tab">日志列表</a></li>
</ul>
<!--标签内容组-->
<div class="tab-content">
    <!--标签内容面板-->
    <div class="tab-pane active" id="list">
        <table id="loglist" class="table-striped"></table>
        <!--准备分页-->
        <div id="pager" style="height: 50px"></div>
    </div>
</div>