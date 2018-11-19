<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- saved from url=(0044)https://lcloud.longene.com.cn/userWeb.action -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>升级兔· 云手机群控平台</title>
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
<style type="text/css">
.fr {
	float: right
}

.fl {
	float: left
}

.disn {
	display: none
}

.help {
	position: absolute;
	z-index: 5555;
	width: 100%;
	height: 100%;
	background: none rgba(0, 0, 0, 0.3);
	display: none;
	overflow: hidden;
}

.help .close {
	float: right;
	font-size: 40px;
	color: #fff;
	width: 40px;
	height: 40px;
	line-height: 36px;
	text-align: center;
	background: none
}

.help .close:hover {
	background: none rgba(0, 0, 0, 0.7)
}

.help .step {
	position: absolute;
	color: #eee;
	padding: 10px 12px 15px;
	background: none rgba(0, 0, 0, 0.7);
	border-radius: 5px;
	display: none;
	z-index: 5555;
}

.help .step p {
	margin-bottom: 0;
}

.help .step .jt {
	font-size: 0;
	height: 0;
	border: 12px solid rgba(0, 0, 0, 0);
	position: absolute
}

.help .step .jt_left {
	border-right: 20px solid rgba(0, 0, 0, 0.7)
}

.help .step .jt_right {
	border-left: 20px solid rgba(0, 0, 0, 0.7)
}

.help .step .jt_top {
	border-bottom: 20px solid rgba(0, 0, 0, 0.7)
}

.help .step .jt_bottom {
	border-top: 20px solid rgba(0, 0, 0, 0.7)
}

.help .step .h1 {
	font-size: 20px;
	font-weight: bold
}

.help .step .h2 {
	font-size: 16px;
	font-weight: bold;
	padding-left: 10px
}

.help .step .next, .help .step .over {
	border: 1px solid #fff;
	color: #fff;
	padding: 0 5px;
	float: right;
	margin-top: 1px
}

.help .step .next:hover, .help .step .over:hover {
	background: none rgba(50, 50, 50, 0)
}

.code-qr-xcx {
	display: none;
}

.qr-entrance:hover>.code-qr-xcx {
	display: block;
	position: absolute;
	padding: 0px 20px 10px;
	text-align: center;
	background: #fff;
	box-shadow: 0 0 10px #888888;
	z-index: 9999;
}

