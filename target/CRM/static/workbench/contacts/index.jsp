<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<script type="text/javascript" src="static/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
	<script type="text/javascript">

	$(function(){
		pageList(1,5);
		$("#create-customerName").typeahead({
			source: function (query, process) {
				$.get(
						"customer/queryLikeCustomerName.do",
						{ "name" : query },
						function (data) {
							//alert(data);
							process(data);
						},
						"json"
				);
			},
			delay: 500
		});
		$("#edit-customerName").typeahead({
			source: function (query, process) {
				$.get(
						"customer/queryLikeCustomerName.do",
						{ "name" : query },
						function (data) {
							//alert(data);
							process(data);
						},
						"json"
				);
			},
			delay: 500
		});
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "top-left"
		});
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
		$("#searchBTN").click(function () {
			$("#hidden-owner").val($.trim($("#owner").val()));
			$("#hidden-fullname").val($.trim($("#fullname").val()));
			$("#hidden-clueSource").val($.trim($("#edit-clueSource").val()));
			$("#hidden-birth").val($.trim($("#birth").val()));
			pageList(1,$("#page").bs_pagination('getOption', 'rowsPerPage'));
		})
		$("#createBTN").click(function () {
			$.ajax({
				url:"user/queryAllUser.do",
				type:"get",
				dataType:"json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫");
				},
				success:function (response) {
					var html = "";
					$.each(response,function (index,element) {
						html += '<option value="'+element.id+'">'+element.name+'</option>'
					})
					var id = "${sessionScope.user.id}";
					$("#create-contactsOwner").html(html);
					$("#create-contactsOwner").val(id);
					$("#createContactsModal").modal("show");
				}
			})
		})
		$("#saveBTN").click(function () {
			$.ajax({
				url:"contacts/addContacts.do",
				data:{
					"owner":$("#create-contactsOwner").val(),
					"source":$("#create-clueSource").val(),
					"fullname":$("#create-surname").val(),
					"appellation":$("#create-call").val(),
					"job":$("#create-job").val(),
					"mphone":$("#create-mphone").val(),
					"email":$("#create-email").val(),
					"birth":$("#create-birth").val(),
					"customerName":$("#create-customerName").val(),
					"description":$("#create-describe").val(),
					"contactSummary":$("#create-contactSummary1").val(),
					"nextContactTime":$("#create-nextContactTime1").val(),
					"address":$("#edit-address1").val()
				},
				type:"post",
				dataType:"json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫");
				},
				success:function (response) {
					if (response.success){
						alert("添加联系人成功！");
						$("#createContactsModal").modal("hide");
						pageList(1,$("#page").bs_pagination('getOption', 'rowsPerPage'));
					}else {alert("因未知原因导致联系人添加失败！");}
				}
			})
		})
		$("#checkAll").click(function () {
			$("input[name=check]").prop("checked",this.checked);
		})
		$("#contactsList").on("click",$("input[name=check]"),function () {
			$("#checkAll").prop("checked",$("input[name=check]").length === $("input[name=check]:checked").length);
		})
		var id = "";
		$("#editBTN").click(function () {
			var $xz = $("input[name=check]:checked");
			if ($xz.length === 0){
				alert("请选择一条联系人进行修改！");
			}else if ($xz.length > 1){
				alert("一次只能修改一条记录！")
			}else {
				id = $xz.val();
				$.ajax({
					url:"contacts/queryUserAndContacts.do",
					data:{
						"id":id
					},
					type:"get",
					dataType:"json",
					error:function () {
						alert("发生了未知的异常，请联系幽灵猫");
					},
					success:function (response) {
						var html = "";
						$.each(response.user,function (index,element) {
							html += '<option value="'+element.id+'">'+element.name+'</option>'
						})
						$("#edit-contactsOwner").html(html);
						$.each(response.contacts,function (index,element) {
							$("#edit-contactsOwner").val(element.owner);
							$("#edit-clueSource1").val(element.source);
							$("#edit-surname").val(element.fullname);
							$("#edit-call").val(element.appellation);
							$("#edit-job").val(element.job);
							$("#edit-mphone").val(element.mphone);
							$("#edit-email").val(element.email);
							$("#edit-birth").val(element.birth);
							$("#edit-customerName").val(element.customerId);
							$("#edit-describe").val(element.description);
							$("#create-contactSummary").val(element.contactSummary);
							$("#create-nextContactTime").val(element.nextContactTime);
							$("#edit-address2").val(element.address);
						})
						$("#editContactsModal").modal("show");
					}
				})
			}
		})
		$("#updateBTN").click(function () {
			$.ajax({
				url:"contacts/editContacts.do",
				data:{
					"id":id,
					"owner":$("#edit-contactsOwner").val(),
					"source":$("#edit-clueSource1").val(),
					"fullname":$("#edit-surname").val(),
					"appellation":$("#edit-call").val(),
					"job":$("#edit-job").val(),
					"mphone":$("#edit-mphone").val(),
					"email":$("#edit-email").val(),
					"birth":$("#edit-birth").val(),
					"customerName":$("#edit-customerName").val(),
					"description":$("#edit-describe").val(),
					"contactSummary":$("#create-contactSummary").val(),
					"nextContactTime":$("#create-nextContactTime").val(),
					"address":$("#edit-address2").val()
				},
					type:"post",
					dataType:"json",
					error:function () {
						alert("发生了未知的异常，请联系幽灵猫");
				},
					success:function (response) {
						if (response.success){
							alert("修改联系人成功！");
							$("#editContactsModal").modal("hide");
							pageList(1,$("#page").bs_pagination('getOption', 'rowsPerPage'));
						}else {alert("因未知原因导致联系人修改失败！");}
				}
			})
		})
		$("#deleteBTN").click(function () {
			var $xz = $("input[name=check]:checked");
			if ($xz.length === 0){
				alert("请选择至少一条联系人进行删除！");
			}else {
				var arr = [];
				for (var i = 0; i < $xz.length; i++){
					arr[i] = $($xz[i]).val();
				}
				if (confirm("确定要删除选中的联系人？")){
					$.ajax({
						url:"contacts/deleteContacts.do",
						data:{"titles":arr},
						type:"post",
						dataType:"json",
						error:function () {
							alert("发生了未知的异常，请联系幽灵猫");
						},
						success:function (response) {
							if (response.success){
								alert("删除联系人成功！");
								pageList(1,$("#page").bs_pagination('getOption', 'rowsPerPage'));
							}else {alert("有一条或多条联系人删除失败，请检查未被删除的联系人后联系幽灵猫...")}
						}
					})
				}
			}
		})

	});
	function pageList(pageNo,pageSize) {
		$("#checkAll").prop("checked",false);
		$("#owner").val($("#hidden-owner").val());
		$("#fullname").val($("#hidden-fullname").val());
		$("#edit-clueSource").val($("#hidden-clueSource").val());
		$("#birth").val($("#hidden-birth").val());
		$.ajax({
			url:"contacts/queryAllContacts.do",
			data:{
				"owner":$("#owner").val(),
				"fullname":$("#fullname").val(),
				"source":$("#edit-clueSource").val(),
				"birth":$("#birth").val(),
				"pageNo":pageNo,
				"pageSize":pageSize
			},
			type:"get",
			dataType:"json",
			error:function () {
				alert("发生了未知的异常，请联系幽灵猫");
			},
			success:function (response) {
				var html = "";
				$.each(response.pageList, function (index,element) {
					html += '<tr>'
					html += '<td><input type="checkbox" name="check" value="'+element.id+'"/></td>'
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'contacts/contactsDetail.do?id='+element.id+'\';">'+element.fullname+'</a></td>'
					html += '<td>'+element.owner+'</td>'
					html += '<td>'+element.source+'</td>'
					html += '<td>'+element.birth+'</td>'
					html += '</tr>'
				})
				$("#contactsList").html(html);
				var totalPages = response.total % pageSize === 0?response.total / pageSize : parseInt(response.total / pageSize) + 1;
				$("#page").bs_pagination({
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

	
	<!-- 创建联系人的模态窗口 -->
	<div class="modal fade" id="createContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-contactsOwner">

								</select>
							</div>
							<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-clueSource">
								  <option></option>
								  <c:forEach items="${applicationScope.source}" var="s">
									  <option value="${s.value}">${s.text}</option>
								  </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-surname">
							</div>
							<label for="create-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-call">
								  <option></option>
								  <c:forEach items="${applicationScope.appellation}" var="a">
									  <option value="${a.value}">${a.text}</option>
								  </c:forEach>
								</select>
							</div>
							
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job">
							</div>
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email">
							</div>
							<label for="create-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-birth">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary1"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime1" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" id="create-nextContactTime1">
								</div>
							</div>
						</div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address1"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBTN">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改联系人的模态窗口 -->
	<div class="modal fade" id="editContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-contactsOwner">

								</select>
							</div>
							<label for="edit-clueSource1" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueSource1">
								  <option></option>
								  <c:forEach items="${applicationScope.source}" var="s">
									  <option value="${s.value}">${s.text}</option>
								  </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname">
							</div>
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-call">
								  <option></option>
								  <c:forEach items="${applicationScope.appellation}" var="a">
									  <option value="${a.value}">${a.text}</option>
								  </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job">
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email">
							</div>
							<label for="edit-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-birth">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address2" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address2"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBTN">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<input type="hidden" id="hidden-owner">
	<input type="hidden" id="hidden-fullname">
	<input type="hidden" id="hidden-clueSource">
	<input type="hidden" id="hidden-birth">
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>联系人列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">姓名</div>
				      <input class="form-control" type="text" id="fullname">
				    </div>
				  </div>
				  
				  <%--<div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="name">
				    </div>
				  </div>--%>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="edit-clueSource">
						  <option></option>
						  <c:forEach items="${applicationScope.source}" var="s">
							  <option value="${s.value}">${s.text}</option>
						  </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">生日</div>
				      <input class="form-control" type="text" id="birth">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="searchBTN">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="createBTN"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBTN"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBTN"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll"/></td>
							<td>姓名</td>
							<td>所有者</td>
							<td>来源</td>
							<td>生日</td>
						</tr>
					</thead>
					<tbody id="contactsList">
						<%--<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='contactsdetail.jsp';">李四</a></td>
							<td>动力节点</td>
							<td>zhangsan</td>
							<td>广告</td>
							<td>2000-10-10</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='contactsdetail.jsp';">李四</a></td>
                            <td>动力节点</td>
                            <td>zhangsan</td>
                            <td>广告</td>
                            <td>2000-10-10</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 10px;" id="page">
				<%--<div>
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