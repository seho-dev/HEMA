<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>河马 · 云手机群控平台</title>
<base href="<%=basePath%>">
<link rel="shortcut icon" href="./河马 · 云手机群控平台_files/logo.ico"
	type="image/png">
<script src="./河马 · 云手机群控平台_files/jquery.min.js" type="text/javascript"></script>
<!-- Bootstrap -->
<script src="./河马 · 云手机群控平台_files/bootstrap.js"></script>
<script src="./河马 · 云手机群控平台_files/layer.js"></script>
<script src="./js/underscore-min.js"></script>
<link rel="stylesheet" href="./css/layui.css">
<link rel="stylesheet" href="./河马 · 云手机群控平台_files/layer.css"
	id="layuicss-layer">
<script type="text/javascript" src="./河马 · 云手机群控平台_files/util.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="./css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" media="all"
	href="./河马 · 云手机群控平台_files/bs.css">
<link rel="stylesheet" type="text/css" media="all"
	href="./css/style.css">
<style>
.inputContext {
	margin-left: 178px;
	display: block;
	width: 270px;
	height: 40px;
	margin-top: 60px;
}

.clickupdate {
	display: inline-block;
	margin-left: 250px;
	margin-top: 100px;
}
</style>

<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "https://hm.baidu.com/hm.js?fcd1487e8e1d6620e8dc18748b804a6b";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>
<script type="text/javascript">
	var upload = layui.upload;
	var form = layui.form,
		table = layui.table,
		layer = layui.layer,
		layedit = layui.layedit,
		laydate = layui.laydate,
		element = layui.element;

	function handelclickUpdate(id, context, name) {
		//出现弹框，把值弹上去
		//tab层
		layer.tab({
			area : [ '600px', '300px' ],
			tab : [ {
				title : '编辑内容',
				content : `
					<input type="hidden" value="" class="updateId">
					<input type="hidden" value="" class="updatename">
					<input type="text" name="title"  required lay-verify="required" autocomplete="off" class="layui-input inputContext">    
					<a class="layui-btn clickupdate" onclick="submitupdate()">确认修改</a>
				`
			} ]
		});
		$('.inputContext').attr("value", context);
		$('.updateId').attr("value", id);
		$('.updatename').attr("value", name);
	}
	function submitupdate() {
		//获取文本框中的内容
		$.ajax({
			url : 'file/update',
			data : {
				context : $('.inputContext').attr("value"),
				id : $('.updateId').attr("value"),
				name : $('.updatename').attr("value"),
			},
			success : function() {
				/* $('.layui-layer-tab').css("display", "none")
				
				setTimeout(function() {
					window.location.href="fileshow.jsp"
				}, 600) */
				layer.alert("修改成功，刷新页面即可显示");
			}
		});
	}
</script>

<script src="./layer-3.1/layer.js"></script>
</head>

<body class="scroll">
	<div class="panel content-s">
		<div class="panel-heading">内容列表</div>
		<div class="panel-content">
			<div class="line line-dashed"></div>
			<div>
				<table id="terminalTable" cellpadding="0" cellspacing="0"
					class="common-table data-table" align="center">
					<thead>
						<tr>
							<th class="manage-column center-column" width="60px">行数</th>
							<th class="manage-column center-column" width="250px">内容</th>
							<th class="manage-column center-column" width="60px">文件名称</th>
							<th class="manage-column center-column" width="120px">管理</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="list1">
							<tr>
								<c:forEach items="${list1}" var="list2">
									<td>${list2}</td>
								</c:forEach>
								<td><a href="file/delete/${list1[0]}/${list1[2]}">删除</a></td>
								<td><a
									onclick="handelclickUpdate('${list1[0]}','${list1[1]}','${list1[2]}')">编辑</a></td>
							</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td colspan="6" align="right"><br /> <script
									type="text/javascript">
								function firstPage() {
									document.getElementById("currentPage").value = "1";
									form1.submit();
								}
								function previousPage() {
									document.getElementById("currentPage").value = currentPage - 1;
									form1.submit();
								}
								function nextPage() {
									document.getElementById("currentPage").value = currentPage + 1;
									form1.submit();
								}
								function lastPage() {
									document.getElementById("currentPage").value = totalPage;
									form1.submit();
								}
								var totalPage = 0;
							
								var totalNumber = 0;
								var pageSize = 50;
							
								var currentPage = 1;
							
								if (totalNumber % pageSize == 0) {
									totalPage = totalNumber / pageSize;
								} else {
									totalPage = Math.floor(totalNumber / pageSize) + 1;
								}
							
								document.write('共 <b><font color=red>' + totalNumber + '</font></b> 条记录 ');
							
								if (currentPage == 1) {
									document.write('&nbsp;&nbsp;首页&nbsp;&nbsp;上一页');
								} else {
									document.write('&nbsp;&nbsp;<a href="#" onclick="firstPage()">首页</a>');
									document.write('&nbsp;&nbsp;<a href="#" onclick="previousPage()">上一页</a>');
								}
							
								if (currentPage >= totalPage) {
									document.write('&nbsp;&nbsp;下一页&nbsp;&nbsp;尾页');
								} else {
									document.write('&nbsp;&nbsp;<a href="#" onclick="nextPage()">下一页</a>');
									document.write('&nbsp;&nbsp;<a href="#" onclick="lastPage()">尾页</a>');
								}
							
								document.write('&nbsp;&nbsp;页次:<b><font color=red>' + currentPage + '/' + totalPage + '</font></b>页&nbsp;&nbsp;');
								document.write('<b><font color=red>' + pageSize + '</font></b>条/页 ');
							</script></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>

	</div>

</body>
</html>