<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/page/common/staticFileHead2.jsp" %>
    <link href="/static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css "
          rel="stylesheet">
    <script src="/static/jquery/js/jquery-form.js"></script>
    <script src="/static/jquery/js/jquery.form.extend.js"></script>
    <script src="/static/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/static/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <script>
        // jQuery的页面加载事件可以多个一起触发
        jQuery(function ($) {
            // bootstrap时间插件
            $(":input[date]").datetimepicker({
                minView: "month",
                language: 'zh-CN',
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayBtn: true
            });

        })

        jQuery(function ($) {
            // 页面加载完成根据搜索框查询活动列表
            $("#searchForm").ajaxForm(function (data) {
                let html = "";
                $(data).each(function () {
                    html += `<tr>
                                <td><input name="id" value="` + this.id + `" type="checkbox" /></td>
                                <td><a style="text-decoration: none; cursor: pointer;">` + this.name + `</a></td>
                                <td>` + this.owner + `</td>
                                <td>` + this.startDate + `</td>
                                <td>` + this.endDate + `</td>
                            </tr>`
                })
                $("#dataBody").html(html);
            }).submit();


            // 单击时让单选框和全选框状态保存一致
            $("#selectAll").click(function () {
                $(":checkbox[name=id]").prop("checked", this.checked);
            });

            // 使用事件委派的方式绑定事件，解决绑定事件时，目标元素不存在的问题
            $("#dataBody").on("click", ":checkbox[name=id]", function () {
                $("#selectAll").prop("checked", $(":checkbox[name=id]").size() == $(":checkbox[name=id]:checked").size());
            });


            // 加载用户下拉框，添加活动时需要
            $.ajax({
                url: "/user/listUser.json",
                success: function (owners) {
                    $(owners).each(function () {
                        $("<option>" + this.name + "</option>").appendTo("select[name=owner]")
                    })
                }
            })


            // 添加活动表单，异步提交
            $("#saveForm").ajaxForm(function (data) {
                if (data.success) {
                    // 重置表单
                    $("#saveForm")[0].reset();
                    $("#searchForm").submit();
                }
                if (data.msg) {
                    alert(data.msg);
                }
            })
            // 单击按钮时触发提交
            $("#saveBtn").click(function () {
                $("#saveForm").submit();
            })

            // 编辑活动
            $("#editBtn").click(function () {
                // 获取选中活动的复选框
                var $cks = $(":checkbox[name=id]:checked");
                if ($cks.size() != 1) {
                    alert("必须且只能选择一项！");
                    return;
                }

                $("#editForm").initForm("/activity/getById.json?id=" + $cks.val());
                $("#editActivityModal").modal("show");

            });
            // 监听表单的提交事件(此时不会提交)：提交时，以ajax的方式来提交
            $("#editForm").ajaxForm({
                success: function (data) {
                    // data: {success: true/false, msg: "xxx"}
                    if (data.success) {
                        // 让当前显示状态下的窗口关闭
                        $("#editActivityModal").modal("hide");
                        // 重置表单
                        $("#editForm")[0].reset();
                        // 根据查询条件更新当前活动列表
                        $("#searchForm").submit();
                    }
                    if (data.msg) {
                        alert(data.msg);
                    }
                }
            });

            $("#updateBtn").click(function () {
                $("#editForm").submit();
            })


            // 删除活动
            $("#delBtn").click(function () {
                // 选中的id集合
                let ids = $(":checkbox[name=id]:checked").map(function () {
                    return this.value;
                }).get().join(",");

                if (ids.length == 0) {
                    alert("请选择删除项");
                    return;
                }
                if (!confirm("确认删除吗？")) return;

                $.ajax({
                    url: "/activity/delete.do?ids=" + ids,
                    success(result) {
                        if (result.success) {
                            $("#searchForm").submit();
                        }
                        if (result.msg) {
                            alert(result.msg);
                        }
                    }
                })
            })

            // 导出Excel活动按钮
            $("#exportExcel").click(function (){
                location = "/activity/export.do";
            })

            // 导入excel
            $("#importBtn").click(function (){
                var data = new FormData();
                // 选择的文件，是一个数组
                var files = $("#upFile").prop("files");

                data.append("upFile", files[0]);

                $.ajax({
                    url: "/activity/import.do",
                    type: "post",
                    // 禁止对上传的数据进行任何处理
                    contentType: false,processData:false,
                    data: data,
                    success:function (data) {
                        if (data.success){
                            // 让当前显示状态下的窗口关闭
                            $("#importActivityModal").modal("hide");
                            // 根据查询条件更新当前活动列表
                            $("#searchForm").submit();
                        }
                        if (data.msg) {
                            alert(data.msg);
                        }
                    }
                })
            })


        })


    </script>
