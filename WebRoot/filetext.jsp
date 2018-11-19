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
<link rel="shortcut icon" href="./河马 · 云手机群控平台_files/logo.ico"
	type="image/png">
<script src="./河马 · 云手机群控平台_files/jquery.min.js" type="text/javascript"></script>
<!-- Bootstrap -->
<script src="./河马 · 云手机群控平台_files/bootstrap.js"></script>
<script src="./河马 · 云手机群控平台_files/underscore-min.js"></script>
<link rel="stylesheet" href="./河马 · 云手机群控平台_files/layer.css"
	id="layuicss-layer">
<script type="text/javascript" src="./河马 · 云手机群控平台_files/util.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="./css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" media="all"
	href="./河马 · 云手机群控平台_files/bs.css">
<link rel="stylesheet" type="text/css" media="all"
	href="./css/style.css">

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
</script>

<script src="./layer-3.1/layer.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : 'file/all',
			success : function(data) {
				for(var i = 0 ;i<data.length;i++){
					$('.itembody').append("<tr><td align='center'>"+i+"</td><td align='center'>"+data[i][0]+"</td><td align='center'>"+data[i][1]+"</td><td align='center'>"+data[i][2]+"</td><td><a href="+data[i][3]+" download="+data[i][1]+">下载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='file/getfile/"+data[i][0]+"'>编辑</a></td></tr>");
				}
			}
		})
	})
</script>
</head>

<body class="scroll">
	<div class="panel content-s">
		<div class="panel-heading">文件列表</div>
		<div class="panel-content">
			<form id="mainForm" class="form-inline" name="form1"
				action="userFiles.action" method="post">
				<input type="hidden" id="currentPage" name="currentPage">
				<div class="btn btn-primary"
					onclick="window.open('./fileupload.jsp','_blank')"
					style="margin-right:60px;">
					<i class="icon-upload-alt"> </i> 上传文件
				</div>
				&nbsp; <b>文件名称:</b>&nbsp; <input type="text" class="mg-form-control"
					name="cfgfilename" value="" size="20" />&nbsp;&nbsp; <select
					name="filetype" class="mg-form-control" style="height:30px;"
					id="filetype">
					<option value="0">选择文件类别</option>
					<option value="1">脚本</option>
					<option value="2">图片</option>
					<option value="3">配置文件</option>
					<option value="4">账号</option>
					<option value="5">视频</option>
					<option value="6">其他</option>
				</select>&nbsp; <input type="submit" class="btn btn-default" value="搜  索" />&nbsp;
			</form>
			<div class="line line-dashed"></div>
			<div>
				<table id="terminalTable" cellpadding="0" cellspacing="0"
					class="common-table data-table" align="center">
					<thead>
						<tr>
							<th class="manage-column top-left-round center-column"
								width="60px">ID</th>
							<th class="manage-column center-column">文件名称</th>
							<th class="manage-column center-column">上传位置</th>
							<th class="manage-column center-column">上传时间</th>
							<th class="manage-column center-column">管理</th>
						</tr>
					</thead>
					<tbody class="itembody">
						
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