<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="/static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/static/jquery/js/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script>
		jQuery(function ($){
			// 表单非空校验
			$("#saveBtn").click(function (){
				// 编码不能为空，不能包含中文
				const code = $.trim($("#code").val());
				if (!code) {
					alert("编码不能为空！");
					return;
				}
				if (/[\u4e00-\u9fa5]/.test(code)) {
					alert("编码不能包含中文！");
					return ;
				}
				if (!$("#name").val()) {
					alert("名称不能为空");
					return;
				}
				if (!$.trim($("#describe").val())) {
					alert("描述不能为空");
					return;
				}
				// 验证当前编码是否存在
				$.ajax({
					url: "/type/exist.json?code="+code,
					success:function (result){
						if (result) {
							alert("编码已存在，请更换！");
							return;
						}
						$("form").submit();
					}
				});

			})
		})
	</script>
</head>
<body>

	<div style="position:  relative; left: 30px;">
		<h3>新增字典类型</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" id="saveBtn" class="btn btn-primary">保存</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form" action="/type/save.do">
					
		<div class="form-group">
			<label  class="col-sm-2 control-label">编码<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" name="code" class="form-control" id="code" style="width: 200%;" placeholder="编码作为主键，不能是中文">
			</div>
		</div>
		
		<div class="form-group">
			<label  class="col-sm-2 control-label">名称</label>
			<div class="col-sm-10" style="width: 300px;">
				<input name="name" type="text"  class="form-control" id="name" style="width: 200%;">
			</div>
		</div>
		
		<div class="form-group">
			<label  class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 300px;">
				<textarea name="description" class="form-control" rows="3" id="describe" style="width: 200%;"></textarea>
			</div>
		</div>
	</form>
	
	<div style="height: 200px;"></div>
</body>
</html>