<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>升级兔· 云手机群控平台</title>
<link rel="shortcut icon"
	href="./河马 · 云手机群控平台_files/logo.ico"
	type="image/png">
<script src="./河马 · 云手机群控平台_files/jquery.min.js"
	type="text/javascript"></script>
<!-- Bootstrap -->
<script src="./河马 · 云手机群控平台_files/bootstrap.js"></script>
<script src="./河马 · 云手机群控平台_files/underscore-min.js"></script>
<script src="./河马 · 云手机群控平台_files/layer.js"></script>
<link rel="stylesheet" href="./河马 · 云手机群控平台_files/layer.css"
	id="layuicss-layer">
<script type="text/javascript" src="./河马 · 云手机群控平台_files/util.js"></script>
<link rel="stylesheet" type="text/css" media="all"
	href="./css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" media="all"
	href="./河马 · 云手机群控平台_files/bs.css">
<link rel="stylesheet" type="text/css" media="all"
	href="./css/style.css">
<script src="./js/simpleUpload.js"></script>
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

<link type="text/css" rel="stylesheet" media="all"
	href="/userweb/css/layerModel.css">
<script src="/userweb/js/jquery.layerModel.js"></script>
<script src="/userweb/js/underscore-min.js"></script>
<script src="/userweb/js/jquery.min.js" type="text/javascript"></script>
<script src="./layer-3.1/layer.js"></script>
<script type="text/javascript">
	var fileS = false;
	var fileN;
	var target;

	function selectfile() {
		$("#file").trigger("click");

	}
	function checkdata() {
	   if(uploadStatus===true){
	   		layer.alert("上传成功，可继续上传")
	   }else{
	   		layer.alert("上传失败，请继续上传")
	   }
	}
	function init() {
		var num = $(":checkbox[name='cb']:checked").length;
		$("#yx").html(num + "台");
	}
	function zk(groupid) {
		if ($("i[id='icon" + groupid + "']").attr("class") == "icon-sort-down") {
			$("i[id='icon" + groupid + "']").attr("class", "icon-caret-right");
		} else if ($("i[id='icon" + groupid + "']").attr("class") == "icon-caret-right") {
			$("i[id='icon" + groupid + "']").attr("class", "icon-sort-down");
		}
		$("tr[groupid='" + groupid + "']").toggle();
	}
	function qxfz(groupid) {
		if ($('#' + groupid).attr('checked')) {
			$("input[groupid='" + groupid + "']").attr("checked", "true");
		} else {
			$("input[groupid='" + groupid + "']").removeAttr("checked");
		}
		init();
	}
	function qxc() {
		if ($('#qx').attr('checked')) {
			$(":checkbox[id!='bz']").attr("checked", "true");
		} else {
			$(":checkbox[id!='bz']").removeAttr("checked");
		}
		init();
	}
	function validfilename(filename) {
		var reg = new RegExp("[\\u4E00-\\u9FFF]+", "g");
		if (reg.test(filename)) {
			layer.alert("文件名不能包含汉字!", {
				icon : 7,
				skin : 'layui-layer-molv'
			});
			return false;
		}
		var reg1 = /\[|\]|【|】|（|）|\(|\)|\{|\}|\/|\\ /g;

		if (reg1.test(filename)) {
			layer.alert("文件名不能包含括号、斜杠等特殊字符！", {
				icon : 7,
				skin : 'layui-layer-molv'
			});
			return false;
		}
		return true;
	}

	function qxcb() {
		var qx = document.getElementById("qx");
		var cb = document.getElementsByName("cb");
		if (qx.checked == true) {
			for (var i = 0; i < cb.length; i++) {
				if (cb[i].type == "checkbox")
					cb[i].checked = true;
			}
		} else {
			for (var i = 0; i < cb.length; i++) {
				if (cb[i].type == "checkbox")
					cb[i].checked = false;
			}
		}
	}
	
	var uploadStatus = false;
	function UploadFile() {
		//获取路径
		var url=$('#targeturl').val();
		$('#file').simpleUpload("file/text/", {
			start: function(file){
				//upload started
				console.log("upload started");
			},
			progress: function(progress){
				//received progress
				//上传成功
				$('#schedule').text("100%")
			},
			success: function(data){
				//upload successful
				uploadStatus=true
			},
			error: function(error){
				//upload failed
				console.log("upload error: " + error.name + ": " + error.message);
			}
		});
	}

	function changegroup() {
		var gid = document.getElementById("groupid").value;

		if (gid > 0) {
			//ajax获取分组内的板卡
			var lurl = "http://" + window.location.host + "/userFiles!getCardsInGroup?groupid=" + gid;

			$.ajax({
				type : "POST",

				url : lurl,
				async : true,
				success : function(data) {
					if (data != '') {
						var ips = data.split(',');

						$("#J_TbData").empty();
						for (var i = 0; i < ips.length; i++) {
							//动态创建一个tr行标签,并且转换成jQuery对象
							var $trTemp = $("<tr></tr>");

							//往行里面追加 td单元格
							$trTemp.append("<td class='data-column first-column center-column' width='20%''> <input type='checkbox' name='cb' value=" + ips[i] + "></td>");
							$trTemp.append("<td class='data-column first-column last-column'>&nbsp;" + ips[i] + "</td>");
							$trTemp.append("<td class='data-column first-column last-column'>&nbsp;" + ips[i] + "</td>");
							// $("#J_TbData").append($trTemp);
							$trTemp.appendTo("#J_TbData");
						}
					}

				}
			});
		} else { //移除之前的列表
			$("#J_TbData").empty();
		}

	}

	function initlbl() {
		var fileObj = document.getElementById("file").files[0];
		if (typeof (fileObj) == "undefined") {
			layer.alert('请选择要上传的文件!', {
				icon : 7
			});
		}

		document.getElementById("fileshow").innerHTML = fileObj.name;

	}

	function validfilename(filename) {
		var reg = new RegExp("[\\u4E00-\\u9FFF]+", "g");
		if (reg.test(filename)) {
			layer.alert(filename + " 不能包含汉字!", {
				icon : 7,
				skin : 'layui-layer-molv'
			});
			return false;
		}

		var reg2 = /\s/;
		if (reg2.test(filename)) {
			layer.alert(filename + " 文件名不能包含空格！", {
				icon : 7,
				skin : 'layui-layer-molv'
			});
			return false;
		}

		var reg1 = /\[|\]|【|】|（|）|\(|\)|\{|\}|&|\/|\\ /g;
		if (reg1.test(filename)) {
			layer.alert(filename + " 不能包含空格、括号、斜杠、&等特殊字符！", {
				icon : 7,
				skin : 'layui-layer-molv'
			});
			return false;
		}

		return true;
	}
