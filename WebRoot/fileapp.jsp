<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<title>河马 · 云手机群控平台</title>
<link rel="shortcut icon"
	href="./河马 · 云手机群控平台_files/logo.ico"
	type="image/png">
<script src="./河马 · 云手机群控平台_files/jquery.min.js"
	type="text/javascript"></script>
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
var form = layui.form
        ,table = layui.table
        ,layer = layui.layer
        ,layedit = layui.layedit
        ,laydate = layui.laydate
        ,element = layui.element;
        
</script>

<script src="/layer-3.1/layer.js"></script>

<script type="text/javascript">
function edit(id){
	$("#id").val(id);
	form1.action="apk!edit";
	form1.submit();
}
function addDate(id){
	$("#id").val(id);
	form1.action="apk!addDate";
	form1.submit();
}

function offline(id,curpage){
	layer.confirm('彻底删除应用？确认后该应用将从河马云手机平台删除，若云手机安装了该应用也将同步删除，点击[取消]按钮撤销本次操作 。',{icon: 3,id:'offtips', title:'提示'}, function(index){
		
		var lurl = 'apk!offline?id='+id;
		$.ajax({
			type:"POST",		
			url:lurl,
			success:function(data){
				layer.msg("所选应用已成功删除！",{icon: 0,skin:'layui-layer-molv'},function(index){
					window.location.reload();
				});
				
			}
		});

	});
}

function batchroot(mode,id){
	if(mode == 1){
		layer.confirm('确定要批量ROOT吗?',{icon: 3, id:'rootips',title:'提示'}, function(index){
		  window.location='apk!batchauthorize?param=1&id='+id;
		  layer.close(index);
		});
	}else{
		layer.confirm('确定要取消ROOT吗?',{icon: 3, id:'norootips',title:'提示'}, function(index){
			  window.location='apk!batchauthorize?param=0&id='+id;
			  layer.close(index);
			});		
	}
}

function noqx(){
	layer.alert("demo用户没有此操作权限!",{icon: 5,id:'demotips',skin:'layui-layer-molv'});
}

function apkmarket(){
	window.location.href = "apk!market";
}

</script>
</head>

<body class="scroll">
<div class="panel content-s">
	<div class="panel-heading">我的应用</div>
	
	<div class="panel-content">
	          <form id="mainForm" class="form-inline" name="form1" action="apk.action" method="post">
	          <input type="hidden" id="currentPage" name="currentPage">
	          <input type="hidden" id="id" name="id" value="">
		 		<div class="form-toolbar">
		 		
		 		<div class="btn btn-primary" onclick="window.open('apk!add?mode=2','_blank')">
					<i class="icon-upload-alt"> </i>
					直接上传
				</div>
		 		<div class="btn btn-default" onclick="apkmarket();">
					<i class="icon-table"></i>
					从应用市场添加
				</div>
				<div class="btn btn-default" onclick="window.open('apk!uploadvialink','_blank');" style="margin-right:20px;">
					<i class="icon-link"></i>
					添加应用下载链接&nbsp;<span class="red">New</span>
				</div>
						 		
				<b>应用名称:</b>
				<input type="text" class="mg-form-control" name="appname" id="appname" value="">
				<b>APPID:</b>
				<input type="text" class="mg-form-control" name="appid" id="appid"  onkeyup="this.value=this.value.replace(/\D/g,'')"/>
				<input type="submit" class="btn btn-default" value="搜  索"/>&nbsp;
				</div>	
		    	<div class="line line-dashed"></div>   	
 	
		<table id="terminalTable" cellpadding="0" cellspacing="0" class="common-table data-table">
			<thead>
				<tr>
				<th class="manage-column top-left-round  center-column" width="60px">ID</th>
				<th class="manage-column center-column">应用名称</th>
				<th class="manage-column center-column">APK名称</th>
				<th class="manage-column center-column">版本号</th>
				<th class="manage-column center-column">APPID</th>
				<th class="manage-column center-column">来源</th>
				<th class="manage-column center-column">管&nbsp;理</th>
				</tr>  
			</thead>   
			<tbody>
				
			</tbody>
			<tfoot>
				<tr>
					<td colspan="7" align="right"><br/>
			<script type="text/javascript">
			function firstPage(){
				document.getElementById("currentPage").value="1";
				form1.submit();
			}
			function previousPage(){
				document.getElementById("currentPage").value=currentPage-1;
				form1.submit();
			}
			function nextPage(){
				document.getElementById("currentPage").value=currentPage+1;
				form1.submit();
			}
			function lastPage(){
				document.getElementById("currentPage").value=totalPage;
				form1.submit();
			}
			
			var totalPage = 0;
			
			var totalNumber = 0;
			var pageSize =50;
			
			var currentPage = 1;
			
			if (totalNumber % pageSize == 0) {
			    totalPage = totalNumber / pageSize;		
			} else {
			    totalPage = Math.floor(totalNumber/pageSize) + 1;		
			}
			
			document.write('共 <b><font color=red>'+ totalNumber +'</font></b> 条记录 ');
			
			if (currentPage == 1){
			    document.write('&nbsp;&nbsp;首页&nbsp;&nbsp;上一页');		
			} else {	
			    document.write('&nbsp;&nbsp;<a href="#" onclick="firstPage()">首页</a>');
			    document.write('&nbsp;&nbsp;<a href="#" onclick="previousPage()">上一页</a>');
			}
			
			if (currentPage >= totalPage){
			    document.write('&nbsp;&nbsp;下一页&nbsp;&nbsp;尾页');		
			} else {
			   	document.write('&nbsp;&nbsp;<a href="#" onclick="nextPage()">下一页</a>');
			    document.write('&nbsp;&nbsp;<a href="#" onclick="lastPage()">尾页</a>');		
			}
			
			document.write('&nbsp;&nbsp;页次:<b><font color=red>'+ currentPage +'/'+ totalPage +'</font></b>页&nbsp;&nbsp;');
			document.write('<b><font color=red>'+ pageSize +'</font></b>条/页 ');
			</script>						
					
					</td>
				</tr>
			</tfoot>
			</table>
		</form>
	</div>	
</div>
</body>
</html>