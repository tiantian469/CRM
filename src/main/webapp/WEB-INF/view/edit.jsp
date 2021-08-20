<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" +
			request.getServerName() + ":" + request.getServerPort() +
			request.getContextPath() + "/";
	Map<String,String> map = (Map<String, String>) application.getAttribute("s2pMap");
	Set<String> set = map.keySet();
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
		var json = {
			<%
                for (String key:set){
                    String value = map.get(key);
            %>
			"<%=key%>" : <%=value%>,
			<%
                }
            %>
		};
		$(function () {
			selected();
			$("#create-accountName").typeahead({
				source: function (query, process) {
					$.get(
							"customer/queryLikeCustomerName.do",
							{ "name" : query },
							function (data) {
								process(data);
							},
							"json"
					);
				},
				delay: 500
			});
			$(".time1").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "top-left"
			});
			$(".time2").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});
			$("#activityOpen").click(function () {
				activityList(1,5);
				$("#findMarketActivity").modal("show");
			})
			$("#contactsOpen").click(function () {
				contactsList(1,5);
				$("#findContacts").modal("show");
			})
			$("#activityName").keydown(function (event) {
				if (event.keyCode === 13){
					$("#activityNameValue").val($.trim($("#activityName").val()));
					activityList(1,$("#apage").bs_pagination('getOption', 'rowsPerPage'));
					return false;
				}
			})
			$("#contactsName").keydown(function (event) {
				if (event.keyCode === 13){
					$("#contactsNameValue").val($.trim($("#contactsName").val()));
					contactsList(1,$("#cpage").bs_pagination('getOption', 'rowsPerPage'));
					return false;
				}
			})
			$("#actsubmitBTN").click(function () {
				var $xz = $("input[name=activity]:checked");
				var activityId = $xz.val();
				var name = $("#"+activityId).html();
				$("#activityId").val(activityId);
				$("#create-activitySrc").val(name);
				$("#findMarketActivity").modal("hide");
			})
			$("#consubmitBTN").click(function () {
				var $xz = $("input[name=contacts]:checked");
				var contactsId = $xz.val();
				var name = $("#"+contactsId).html();
				$("#contactsId").val(contactsId);
				$("#create-contactsName").val(name);
				$("#findContacts").modal("hide");
			})
			$("#create-transactionStage").change(function () {
				var stage = $("#create-transactionStage").val();
				var possibility = json[stage];
				$("#create-possibility").val(possibility);
			})
			$("#saveBTN").click(function () {
				$.ajax({
					url:"tran/updateTran.do",
					data:{
						"id":"${id}",
						"owner":$("#create-transactionOwner").val(),
						"money":$("#create-amountOfMoney").val(),
						"name":$("#create-transactionName").val(),
						"expectedDate":$("#create-expectedClosingDate").val(),
						"customerName":$("#create-accountName").val(),
						"stage":$("#create-transactionStage").val(),
						"type":$("#create-transactionType").val(),
						"source":$("#create-clueSource").val(),
						"possibility":$("#create-possibility").val(),
						"activityId":$("#activityId").val(),
						"contactsId":$("#contactsId").val(),
						"description":$("#create-describe").val(),
						"contactSummary":$("#create-contactSummary").val(),
						"nextContactTime":$("#create-nextContactTime").val()
					},
					type:"post",
					dataType:"json",
					error:function () {
						var messagr = "${sessionScope.message}"
						if (messagr !== ''){
							alert("${sessionScope.message}");
						}else {
							alert("发生了未知的异常，请联系幽灵猫...");
						}
					},
					success:function (response) {
						if (response.success){
							alert("修改成功！");
							window.location.href='static/workbench/transaction/index.jsp';
						}else {
							alert("因未知原因导致添加失败，请注意格式或联系幽灵猫...");
						}
					}
				})
			})

		})

		function activityList(pageNo,pageSize) {
			$.ajax({
				url:"tran/queryAllActivityWithName.do",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"name":$("#activityNameValue").val()
				},
				type:"get",
				dataType:"json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫...");
				},
				success:function (response) {
					var html = "";
					$.each(response.pageList,function (index,element) {
						html += '<tr>'
						html += '<td><input type="radio" name="activity" value="'+element.id+'"/></td>'
						html += '<td id="'+element.id+'">'+element.name+'</td>'
						html += '<td>'+element.startDate+'</td>'
						html += '<td>'+element.endDate+'</td>'
						html += '<td>'+element.owner+'</td>'
						html += '</tr>'
					})
					$("#activityPage").html(html);
					var totalPages = response.total % pageSize === 0?response.total / pageSize : parseInt(response.total / pageSize) + 1;
					$("#apage").bs_pagination({
						currentPage: pageNo,
						rowsPerPage: pageSize,
						maxRowsPerPage: 10,
						totalPages: totalPages,
						totalRows: response.total,

						visiblePageLinks: 3,

						showGoToPage: true,
						showRowsPerPage: true,
						showRowsInfo: true,
						showRowsDefaultInfo: true,

						onChangePage : function(event, data){
							activityList(data.currentPage , data.rowsPerPage);
						}
					});
				}
			})
		}
		function contactsList(pageNo,pageSize) {
			$.ajax({
				url:"tran/queryAllContactsWithName.do",
				data:{
					"pageNo":pageNo,
					"pageSize":pageSize,
					"fullname":$("#contactsNameValue").val()
				},
				type:"get",
				dataType:"json",
				error:function () {
					alert("发生了未知的异常，请联系幽灵猫...");
				},
				success:function (response) {
					var html = "";
					$.each(response.pageList,function (index,element) {
						html += '<tr>'
						html += '<td><input type="radio" name="contacts" value="'+element.id+'"/></td>'
						html += '<td id="'+element.id+'">'+element.fullname+'</td>'
						html += '<td>'+element.email+'</td>'
						html += '<td>'+element.mphone+'</td>'
						html += '</tr>'
					})
					$("#contactsPage").html(html);
					var totalPages = response.total % pageSize === 0?response.total / pageSize : parseInt(response.total / pageSize) + 1;
					$("#cpage").bs_pagination({
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
							contactsList(data.currentPage , data.rowsPerPage);
						}
					});
				}
			})
		}
		function selected(){
			$("#create-transactionStage").val("${stage}");
			$("#create-clueSource").val("${source}");
			$("#create-transactionType").val("${type}");
			var stage = $("#create-transactionStage").val();
			var possibility = json[stage];
			$("#create-possibility").val(possibility);
		}
	</script>

