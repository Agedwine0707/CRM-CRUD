<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>

	<%@include file="/WEB-INF/page/common/staticFileHead.jsp"%>
	<script>
		jQuery(function ($){
			$("#selectAll").click(function (){
				$(":checkbox[name=code]").prop("checked", this.checked);
			})

			$(":checkbox[name=code]").click(function (){
				// 如果选中的checkbox和已有的checkbox数量相同，将全选框的状态设置为选中
				$("#selectAll").prop("checked", $(":checkbox[name=code]").size() === $(":checkbox[name=code]:checked").size());
			})

			$("#delBtn").click(function (){
				var ids = $(":checkbox[name=code]:checked").map(function () {
					return this.value;
				}).get().join(",");

				if (!ids) {
					alert("请选择删除项！");
					return;
				}
				if (!confirm("确定删除吗？")) return;
					location = "/type/delete.do?ids=" + ids;

			})

			$("#editBtn").click(function (){
				var ids = $(":checkbox[name=code]:checked").map(function(){
					return this.value;
				}).get();
				if (ids.length !== 1) {
					alert("必须且只能选中一项！");
					$("#editBtn").blur();
					return;
				}
				location = "/type/edit.html?code=" + ids[0];
			})

		})
	</script>
</head>
<body>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典类型列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='/settings/dictionary/type/save.html'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button type="button" id="editBtn" class="btn btn-default" ><span class="glyphicon glyphicon-edit"></span> 编辑</button>
		  <button type="button" id="delBtn" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table class="table table-hover table-striped">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input id="selectAll" type="checkbox" /></td>
					<td>序号</td>
					<td>编码</td>
					<td>名称</td>
					<td>描述</td>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${requestScope.typeList}" var="t" varStatus="step">
				<tr class="active">
					<td><input type="checkbox" name="code"  value="${t.code}" /></td>
					<td>${step.count}</td>
					<td>${t.code}</td>
					<td>${t.name}</td>
					<td>${t.description}</td>
				</tr>

			</c:forEach>
			</tbody>
		</table>
	</div>
	
</body>
</html>