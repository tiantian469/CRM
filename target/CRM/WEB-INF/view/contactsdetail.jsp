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

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	showRemarkList();
	showActivityList();
	$(function(){
		$("#remarkBody").on("mouseover",".remarkDiv",function(){
			$(this).children("div").children("div").show();
		})
		$("#remarkBody").on("mouseout",".remarkDiv",function(){
			$(this).children("div").children("div").hide();
		})
		$(".time").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
			autoclose: true,
			todayBtn: true,
			pickerPosition: "top-left"
		});
		var id = "${id}";
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});
		$("#editBTN").click(function () {
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
					$("#edit-contactsOwner").html(html);
					$("#edit-clueSource").val("${source}");
					$("#edit-call").val("${appellation}");
					$("#editContactsModal").modal("show");
				}
			})
		})
		$("#updateBNT").click(function () {
			$.ajax({
				url:"contacts/editContacts.do",
				data:{
					"id":id,
					"owner":$("#edit-contactsOwner").val(),
					"source":$("#edit-clueSource").val(),
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
					"address":$("#edit-address1").val()
				},
				type: "post",
				dataType: "json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫");
				},
				success:function (response) {
					if (response.success){
						alert("修改联系人成功！");
						window.location.href='contacts/contactsDetail.do?id='+id+'';
					}else {alert("因未知原因导致联系人修改失败！");}
				}
			})
		})
		$("#deleteBTN").click(function () {
			if (confirm("确定要删除这条联系人？")){
				$.ajax({
					url:"contacts/deleteInDetail.do",
					data: {"id":id},
					type:"post",
					dataType:"json",
					error:function () {
						alert("发生了未知的异常，请联系幽灵猫");
					},
					success:function (response) {
						if (response.success){
							alert("删除联系人成功！");
							window.location.href='static/workbench/contacts/index.jsp';
						}else {alert("有一条或多条联系人删除失败，请检查未被删除的联系人后联系幽灵猫...")}
					}
				})
			}
		})
		$("#updateRemarkBtn").click(function () {
			var id = $("#remarkId").val();
			$.ajax({
				url:"contacts/queryContactsRemarkWithID.do",
				data:{
					"id":id,
					"noteContent":$.trim($("#noteContent").val())
				},
				type:"post",
				dataType:"json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫");
				},
				success:function (response) {
					if (response.success){
						$("#n"+id).html($("#noteContent").val());
						$("#editRemarkModal").modal("hide");
						$("#noteContent").val("");
					}else {alert("因未知原因导致备注修改失败！");}
				}
			})
		})
		$("#saveBTN").click(function () {
			$.ajax({
				url:"contacts/addContactsRemark.do",
				data:{
					"noteContent":$.trim($("#remark").val()),
					"contactsId":id
				},
				type:"post",
				dataType:"json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫");
				},
				success:function (response) {
					if (response.success){
						$("#remark").val("");
						var html = "";
						$.each(response.contactsRemarkList,function (index,element) {
							html += '<div class="remarkDiv" style="height: 60px;" id="'+element.id+'">';
							html += '<img title="zhangsan" src="static/image/user-thumbnail.png" style="width: 30px; height:30px;">';
							html += '<div style="position: relative; top: -40px; left: 40px;" >';
							html += '<h5 id="n'+element.id+'">'+element.noteContent+'</h5>';
							html += '<font color="gray">联系人</font> <font color="gray">-</font> <b>${fullname}${appellation}-${address}${customerId}</b> <small style="color: gray;"> '+(element.editFlag === "0"?element.createTime:element.editTime)+' 由'+(element.editFlag === "0"?element.createBy:editBy)+'</small>';
							html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
							html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+element.id+'\')" "><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
							html += '&nbsp;&nbsp;&nbsp;&nbsp;';
							html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+element.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
							html += '</div>';
							html += '</div>';
							html += '</div>';
						})
						$("#remarkDiv").before(html);
					}else {alert("因未知原因添加备注失败，请联系幽灵猫...");}
				}
			})
		})
		$("#deleteRelation").click(function () {
			$.ajax({
				url:"contacts/deleteCARelation.do",
				data:{
					"contactsId":"${id}",
					"activityId":$("#activityId").val()
				},
				type:"post",
				dataType:"json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫");
				},
				success:function (response) {
					var id = $("#activityId").val();
					if (response.success){
						alert("删除关联成功！");
						$("#"+id).remove();
						$("#unbundActivityModal").modal("hide");
					}else {alert("因未知原因删除失败，请联系幽灵猫...");}
				}
			})
		})
		$("#addRelation").click(function () {
			queryActivityNotInRelation(1,5);
			$("#bundActivityModal").modal("show");
		})
		$("#checkAll").click(function () {
			$("input[name=check]").prop("checked",this.checked);
		})
		$("#activityList1").on("click",$("input[name=check]"),function () {
			$("#checkAll").prop("checked",$("input[name=check]").length === $("input[name=check]:checked").length);
		})
		$("#addRelation1").click(function () {
			var $xz = $("input[name=check]:checked");
			if ($xz === 0){
				alert("请选择至少一条关联！");
			}else {
				var param = [];
				for (var i = 0; i < $xz.length; i++){
					param[i] = $($xz[i]).val();
				}
				$.ajax({
					url:"contacts/addCARelation.do",
					data:{
						"ids":param,
						"contactsId":"${id}"
					},
					type:"post",
					dataType:"json",
					error:function () {
						alert("发生了未知的异常，请联系幽灵猫");
					},
					success:function (response) {
						if (response.success){
							alert("关联成功！");
							var id = "${id}";
							window.location.href='contacts/contactsDetail.do?id='+id+'';
						}else {alert("因未知原因导致关联失败，请联系幽灵猫...")}
					}
				})
			}
		})
		
	});
	
	function showRemarkList() {
		var id = "${id}";
		$.ajax({
			url:"contacts/queryAllContactsRemarkWithID.do",
			data:{
				"contactsId":id
			},
			type:"get",
			dataType:"json",
			error:function () {
				alert("发生了未知的异常，请联系幽灵猫");
			},
			success:function (response) {
				var html = "";
				$.each(response,function (index,element) {
					html += '<div class="remarkDiv" style="height: 60px;" id="'+element.id+'">';
					html += '<img title="zhangsan" src="static/image/user-thumbnail.png" style="width: 30px; height:30px;">';
					html += '<div style="position: relative; top: -40px; left: 40px;" >';
					html += '<h5 id="n'+element.id+'">'+element.noteContent+'</h5>';
					html += '<font color="gray">联系人</font> <font color="gray">-</font> <b>${fullname}${appellation}-${address}${customerId}</b> <small style="color: gray;"> '+(element.editFlag === "0"?element.createTime:element.editTime)+' 由'+(element.editFlag === "0"?element.createBy:editBy)+'</small>';
					html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
					html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+element.id+'\')" "><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
					html += '&nbsp;&nbsp;&nbsp;&nbsp;';
					html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+element.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
					html += '</div>';
					html += '</div>';
					html += '</div>';
				})
				$("#remarkDiv").before(html);
			}
		})
	}
	function editRemark(id) {
		var note = $("#n"+id).html();
		$("#noteContent").val(note);
		$("#remarkId").val(id);
		$("#editRemarkModal").modal("show");
	}
	function deleteRemark(id) {
		$.ajax({
			url:"",
			data:{"id":id},
			type:"post",
			dataType:"json",
			error:function () {
				alert("发生了未知的异常，请联系幽灵猫");
			},
			success:function (response) {
				if (response.success){
					alert("删除关联成功！");
					$("#"+id).remove();
				}else {alert("因未知原因删除失败，请联系幽灵猫...");}
			}
		})
	}
	function showActivityList() {
		$.ajax({
			url:"contacts/queryAllActivityWithContactsId.do",
			data:{
				"contactsId":"${id}"
			},
			type:"get",
			dataType:"json",
			error:function () {
				alert("发生了未知的异常，请联系幽灵猫");
			},
			success:function (response) {
				var html = "";
				$.each(response,function (index,element) {
					html += '<tr id="'+element.id+'">'
					html += '<td><a href="activity/detail.do?id='+element.id+'" style="text-decoration: none;">'+element.name+'</a></td>'
					html += '<td>'+element.startDate+'</td>'
					html += '<td>'+element.endDate+'</td>'
					html += '<td>'+element.owner+'</td>'
					html += '<td><a href="javascript:void(0);" onclick="deleteRelation(\''+element.id+'\')" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>'
					html += '</tr>'
				})
				$("#activityList").html(html);
			}
		})
	}
	function deleteRelation(id) {
		$("#activityId").val(id);
		$("#unbundActivityModal").modal("show");
	}
	function queryActivityNotInRelation(pageNo,pageSize){
		$("#checkAll").prop("checked",false);
		$("#activityName").val($.trim($("#act-name").val()));
		$.ajax({
			url:"clue/queryActivityNotInRelation.do",
			data:{
				"contactsId":"${id}",
				"pageNo":pageNo,
				"pageSize":pageSize,
				"name":$("#activityName").val()
			},
			type:"get",
			dataType:"json",
			error:function () {
				alert("发生了未知的异常，请联系幽灵猫");
			},
			success:function (response) {
				var html = "";
				$.each(response.pageList,function (index,element) {
					html += '<tr>'
					html += '<td><input type="checkbox" name="check" value="'+element.id+'"/></td>'
					html += '<td>'+element.name+'</td>'
					html += '<td>'+element.startDate+'</td>'
					html += '<td>'+element.endDate+'</td>'
					html += '<td>'+element.owner+'</td>'
					html += '</tr>'
				})
				$("#activityList1").html(html);
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
						queryActivityNotInRelation(data.currentPage , data.rowsPerPage);
					}
				});
			}
		})
	}
	