</script>

</head>

<body class="scroll" onload="init()">
	<div>

		<div class="header hd-manga hd-ab">
			<h1 class="logo pull-left">
				<img src="./河马 · 云手机群控平台_files/logo.ico" style="width:50px;">
				<span>&nbsp;&nbsp;</span>
			</h1>

		</div>
		<div class="content" style="padding-top:75px;">
			<div class="panel price-menu">
				<div class="panel-content">
					<div class="s-head price-head over-flow">
						<h1 class="price-title">上传文件</h1>
						<form class="form-inline">
							<div class="mg-form-group">
								<label>选择文件类别:</label> <select name="filetype"
									class="mg-form-control" style="height:30px;width:141px;"
									id="filetype">
									<option value="0">选择文件类别</option>
									<option value="1">脚本</option>
									<option value="2">图片</option>
									<option value="3">配置文件</option>
									<option value="4">账号</option>
									<option value="5">视频</option>
									<option value="6">其他</option>
								</select>&nbsp;&nbsp;<span style="color: #CC0000" id="filetypemessage"></span>
							</div>
							<div class="mg-form-group">
								<label>文件存放路径:</label> <input type="text"
									class="mg-form-control" name="targeturl" id="targeturl"
									value="/sdcard" size="50" / disabled="disabled">&nbsp;&nbsp;<span
									style="color: #CC0000" id="savepathmessage"></span>
							</div>
							<div class="mg-form-group">
								<label>选择文件:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
								<button class="btn btn-default" onclick="selectfile()">
									<i class="icon-folder-open"></i>选择文件
								</button>
								<input type="file" name="file" id="file"
									style="opacity: 0;margin-left:-102px;width:97px;"
									onchange="initlbl();" multiple />&nbsp;&nbsp;<font
									color="green" style="font-weight:normal">支持断点续传，上传的文件名不能含有中文、括号等字符。</font>

							</div>
						</form>
					</div>
					<div class="line"></div>
					<table style="width:100%;margin-bottom:10px;">
						<tr>
							<td><img
								src="https://lcloud.longene.com.cn/userweb/images/i_word.png"
								style="width:22px;"> <span id="fileshow"></span></td>
							<td style="text-align:center;"><label>当前上传进度&nbsp;:&nbsp;&nbsp;<font
									id="schedule" color="red">0%</font>&nbsp;
							</label></td>
							<td><input id="uploadFileBtn" class="btn btn-default"
								type="button" onclick="UploadFile()" value="上传" /> <input
								id="stopFileBtn" class="btn btn-default" type="button"
								onclick="location.reload()" value="删除" />&nbsp; <span
								style="color: #CC0000" id="filemessage"></span></td>
						</tr>
					</table>
					<div class="line"></div>

					<div class="panel-footer">
						<input type="button" class="btn btn-primary btn-big" name="issue"
							value="确&nbsp;认" onclick="checkdata();" /> <input type="button"
							class="btn btn-default btn-big" name="cancel" value="取&nbsp;消"
							onclick="javascript:window.close();"> <span
							style="color: #CC0000"></span>
					</div>
				</div>
			</div>
		</div>
	</div>

	</div>

</body>
</html>