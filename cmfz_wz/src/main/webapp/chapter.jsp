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
        $("#addbtn").click(function() {
            $.ajax({
                url : "${app}/album/queryAll" ,
                type : "GET",
                dataType:"json",
                success : function(data) {
                    for (var i = 0; i < data.length; i++) {
                        var option = document.createElement("option");
                        $(option).val(data[i].id);
                        $(option).text(data[i].name);
                        $('#album').append(option);
                    }
                }
            });
            $("#myModal").modal('show');

        });

        $("#myModal").on('hide.bs.modal',function(){
            document.getElementById('editForm').reset();
            $(':input',"#editForm").removeAttr('disabled');
            $("#status").empty();
        });

        $("#chaplist").jqGrid({
            url:"${app}/chapter/findByPage",//用来加载远程数据
            datatype:"json",
            pager:"#pager",
            styleUI : 'Bootstrap',//使用bootstrap风格样式
            viewrecords:true,
            rowNum:3,
            rowList:[8,10,15,20,30],//用来指定下拉列表中每页显示条数
            toolbar:['true','top'],
            colNames:["专辑名称","章节id","章节名称","章节路径","章节大小","章节时长","章节播放数","上传时间","操作"],
            colModel:[
                {name:"album.name"},
                {name:"id",editable:true,width:100},
                {name:"name",editable:true},
                {name:"path",editable:true},
                {name:"size",editable:true},
                {name:"length",editable:true,width:100},
                {name:"playTimes",editable:true,width:100},
                {name:"createDate",editable:true},
                {name:"option",width:120,
                    formatter:function(value,options,row){
                        console.log(options);
                        console.log(row.id);
                        var content = "<a href='javascript:void(0)' onclick=\"javascript:plays('"+row.id+"')\"><span class='glyphicon glyphicon-play'></span></a>      "
                            +"<a href=\"${app}/chapter/download?id="+row.id+"\"><span class='glyphicon glyphicon-save'></span></a>      "
                            +"<a href='javascript:void(0)' onclick=\"javascript:del('"+row.id+"')\"><span class='glyphicon glyphicon-remove'></span></a>      ";
                        return content;
                    }
                }
            ],
            grouping:true,
            groupingView : {
                groupField : ['album.name'],
                groupColumnShow : [true],
                groupCollapse : true,
                groupOrder: ['desc']
            },

        }).jqGrid("navGrid","#pager",{edit:false,add:false,del:false,search:false,refresh:false});
    })
    function del(id) {
        $.post("${app}/chapter/delete",{"id":id},function (result) {

            $("#chaplist").jqGrid().trigger("reloadGrid");
        });
    }

    $("#save").click(function () {
        var formData = new FormData($("#editForm")[0]);
        $.ajax({
            type:"POST",
            url:"${app}/chapter/insert",
            data:formData,
            cache: false,
            async: false,
            processData : false,  //必须false才会避开jQuery对 formdata 的默认处理
            contentType : false,
            success: function(data) {
                $("#myModal").modal('hide');
                $("#chaplist").jqGrid().trigger("reloadGrid");
            }

        });

    })

    function plays(id){

        $("#play").empty();
        $.post("${app}/chapter/queryById",{id:id},function(result){
            $("#play").show({
                title:'歌曲播放',
                width:400,
                height:200,
                top:20,

            })
            $("#play").append("<audio id='player' controls='controls' autoplay='autoplay'><source src='${app}/chapters/"+result.fileName+"'/></audio>");
            $("#chaplist").jqGrid().trigger("reloadGrid");
        })
    }
</script>
<div id="play"></div>
<div class="page-header">
    <h1>章节管理</h1>
</div>
<ul class="nav nav-pills">
    <li class="active"><a href="#list" data-toggle="tab">章节列表</a></li>
    <li ><a href=""id="addbtn" data-toggle="modal">章节添加</a></li>
</ul>
<!--标签内容组-->
<div class="tab-content">
    <!--标签内容面板-->
    <div class="tab-pane active" id="list">
        <table id="chaplist" class="table-striped"></table>
        <!--准备分页-->
        <div id="pager" style="height: 50px;"></div>
    </div>

</div>
<!--模态框的创建-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <!--模态框标题-->
            <div class="modal-header">
                <!--
                    用来关闭模态框的属性:data-dismiss="modal"
                -->
                <button type="button" class="close" data-dismiss="modal" ><span >&times;</span></button>
                <h4 class="modal-title">编辑章节信息</h4>
            </div>

            <!--模态框内容体-->
            <div class="modal-body">

                <form action="" class="form-horizontal" id="editForm" enctype="multipart/form-data" method="post">
                    <div class="form-group">
                        <input type="hidden" class="form-control" name="id"  id="id" />
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">章节名称</label>
                        <div class="col-sm-8">
                            <input type="text" name="name" id="name" placeholder="请输入章节名称" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2">所属专辑</label>
                        <div class="col-xs-8">
                            <select name="albumId" id="album" class="form-control">
                            </select>
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-sm-2 control-label" >上传音频</label>
                        <div class="col-sm-8">
                            <input type="file" name="aaa" id="path" placeholder="请上传音频" class="form-control">
                        </div>
                    </div>
                </form>
                <embed id="ii"></embed>
            </div>

            <!--模态页脚-->
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="save" >保存</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>
            </div>

        </div>
    </div>
</div>
