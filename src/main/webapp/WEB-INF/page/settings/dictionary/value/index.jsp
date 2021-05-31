<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/page/common/staticFileHead.jsp" %>

    <script>
        jQuery(function ($) {
            // 让单选框和全选框的选中状态一致
            $("#selectAll").click(function () {
                $(":checkbox[name=id]").prop("checked", this.checked);
            })

            // 如果选中的checkbox和已有的checkbox数量相同将全选框的状态设置为选中
            $(":checkbox[name=id]").click(function () {
                $("#selectAll").prop("checked", $(":checkbox[name=id]").size() == $(":checkbox[name=id]:checked").size());
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
                location = "/value/delete.do?ids=" + ids;
            })

            $("#editBtn").click(function () {
                const ids = $(":checkbox[name=id]:checked").map(function () {
                    return this.value;
                }).get();
                if (ids.length !== 1) {
                    alert("必须且只能选中一项！");
                    return;
                }
                location = "/value/edit.html?id=" + ids[0];
            })
        })
    </script>
</head>
<body>

<div>
    <div style="position: relative; left: 30px; top: -10px;">
        <div class="page-header">
            <h3>字典值列表</h3>
        </div>
    </div>
</div>
<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
    <div class="btn-group" style="position: relative; top: 18%;">
        <button type="button" class="btn btn-primary"
                onclick="window.location.href='/settings/dictionary/value/save.html'"><span
                class="glyphicon glyphicon-plus"></span> 创建
        </button>
        <button type="button" id="editBtn" class="btn btn-default"><span class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button type="button" id="delBtn" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除
        </button>
    </div>
</div>
<div style="position: relative; left: 30px; top: 20px;">
    <table class="table table-hover table-striped">
        <thead>
        <tr style="color: #B3B3B3;">
            <td><input id="selectAll" type="checkbox"/></td>
            <td>序号</td>
            <td>字典值</td>
            <td>文本</td>
            <td>排序号</td>
            <td>字典类型编码</td>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${listTypeValue}" var="v" varStatus="step">
            <tr class="active">
                <td><input type="checkbox" name="id" value="${v.id}"/></td>
                <td>${step.count}</td>
                <td>${v.value}</td>
                <td>${v.text}</td>
                <td>${v.orderno}</td>
                <td>${v.typecode}</td>
            </tr>

        </c:forEach>

        </tbody>
    </table>
</div>

</body>
</html>