</head>
<body>
<input type="hidden" id="activityNameValue"/>
<input type="hidden" id="contactsNameValue"/>
<!-- 查找市场活动 -->
<div class="modal fade" id="findMarketActivity" role="dialog">
	<div class="modal-dialog" role="document" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">查找市场活动</h4>
			</div>
			<div class="modal-body">
				<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
					<form class="form-inline" role="form">
						<div class="form-group has-feedback">
							<input type="text" class="form-control" style="width: 300px;" id="activityName" placeholder="请输入市场活动名称，支持模糊查询">
							<span class="glyphicon glyphicon-search form-control-feedback"></span>
						</div>
					</form>
				</div>
				<table id="activityTable3" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
					<thead>
					<tr style="color: #B3B3B3;">
						<td></td>
						<td>名称</td>
						<td>开始日期</td>
						<td>结束日期</td>
						<td>所有者</td>
					</tr>
					</thead>
					<tbody id="activityPage">
					<%--<tr>
                        <td><input type="radio" name="activity"/></td>
                        <td>发传单</td>
                        <td>2020-10-10</td>
                        <td>2020-10-20</td>
                        <td>zhangsan</td>
                    </tr>
                    <tr>
                        <td><input type="radio" name="activity"/></td>
                        <td>发传单</td>
                        <td>2020-10-10</td>
                        <td>2020-10-20</td>
                        <td>zhangsan</td>
                    </tr>--%>
					</tbody>
				</table>
				<div style="width: 900px; position: relative;top: 10px;" id="apage"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="actsubmitBTN">提交</button>
			</div>
		</div>
	</div>
</div>

<!-- 查找联系人 -->
<div class="modal fade" id="findContacts" role="dialog">
	<div class="modal-dialog" role="document" style="width: 80%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title">查找联系人</h4>
			</div>
			<div class="modal-body">
				<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
					<form class="form-inline" role="form">
						<div class="form-group has-feedback">
							<input type="text" class="form-control" style="width: 300px;" id="contactsName" placeholder="请输入联系人名称，支持模糊查询">
							<span class="glyphicon glyphicon-search form-control-feedback"></span>
						</div>
					</form>
				</div>
				<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
					<thead>
					<tr style="color: #B3B3B3;">
						<td></td>
						<td>名称</td>
						<td>邮箱</td>
						<td>手机</td>
					</tr>
					</thead>
					<tbody id="contactsPage">
					<%--<tr>
                        <td><input type="radio" name="activity"/></td>
                        <td>李四</td>
                        <td>lisi@bjpowernode.com</td>
                        <td>12345678901</td>
                    </tr>
                    <tr>
                        <td><input type="radio" name="activity"/></td>
                        <td>李四</td>
                        <td>lisi@bjpowernode.com</td>
                        <td>12345678901</td>
                    </tr>--%>
					</tbody>
				</table>
				<div style="width: 900px; position: relative;top: 10px;" id="cpage"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary" id="consubmitBTN">提交</button>
			</div>
		</div>
	</div>
