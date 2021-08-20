<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" +
			request.getServerName() + ":" + request.getServerPort() +
			request.getContextPath() + "/";
%>
<html>
<head>
	<base href="<%=basePath%>">

<link href="static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="static/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="static/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="static/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="static/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="static/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<link rel="stylesheet" type="text/css" href="static/jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="static/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="static/jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	$(function(){
		pageList(1,5);
		$("#addButton").click(function () {
			$(".time").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});
			/*$(".time").datetimepicker({
				language:  "zh-CN",
				format: "yyyy-mm-dd hh:ii:ss",//显示格式
				minView: "hour",//设置只显示到月份
				initialDate: new Date(),//初始化当前日期
				autoclose: true,//选中自动关闭
				todayBtn: true, //显示今日按钮
				clearBtn : true,
				pickerPosition: "bottom-left"
			});*/
			$.ajax({
				url:"activity/queryAllUser.do",
				type:"get",
				dataType:"json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫...");
				},
				success:function (response) {
					var html = "";
					$.each(response,function (index,element) {
						html = html + "<option value='"+element.id+"'>"+element.name+"</option>";
					})
					//alert(html);
					$("#create-marketActivityOwner").html(html);
					var id = "${sessionScope.user.id}";
					//alert(id);
					$("#create-marketActivityOwner").val(id);
					$("#createActivityModal").modal("show");
				}
			})
		})
		$("#saveButton").click(function () {
			$.ajax({
				url: "activity/addActivity.do",
				data:{
					"owner":$.trim($("#create-marketActivityOwner").val()),
					"name":$.trim($("#create-marketActivityName").val()),
					"startDate":$.trim($("#create-startTime").val()),
					"endDate":$.trim($("#create-endTime").val()),
					"cost":$.trim($("#create-cost").val()),
					"description":$.trim($("#create-describe").val())
				},
				type: "post",
				dataType: "json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫...");
				},
				success:function (response) {
					$.each(response,function (index,element) {
						if (element.success === true){
							alert("事件添加成功！");
						}else {
							alert("发生了未知的异常导致添加失败，请检查输入格式，或联系幽灵猫...");
						}
					})
					$("#addActivityForm")[0].reset();
					$("#createActivityModal").modal("hide");
					//pageList(1,5);
					pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
				}
			})
		})
		var id = "";
		$("#updateButton").click(function () {
			var $xz = $("input[name=check]:checked");
			if ($xz.length === 0){
				alert("请选择一个要修改的记录！");
			}else if ($xz.length > 1){
				alert("只能选择一个进行修改！");
			}else {
				id = $xz.val();
				$(".time").datetimepicker({
					minView: "month",
					language:  'zh-CN',
					format: 'yyyy-mm-dd',
					autoclose: true,
					todayBtn: true,
					pickerPosition: "bottom-left"
				});
				$.ajax({
					url:"activity/queryUserAndActivity.do",
					data:{"id":id},
					type:"get",
					dataType:"json",
					error:function () {
						alert("发生了未知的异常，请联系幽灵猫...");
					},
					success:function (response) {
						var html = "<option></option>";
						$.each(response.user,function (index,element) {
							html = html + "<option value='"+element.id+"'>"+element.name+"</option>";
						})
						$.each(response.activity,function (index,element) {
							$("#edit-marketActivityName").val(element.name);
							$("#edit-startTime").val(element.startDate);
							$("#edit-endTime").val(element.endDate);
							$("#edit-cost").val(element.cost);
							$("#edit-describe").val(element.description);
						})
						//alert(html);
						$("#edit-marketActivityOwner").html(html);
						var id = "${sessionScope.user.id}";
						//alert(id);
						$("#edit-marketActivityOwner").val(id);
						$("#editActivityModal").modal("show");
					}
				})
			}
		})
		$("#editButton").click(function () {
			$.ajax({
				url: "activity/editActivity.do",
				data:{
					"id":id,
					"owner":$.trim($("#edit-marketActivityOwner").val()),
					"name":$.trim($("#edit-marketActivityName").val()),
					"startDate":$.trim($("#edit-startTime").val()),
					"endDate":$.trim($("#edit-endTime").val()),
					"cost":$.trim($("#edit-cost").val()),
					"description":$.trim($("#edit-describe").val())
				},
				type: "post",
				dataType: "json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫...");
				},
				success:function (response) {
						if (response.success === true){
							alert("事件更新成功！");
						}else {
							alert("发生了未知的异常导致更新失败，请检查输入格式，或联系幽灵猫...");
						}
					$("#editActivityModal").modal("hide");
					pageList($("#activityPage").bs_pagination('getOption', 'currentPage')
							,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
				}
			})
		})
		$("#search").click(function () {
			$("#hidden-name").val($.trim($("#search-name").val()));
			$("#hidden-owner").val($.trim($("#search-owner").val()));
			$("#hidden-startTime").val($.trim($("#startTime").val()));
			$("#hidden-endTime").val($.trim($("#endTime").val()));
			pageList(1,$("#cluePage").bs_pagination('getOption', 'rowsPerPage'));
		})
		$("#qx").click(function () {
			$("input[name=check]").prop("checked",this.checked);
		})
		$("#addActivity").on("click",$("input[name=check]"),function () {
			$("#qx").prop("checked",$("input[name=check]").length === $("input[name=check]:checked").length);
		})
		$("#deleteButton").click(function () {
			var $xz = $("input[name=check]:checked");
			if ($xz.length === 0){
				alert("请勾选您要删除的记录！");
			}else {
				var param = "";
				for (var i=0;i<$xz.length;i++){
					param += "id="+$($xz[i]).val();
					if (i<$xz.length-1){
						param += "&";
					}
				}
				if (confirm("您确定要删除选中的记录吗？")){
					$.ajax({
						url: "activity/deleteActivity.do",
						data: param,
						type: "post",
						dataType: "json",
						error:function () {
							alert("发生了未知的异常，请联系幽灵猫...");
						},
						success:function (response) {
							if (response.success){
								alert("删除记录成功！");
								pageList(1,$("#activityPage").bs_pagination('getOption', 'rowsPerPage'));
							}else {
								alert("删除失败，请联系幽灵猫...");
							}
						}
					})
				}
			}
		})
	});
	function pageList(pageNo,pageSize) {
		$("#qx").prop("checked",false);
		$("#search-name").val($.trim($("#hidden-name").val()));
		$("#search-owner").val($.trim($("#hidden-owner").val()));
		$("#startTime").val($.trim($("#hidden-startTime").val()));
		$("#endTime").val($.trim($("#hidden-endTime").val()));
		$.ajax({
			url:"activity/queryActivityWithPage.do",
			data: {
				"pageNo":pageNo,
				"pageSize":pageSize,
				"name":$.trim($("#search-name").val()),
				"owner":$.trim($("#search-owner").val()),
				"startTime":$.trim($("#startTime").val()),
				"endTime":$.trim($("#endTime").val())
			},
			type:"get",
			dataType:"json",
			error:function () {
				alert("发生了未知的异常，请联系幽灵猫...");
			},
			success:function (response) {
				var html = "";
				$.each(response.pageList,function (index,element) {
					html += '<tr class="active">'
					html +=	'<td><input type="checkbox" name="check" value="'+element.id+'"/></td>'
					html +=	'<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'activity/detail.do?id='+element.id+'\';">"'+element.name+'"</a></td>'
					html +=	'<td>"'+element.owner+'"</td>'
					html +=	'<td>"'+element.startDate+'"</td>'
					html +=	'<td>"'+element.endDate+'"</td>'
					html += '</tr>'
				})
				$("#addActivity").html(html);
				var totalPages = response.total % pageSize === 0?response.total / pageSize : parseInt(response.total / pageSize) + 1;
				$("#activityPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 10, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: response.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});

			}
		})
	}
	
</script>
</head>
<body>
	<input type="hidden" id="hidden-name"/>
	<input type="hidden" id="hidden-owner"/>
	<input type="hidden" id="hidden-startTime"/>
	<input type="hidden" id="hidden-endTime"/>
	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form id="addActivityForm" class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityOwner">

								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-marketActivityName">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-startTime">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endTime">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveButton">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityOwner">
								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-startTime">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-endTime">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="editButton">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="search-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="search-owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="startTime" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="endTime">
				    </div>
				  </div>
				  
				  <button type="button" id="search" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addButton"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="updateButton"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteButton"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="addActivity">
						<%--<tr class="active">
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='static/workbench/activity/cluedetail.jsp';">发传单</a></td>
                            <td>zhangsan</td>
							<td>2020-10-10</td>
							<td>2020-10-20</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='static/workbench/activity/cluedetail.jsp';">发传单</a></td>
                            <td>zhangsan</td>
                            <td>2020-10-10</td>
                            <td>2020-10-20</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div id="activityPage">
				<%--<div>
					<button type="button" class="btn btn-default" style="cursor: default;">共<span id="activityCount"></span>条记录</button>
				</div>
				<div class="btn-group" style="position: relative;top: -34px; left: 110px;">
					<button type="button" class="btn btn-default" style="cursor: default;">显示</button>
					<div class="btn-group">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
							<b id="pageSize">10</b>
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
				</div>--%>
			</div>
			
		</div>
		
	</div>
</body>
</html>