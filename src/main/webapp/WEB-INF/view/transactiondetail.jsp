<%@ page import="java.util.List" %>
<%@ page import="ghostcat.crm.settings.domain.DicValue" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String basePath = request.getScheme() + "://" +
			request.getServerName() + ":" + request.getServerPort() +
			request.getContextPath() + "/";
	List<DicValue> dicValueList = (List<DicValue>) application.getAttribute("stage");
	Map<String,String> map = (Map<String, String>) application.getAttribute("s2pMap");
	Set<String> set = map.keySet();
	int point = 0;
	for (int i = 0; i < dicValueList.size(); i++){
		DicValue dicValue = dicValueList.get(i);
		String stage = dicValue.getValue();
		String possibility = map.get(stage);
		if ("0".equals(possibility)){
			point = i;
			break;
		}
	}
%>
<html>
<head>
	<base href="<%=basePath%>">

<link href="static/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<style type="text/css">
.mystage{
	font-size: 20px;
	vertical-align: middle;
	cursor: pointer;
}
.closingDate{
	font-size : 15px;
	cursor: pointer;
	vertical-align: middle;
}
</style>
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

	//????????????????????????????????????????????????
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//??????remarkDiv????????????130px
				$("#remarkDiv").css("height","130px");
				//??????
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//??????
			$("#cancelAndSaveBtn").hide();
			//??????remarkDiv????????????130px
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
		
		
		//???????????????
		$(".mystage").popover({
            trigger:'manual',
            placement : 'bottom',
            html: 'true',
            animation: false
        }).on("mouseenter", function () {
                    var _this = this;
                    $(this).popover("show");
                    $(this).siblings(".popover").on("mouseleave", function () {
                        $(_this).popover('hide');
                    });
                }).on("mouseleave", function () {
                    var _this = this;
                    setTimeout(function () {
                        if (!$(".popover:hover").length) {
                            $(_this).popover("hide")
                        }
                    }, 100);
                });
		$("#deleteBTN").click(function () {
			var id = "${id}";
			$.ajax({
				url:"",
				data:{"id":id},
				type:"post",
				dataType:"json",
				error:function () {
					var messagr = "${sessionScope.message}"
					if (messagr !== ''){
						alert("${sessionScope.message}");
					}else {
						alert("?????????????????????????????????????????????...");
					}
				},
				success:function (response) {
					if (response.success){
						alert("?????????????????????");
						window.location.href='static/workbench/transaction/index.jsp';
					}else {
						alert("?????????????????????????????????...");
					}
				}
			})
		})
	});
	function changeStage(stage,i) {
		$.ajax({
			url:"tran/updateStage.do",
			data:{
				"id":"${id}",
				"stage":stage,
				"money":"${money}",
				"expectedDate":"${expectedDate}"
			},
			type: "post",
			dataType: "json",
			error:function () {
				var messagr = "${sessionScope.message}"
				if (messagr !== ''){
					alert("${sessionScope.message}");
				}else {
					alert("?????????????????????????????????????????????...");
				}
			},
			success:function (response) {
				if (response.success){
					$("#stage").html(response.stage);
					$("#possibility").html(response.possibility);
					$("#editBy").html(response.editBy);
					$("#editTime").html(response.editTime);
					changeIcon(stage,i);
				}else {alert("????????????????????????????????????????????????...");}
			}
		})
	}
	function changeIcon(stage,index) {
		var nowStage = stage;
		var nowPossibility = $("#possibility").html();
		var point = "<%=point%>";
		var length = "<%=dicValueList.size()%>";
		if (nowPossibility === "0"){
			for (var i = 0; i < point; i++){
				//??????
				$("#"+i).removeClass();
				$("#"+i).addClass("glyphicon glyphicon-record mystage");
				$("#"+i).css("color","#000000");
			}
			for (var j = point; j < length; j++){
				if (index == j){
					//???X
					$("#"+j).removeClass();
					$("#"+j).addClass("glyphicon glyphicon-remove mystage");
					$("#"+j).css("color","#FF0000");
				}else {
					//???X
					$("#"+j).removeClass();
					$("#"+j).addClass("glyphicon glyphicon-remove mystage");
					$("#"+j).css("color","#000000");
				}
			}
		}else {
			for (var k = 0; k < point; k++){
				if (index == k){
					//?????????
					$("#"+k).removeClass();
					$("#"+k).addClass("glyphicon glyphicon-map-marker mystage");
					$("#"+k).css("color","#90F790");
				}else if (k < index){
					//??????
					$("#"+k).removeClass();
					$("#"+k).addClass("glyphicon glyphicon-record mystage");
					$("#"+k).css("color","#90F790");
				}else {
					//??????
					$("#"+k).removeClass();
					$("#"+k).addClass("glyphicon glyphicon-record mystage");
					$("#"+k).css("color","#000000");
				}
			}
			for (var l = point; l < length; l++){
				//???X
				$("#"+l).removeClass();
				$("#"+l).addClass("glyphicon glyphicon-remove mystage");
				$("#"+l).css("color","#000000");
			}
		}
	}
	
	
	
</script>

