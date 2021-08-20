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
		pageList(1,5)
		$("#searchBTN").click(function () {
			pageList(1,$("#page").bs_pagination('getOption', 'rowsPerPage'));
		})
		$("#editBTN").click(function () {
			var $xz = $("input[name=check]:checked");
			if ($xz.length === 0){
				alert("请选择一条交易进行修改！");
			}else if ($xz.length > 1){
				alert("一次只能选择一条交易进行修改！");
			}else {
				var id = $xz.val();
				window.location.href='tran/gotoEdit.do?id='+id+'';
			}
		})
		
		
	});

	function pageList(pageNo,pageSize){
		$("#hidden-owner").val($.trim($("#tran-owner").val()));
		$("#hidden-name").val($.trim($("#tran-name").val()));
		$("#hidden-customerName").val($.trim($("#tran-customerName").val()));
		$("#hidden-stage").val($.trim($("#tran-stage").val()));
		$("#hidden-transactionType").val($.trim($("#tran-transactionType").val()));
		$("#hidden-source").val($.trim($("#tran-source").val()));
		$("#hidden-contactsName").val($.trim($("#tran-contactsName").val()));
		$.ajax({
			url:"tran/queryAllTranInPage.do",
			data:{
				"pageNo":pageNo,
				"pageSize":pageSize,
				"owner":$("#hidden-owner").val(),
				"name":$("#hidden-name").val(),
				"customerName":$("#hidden-customerName").val(),
				"stage":$("#hidden-stage").val(),
				"type":$("#hidden-transactionType").val(),
				"source":$("#hidden-source").val(),
				"contactsName":$("#hidden-contactsName").val()
			},
			type:"get",
			dataType:"json",
			error:function () {
				alert("发生了未知的异常，请联系幽灵猫...");
			},
			success:function (response) {
				var html = "";
				$.each(response.pageList,function (index,element) {
					html += '<tr id="'+element.id+'">'
					html += '<td><input type="checkbox" name="check" value="'+element.id+'"/></td>'
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'tran/tranDetail.do?id='+element.id+'\';">'+element.name+'</a></td>'
					html += '<td>'+element.customerId+'</td>'
					html += '<td>'+element.stage+'</td>'
					html += '<td>'+element.type+'</td>'
					html += '<td>'+element.owner+'</td>'
					html += '<td>'+element.source+'</td>'
					html += '<td>'+element.contactsId+'</td>'
					html += '</tr>'
				})
				$("#tranList").html(html);
				var totalPages = response.total % pageSize === 0?response.total / pageSize : parseInt(response.total / pageSize) + 1;
				$("#page").bs_pagination({
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
						pageList(data.currentPage , data.rowsPerPage);
					}
				});
			}
		})
	}
	
</script>
</head>
<body>

	
	<input type="hidden" id="hidden-owner"/>
	<input type="hidden" id="hidden-name"/>
	<input type="hidden" id="hidden-customerName"/>
	<input type="hidden" id="hidden-stage"/>
	<input type="hidden" id="hidden-transactionType"/>
	<input type="hidden" id="hidden-source"/>
	<input type="hidden" id="hidden-contactsName"/>
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>交易列表</h3>
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
				      <input class="form-control" type="text" id="tran-owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="tran-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="tran-customerName">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">阶段</div>
					  <select class="form-control" id="tran-stage">
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
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select class="form-control" id="tran-transactionType">
					  	<option></option>
						  <c:forEach items="${applicationScope.transactionType}" var="t">
							  <option value="${t.value}">${t.text}</option>
						  </c:forEach>
					  	<%--<option>已有业务</option>
					  	<option>新业务</option>--%>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="tran-source">
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
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">联系人名称</div>
				      <input class="form-control" type="text" id="tran-contactsName">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="searchBTN">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" onclick="window.location.href='static/workbench/transaction/save.jsp';"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBTN"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll"/></td>
							<td>名称</td>
							<td>客户名称</td>
							<td>阶段</td>
							<td>类型</td>
							<td>所有者</td>
							<td>来源</td>
							<td>联系人名称</td>
						</tr>
					</thead>
					<tbody id="tranList">
						<%--<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='transactiondetail.jsp';">动力节点-交易01</a></td>
							<td>动力节点</td>
							<td>谈判/复审</td>
							<td>新业务</td>
							<td>zhangsan</td>
							<td>广告</td>
							<td>李四</td>
						</tr>
                        <tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='transactiondetail.jsp';">动力节点-交易01</a></td>
                            <td>动力节点</td>
                            <td>谈判/复审</td>
                            <td>新业务</td>
                            <td>zhangsan</td>
                            <td>广告</td>
                            <td>李四</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 20px;" id="page">
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