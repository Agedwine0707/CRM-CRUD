<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/page/common/staticFileHead.jsp" %>
    <script>
        // jQuery页面加载事件
        jQuery(function ($) {
            // 表单非空验证
            $("#btnSubmit").click(function () {
                if (!$("#username").val()) {
                    alert("请输入用户名！");
                    $("#username").focus();
                    return;
                }
                if (!$("#password").val()) {
                    alert("请输入密码！");
                    $("#password").focus();
                    return;
                }
                // 请求后台查询相关用户数据
                $.ajax({
                    url: "/user/login.do",
                    type: "post",
                    data: {
                        loginAct: $("#username").val(),
                        loginPwd: $("#password").val(),
                        exemptLogin: $("#exemptCheckBox").is(':checked'),
                    },
                    // 请求成功后执行的方法
                    success: function (result) {
                        if (result.success) {
                            location = "/workbench/index.html" ;
                        }
                    }
                })
            })
            // 按键事件监听，当按下enter键触发登录
            $(document).keydown(function (event) {
                if (event.keyCode === 13) {
                    $("#btnSubmit").click();
                }
            });

        })

    </script>
</head>
<body>
<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
    <img src="/static/image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2021&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form action="/user/login" id="loginForm" class="form-horizontal" role="form">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input class="form-control" id="username" name="username" type="text" placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input class="form-control" id="password" name="password" type="password" placeholder="密码">
                </div>
                <div class="checkbox" style="position: relative;top: 30px; left: 10px;">
                    <label>
                        <input type="checkbox" id="exemptCheckBox"> 十天内免登录
                    </label>
                </div>
                <button type="button" id="btnSubmit" class="btn btn-primary btn-lg btn-block"
                        style="width: 350px; position: relative;top: 45px;">登录
                </button>
            </div>
        </form>
    </div>
</div>
</body>
</html>