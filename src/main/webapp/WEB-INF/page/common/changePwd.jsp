<%--
  Created by IntelliJ IDEA.
  User: Agedwine
  Date: 2021/5/27
  Time: 14:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<script>
    jQuery(function ($){
        $("#updatePwd").click(function (){
            const oldPwd = "${sessionScope.USER.loginpwd}";
            const oldPwd2 = md5($("#oldPwd").val());
            const newPwd = $("#newPwd").val();
            const confirmPwd = $("#confirmPwd").val();
            if (oldPwd !== oldPwd2) {
                alert("原密码错误！");
                return;
            }
            if (!newPwd) {
                alert("请输入新密码！");
                return ;
            }

            if (!confirmPwd) {
                alert("请输入确认密码！");
                return ;
            }

            if (newPwd !== confirmPwd) {
                alert("两次输入的密码不一致");
                return;
            }

            $.ajax({
                url: "/user/updatePwd",
                type: "post",
                data:{
                    confirmPwd : confirmPwd,
                    id: "${sessionScope.USER.id}"
                },
                success: function (result){
                    if (result.success){
                        alert("修改成功，请重新登录");
                    }
                    if (result.message){
                        alert(result.message);
                    }
                    // 修改密码成功后，将用户信息cookie中的信息清除并且重定向到登录
                    window.location = "/user/signOut";
                }
            })

        })
    })
</script>
