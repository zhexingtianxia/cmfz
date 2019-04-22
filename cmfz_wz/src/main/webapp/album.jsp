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

    /*修改展示图片的大小*/
    function AutoResizeImage(maxWidth, maxHeight, objImg) {
        var img = new Image();
        img.src = objImg.src;
        var hRatio;
        var wRatio;
        var Ratio = 1;
        var w = img.width;
        var h = img.height;
        wRatio = maxWidth / w;
        hRatio = maxHeight / h;
        if (maxWidth == 0 && maxHeight == 0) {
            Ratio = 1;
        } else if (maxWidth == 0) { //
            if (hRatio < 1) Ratio = hRatio;
        } else if (maxHeight == 0) {
            if (wRatio < 1) Ratio = wRatio;
        } else if (wRatio < 1 || hRatio < 1) {
            Ratio = (wRatio <= hRatio ? wRatio : hRatio);
        }
        if (Ratio < 1) {
            w = w * Ratio;
            h = h * Ratio;
        }
        objImg.height = h;
        objImg.width = w;
    }

    $(function () {
        //清除弹窗原数据
        $("#myModal").on("hide.bs.modal", function () {
            //document.getElementById('editForm').reset();
            $("#editForm")[0].reset();
        });
        //给添加按钮绑定模态框显示事件
        $("#addbtn").click(function () {
            $("#editForm")[0].reset();
            $("#id").val("");
            $(':input', '#editForm').removeAttr('disabled');
            $("#myModal").modal("show");
        });
        $("#editInfo").click(function () {
            var formData = new FormData($("#editForm")[0]);//将表单数据装换为对象 使其可以传输流文件
            $.ajax({
                type: "POST",
                url: "${app}/album/edit",
                data: formData,
                /**
                 *必须false才会自动加上正确的Content-Type
                 */
                contentType: false,
                /**
                 * 必须false才会避开jQuery对 formdata 的默认处理
                 * XMLHttpRequest会对 formdata 进行正确的处理
                 */
                processData: false,
                success: function (data) {
                    $("#myModal").modal("hide");
                    $("#carouselList").jqGrid().trigger("reloadGrid");
                }
            });
        });

        $("#carouselList").jqGrid({
            url: "${app}/album/findByPage",//用来加载远程数据
            datatype: "json",
            pager: "#pager",
            styleUI: 'Bootstrap',//使用bootstrap风格样式
            viewrecords: true,
            autowidth: true,
            rowNum: 2,
            toolbar: ['true', 'top'],
            editurl: "",//编辑时的url
            colNames: ["图片id", "专辑名称", "专辑分数", "专辑作者", "专辑播音", "章节数量", "专辑描述", "专辑封面", "上传时间", "专辑状态", "操作"],
            colModel: [
                {name: "id", hidden: true},
                {name: "name", editable: true},
                {name: "rating", editable: true},
                {name: "author", editable: true},
                {name: "announcer", editable: true},
                {name: "episodes", editable: true},
                {name: "intro", editable: true},
                {name: "image", editable: true},
                {name: "createDate", editable: true},
                {name: "status", editable: true},
                {
                    name: "option",
                    formatter: function (value, options, row) {
                        console.log(options);
                        console.log(row.id);
                        var content = "<a href='javascript:void(0)' onclick=\"javascript:preview('" + row.id + "')\"><span class='glyphicon glyphicon-search'></span></a>      "
                            + "<a href='javascript:void(0)' onclick=\"javascript:edit('" + row.id + "')\"><span class='glyphicon glyphicon-pencil'></span></a>      "
                            + "<a href='javascript:void(0)' onclick=\"javascript:del('" + row.id + "')\"><span class='glyphicon glyphicon-remove'></span></a>      "
                        ;
                        return content;
                    }
                }
            ],

        }).jqGrid("navGrid", "#pager", {edit: false, add: false, del: false, search: false, refresh: false});
    })

    function edit(id) {
        if (id != null) {
            $.ajax({
                url: "${app}/album/queryById",
                type: "POST",
                data: "id=" + id,
                success: function (result) {
                    $(':input', '#editForm').removeAttr('disabled');
                    $('#editForm #aa').attr('disabled', 'disabled');
                    $("#id").val(result.id);
                    $("#name").val(result.name);
                    $("#rating").val(result.rating);
                    $("#author").val(result.author);
                    $("#announcer").val(result.announcer);
                    $("#episodes").val(result.episodes);
                    $("#container").val(result.intro);
                    $("#fileName").val(result.fileName);
                    $("#createDate").val(result.createDate);
                    $("#status").val(result.status);


                }
            });
            $("#myModal").modal("show");
        }
    }

    function del(id) {
        if (confirm("是否确认删除？") == true) {
            $.ajax({
                type: "POST",
                url: "${app}/album/delete",
                data: "id=" + id,
                success: function () {
                    alert("删除成功！~");
                    $("#carouselList").jqGrid().trigger("reloadGrid");
                }
            });
        } else {
            alert("删除失败！~");
        }

    }

    //预览图片
    function preview(id) {
        $.post("${app}/album/queryById", {id: id}, function (result) {
            console.log(result);
            $("#img").attr("src", "${app}/upload/" + result.fileName);
            $('#ac').attr('disabled', 'disabled');
            $('#bc').attr('disabled', 'disabled');
            $('#cc').attr('disabled', 'disabled');
            $('#dc').attr('disabled', 'disabled');
            $('#ec').attr('disabled', 'disabled');
            $('#co').attr('disabled', 'disabled');
            $('#gc').attr('disabled', 'disabled');
            $('#hc').attr('disabled', 'disabled');
            $('#jc').attr('disabled', 'disabled');
            $("#ac").val(result.id);
            $("#bc").val(result.name);
            $("#cc").val(result.rating);
            $("#dc").val(result.author);
            $("#ec").val(result.announcer);
            $("#gc").val(result.episodes);
            $("#hc").val(result.createDate);
            $("#jc").val(result.status);
        }, "JSON");
        $("#Modal").modal('show');
    }

