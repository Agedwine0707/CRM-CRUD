<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/page/common/staticFileHead.jsp" %>
    <link href="/static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css "
          rel="stylesheet">
    <script src="/static/jquery/js/jquery-form.js"></script>
    <script src="/static/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/static/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>


    <script>
        jQuery(function ($) {
            // 页面初始化时加载用户数据
            function load() {
                $.ajax({
                    url: "/user/listUser.json",
                    dataType: "json",
                    success: function (data) {
                        let html = "";
                        $(data).each(function (index) {
                            html += '<tr class="active">';
                            html += '<td><input type="checkbox" name="id" value="'+this.id+'" /></td>';
                            html += '<td>' + (index+1) + '</td>';
                            html += '<td><a  href="detail.html">' + this.loginact + '</a></td>';
                            html += '<td>' + this.name + ' </td>';
                            html += '<td>' + this.deptid + ' </td>';
                            html += '<td>' + this.email + ' </td>';
                            html += '<td>' + this.expireTime + '     </td>';
                            html += '<td>' + this.allowips + ' </td>';
                            html += '<td><a href="#" style="text-decoration: none;">' + this.lockstatus+ '</a></td>';
                            html += '<td>admin</td>';
                            html += '<td>' + this.createtime + '</td>';
                            html += '<td>admin</td>';
                            html += '<td>' + this.edittime + '</td>';
                            html += '</tr>';

                        });
                        $("#tbody").html(html);
                    }
                })
            }

            load();

            // 加载部门信息
            $.ajax({
                url: "/dept/list.json",
                success: function (data) {
                    $(data).each(function () {
                        $("<option>", {
                            value: this.id,
                            text: this.name
                        }).appendTo("#create-dept");
                    });
                }
            });
            // 选择时间控件
            $(":input[datetime]").datetimepicker({
                language: "zh-CN",
                format: "yyyy-mm-dd hh:ii:ss",//显示格式
                minView: "hour", //设置只显示到月份
                autoclose: true, //选中自动关闭
                todayBtn: true, //显示今日按钮
                clearBtn: true,
                pickerPosition: "bottom-right"
            });

            // 表单提交时以ajax的方式提交
            $("#addForm").ajaxForm(function (data) {
                if (data.success) {
                    $("#createUserModal").hide();
                    // 表单的重置功能必须调用原生DOM对象的方法来完成
                    $("#addForm")[0].reset();
                    load();
                }
                if (data.msg) {
                    alert(data.msg);
                }
            });


            $("#saveBtn").click(function () {
                // 账号验证：非空、不能重复
                var act = $.trim($("#create-loginActNo").val());
                if (!act) {
                    alert("请填写账号！");
                    return;
                }

                $.ajax({
                    url: "/user/getExists.json?act=" + act,
                    success(exists) {
                        if (!exists) {
                            alert("该工号已存在！");
                            return;
                        }

                        // 验证密码
                        var pwd = $("#create-loginPwd").val();
                        if (!pwd) {
                            alert("请输入密码！");
                            return;
                        }

                        var repwd = $("#create-confirmPwd").val();
                        if (!repwd) {
                            alert("请输入确认密码！");
                            return;
                        }

                        if (pwd != repwd) {
                            alert("两次输入不一致！");
                            $("#create-loginPwd,#create-confirmPwd").val("");
                            return;
                        }

                        if (!$("#create-dept").val()) {
                            alert("请选择部门！");
                            return;
                        }

                        $("#addForm").submit();
                    }
                });
            })



            // 让单选框和全选框的选中状态一致
            $("#selectAll").click(function () {
                $(":checkbox[name=id]").prop("checked", this.checked);
            })

            // 如果选中的checkbox和已有的checkbox数量相同将全选框的状态设置为选中
            $(":checkbox[name=id]").click(function () {
                $("#selectAll").prop("checked", $(":checkbox[name=id]").size() === $(":checkbox[name=id]").size());
            });

            $("#delBtn").click(function () {
                var ids = $(":checkbox[name=id]:checked").map(function () {
                    return this.value;
                }).get().join(",");

                if (!ids) {
                    alert("请选选中删除项！");
                    return;
                }
                if (!confirm("确认删除吗？")) return;
                 $.ajax({
                     url : "/user/delete.do?ids=" + ids,
                     success:function (result){
                         if (result.success){
                             alert("删除成功");
                         }
                         load();
                     }
                 })

            })

        })
    </script>
</head>
<body>