</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" action="/activity/save.do" id="saveForm" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name=owner id="create-marketActivityOwner">

                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="name" class="form-control" id="create-marketActivityName">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" date name="startDate" class="form-control" autocomplete="off"
                                   id="create-startTime">
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" date name="endDate" autocomplete="off" class="form-control"
                                   id="create-endTime">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="cost" class="form-control" id="create-cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" name="description" rows="3" id="create-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="saveBtn" class="btn btn-primary" data-dismiss="modal">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" action="/activity/update.do" id="editForm" role="form">
                    <input type="hidden" name="id">

                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="owner" id="edit-marketActivityOwner">

                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="name" class="form-control" id="edit-marketActivityName"
                                   value="发传单">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="startDate" class="form-control" id="edit-startTime"
                                   value="2020-10-10">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="endDate" class="form-control" id="edit-endTime" value="2020-10-20">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="cost" class="form-control" id="edit-cost" value="5,000">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" name="description" rows="3" id="edit-describe"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateBtn" data-dismiss="modal">更新</button>
            </div>
        </div>
    </div>
</div>


<!-- 导入市场活动的模态窗口 -->
<div class="modal fade" id="importActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入市场活动</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：<small style="color: gray;">[仅支持.xls或.xlsx格式]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input type="file" id="upFile">
                </div>
                <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;">
                    <h3>重要提示</h3>
                    <ul>
                        <li>给定文件的第一行将视为字段名。</li>
                        <li>请确认您的文件大小不超过5MB。</li>
                        <li>从XLS/XLSX文件中导入全部重复记录之前都会被忽略。</li>
                        <li>复选框值应该是1或者0。</li>
                        <li>日期值必须为MM/dd/yyyy格式。任何其它格式的日期都将被忽略。</li>
                        <li>日期时间必须符合MM/dd/yyyy hh:mm:ss的格式，其它格式的日期时间将被忽略。</li>
                        <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                        <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="importBtn" class="btn btn-primary" data-dismiss="modal">导入</button>
            </div>
        </div>
    </div>
</div>

<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" id="searchForm" action="/activity/searchList.json" role="form"
                  style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" type="text">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control" autocomplete="off" type="text" date name="startDate"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control" autocomplete="off" type="text" date name="endDate">
                    </div>
                </div>

                <button type="submit" class="btn btn-default">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" id="editBtn" class="btn btn-default" data-toggle="modal"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" id="delBtn" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span>
                    删除
                </button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importActivityModal">
                    <span class="glyphicon glyphicon-import"></span> 导入
                </button>
                <button type="button" class="btn btn-default" id="exportExcel"><span class="glyphicon glyphicon-export"></span> 导出
                </button>
            </div>
        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="selectAll" type="checkbox"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="dataBody">

                </tbody>
            </table>
        </div>

        <!-- 分页控件 -->
        <div style="height: 50px; position: relative;top: 30px;">
            <div>
                <button type="button" class="btn btn-default" style="cursor: default;">共<b>50</b>条记录</button>
            </div>
            <div class="btn-group" style="position: relative;top: -34px; left: 110px;">
                <button type="button" class="btn btn-default" style="cursor: default;">显示</button>
                <div class="btn-group">
                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                        10
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">20</a></li>
                        <li><a href="#">30</a></li>
                    </ul>
                </div>
                <button type="button" class="btn btn-default" style="cursor: default;">条/页</button>
            </div>
            <div style="position: relative;top: -88px; left: 285px;">
                <nav>
                    <ul class="pagination">
                        <li class="disabled"><a href="#">首页</a></li>
                        <li class="disabled"><a href="#">上一页</a></li>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">下一页</a></li>
                        <li class="disabled"><a href="#">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>

    </div>

</div>
</body>
</html>