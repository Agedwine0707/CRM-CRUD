<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@include file="/WEB-INF/page/common/staticFileHead.jsp" %>
    <%@include file="/WEB-INF/page/common/changePwd.jsp" %>
	<script src="/static/jquery/js/jquery.form.extend.js"></script>
	<script src="/static/jquery/js/jquery-form.js"></script>

    <script>
        jQuery(function ($) {
            function load() {
                // 页面加载时获取部门数据
                $.ajax({
                    url: "/dept/list.json",
                    dataType: 'json',
                    success: function (result) {
                        var html = "";
                        $(result).each(function () {
                            html += '<tr>'
                            html += '	<td><input name="id" value="' + this.id + '" type="checkbox" /></td>'
                            html += '	<td>' + this.no + '</td>'
                            html += '	<td>' + this.name + '</td>'
                            html += '	<td>' + this.manager + '</td>'
                            html += '	<td>' + this.phone + '</td>'
                            html += '	<td>' + this.description + '</td>'
                            html += '</tr>'
                        });
                        $("#tbody").html(html);
                    }
                })
            }

            load();

            // 让单选框和全选框的选中状态一致
            $("#selectAll").click(function () {
                $(":checkbox[name=id]").prop("checked", this.checked);
            })

            // 如果选中的checkbox和已有的checkbox数量相同将全选框的状态设置为选中
            $(":checkbox[name=id]").click(function () {
                $("#selectAll").prop("checked", $(":checkbox[name=id]").size() === $(":checkbox[name=id]").size());
            });

			// 监听表单的提交事件(此时不会提交)：提交时，以ajax的方式来提交
			$("#saveForm").ajaxForm({


				success(data) {
					// data: {success: true/false, msg: "xxx"}
					if (data.success) {
						// 关闭模态窗口
						//$("#createDeptModal").modal('hide');
						// 让当前显示状态下的窗口关闭
						$("div.modal:visible").modal('hide');
						// 重新加载页面，编辑页面表单数据缓存
						location = "/settings/dept/index.html";
					}
					if (data.msg) {
						alert(data.msg);
					}
				}
			});

			$("#saveBtn").click(function () {
				var no = $("#create-code").val();
				// 四位数字，非空
				if ( !/^\d{4}$/.test(no) ) {
					alert("编号必须是四位数字！");
					return ;
				}
				// 表单非空校验
				if (!$("#create-code").val()) {
					alert("编号不能为空！");
					return;
				}
				if (!$("#create-name").val()) {
					alert("部门名称不能为空！");
					return;
				}
				if (!$("#create-manager").val()) {
					alert("负责人不能为空！");
					return;
				}
				var phone = $("#create-phone").val();
				if (!/^1[34578]\d{9}$/.test(phone)) {
					alert("请输入正确的电话！");
					return;
				}

				// 后台校验：唯一性
				$.ajax({
					url: "/dept/" + no, // 参数作为路径的组成部分："/dept/0000"
					success: function (exists) {
						if (!exists) {
							alert("部门编号已存在！");
							return ;
						}
						$("#saveForm").submit();

					}
				});
			});

			$("#editBtn").click(function () {
				// 获取选中的部门复选框
				var $cks = $(":checkbox[name=id]:checked");
				if ($cks.size() != 1) {
					alert("必须且只能选择一项！");
					return ;
				}

				$("#editDeptModal").modal("show");
				$("#editForm").initForm("/dept/one/" + $cks.val());



			});


			// 监听表单的提交事件(此时不会提交)：提交时，以ajax的方式来提交
			$("#editForm").ajaxForm({
				type: "put",
				success: function (data) {
					// data: {success: true/false, msg: "xxx"}
					if (data.success) {
						// 关闭模态窗口
						//$("#createDeptModal").modal('hide');
						// 让当前显示状态下的窗口关闭
						$("div.modal:visible").modal('hide');
						load(); // 重新加载列表
					}
					if (data.msg) {
						alert(data.msg);
					}
				}
			});

			$("#updateBtn").click(function () {
				// 表单非空校验
				if (!$("#edit-no").val()) {
					alert("编号不能为空！");
					return;
				}
				var no = $("#edit-no").val();
				// 四位数字，非空
				if ( !/^\d{4}$/.test(no) ) {
					alert("编号必须是四位数字！");
					return ;
				}
				if (!$("#edit-name").val()) {
					alert("部门名称不能为空！");
					return;
				}
				if (!$("#edit-manager").val()) {
					alert("负责人不能为空！");
					return;
				}
				var phone = $("#create-phone").val();
				if (!/^1[34578]\d{9}$/.test(phone)) {
					alert("请输入正确的电话！");
					return;
				}




				// 表单不会真正提交，但是表单中的action、method、含有name属性的
				// 表单元素将分别作为ajax请求url、type、data
				$("#editForm").submit();
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
					url: "/dept/"+ids,
					type: "delete",
					data:{
						ids: ids
					},
					success:function (result){
						if (result) {
							alert("删除成功");
							load();
						} else {
							alert("操作失败");
							load();
						}
					}
				})
			})


        });
    </script>