<!-- 创建用户的模态窗口 -->
<div class="modal fade" id="createUserModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">新增用户</h4>
            </div>
            <div class="modal-body">

                <form id="addForm" action="/user/save.do" method="post" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-loginActNo" class="col-sm-2 control-label">登录帐号<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="loginAct" type="text" class="form-control" id="create-loginActNo">
                        </div>
                        <label for="create-username" class="col-sm-2 control-label">用户姓名</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="name" type="text" class="form-control" id="create-username">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-loginPwd" class="col-sm-2 control-label">登录密码<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="loginpwd" type="password" class="form-control" id="create-loginPwd">
                        </div>
                        <label for="create-confirmPwd" class="col-sm-2 control-label">确认密码<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="password" class="form-control" id="create-confirmPwd">
                        </div>
                    </div>
                    <%--token令牌--%>
                    <div class="form-group">
                        <label for="create-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="email" type="text" class="form-control" id="create-email">
                        </div>
                        <label for="create-expireTime" class="col-sm-2 control-label">失效时间</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="expiretime" datetime type="text" class="form-control" id="create-expireTime">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-lockStatus" class="col-sm-2 control-label">锁定状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select name="lockstatus" class="form-control" id="create-lockStatus">
                                <option></option>
                                <option value="1">启用</option>
                                <option value="0">锁定</option>
                            </select>
                        </div>
                        <label for="create-org" class="col-sm-2 control-label">部门<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select name="deptid" class="form-control" id="create-dept">
                                <option></option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input name="allowips" type="text" class="form-control" id="create-allowIps"
                                   style="width: 280%" placeholder="多个用逗号隔开">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="saveBtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 30px; top: -10px;">
        <div class="page-header">
            <h3>用户列表</h3>
        </div>
    </div>
</div>

<div class="btn-toolbar" role="toolbar" style="position: relative; height: 80px; left: 30px; top: -10px;">
    <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">用户姓名</div>
                <input class="form-control" type="text">
            </div>
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">部门名称</div>
                <input class="form-control" type="text">
            </div>
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">锁定状态</div>
                <select class="form-control">
                    <option></option>
                    <option>锁定</option>
                    <option>启用</option>
                </select>
            </div>
        </div>
        <br><br>

        <div class="form-group">
            <div class="input-group">
                <div class="input-group-addon">失效时间</div>
                <input class="form-control" type="text" id="startTime"/>
            </div>
        </div>

        ~

        <div class="form-group">
            <div class="input-group">
                <input class="form-control" type="text" id="endTime"/>
            </div>
        </div>

        <button type="submit" class="btn btn-default">查询</button>

    </form>
</div>


<div class="btn-toolbar" role="toolbar"
     style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; width: 110%; top: 20px;">
    <div class="btn-group" style="position: relative; top: 18%;">
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createUserModal"><span
                class="glyphicon glyphicon-plus"></span> 创建
        </button>
        <button type="button" id="delBtn" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
    </div>
    <div class="btn-group" style="position: relative; top: 18%; left: 5px;">
        <button type="button" class="btn btn-default">设置显示字段</button>
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
            <span class="caret"></span>
            <span class="sr-only">Toggle Dropdown</span>
        </button>
        <ul id="definedColumns" class="dropdown-menu" role="menu">
            <li><a href="javascript:void(0);"><input type="checkbox"/> 登录帐号</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 用户姓名</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 部门名称</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 邮箱</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 失效时间</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 允许访问IP</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 锁定状态</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 创建者</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 创建时间</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 修改者</a></li>
            <li><a href="javascript:void(0);"><input type="checkbox"/> 修改时间</a></li>
        </ul>
    </div>
</div>

<div style="position: relative; left: 30px; top: 40px; width: 110%">
    <table class="table table-hover">
        <thead>
        <tr style="color: #B3B3B3;">
            <td><input id="selectAll" type="checkbox"/></td>
            <td>序号</td>
            <td>登录帐号</td>
            <td>用户姓名</td>
            <td>部门名称</td>
            <td>邮箱</td>
            <td>失效时间</td>
            <td>允许访问IP</td>
            <td>锁定状态</td>
            <td>创建者</td>
            <td>创建时间</td>
            <td>修改者</td>
            <td>修改时间</td>
        </tr>
        </thead>
        <tbody id="tbody">

        </tbody>
    </table>
</div>

<div style="height: 50px; position: relative;top: 30px; left: 30px;">
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

</body>
</html>