</script>

</head>
<body>
	<input type="hidden" id="activityId"/>
	<input type="hidden" id="activityName">
	<!-- 修改市场活动备注的模态窗口 -->
	<div class="modal fade" id="editRemarkModal" role="dialog">
		<%-- 备注的id --%>
		<input type="hidden" id="remarkId">
		<div class="modal-dialog" role="document" style="width: 40%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改备注</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">内容</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="noteContent"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 解除联系人和市场活动关联的模态窗口 -->
	<div class="modal fade" id="unbundActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">解除关联</h4>
				</div>
				<div class="modal-body">
					<p>您确定要解除该关联关系吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-danger" id="deleteRelation">解除</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 联系人和市场活动关联的模态窗口 -->
	<div class="modal fade" id="bundActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">关联市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						<form class="form-inline" role="form">
						  <div class="form-group has-feedback">
						    <input type="text" class="form-control" id="act-name" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
						</form>
					</div>
					<table id="activityTable2" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td><input type="checkbox" id="checkAll"/></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="activityList1">
							<%--<tr>
								<td><input type="checkbox"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>
							<tr>
								<td><input type="checkbox"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>--%>
						</tbody>
					</table>
					<div id="page" style="width: 900px; position: relative;top: 10px;"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="addRelation1">关联</button>
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
								  <%--<option selected>zhangsan</option>
								  <option>lisi</option>
								  <option>wangwu</option>--%>
								</select>
							</div>
							<label for="edit-clueSource" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueSource">
								  <option></option>
									<c:forEach items="${applicationScope.source}" var="s">
										<option value="${s.value}">${s.text}</option>
									</c:forEach>
								  <%--<option selected>广告</option>
								  <option>推销电话</option>
								  <option>员工介绍</option>
								  <option>外部介绍</option>
								  <option>在线商场</option>
								  <option>合作伙伴</option>
								  <option>公开媒介</option>
								  <option>销售邮件</option>
								  <option>合作伙伴研讨会</option>
								  <option>内部研讨会</option>
								  <option>交易会</option>
								  <option>web下载</option>
								  <option>web调研</option>
								  <option>聊天</option>--%>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname" value="${fullname}">
							</div>
							<label for="edit-call" class="col-sm-2 control-label">${appellation}</label>
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
								<input type="text" class="form-control" id="edit-job" value="${job}">
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" value="${mphone}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" value="${email}">
							</div>
							<label for="edit-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-birth" value="${birth}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建" value="${customerId}">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe">${description}</textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary">${contactSummary}</textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" id="create-nextContactTime" value="${nextContactTime}">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address1">${address}</textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBNT">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>${fullname}${appellation} <small> - ${customerId}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" id="editBTN"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger" id="deleteBTN"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">来源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${source}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">客户名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${customerId}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">姓名</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${fullname}${appellation}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">邮箱</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${email}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${mphone}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">职位</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${job}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">生日</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${birth}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${contactSummary}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${nextContactTime}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 90px;">
            <div style="width: 300px; color: gray;">详细地址</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b>
                    ${address}
                </b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
	</div>
	<!-- 备注 -->
	<div style="position: relative; top: 20px; left: 40px;" id="remarkBody">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<%--<!-- 备注1 -->
		<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="static/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>哎呦！</h5>
				<font color="gray">联系人</font> <font color="gray">-</font> <b>李四先生-北京动力节点</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>
		
		<!-- 备注2 -->
		<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="../../static/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>呵呵！</h5>
				<font color="gray">联系人</font> <font color="gray">-</font> <b>李四先生-北京动力节点</b> <small style="color: gray;"> 2017-01-22 10:20:10 由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>--%>
		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary" id="saveBTN">保存</button>
				</p>
			</form>
		</div>
	</div>
	
	<!-- 交易 -->
	<div>
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>交易</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable3" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>金额</td>
							<td>阶段</td>
							<td>可能性</td>
							<td>预计成交日期</td>
							<td>类型</td>
							<td></td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><a href="transactiondetail.jsp" style="text-decoration: none;">动力节点-交易01</a></td>
							<td>5,000</td>
							<td>谈判/复审</td>
							<td>90</td>
							<td>2017-02-07</td>
							<td>新业务</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#unbundModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
						</tr>
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="../../static/workbench/transaction/save.jsp" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建交易</a>
			</div>
		</div>
	</div>
	
	<!-- 市场活动 -->
	<div>
		<div style="position: relative; top: 60px; left: 40px;">
			<div class="page-header">
				<h4>市场活动</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>开始日期</td>
							<td>结束日期</td>
							<td>所有者</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="activityList">
						<%--<tr>
							<td><a href="cluedetail.jsp" style="text-decoration: none;">发传单</a></td>
							<td>2020-10-10</td>
							<td>2020-10-20</td>
							<td>zhangsan</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#unbundActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="javascript:void(0);" id="addRelation" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
			</div>
		</div>
	</div>
	
	
	<div style="height: 200px;"></div>
</body>
</html>