</script>


<!--右侧-->
<div class="col-sm-10" id="centerLayout">
    <!--首页介绍-->
    <div class="page-header">
        <h1>专辑管理</h1>
    </div>
    <ul class="nav nav-pills">
        <li class="active"><a href="#list" data-toggle="tab">专辑列表</a></li>
        <li><a href=" " id="addbtn" data-toggle="modal">专辑添加</a></li>
    </ul>
    <!--标签内容组-->
    <div class="tab-content">
        <!--标签内容面板-->
        <div class="tab-pane active" id="list">
            <table id="carouselList" class="table-striped"></table>
            <!--准备分页-->
            <div id="pager" style="height: 50px;"></div>
        </div>
        <div class="tab-pane active" id="a"></div>
    </div>
</div>

<div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog" role="document">

        <div class="modal-content">
            <!--标题-->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
                </button>
                <h3>编辑专辑信息</h3>
            </div>
            <!--内容-->
            <div class="modal-body">
                <form class="form-horizontal" id="editForm" method="post" enctype="multipart/form-data">

                    <div class="form-group">
                        <input type="hidden" name="id" id="id"/>
                        <label class="col-sm-2 control-label">专辑名称</label>
                        <div class="col-sm-10">
                            <input type="text" name="name" id="name" placeholder="请输入名称" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">专辑分数</label>
                        <div class="col-sm-10">
                            <input type="text" name="rating" id="rating" placeholder="请输入分数" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">专辑播音</label>
                        <div class="col-sm-10">
                            <input type="text" name="announcer" id="announcer" placeholder="请输入姓名" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">专辑作者</label>
                        <div class="col-sm-10">
                            <input type="text" name="author" id="author" placeholder="请输入作者" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">专辑描述</label>
                        <div class="col-sm-10">
                            <%--<input type="text" name="intro" id="intro" placeholder="请输入描述" class="form-control">--%>
                            <!-- 加载编辑器的容器 -->
                            <script id="container" name="intro" type="text/plain">
                            </script>
                            <!-- 实例化编辑器 -->
                            <script type="text/javascript">
                                var ue = UE.getEditor('container', {
                                    toolbars: [
                                        ['source', 'undo', 'redo', 'bold']
                                    ],
                                });
                            </script>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">专辑集数</label>
                        <div class="col-sm-10">
                            <input type="text" name="episodes" id="episodes" placeholder="请输入集数" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">封面图片</label>
                        <div class="col-sm-10">
                            <input type="file" name="aa" id="aa" class="form-control">
                        </div>
                    </div>
                    <%-- <div class="form-group">
                         <label class="col-sm-2 control-label">图片路径</label>
                         <div class="col-sm-10">
                             <input type="text" name="img_path" id="img_path" placeholder="请输入路径" class="form-control">
                         </div>
                     </div>--%>

                    <%--<div class="form-group">--%>
                    <%--<label class="col-sm-2 control-label">图片描述</label>--%>
                    <%--<div class="col-sm-10">--%>
                    <%--<input type="text" name="description" id="description" placeholder="请输入图片描述"--%>
                    <%--class="form-control">--%>
                    <%--</div>--%>
                    <%--</div>--%>
                    <%--<div class="form-group">
                        <label class="col-sm-2 control-label">链接地址</label>
                        <div class="col-sm-10">
                            <input type="text" name="aa" id="aa" placeholder="请输入图片超链接地址" class="form-control">
                        </div>
                    </div>--%>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">专辑状态</label>
                        <div class="col-sm-10">
                            <select name="status" id="status" class="form-control">
                                <option>---请选择---</option>
                                <option value="正常">正常</option>
                                <option value="冻结">冻结</option>
                            </select>
                        </div>
                    </div>
            </div>
            </form>
            <!--尾部-->
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary" id="editInfo">保存</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="Modal" role="dialog">
    <div class="modal-dialog" role="document">

        <div class="modal-content">
            <!--标题-->
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span>
                </button>
                <h3>展示专辑信息</h3>
            </div>
            <!--内容-->
            <div class="modal-body">
                <div class="form-group">
                    <input type="hidden" name="id" id="ac"/>
                    <label class="col-sm-2 control-label">专辑名称</label>
                    <div class="col-sm-10">
                        <input type="text" name="name" id="bc" placeholder="请输入名称" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">专辑分数</label>
                    <div class="col-sm-10">
                        <input type="text" name="rating" id="cc" placeholder="请输入分数" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">专辑播音</label>
                    <div class="col-sm-10">
                        <input type="text" name="announcer" id="dc" placeholder="请输入姓名" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">专辑作者</label>
                    <div class="col-sm-10">
                        <input type="text" name="author" id="ec" placeholder="请输入作者" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">专辑描述</label>
                    <div class="col-sm-10" id="co">
                        <%--<input type="text" name="intro" id="fc" placeholder="请输入描述" class="form-control">--%>
                        <!-- 加载编辑器的容器 -->
                        <script id="con" name="intro" type="text/plain">
                        </script>
                            <!-- 实例化编辑器 -->
                            <script type="text/javascript">
                                var ue = UE.getEditor('con', {
                                    toolbars: [
                                        ['source', 'undo', 'redo', 'bold']
                                    ],
                                });
                            </script>

                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">专辑集数</label>
                    <div class="col-sm-10">
                        <input type="text" name="episodes" id="gc" placeholder="请输入集数" class="form-control">
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">创建时间</label>
                    <div class="col-sm-10">
                        <input type="text" name="createDate" id="hc" placeholder="创建时间" class="form-control">
                    </div>
                </div>
                <%-- <div class="form-group">
                     <label class="col-sm-2 control-label">图片路径</label>
                     <div class="col-sm-10">
                         <input type="text" name="img_path" id="img_path" placeholder="请输入路径" class="form-control">
                     </div>
                 </div>--%>

                <%--<div class="form-group">--%>
                <%--<label class="col-sm-2 control-label">图片描述</label>--%>
                <%--<div class="col-sm-10">--%>
                <%--<input type="text" name="description" id="description" placeholder="请输入图片描述"--%>
                <%--class="form-control">--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<div class="form-group">
                    <label class="col-sm-2 control-label">链接地址</label>
                    <div class="col-sm-10">
                        <input type="text" name="aa" id="aa" placeholder="请输入图片超链接地址" class="form-control">
                    </div>
                </div>--%>
                <div class="form-group">
                    <label class="col-sm-2 control-label">专辑状态</label>
                    <div class="col-sm-10">
                        <select name="status" id="jc" class="form-control">
                            <option>---请选择---</option>
                            <option value="正常">正常</option>
                            <option value="冻结">冻结</option>
                        </select>
                    </div>
                </div>
                <label class="col-sm-2 control-label">专辑封面</label>
                <img src="" id="img" border="0" width="0" height="0" onload="AutoResizeImage(0,250,this)"
                     alt="166 X 250"/>

            </div>

        </div>

    </div>
</div>
</div>