</head>
<body>
<%@include file="/WEB-INF/page/common/modalBoxSettings.jsp" %>

<!-- 创建部门的模态窗口 -->
<div class="modal fade" id="createDeptModal"  role="dialog">
	<div class="modal-dialog" role="document" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title"><span class="glyphicon glyphicon-plus"></span> 新增部门</h4>
			</div>
			<div class="modal-body">
				<form id="saveForm" action="/dept" method="post" class="form-horizontal" role="form">
					<div class="form-group">
						<label for="create-code" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input name="no" type="text" class="form-control" id="create-code" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性">
						</div>
					</div>

					<div class="form-group">
						<label for="create-name" class="col-sm-2 control-label">名称</label>
						<div class="col-sm-10" style="width: 300px;">
							<input name="name" type="text" class="form-control" id="create-name" style="width: 200%;">
						</div>
					</div>

					<div class="form-group">
						<label for="create-manager" class="col-sm-2 control-label">负责人</label>
						<div class="col-sm-10" style="width: 300px;">
							<input name="manager" type="text" class="form-control" id="create-manager" style="width: 200%;">
						</div>
					</div>

					<div class="form-group">
						<label for="create-phone" class="col-sm-2 control-label">电话</label>
						<div class="col-sm-10" style="width: 300px;">
							<input name="phone" type="text" class="form-control" id="create-phone" style="width: 200%;">
						</div>
					</div>

					<div class="form-group">
						<label for="create-describe" class="col-sm-2 control-label">描述</label>
						<div class="col-sm-10" style="width: 55%;">
							<textarea name="description" class="form-control" rows="3" id="create-describe"></textarea>
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

<!-- 修改部门的模态窗口 -->
<div class="modal fade" id="editDeptModal" role="dialog">
	<div class="modal-dialog" role="document" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-edit"></span> 编辑部门</h4>
			</div>
			<div class="modal-body">

				<form id="editForm" action="/dept" method="get" class="form-horizontal" role="form">
					<%--隐藏域统一写在表单内开始处--%>
					<input type="hidden" name="id" />
					<div class="form-group">
						<label for="edit-no" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" name="no" id="edit-no" style="width: 200%;" placeholder="编号为四位数字，不能为空，具有唯一性" value="1110">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-name" class="col-sm-2 control-label">名称</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" name="name" id="edit-name" style="width: 200%;" value="财务部">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-manager" class="col-sm-2 control-label">负责人</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" name="manager" id="edit-manager" style="width: 200%;" value="张飞">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-phone" class="col-sm-2 control-label">电话</label>
						<div class="col-sm-10" style="width: 300px;">
							<input type="text" class="form-control" name="phone" id="edit-phone" style="width: 200%;" value="010-84846004">
						</div>
					</div>

					<div class="form-group">
						<label for="edit-description" class="col-sm-2 control-label">描述</label>
						<div class="col-sm-10" style="width: 55%;">
							<textarea class="form-control" rows="3" name="description" id="edit-description">description info</textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button id="updateBtn" type="button" class="btn btn-primary">更新</button>
			</div>
		</div>
	</div>
</div>

<div style="width: 95%">
	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>部门列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
			<button id="editBtn" type="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" id="delBtn" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: -10px;">
		<table class="table table-hover table-striped">
			<thead>
			<tr style="color: #B3B3B3;">
				<td><input type="checkbox" id="selectAll" /></td>
				<td>编号</td>
				<td>名称</td>
				<td>负责人</td>
				<td>电话</td>
				<td>描述</td>
			</tr>
			</thead>
			<tbody id="tbody"></tbody>
		</table>
	</div>

	<div style="height: 50px; position: relative;top: 0px; left:30px;">
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
					<li><a href="#">下一页</a></li>
					<li class="disabled"><a href="#">末页</a></li>
				</ul>
			</nav>
		</div>
	</div>

</div>

</body>

</html>