</head>
<body>
	
	<!-- ???????????? -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- ????????? -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>${name} <small>???${money}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" onclick="window.location.href='tran/gotoEdit.do?id=${id}';"><span class="glyphicon glyphicon-edit"></span> ??????</button>
			<button type="button" class="btn btn-danger" id="deleteBTN"><span class="glyphicon glyphicon-minus"></span> ??????</button>
		</div>
	</div>

	<!-- ???????????? -->
	<div style="position: relative; left: 40px; top: -50px;">
		??????&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%
			String nowStage = (String) request.getAttribute("stage");
			String nowPossibility = map.get(nowStage);
			if ("0".equals(nowPossibility)){
				for (int i = 0; i < dicValueList.size(); i++){
					DicValue dicValue = dicValueList.get(i);
					String stage = dicValue.getValue();
					String possibility = map.get(stage);
					if ("0".equals(possibility)){
						if (nowStage.equals(stage)){
							//???X
		%>
		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')" class="glyphicon glyphicon-remove mystage"
			  data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #FF0000;"></span>
		-----------
		<%
						}else {
							//???X
		%>
		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')" class="glyphicon glyphicon-remove mystage"
			  data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #000000;"></span>
		-----------
		<%
						}
					}else {
						//??????
		%>
		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')" class="glyphicon glyphicon-record mystage"
			  data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #000000;"></span>
		-----------
		<%
					}
				}
			}else {
				int index = 0;
				for (int i = 0; i < dicValueList.size(); i++){
					DicValue dicValue = dicValueList.get(i);
					String stage = dicValue.getValue();
					if (nowStage.equals(stage)){
						index = i;
						break;
					}
				}
				for (int i = 0; i < dicValueList.size(); i++){
					DicValue dicValue = dicValueList.get(i);
					String stage = dicValue.getValue();
					String possibility = map.get(stage);
					if ("0".equals(possibility)){
						//???X
		%>
		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')" class="glyphicon glyphicon-remove mystage"
			  data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #000000;"></span>
		-----------
		<%
					}else {
						if (index == i){
							//?????????
		%>
		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')" class="glyphicon glyphicon-map-marker mystage"
			  data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #90F790;"></span>
		-----------
		<%
						}else if (i < index){
							//??????
		%>
		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')" class="glyphicon glyphicon-ok-circle mystage"
			  data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #90F790;"></span>
		-----------
		<%
						}else {
							//??????
		%>
		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')" class="glyphicon glyphicon-record mystage"
			  data-toggle="popover" data-placement="bottom" data-content="<%=dicValue.getText()%>" style="color: #000000;"></span>
		-----------
		<%
						}
					}
				}
			}
		%>
		<%--<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="????????????" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="????????????" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="????????????" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="???????????????" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-map-marker mystage" data-toggle="popover" data-placement="bottom" data-content="??????/??????" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="??????/??????"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="??????"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="???????????????"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="?????????????????????"></span>--%>
		-----------
		<span class="closingDate">${expectedDate}</span>
	</div>
	
	<!-- ???????????? -->
	<div style="position: relative; top: 0px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">?????????</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${owner}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">??????</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${money}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">??????</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${name}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">??????????????????</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${expectedDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">????????????</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${customerId}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">??????</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="stage">${stage}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">??????</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${type}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">?????????</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="possibility"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">??????</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${source}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">???????????????</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activityId}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">???????????????</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${customerId}</b></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">?????????</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${createBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">${createTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">?????????</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy">${editBy}&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;" id="editTime">${editTime}</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">??????</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 90px;">
			<div style="width: 300px; color: gray;">????????????</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${contactSummary}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 100px;">
			<div style="width: 300px; color: gray;">??????????????????</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${nextContactTime}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- ?????? -->
	<div style="position: relative; top: 100px; left: 40px;">
		<div class="page-header">
			<h4>??????</h4>
		</div>
		
		<!-- ??????1 -->
		<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="../../static/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>?????????</h5>
				<font color="gray">??????</font> <font color="gray">-</font> <b>????????????-??????01</b> <small style="color: gray;"> 2017-01-22 10:10:10 ???zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>
		
		<!-- ??????2 -->
		<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="../../static/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>?????????</h5>
				<font color="gray">??????</font> <font color="gray">-</font> <b>????????????-??????01</b> <small style="color: gray;"> 2017-01-22 10:20:10 ???zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>
		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="????????????..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">??????</button>
					<button type="button" class="btn btn-primary">??????</button>
				</p>
			</form>
		</div>
	</div>
	
	<!-- ???????????? -->
	<div>
		<div style="position: relative; top: 100px; left: 40px;">
			<div class="page-header">
				<h4>????????????</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>??????</td>
							<td>??????</td>
							<td>?????????</td>
							<td>??????????????????</td>
							<td>????????????</td>
							<td>?????????</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>????????????</td>
							<td>5,000</td>
							<td>10</td>
							<td>2017-02-07</td>
							<td>2016-10-10 10:10:10</td>
							<td>zhangsan</td>
						</tr>
						<tr>
							<td>????????????</td>
							<td>5,000</td>
							<td>20</td>
							<td>2017-02-07</td>
							<td>2016-10-20 10:10:10</td>
							<td>zhangsan</td>
						</tr>
						<tr>
							<td>??????/??????</td>
							<td>5,000</td>
							<td>90</td>
							<td>2017-02-07</td>
							<td>2017-02-09 10:10:10</td>
							<td>zhangsan</td>
						</tr>
					</tbody>
				</table>
			</div>
			
		</div>
	</div>
	
	<div style="height: 200px;"></div>
	
</body>
</html>