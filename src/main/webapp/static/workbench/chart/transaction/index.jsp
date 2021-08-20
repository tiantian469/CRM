<%--
  Created by IntelliJ IDEA.
  User: GhostCat
  Date: 2021/8/17
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" +
            request.getServerName() + ":" + request.getServerPort() +
            request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <script type="text/javascript" src="static/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="static/Echarts/echarts.js"></script>
    <script>
        $(function () {
            $.ajax({
                url:"tran/selectNumAndName.do",
                type:"get",
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
                    var echart = echarts.init(document.getElementById("main"));
                    var option = {
                        title: {
                            text: '交易漏斗图',
                            subtext: '交易统计图'
                        },
                        tooltip: {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c}%"
                        },
                        toolbox: {
                            feature: {
                                dataView: {readOnly: false},
                                restore: {},
                                saveAsImage: {}
                            }
                        },
                        legend: {
                            data: ['展现','点击','访问','咨询','订单']
                        },

                        series: [
                            {
                                name:'漏斗图',
                                type:'funnel',
                                left: '10%',
                                top: 60,
                                //x2: 80,
                                bottom: 60,
                                width: '80%',
                                // height: {totalHeight} - y - y2,
                                min: 0,
                                max: response.total,
                                minSize: '0%',
                                maxSize: '100%',
                                sort: 'descending',
                                gap: 2,
                                label: {
                                    show: true,
                                    position: 'inside'
                                },
                                labelLine: {
                                    length: 10,
                                    lineStyle: {
                                        width: 1,
                                        type: 'solid'
                                    }
                                },
                                itemStyle: {
                                    borderColor: '#fff',
                                    borderWidth: 1
                                },
                                emphasis: {
                                    label: {
                                        fontSize: 20
                                    }
                                },
                                data: response.mapList
                            }
                        ]
                    };

                    // 使用刚指定的配置项和数据显示图表。
                    echart.setOption(option);
                }
            })
        })
    </script>
</head>
<body>
    <div id="main" style="width: 1200px;height:1000px;">

    </div>
</body>
</html>