</div>


<div style="position:  relative; left: 30px;">
	<h3>创建交易</h3>
	<div style="position: relative; top: -40px; left: 70%;">
		<button type="button" class="btn btn-primary" id="saveBTN">保存</button>
		<button type="button" class="btn btn-default" onclick="window.location.href='../../static/workbench/transaction/index.jsp'">取消</button>
	</div>
	<hr style="position: relative; top: -40px;">
</div>
<form class="form-horizontal" role="form" style="position: relative; top: -30px;">
	<div class="form-group">
		<label for="create-transactionOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<select class="form-control" id="create-transactionOwner">
				<c:forEach items="${userList}" var="user">
					<option value="${user.id}" ${sessionScope.user.id eq user.id ? "selected" : ""}>${user.name}</option>
				</c:forEach>
			</select>
		</div>
		<label for="create-amountOfMoney" class="col-sm-2 control-label">金额</label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-amountOfMoney" value="${money}">
		</div>
	</div>

	<div class="form-group">
		<label for="create-transactionName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-transactionName" value="${name}">
		</div>
		<label for="create-expectedClosingDate" class="col-sm-2 control-label">预计成交日期<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control time2" id="create-expectedClosingDate" value="${expectedDate}">
		</div>
	</div>

	<div class="form-group">
		<label for="create-accountName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-accountName" value="${customerId}" placeholder="支持自动补全，输入客户不存在则新建">
		</div>
		<label for="create-transactionStage" class="col-sm-2 control-label">阶段<span style="font-size: 15px; color: red;">*</span></label>
		<div class="col-sm-10" style="width: 300px;">
			<select class="form-control" id="create-transactionStage">
				<option></option>
				<c:forEach items="${applicationScope.stage}" var="s">
					<option value="${s.value}">${s.text}</option>
				</c:forEach>
				<%--<option>资质审查</option>
                <option>需求分析</option>
                <option>价值建议</option>
                <option>确定决策者</option>
                <option>提案/报价</option>
                <option>谈判/复审</option>
                <option>成交</option>
                <option>丢失的线索</option>
                <option>因竞争丢失关闭</option>--%>
			</select>
		</div>
	</div>

	<div class="form-group">
		<label for="create-transactionType" class="col-sm-2 control-label">类型</label>
		<div class="col-sm-10" style="width: 300px;">
			<select class="form-control" id="create-transactionType">
				<option></option>
				<c:forEach items="${applicationScope.transactionType}" var="t">
					<option value="${t.value}">${t.text}</option>
				</c:forEach>
				<%--<option>已有业务</option>
                <option>新业务</option>--%>
			</select>
		</div>
		<label for="create-possibility" class="col-sm-2 control-label">可能性</label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-possibility">
		</div>
	</div>

	<div class="form-group">
		<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
		<div class="col-sm-10" style="width: 300px;">
			<select class="form-control" id="create-clueSource">
				<option></option>
				<c:forEach items="${applicationScope.source}" var="source">
					<option value="${source.value}">${source.text}</option>
				</c:forEach>
				<%--<option>广告</option>
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
		<label for="create-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" id="activityOpen"><span class="glyphicon glyphicon-search"></span></a></label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-activitySrc" value="${activityName}" readonly>
			<input type="hidden" id="activityId" value="${activityId}">
		</div>
	</div>

	<div class="form-group">
		<label for="create-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" id="contactsOpen"><span class="glyphicon glyphicon-search"></span></a></label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control" id="create-contactsName" value="${contactsName}" readonly>
			<input type="hidden" id="contactsId" value="${contactsId}">
		</div>
	</div>

	<div class="form-group">
		<label for="create-describe" class="col-sm-2 control-label">描述</label>
		<div class="col-sm-10" style="width: 70%;">
			<textarea class="form-control" rows="3" id="create-describe">${description}</textarea>
		</div>
	</div>

	<div class="form-group">
		<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
		<div class="col-sm-10" style="width: 70%;">
			<textarea class="form-control" rows="3" id="create-contactSummary">${contactSummary}</textarea>
		</div>
	</div>

	<div class="form-group">
		<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
		<div class="col-sm-10" style="width: 300px;">
			<input type="text" class="form-control time1" id="create-nextContactTime" value="${nextContactTime}">
		</div>
	</div>

</form>
</body>
</html>