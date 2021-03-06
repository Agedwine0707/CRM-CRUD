<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="/static/jquery/zTree_v3-master/css/zTreeStyle/zTreeStyle.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/static/jquery/js/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/static/jquery/zTree_v3-master/js/jquery.ztree.all.min.js"></script>
<script type="text/javascript">

	var setting = {
		edit: {
			enable : true,
			showRenameBtn : false,
			showRemoveBtn : true
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};

	var zNodes =[
		{ id:0, name:"某公司" , open : true},
		{ id:1, pId:0, name:"品牌部"},
		{ id:2, pId:0, name:"财务部"},
		{ id:3, pId:0, name:"人事部"},
		{ id:4, pId:0, name:"传媒部"},
		{ id:5, pId:0, name:"市场部"}
	];
	
	$(document).ready(function(){
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	});
</script>
	<%@include file="/WEB-INF/page/common/changePwd.jsp"%>

</head>
<body>

<%@include file="/WEB-INF/page/common/modalBoxSettings.jsp"%>
	
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">
	
		<!-- 新增机构模态窗口 -->
		<div class="modal fade" id="createOrgModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 80%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">新增机构</h4>
					</div>
					<div class="modal-body">
					
						<form class="form-horizontal" role="form">
						
							<div class="form-group">
								<label for="create-orgCode" class="col-sm-2 control-label">机构代码<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-orgCode" style="width: 200%;">
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-orgName" class="col-sm-2 control-label">机构名称<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-orgName" style="width: 200%;">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-marketActivityOwner" class="col-sm-2 control-label">机构类型<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 570px;">
									<select class="form-control" id="edit-marketActivityOwner">
									  <option></option>
									  <option>一级部门</option>
									  <option>二级部门</option>
									  <option>三级部门</option>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-orderNo" class="col-sm-2 control-label">负责人</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-orderNo" style="width: 200%;">
								</div>
							</div>
							
							<div class="form-group">
								<label for="create-orgDescribe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 570px;">
									<textarea class="form-control" rows="3" id="create-orgDescribe"></textarea>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
					</div>
				</div>
			</div>
		</div>
	
		<!-- 修改机构模态窗口 -->
		<div class="modal fade" id="editOrgModal" role="dialog">
			<div class="modal-dialog" role="document" style="width: 80%;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改机构</h4>
					</div>
					<div class="modal-body">
					
						<form class="form-horizontal" role="form">
						
							<div class="form-group">
								<label for="edit-orgCode" class="col-sm-2 control-label">机构代码<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-orgCode" style="width: 200%;" value="1005">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-orgName" class="col-sm-2 control-label">机构名称<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-orgName" style="width: 200%;" value="市场部">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-marketActivityOwner" class="col-sm-2 control-label">机构类型<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 570px;">
									<select class="form-control" id="edit-marketActivityOwner">
									  <option></option>
									  <option>一级部门</option>
									  <option selected>二级部门</option>
									  <option>三级部门</option>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-orderNo" class="col-sm-2 control-label">负责人</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-orderNo" style="width: 200%;" value="张三">
								</div>
							</div>
							
							<div class="form-group">
								<label for="edit-orgDescribe" class="col-sm-2 control-label">描述</label>
								<div class="col-sm-10" style="width: 570px;">
									<textarea class="form-control" rows="3" id="create-orgDescribe">市场活动Marketing，是指品牌主办或参与的展览会议与公关市场活动，包括自行主办的各类研讨会、客户交流会、演示会、新产品发布会、体验会、答谢会、年会和出席参加并布展或演讲的展览会、研讨会、行业交流会、颁奖典礼等</textarea>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
					</div>
				</div>
			</div>
		</div>
		
		<div style="width: 20%; height: 100%; background-color: #F7F7F7; position: absolute; overflow:auto;">
			<ul id="treeDemo" class="ztree" style="position: relative; top: 15px; left: 15px;"></ul>
		</div>
		<div style="position: absolute; width: 80%; height: 100%; overflow: auto; left: 20%;">
			<!-- 大标题 -->
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>市场部 <small> 机构明细 </small></h3>
				</div>
				<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 60%;">
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createOrgModal"><span class="glyphicon glyphicon-plus"></span> 新增</button>
					<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editOrgModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
				</div>
			</div>
			<!-- 详细信息 -->
			<div style="position: relative; top: -70px;">
				<div style="position: relative; left: 40px; height: 30px; top: 20px;">
					<div style="width: 300px; color: gray;">机构代码</div>
					<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>1005</b></div>
					<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
				</div>
				<div style="position: relative; left: 40px; height: 30px; top: 40px;">
					<div style="width: 300px; color: gray;">机构名称</div>
					<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>市场部</b></div>
					<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
				</div>
				<div style="position: relative; left: 40px; height: 30px; top: 60px;">
					<div style="width: 300px; color: gray;">机构类型</div>
					<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>二级部门</b></div>
					<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
				</div>
				<div style="position: relative; left: 40px; height: 30px; top: 80px;">
					<div style="width: 300px; color: gray;">负责人</div>
					<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>张三</b></div>
					<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
				</div>
				<div style="position: relative; left: 40px; height: 30px; top: 100px;">
					<div style="width: 300px; color: gray;">创建者</div>
					<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>zhangsan&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-18 10:10:10</small></div>
					<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
				</div>
				<div style="position: relative; left: 40px; height: 30px; top: 120px;">
					<div style="width: 300px; color: gray;">修改者</div>
					<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>zhangsan&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-19 10:10:10</small></div>
					<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
				</div>
				<div style="position: relative; left: 40px; height: 30px; top: 140px;">
					<div style="width: 300px; color: gray;">描述</div>
					<div style="width: 350px;position: relative; left: 200px; top: -20px;">
						<b>
							市场活动Marketing，是指品牌主办或参与的展览会议与公关市场活动，包括自行主办的各类研讨会、客户交流会、演示会、新产品发布会、体验会、答谢会、年会和出席参加并布展或演讲的展览会、研讨会、行业交流会、颁奖典礼等
						</b>
					</div>
					<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
				</div>
			</div>
		</div>
		
	</div>
	
	<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>
	
	<!-- 底部 -->
	<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>
	
</body>
</html>