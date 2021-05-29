<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="/static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>

    <script type="text/javascript" src="/static/jquery/js/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

	<script>
		jQuery(function ($) {

			$("#updateBtn").click(function () {
                if (!$.trim($(":input[name=value]").val())) {
                    alert("字典值不能为空");
                    return;
                }
                if (!$.trim($(":input[name=text]").val())) {
                    alert("文本不能为空");
                    return;
                }
                if (!/[\d]/.test($(":input[name=orderno]").val())) {
                    alert("排序号请输入一个1到9的有效数字");
                    return;
                }

				$("#updateForm").submit();
			});
		});

	</script>
</head>
<body>

<div style="position:  relative; left: 30px;">
    <h3>修改字典值</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button type="button" id="updateBtn" class="btn btn-primary">更新</button>
        <button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form class="form-horizontal" id="updateForm" action="/value/update.do" role="form">
	<input type="hidden" name="id" value="${value.id}">

    <div class="form-group">
        <label for="edit-dicTypeCode" class="col-sm-2 control-label">字典类型编码</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" name="typecode" id="edit-dicTypeCode" style="width: 200%;" value="${value.typecode}" readonly>
        </div>
    </div>

    <div class="form-group">
        <label for="edit-dicValue" class="col-sm-2 control-label">字典值<span style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" name="value" class="form-control" id="edit-dicValue" style="width: 200%;" value="${value.value}">
        </div>
    </div>

    <div class="form-group">
        <label for="edit-text" class="col-sm-2 control-label">文本</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" name="text" id="edit-text" style="width: 200%;" value="${value.text}">
        </div>
    </div>

    <div class="form-group">
        <label for="edit-orderNo" class="col-sm-2 control-label">排序号</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" name="orderno" class="form-control" id="edit-orderNo" style="width: 200%;" value="${value.orderno}">
        </div>
    </div>
</form>

<div style="height: 200px;"></div>
</body>
</html>