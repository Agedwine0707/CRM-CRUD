<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="/static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <script src="/static/jquery/jquery-form.js"></script>
    <script type="text/javascript" src="/static/jquery/js/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

    <script>
        jQuery(function ($) {

            $("#editBtn").click(function () {
                if (!$(":input[name=name]").val()) {
                    alert("名称不能为空！");
                    return;
                }
                if (!$(":input[name=description]").val()) {
                    alert("描述不能为空");
                    return;
                }

                $("#editForm").submit();
            })
        })

    </script>
</head>
<body>

<div style="position:  relative; left: 30px;">
    <h3>修改字典类型</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button type="button" id="editBtn" class="btn btn-primary">更新</button>
        <button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form class="form-horizontal" id="editForm" action="/type/edit.do" role="form">

    <div class="form-group">
        <label for="create-code" class="col-sm-2 control-label">编码<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" name="code" style="width: 200%;" placeholder="编码作为主键，不能是中文" readonly
                   value="${type.code}">
        </div>
    </div>

    <div class="form-group">
        <label for="create-name" class="col-sm-2 control-label">名称</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" name="name" style="width: 200%;" value="${type.name}">
        </div>
    </div>

    <div class="form-group">
        <label for="create-describe" class="col-sm-2 control-label">描述</label>
        <div class="col-sm-10" style="width: 300px;">
            <textarea class="form-control" rows="3" name="description"
                      style="width: 200%;">${type.description}</textarea>
        </div>
    </div>
</form>

<div style="height: 200px;"></div>
</body>
</html>