body .myskin .layui-layer-title {
	background-color: transparent; /*背景透明*/
	box-shadow: 0 0 0 rgba(0, 0, 0, 0); /*前景无阴影*/
}
</style>
<script type="text/javascript">
	var groupid = 0;
	var inpreview = 0;
	var selids = "";
	var searchids = "";
	var bfirst = 0;
	var bpopup = 1;

	//判断访问终端
	var browser = {
		versions : function() {
			var u = navigator.userAgent,
				app = navigator.appVersion;
			return {
				trident : u.indexOf('Trident') > -1, //IE内核
				presto : u.indexOf('Presto') > -1, //opera内核
				webKit : u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
				gecko : u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
				mobile : !!u.match(/AppleWebKit.*Mobile.*/), //是否为移动终端
				ios : !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
				android : u.indexOf('Android') > -1 || u.indexOf('Adr') > -1, //android终端
				iPhone : u.indexOf('iPhone') > -1, //是否为iPhone或者QQHD浏览器
				iPad : u.indexOf('iPad') > -1, //是否iPad
				webApp : u.indexOf('Safari') > -1, //是否web应该程序，没有头部与底部
				weixin : u.indexOf('MicroMessenger') > -1, //是否微信 （2015-01-22新增）
				qq : u.match(/\sQQ/i) == " qq" //是否QQ
			};
		}(),
		language : (navigator.browserLanguage || navigator.language).toLowerCase()
	}
	
	function clicknav(url){
		$('iframe').attr('src',url);
	}

	/**
	 * 页面初始化
	 */
	 /**
	function init() {
		var radios = document.getElementsByName("gradio");
		for (var i = 0; i < radios.length; i++) {
			if (radios[i].value == groupid) {
				radios[i].checked = true;
			}
		}
		radiochange(groupid, 'group0', 'cb0', 'divc0', '未分组');

		refreshgroup();

		//if(inpreview == 0){
		snapshow.location.href = "userWeb!devsingroup?groupid=" + groupid + "&ids=" + selids;
		//}

		var isbuy = 0;
		if (isbuy == 1) {
			snapshow.location.href = "userApply.action";
		}

		//判断是否safari app
		if (browser.versions.trident) {

			document.getElementById("msgno").style.display = '';
		//ayer.alert("建议使用谷歌chrome 64及以上版本浏览器，safari下部分功能可能无法正常使用。",{icon:7,skin:'layui-layer-molv'}); 
		}
		//判断是否移动端 
		if (browser.versions.mobile || browser.versions.android || browser.versions.ios) {
			layer.alert("不建议您使用移动端浏览器访问本系统", {
				icon : 7,
				skin : 'layui-layer-molv'
			});
		}

		if (bpopup == 1) {

			var newsid = 0;
			if (newsid > 0) {
				layer.open({
					type : 2,
					//title:['公告详情', 'font-size:18px;'],
					title : false,
					closeBtn : 0, //不显示关闭按钮
					resize : false,
					skin : 'myskin',
					area : [ '700px', '460px' ],
					shade : [ 0.9, '#393D49' ],
					content : 'userNews!shownews?id=0',
					cancel : function(index, layero) {
						layer.close(index);
					}
				});
			}
		}
	}
*/
	/**
	 * radio选择框变化时的函数
	 */
	function radiochange(id, m, n, hide, gname) {
		var radios = document.getElementsByName("gradio");
		for (var i = 0; i < radios.length; i++) {
			if (radios[i].checked) {
				//去除其他分组设备的选中状态
				var chkbox = document.getElementsByName("groupradio");
				for (var j = 0; j < chkbox.length; j++) {
					if (chkbox[j].id != m)
						chkbox[j].checked = false;
					else
						chkbox[j].checked = true;
				}

				var chkbox2 = document.getElementsByName("cbs");
				var devsel = 0;
				var ids = "";
				for (var x = 0; x < chkbox2.length; x++) {
					if (chkbox2[x].type == "checkbox" && chkbox2[x].id != n)
						chkbox2[x].checked = false;else {
						chkbox2[x].checked = true;
						devsel++;
						ids += "," + chkbox2[x].value;
					}
				}
				if (ids != "")
					ids = ids.substring(1);

				document.getElementById("devsel").innerHTML = devsel;
				selids = ids;
				groupid = radios[i].value;
				break;
			}

		}

		var divcs = document.getElementsByName("divc");
		for (var k = 0; k < divcs.length; k++) {
			if (divcs[k].id == hide)
				divcs[k].style.display = "";
			else
				divcs[k].style.display = "none";
		}

		//右侧设备截图清空
		//判断是否需要刷新iframe内页面
		var ltxt = snapshow.location.href;
		//if(inpreview == 1 && ltxt.indexOf("userWeb") >= 0)
		if (ltxt.indexOf("userWeb") >= 0)
			snapshow.location.href = "userWeb!devsingroup?groupid=" + groupid + "&ids=" + selids;
			//inpreview = 0;

	}

	var timer = setInterval(refreshgroup, 30000);


	function launchtimer() {
		timer = setInterval(refreshgroup, 30000);
	}

	/**
	 * checkbox选择框发生变化时函数
	 */
	function altselect(cbsid) {
		var cb = "cb" + groupid;
		var cbs = "";
		var obj = document.getElementsByName("cbs");
		var selnum = 0;
		for (var i = 0; i < obj.length; i++) {
			if (obj[i].checked == true && obj[i].id == cb) {
				selnum++;
				cbs = cbs + "," + obj[i].value;
			}
		}
		document.getElementById("devsel").innerHTML = selnum;

		if (cbs.indexOf(",") >= 0) {
			cbs = cbs.substring(1, cbs.length);
		}

		/*if(cbs == ""){
			layer.alert("请选择设备！");
			return false;
		}*/
		var ltxt = snapshow.location.href;
		//if(inpreview == 1)
		if (ltxt.indexOf("userWeb") >= 0)
			snapshow.location.href = "userWeb!devsingroup?groupid=" + groupid + "&ids=" + cbs;
		selids = cbs;
	}

	/**
	 * 删除分组函数
	 */
	function deletegroup(id) {
		layer.confirm('默认情况下，删除分组会清理云机上的应用，如需保留，请点击“保留应用”按钮，否则请选择“清理应用”按钮。点击“取消”按钮撤销本次操作。',
			{
				icon : 7,
				title : '提示信息',
				skin : 'layui-layer-molv',
				btn : [ '保留应用', '清理应用', '取消' ],
				btn1 : function(index) {
					var lurl = window.location.protocol + "://" + window.location.host + "/cardgroup!delete?breserved=1&id=" + id;
					$.ajax({
						type : "POST",
						url : lurl,
						async : true,
						success : function(data) {

							if (groupid == id)
								top.window.location.href = "userWeb?groupid=0";
							else
								top.window.location.href = "userWeb?groupid=" + groupid;
							layer.close(index);
						}
					});
				},
				btn2 : function(index) {
					var lurl = window.location.protocol + "://" + window.location.host + "/cardgroup!delete?breserved=0&id=" + id;
					$.ajax({
						type : "POST",
						url : lurl,
						async : true,
						success : function(data) {

							if (groupid == id)
								top.window.location.href = "userWeb?groupid=0";
							else
								top.window.location.href = "userWeb?groupid=" + groupid;
							layer.close(index);
						}
					});
				}
			});
	}

	/**
	 * 点击预览按钮函数
	 */
	function preview() {
		var isonsync = snapshow.syncid;
		if (isonsync > 0) {
			return false;
		}

		$("#liview").trigger("click");

		var objname = "lbl" + groupid;
		var gdevs = document.getElementById(objname).innerHTML;
		if (gdevs == 0) {
			layer.alert("请先增加组内云手机！", {
				icon : 7,
				skin : 'layui-layer-molv'
			});
			return false;
		}

		var cb = "cb" + groupid;
		var chkboxs = document.getElementsByName("cbs");
		var cbs = "";
		for (var i = 0; i < chkboxs.length; i++) {
			if (chkboxs[i].checked == true && chkboxs[i].id == cb) {
				cbs = cbs + "," + chkboxs[i].value;
			}
		}
		if (cbs.indexOf(",") >= 0) {
			cbs = cbs.substring(1, cbs.length);
		}

		if (cbs == "") {
			layer.alert("请选择云手机！", {
				icon : 7,
				skin : 'layui-layer-molv'
			});
			return false;
		}

		snapshow.location.href = "userWeb!devsingroup?groupid=" + groupid + "&ids=" + cbs;
		/*
		layer.load(0, {
			shade: [0.5, '#393D49'],
			shadeClose : true
		});
		
		setTimeout(function(){
			  layer.closeAll('loading');
		}, 2000);
		*/
		inpreview = 1;

	}

	/**
	 * 新建分组函数
	 */
	function newgroup() {
		var openUrl = "userWeb!addgroup"; //弹出窗口的url
		layer.open({
			type : 2,
			//title:['新建分组', 'font-size:18px;'],
			title : false,
			resize : false,
			closeBtn : 0,
			skin : 'layui-layer-molv',
			area : [ '380px', '280px' ],
			shade : [ 0.9, '#393D49' ],
			scrollbar : false,
			content : openUrl,
			cancel : function(index, layero) {
				layer.close(index);
			}
		});
	}

	/**
	 * 管理分组内手机函数
	 */
	function modifygroup(id) {
		layer.open({
			type : 2,
			title : false,
			closeBtn : 0,
			shadeClose : false,
			resize : false,
			skin : 'layui-layer-molv',
			area : [ '960px', '620px' ],
			shade : [ 0.9, '#393D49' ],
			content : 'userWeb!addsubdev?groupid=' + id,
			success : function() {
				//bpopup = 1;
			},
			cancel : function(index, layero) {
				//parent.window.location.reload();
				layer.close(index);
			},
			end : function() {
				//bpopup = 0;
			}
		});
	}
	/**
	 * 修改密码函数
	 */
	function editprofile() {
		var openUrl = "user!toeditprofile"; //弹出窗口的url
		layer.open({
			type : 2,
			title : [ '修改资料', 'font-size:18px;' ],
			resize : false,
			skin : 'layui-layer-molv',
			area : [ '420px', '460px' ],
			shade : [ 0.9, '#393D49' ],
			content : openUrl,
			cancel : function(index, layero) {
				layer.close(index);
			}
		});

	}
	/**
	 * 分组应用管理
	 */
	function issueapk(id) {
		var openUrl = "cardgroup!toSelectApk?id=" + id; //弹出窗口的url
		layer.open({
			type : 2,
			title : [ '分组应用管理', 'font-size:18px;' ],
			resize : false,
			skin : 'layui-layer-molv',
			area : [ '600px', '400px' ],
			shade : [ 0.9, '#393D49' ],
			content : openUrl,
			cancel : function(index, layero) {
				layer.close(index);
			}
		});

	}
	/**
	 * 
	 */
	function showhide(radioid, TagName) {
		var radioobj = document.getElementById(radioid);
		if (radioobj.checked == true) {
			var obj = document.getElementById(TagName);
			if (obj.style.display == "") {
				obj.style.display = "none";
			} else {
				obj.style.display = "";
			}
		}
	}

	function toshowhide(TagName) {
		var obj = document.getElementById(TagName);
		if (obj.style.display == "") {
			obj.style.display = "none";
		} else {
			obj.style.display = "";
		}
	}

	/**
	 * 修改分组名称函数，使用弹出层
	 */
	function groupedit(m, groupid) {
		var gname = document.getElementById(m).innerHTML;
		var openUrl = "userWeb!tomodifygname?groupid=" + groupid; //弹出窗口的url
		layer.open({
			type : 2,
			//title:['修改分组名称', 'font-size:18px;'],
			title : false,
			closeBtn : 0,
			resize : false,
			skin : 'layui-layer-molv',
			area : [ '420px', '280px' ],
			shade : [ 0.9, '#393D49' ],
			scrollbar : false,
			content : openUrl,
			cancel : function(index, layero) {
				layer.close(index);
			}
		});

	}


	/**
	 * 导航菜单函数
	 
	function showbox(id) {
		var isonsync = snapshow.syncid;
		if (isonsync > 0) {
			return false;
		}

		if (id == 1) {
			var cb = "cb" + groupid;
			var chkboxs = document.getElementsByName("cbs");
			var cbs = "";
			for (var i = 0; i < chkboxs.length; i++) {
				if (chkboxs[i].checked == true && chkboxs[i].id == cb) {
					cbs = cbs + "," + chkboxs[i].value;
				}
			}
			if (cbs.indexOf(",") >= 0) {
				cbs = cbs.substring(1, cbs.length);
			}
			//获取页面上所选择的groupid
			//if(inpreview == 1)
			snapshow.location.href = "userWeb!devsingroup?groupid=" + groupid + "&ids=" + cbs;
		//else
		//snapshow.location.href = "userWeb!devsingroup?groupid="+groupid+"&ids=0";
		} else if (id == 2) {
			snapshow.location.href = "apk.action";
		} else if (id == 3) {
			snapshow.location.href = "userFiles.action";
		} else if (id == 4) {
			snapshow.location.href = "userApply.action";
			$("#liorder").trigger("click");
		} else if (id == 5) {
			snapshow.location.href = "userApply!devservice";
		} else if (id == 6) {
			snapshow.location.href = "inviteDetail!userList";
		} else if (id == 7) {
			snapshow.location.href = "coinDetail!userList";
		} else if (id == 8) {
			snapshow.location.href = "inviteDetail!invite";
		}
	}
	*/
	/**
	 * 切换到旧版本
	 */
	function oldversion() {
		window.location.href = "userWeb!gotooldversion";
	}
	/**
	 * 查看帮助文件
	 */
	function viewhelp() {
		window.open("userWeb!help", "_blank");
	//snapshow.location.href = "userWeb!help";
	}

	/**
	 * 
	 */
	function applytry() {
		var trybtn = document.getElementById("trybtn");
		trybtn.style.display = "none";
		var lurl = window.location.protocol + "://" + window.location.host + "/login!applydev";
		$.ajax({
			type : "POST",
			url : lurl,
			async : false,
			success : function(data) {

				if (data == 0) {
					refreshgroup();
				}
				if (data == 1) {
					layer.alert("抱歉，暂时没有资源，请稍后再来申请！", {
						icon : 7,
						skin : 'layui-layer-molv'
					});
					trybtn.style.display = "";
				}
				window.location.reload();
			}
		});
	}


	/**
	 * 查看公告信息
	 */
	function viewmsg(id) {
		layer.open({
			type : 2,
			title : false,
			closeBtn : 0, //不显示关闭按钮
			resize : false,
			area : [ '700px', '460px' ],
			skin : 'myskin',
			shade : [ 0.9, '#393D49' ],
			content : 'userNews!shownews?id=' + id,
			cancel : function(index, layero) {
				parent.window.location.reload();
				layer.close(index);
			}
		});

	}

	function refreshafteroperate() {
		refreshgroup();
		snapshow.location.href = "userWeb!devsingroup?groupid=" + groupid + "&ids=" + selids;
	}

	/**
	 * 修改云机备注信息
	 */
	function memo(id) {
		var openUrl = "userWeb!toremarkdevid?id=" + id; //弹出窗口的url
		layer.open({
			type : 2,
			title : [ '修改云机备注', 'font-size:18px;' ],
			resize : false,
			skin : 'layui-layer-molv',
			area : [ '400px', '240px' ],
			shade : [ 0.2, '#393D49' ],
			scrollbar : false,
			content : openUrl,
			cancel : function(index, layero) {
				layer.close(index);
			}
		});

	}


	/**
	 * Ajax单独刷新分组中设备列表信息
	 * id为分组id
	 */
	function refreshgroup() {
		var checkstr = "," + selids + ",";
		var bodyid = "divc" + groupid;
		var tbody = document.getElementById(bodyid);
		dwr.util.removeAllRows(tbody);
		var lurl = "userWeb!getuserdeviceinfo?groupid=" + groupid;
		var cbid = "cb" + groupid;
		$.ajax({
			type : "POST",
			url : lurl,
			async : true,
			success : function(data) {
				if (data == 0 || data == "" || data.indexOf("debug") != -1) { //session失效,跳转到登录界面
					//top.window.loaction.href="login!index";
					return false;
				} else {
					var selnum = 0;
					//动态添加数据
					if (data != "" && data.indexOf("#") >= 0) {
						var obj = new Array();
						obj = data.split(",");
						for (var i = 0; i < obj.length; i++) {
							var dev = obj[i].split("#");
							var row = tbody.insertRow(i);
							var td1 = row.insertCell(0);
							var td2 = row.insertCell(1);
							var td3 = row.insertCell(2);
							var td4 = row.insertCell(3);
							var td5 = row.insertCell(4);
							var td6 = row.insertCell(5);

							td1.style.cssText = "width=\"14px\"";
							td2.style.cssText = "text-align:left;";
							td3.setAttribute("class", "left-column");
							td4.setAttribute("class", "left-column");

							td5.setAttribute("class", "center-column");
							td6.setAttribute("class", "left-column");

							td4.id = "remark" + dev[0];
							td4.value = dev[0];
							td4.onclick = function() {
								memo(this.value);
							};
							td4.onmouseover = function() {
								this.style.backgroundColor = "#DBDB70";
							}
							td4.onmouseout = function() {
								this.style.backgroundColor = "#FFFFFF";
							} //这种方法在IE和火狐下面都有效   在这里this代表的是div2

							var str = new Array();
							str = searchids.split(",");
							for (var x = 0; x < str.length; x++) {
								if (str[x] == dev[0])
									td1.innerHTML = "<i class=\"icon-ok red\"></i>";
							}

							/*if(searchids.indexOf(""+dev[0]) != -1)
								td1.innerHTML = "<i class=\"icon-ok red\"></i>";*/

							if (checkstr.indexOf("," + dev[0] + ",") >= 0) {
								selnum++;
								td2.innerHTML = '<input type="checkbox" name="cbs" id="' + cbid + '" value="' + dev[0] + '" checked="checked" onchange="altselect(' + cbid + ')" >';
							} else
								td2.innerHTML = '<input type="checkbox" name="cbs" id="' + cbid + '" value="' + dev[0] + '" onchange="altselect(' + cbid + ')" >';

							td3.innerHTML = dev[0];

							if (dev[1] == 'null') {
								td4.setAttribute("title", "");
								td4.innerHTML = "<span class=\"line-tow\"></span>";
							} else {
								td4.setAttribute("title", "备注:" + dev[1] + "");
								td4.innerHTML = "<span class=\"line-tow\"></span><span class=\"nowrap note\">" + dev[1] + "</span>";
							}
							td5.innerHTML = dev[2];

							var strpic = "";
							var strexpire = "";
							if (dev[3] == 0)
								strpic = "&nbsp;<img src='/userweb/images/i_zc.png'/>";
							else if (dev[3] == 1)
								//td4.innerHTML = '<font color="blue">重启中</font>';
								strpic = "&nbsp;<img src='/userweb/images/i_zc.png'/>";
							else if (dev[3] == 2)
								strpic = "&nbsp;<img src='/userweb/images/i_az.png'/>";
							else if (dev[3] == 3)
								strpic = "&nbsp;<img src='/userweb/images/i_gz.png'/>";
							else if (dev[3] == 4)
								strpic = '<font color="blue">预启动</font>';
							else if (dev[3] == 5)
								strpic = "&nbsp;<img src='/userweb/images/i_zc.png'/>";
							else if (dev[3] == 7)
								strpic = '<font color="blue">退出控制</font>';
							if (dev[4] <= 3 && dev[4] > 0)
								strexpire = '<span class="data-text" style="">' + dev[4] + '天后到期</span>';
							else if (dev[4] <= 0 && dev[5] > 0)
								strexpire = '<span class="data-text" style="">' + dev[5] + '小时后到期</span>';
							else if (dev[5] <= 0)
								strexpire = '<span class="data-text" style="">' + dev[6].substring(11, 19) + '&nbsp;到期</span>';
							td6.innerHTML = strpic + "&nbsp;" + strexpire;
						}

					//判断是否需要刷新iframe内页面
					//var ltxt = snapshow.location.href;
					//if(inpreview == 1 && ltxt.indexOf("userWeb") >= 0)
					//snapshow.location.href = "userWeb!devsingroup?groupid="+groupid+"&ids="+selids;
					}

					document.getElementById("devsel").innerHTML = selnum;
				}

			},
			error : function() {
				window.clearInterval(timer);
				layer.alert("因长时间未操作，session超时，请刷新页面后重新登录！", {
					icon : 5,
					id : "alarm",
					skin : 'layui-layer-molv'
				});
				return false;
			}
		});

	}

	function menuchange() {
		var isonsync = snapshow.syncid;
		if (isonsync > 0) {
			return false;
		}

	//$("#liorder").trigger("click"); 
	}

	function noqx() {
		layer.alert("demo用户没有此操作权限！", {
			icon : 5,
			skin : 'layui-layer-molv'
		});
	}

	function gmtc() {
		layer.open({
			type : 2,
			title : false,
			closeBtn : 0,
			resize : false,
			skin : 'layui-layer-molv',
			area : [ '960px', '620px' ],
			shade : [ 0.9, '#393D49' ],
			content : 'userApply!itemchoice',
			cancel : function(index, layero) {
				parent.window.snapshow.location.href = "userApply.action";
				layer.close(index);
			}
		});
	}

	function activationCodeInput() {
		layer.open({
			type : 2,
			title : false,
			closeBtn : 0,
			area : [ '600px', '620px' ],
			shade : [ 0.9, '#393D49' ],
			content : 'userApply!activationCodeInput',
		});
	}

	function coinRecharge() {
		layer.open({
			type : 2,
			title : false,
			closeBtn : 0,
			resize : false,
			skin : 'layui-layer-molv',
			area : [ '960px', '620px' ],
			shade : [ 0.9, '#393D49' ],
			content : 'coinRecharge.action',
			cancel : function(index, layero) {
				parent.window.snapshow.location.href = "userApply.action";
				layer.close(index);
			}
		});
	}

	function isearch() {
		var searchtxt = document.getElementById("yjid").value;
		if (searchtxt == '') {
			//layer.alert("请输入要查找的云机id或者备注！",{icon: 5,skin:'layui-layer-molv'});
			searchids = "";
			return false;
		}

		//验证是否含有 ^%&',;=?$\" 等字符：[^%&',;=?$\x22]+
		var reg0 = /[@#$%\^&\*]+/g;
		if (reg0.test(searchtxt)) {
			layer.alert(searchtxt + " 不能包含^%&',;=?$\"反斜杠等字符!", {
				icon : 7,
				skin : 'layui-layer-molv'
			});
			return false;
		}

		var sreg = /[^\u4e00-\u9fa5a-zA-Z0-9]/g;
		if (sreg.test(searchtxt)) {
			layer.alert("只允许输入中文、英文字母和数字！", {
				icon : 7,
				id : 'alarm1',
				skin : 'layui-layer-molv'
			});
			return false;
		}

		var lurl = "userWeb!idsearch?searchtxt=" + escape(encodeURIComponent(searchtxt));
		$.ajax({
			type : "POST",
			url : lurl,
			async : true,
			success : function(data) {
				var obj = new Array();
				obj = data.split("#");
				if (obj.length > 0) {
					if (obj[0] == '0') {
						layer.alert("没有找到匹配的云机设备！", {
							icon : 7,
							id : 'batchoper',
							skin : 'layui-layer-molv'
						});

						searchids = "";
						var m = 'group' + groupid;
						var n = 'cb' + groupid;
						var hide = 'divc' + groupid;
						var gnameid = 'gname' + groupid;
						var groupname = document.getElementById(gnameid).innerHTML;
						var radioid = 'radio' + groupid;
						document.getElementById(radioid).checked = true;
						radiochange(groupid, m, n, hide, groupname);

						refreshgroup();

					//return false;
					} else {
						searchids = obj[2];
						var xg = obj[1].split(",");
						groupid = xg[0];

						//init();	 

						var m = 'group' + groupid;
						var n = 'cb' + groupid;
						var hide = 'divc' + groupid;
						var gnameid = 'gname' + groupid;
						var groupname = document.getElementById(gnameid).innerHTML;
						var radioid = 'radio' + groupid;
						document.getElementById(radioid).checked = true;
						radiochange(groupid, m, n, hide, groupname);

						refreshgroup();


					}
				}
			}
		});
	}

	function reloadmsg(url) {
		//$("#msgid").trigger("click"); 
		window.location.href = "userWeb.action?groupid=" + groupid;
	}

	function markallread() {
		layer.confirm('确认要全部标记为已读吗?', {
			icon : 3,
			title : '提示信息',
			skin : 'layui-layer-molv'
		}, function(index) {
			var lurl = window.location.protocol + "://" + window.location.host + "/userNews!marknewsread";
			$.ajax({
				type : "POST",
				url : lurl,
				async : true,
				success : function(data) {
					window.location.reload();
					layer.close(index);
				}
			});
		});
	}
</script>
</head>

<body id="gcontrol" onload="init()">
	<div class="help">
		<div id="step1" class="step" step="1"
			style="left:0;top:0;width:100%;height:100%;margin:0;">
			<p
				style="position: relative;margin:100px auto;text-align:center;border:none;width:850px;height:368px;">
				<img src="./河马 · 云手机群控平台_files/yd_step.png">
			</p>
			<div class="next"
				style="position:absolute;top:0;left:0;cursor: pointer;width:100%;;height:100%;border:none;">
			</div>
			<p></p>
		</div>
		<div id="step2" class="step" step="2"
			style="top:195px;left:73px;width:328px">
			<b class="jt jt_left" style="top:20px;left:-31px;"></b>
			<p>
				<span class="h2">勾选云手机id,云手机会在右侧显示</span> <a
					href="https://lcloud.longene.com.cn/userWeb.action###" class="next">下一步</a>
			</p>
		</div>
		<div id="step3" class="step" step="3"
			style="top:120px;left:260px;width:250px">
			<b class="jt jt_top" style="top:-31px;left:40px"></b>
			<p>
				<span class="h2">分组内添加云手机</span> <a
					href="https://lcloud.longene.com.cn/userWeb.action###" class="next">
					下一步 </a>
			</p>
		</div>
		<div id="step4" class="step" step="4"
			style="top:65px;left:380px;width:250px">
			<b class="jt jt_top" style="left:20px;top:-31px"></b>
			<p>
				<span class="h2">上传应用至云手机</span> <a
					href="https://lcloud.longene.com.cn/userWeb.action###" class="next">下一步</a>
			</p>
		</div>
		<div id="step5" class="step" step="5"
			style="top:275px;left:50%;margin-left:-160px;width:320px">
			<p>
				<span class="h2"> 恭喜您，新手指引已完成！<br>
				</span> <a href="https://lcloud.longene.com.cn/userWeb.action###"
					class="over">开始操作</a>
			</p>
		</div>
	</div>
	<script type="text/javascript">
		if (bfirst == 1) {
			$(function() {
				$('.help').show();
				$('#step1').show();
				$('.close').on('click', function() {
					$('.step').hide();
					$('.help').hide();
				});
				$('.next').on('click', function() {
					var obj = $(this).parents('.step');
					var step = obj.attr('step');
					obj.hide();
					$('#step' + (parseInt(step) + 1)).show();
				});
				$('.over').on('click', function() {
					$(this).parents('.step').hide();
					$('.help').hide();
				});
			});
		}
	</script>
	<div id="wrapper">
		<div class="header hd-manga hd-ab">
			<h1 class="logo pull-left">
				<img src="./河马 · 云手机群控平台_files/logo.ico" style="width:50px;">
				<span>&nbsp;&nbsp;升级兔&nbsp;</span>

			</h1>
			<ul class="nav navbar-main pull-left">
				<li id="liview" class="navbtn active"><a
					onclick="clicknav('./show.jsp')">云机预览</a></li>
				<li id="liapk" class="navbtn"><a
					onclick="clicknav('./fileapp.jsp')"><i class="icon-upload-alt"></i>上传应用</a> <!-- <a href="#"  onclick="showbox(2)">应用管理</a> -->
				</li>


				<li id="lifile" class="navbtn"><a
					onclick="clicknav('./filetext.jsp')">上传文件</a></li>

				<li id="liorder" class="navbtn"><a
					href="https://lcloud.longene.com.cn/userWeb.action#"
					onclick="showbox(5)">配套服务</a></li>
			</ul>

			<ul class="nav navbar-avatar pull-right" role="navigation">
				<li class="dropdown"><a
					href="https://lcloud.longene.com.cn/userWeb.action#"
					class="dropdown-toggle" data-toggle="dropdown"> <!-- span class="admin-name">繁华</span> -->
						<span class="thumb-small avatar inline"><img
							src="./河马 · 云手机群控平台_files/avatar.jpg" class="img-circle"></span> <b
						class="icon-caret-down hidden-sm-only"></b>
				</a>
					<ul class="dropdown-menu l-dropdown-menu">
						<div class="avatar-box">
							<div class="avatar-label">
								<i class="icon-bookmark"></i> 试用用户
							</div>
							<div class="line"></div>
						</div>
						<li><a href="https://lcloud.longene.com.cn/userWeb.action#"
							onclick="menuchange();showbox(8)"><span class="icon-gift"></span>&nbsp;邀请有礼</a></li>
						<li><a href="https://lcloud.longene.com.cn/userWeb.action#"
							onclick="showbox(7)"><span class="icon-bullseye"></span>&nbsp;河马币明细</a></li>
						<li><a href="https://lcloud.longene.com.cn/userWeb.action#"
							onclick="menuchange();activationCodeInput()"><span
								class="icon-exchange"></span>&nbsp;兑换激活码</a></li>
						<li><a href="https://lcloud.longene.com.cn/userWeb.action#"
							onclick="showbox(4)">订购记录</a></li>
						<li><a href="https://lcloud.longene.com.cn/userWeb.action#"
							onclick="editprofile()">修改资料</a></li>
						<li><a href="https://lcloud.longene.com.cn/login!exit">退出登录</a></li>
					</ul></li>
			</ul>
			<ul class="nav navbar hidden-sm pull-right">
				<li><span> <a target="snapshow"
						onclick="menuchange();coinRecharge()" class="btn-yellow"> 充值 </a>
				</span></li>
				<li><span> <a target="snapshow"
						onclick="menuchange();gmtc()" class="btn-yellow"> <i
							class="icon-shopping-cart"></i>订购/续费
					</a>
				</span></li>
				<li>
					<div class="m-t m-b-small" id="panel-notifications">
						<a href="https://lcloud.longene.com.cn/userWeb.action#" id="msgid"
							title="消息查看" class="dropdown-toggle" data-toggle="dropdown"><i
							class="icon-comment-alt icon-xlarge text-default"></i> </a>
						<section class="dropdown-menu m-l-small m-t-mini"> <section
							class="panel panel-large arrow arrow-top"> <header
							class="panel-heading bg-white">
						<span class="h5"><strong>你有 <span class="count-n"
								style="display: inline;">0</span> 条未读通知
						</strong></span> <input type="button" class="btn btn-small btn-default"
							value="全部已读" onclick="markallread();"> </header>
						<div class="list-group list-group-flush m-t-n"></div>
						<footer class="panel-footer text-small"> <!--  <a href="#" class="pull-right"><i class="icon-cog"></i></a> -->
						<a href="https://lcloud.longene.com.cn/userNews!showallnews"
							target="_blank">查看所有通知</a> </footer> </section> </section>
					</div>
				</li>
				<li><a href="https://lcloud.longene.com.cn/userWeb.action#"
					style="font-size:14px" onclick="viewhelp()"><span
						class="icon-question-sign" style="font-size:20px"></span>&nbsp;帮助</a>
				</li>
				<li><a href="https://lcloud.longene.com.cn/userWeb.action"
					style="font-size:14px;" class="qr-entrance"> <span
						class="icon-mobile-phone" style="font-size:20px;"></span>&nbsp;小程序
						<div class="code-qr-xcx">
							<div>微信小程序入口</div>
							<img src="./河马 · 云手机群控平台_files/code-qr-xcx.png">
						</div>
				</a></li>
			</ul>
		</div>

		<div class="window-iframe">
			<div id="msgno" class="alert alert-warning alert-dismissible"
				role="alert" style="display:none;">
				<button type="button" class="close" data-dismiss="alert"
					aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<strong>提示!</strong> 建议使用谷歌chrome 64及以上版本浏览器，safari浏览器下部分功能可能无法正常使用。
			</div>
			<iframe name="snapshow"
				src="./show.jsp"
				style="width:100%;border:none;height:100%;"></iframe>
		</div>
		<div class="panel-left scroll">
			<div class="refresh form-inline">


				<a class="btn btn-w btn-small" id="trybtn" onclick="applytry()"><i
					class="icon-plus"></i>试用申请</a>&nbsp;&nbsp; <a
					class="btn btn-w btn-small" onclick="newgroup()"><i
					class="icon-plus"></i>新建分组</a> <a class="btn btn-w btn-small"
					onclick="refreshgroup();"><i class="icon-refresh"></i>刷新</a>
			</div>

			<table class="table-left table-striped">
				<thead>
					<tr>
						<th width="14px"></th>
						<th></th>
						<th colspan="2" class="left-column">云机ID</th>
						<th class="center-column">应用</th>
						<th class="left-column">状态</th>
					</tr>
				</thead>

				<thead>
					<tr class="group"
						ondblclick="showhide(&#39;radio0&#39;,&#39;divc0&#39;);">
						<td colspan="6" lass="left-column"><input type="radio"
							name="gradio" id="radio0" value="0"
							onchange="radiochange(0,&#39;group0&#39;,&#39;cb0&#39;,&#39;divc0&#39;,&#39;未分组&#39;)">
							<!-- <i class="icon-expand-alt" onclick="showhide('radio0','divc0');"></i>-->
							<!-- <input type="checkbox" name="groupradio" id="group0"  value="0" onchange="checkall('group0','cb0','divc0','未分组');" /> -->
							<span id="gname0">未分组</span>&nbsp;&nbsp;(&nbsp;<font color="red"><label
								id="lbl0">0</label></font>&nbsp;) <span class="btn-icon-bar"> </span></td>
					</tr>

				</thead>
				<tbody name="divc" id="divc0"></tbody>

				<thead>
					<tr class="group"
						ondblclick="showhide(&#39;radio10920&#39;,&#39;divc10920&#39;);">
						<td colspan="6" lass="left-column"><input type="radio"
							name="gradio" id="radio10920" value="10920"
							onchange="radiochange(10920,&#39;group10920&#39;,&#39;cb10920&#39;,&#39;divc10920&#39;,&#39;小号云机&#39;)">
							<!-- <i class="icon-expand-alt" onclick="showhide('radio10920','divc10920');"></i>-->
							<!-- <input type="checkbox" name="groupradio" id="group10920"  value="10920" onchange="checkall('group10920','cb10920','divc10920','小号云机');" /> -->
							<span id="gname10920">小号云机</span>&nbsp;&nbsp;(&nbsp;<font
							color="red"><label id="lbl10920">1</label></font>&nbsp;) <span
							class="btn-icon-bar"> <i class="icon-plus" title="增加云机"
								onclick="modifygroup(10920)"></i> <i class="icon-pencil"
								title="编辑" onclick="groupedit(&#39;gname10920&#39;,10920)"></i>


								<i class="icon-trash" title="删除分组" onclick="deletegroup(10920)"></i>


						</span></td>
					</tr>

				</thead>
				<tbody name="divc" id="divc10920" style="display: none;">


					<tr style="position: relative;">
						<td width="14px"></td>
						<td><input name="cbs" id="cb10920" type="checkbox"
							value="2232" onchange="altselect(&#39;cb10920&#39;)">&nbsp;
						</td>
						<td class="left-column"><b>2232</b>&nbsp;</td>
						<td class="left-column" id="remark2232" value="2232"
							onclick="memo(2232)"
							onmouseover="this.style.backgroundColor=&#39;#DBDB70&#39;"
							onmouseout="this.style.backgroundColor=&#39;#FFFFFF&#39;"><span
							class="line-tow"></span><span class="nowrap note"></span></td>
						<td class="center-column">0</td>
						<td class="left-column"><img
							src="./河马 · 云手机群控平台_files/i_zc.png"></td>
					</tr>


				</tbody>

			</table>
			<div class="preview-bar">
				<div class="pull-left">
					已选中&nbsp;<b><font color="red"><span id="devsel">0</span></font></b>&nbsp;台云手机
				</div>
				<!--  <div class="pull-right btn btn-primary btn-large" style="position:absoult;right:0px;top:6px;" onclick="preview()"><i class="icon-play" style="font-size:12px;"></i>&nbsp;预览</div>-->
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(".navbtn").click(function() {
			$(this).siblings(".active").removeClass("active");
			$(this).addClass("active");
		});
	</script>


</body>
</html>