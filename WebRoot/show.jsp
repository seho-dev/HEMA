<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>河马云手机群控平台</title>
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

<script type="text/javascript">

var layernum = 1;//弹窗总数
var layerids = new Array();//已弹出设备id数组
var bsmall = 0;
var myips = 0;
var syncid = 0;
var syncip = "";
var refreshinterval = 0;
var bpopup = 0;
var informflag = '0100000000';
var number = 2232;
//循环手机列表
$(function(){
	for(var i=0;i<110;i++){
	number--;
	$('.window-list').append("<li><div name='imgwindow' class='window-panel' style='width:144; height: 144;'><div class='window-header'><div class='checkbox checkbox-small'><input name='devcb' type='checkbox' title='10.0.0.39' value='10.0.0.39'><label></label><span class='id-device' title='167772199'>ID:"+number+"</span></div><div class='level-label level-low'>高级版</div></div><div class='window-body'><div name='picscreen' class='screenPic'><img  name='snapimgs' id='snapimg_2232' width='144' height='256' src='./河马 · 云手机群控平台_files/10.0.0.39.jpg' alt='10.0.0.39' onclick='rchost('10.0.0.39',2232,0)'><div class='label-area'></div><div class='state-area'><span name='softlbl' id='softlbl2232'></span><br><span name='disklbl' id='disklbl2232'></span><br><span name='newphonelbl' id='newphonelbl2232'></span></div><ul name='ulmenu' class='window-btn'><li><button class='btn btn-primary btn-tiny' onclick='restart('snapimg_2232','10.0.0.39')'>重启云机</button></li><li><button class='btn btn-default btn-tiny' onclk='stopapp(2232)'>停止应用</button></li><li><button class='tn btn-default btn-tiny' onclick='deletedev(2232,'10.0.0.39')'>回收云机</button></li></ul><div class='screenMask' onclick='rchost('10.0.0.39',2232,0)'></div></div></div><div class='window-footer'><div><span  class='state-ip'></span></div></div></div></li>")
	}
})

function qx(){
	var qx = document.getElementById("selall");
	var devcbs = document.getElementsByName("devcb");
	if(qx.checked == true){
		for(var i = 0;i<devcbs.length;i++){
			if(devcbs[i].type == "checkbox") devcbs[i].checked = true;
		}
	}else{
		for(var i = 0;i<devcbs.length;i++){
		    if(devcbs[i].type == "checkbox") devcbs[i].checked = false;
		}
	}
}
/**
 * 获取当前页面所选择的设备ip集合
 */
function getseldevs(){
	var devcbs = "";
	var chkboxs = document.getElementsByName("devcb");
	for(var i=0;i<chkboxs.length;i++){
		if(chkboxs[i].checked == true){
			devcbs = devcbs+","+chkboxs[i].value;
		}
	}
	if(devcbs.indexOf(",")>= 0){
		devcbs = devcbs.substring(1,devcbs.length);
	}
	
	return devcbs;
	
}

/**
 * 获取当前页面所选择的设备id集合
 */
function getseldevids(){
	var devids = "";
	var chkboxs = document.getElementsByName("devcb");
	for(var i=0;i<chkboxs.length;i++){
		if(chkboxs[i].checked == true){
			devids = devids+","+chkboxs[i].id;
		}
	}
	if(devids.indexOf(",")>= 0){
		devids = devids.substring(1,devids.length);
	}
	
	return devids;
	
}

/**
 * 禁止对未分组设备进行操作
 */
function zorogroupforbidden(){
	var gid = 10920;
	if(gid == 0){
		layer.alert("不允许对未分组设备进行该操作，请先对其进行分组！",{icon:7,id:'salert',skin:'layui-layer-molv'});
		return false;
	}else return true;
}

/*
 * 批量启动分组内某一应用
 */
function batchstart(){

	if(zorogroupforbidden()){
		var cbs = getseldevs();	
		if(cbs == ""){
			layer.alert("请先选择云机！",{icon:7,id:'salert',skin:'layui-layer-molv'});
			return false;
		}else{
		
			layer.open({
				id:'bstart',
				type: 2,
				title:['批量启动应用', 'font-size:18px;'],
				skin: 'layui-layer-molv',
				area: ['400px', '250px'],
				content: 'cardgroup!tobatchstart?id=10920&cbs='+cbs,
				success: function(){
					bpopup = 1;
				},
				cancel: function(index, layero){
				    layer.close(index);
				},
				end:function(){
					bpopup = 0;
				}
			});
		}
	}
	
}

function batchnewphone(){
	
	if(zorogroupforbidden()){
		var ids = getseldevids();
		
		if(ids == ""){
			layer.alert("请先选择云机！",{icon:7,id:'abstop',skin:'layui-layer-molv'});
			return false;
		}else{
			top.layer.open({
				id:'bstop',
				type: 2,
	 			title:['批量一键新机', 'font-size:18px;'],
				skin: 'layui-layer-molv',
				area: ['600px', '400px'], 
				//content: 'cardgroup!tobatchstop?id=10920&cbs='+cbs,
				content: 'userWeb!tobatchnewphone?groupid=10920&ids='+ids,
				success: function(){
					bpopup = 1;
				},
				cancel: function(index, layero){
				    layer.close(index);
				},
				end:function(){
					bpopup = 0;
				}
			});
		}	
	}
	

	
}

/**
 * 批量停止分组内某一应用
 */
function batchstop(){
	if(zorogroupforbidden()){
		var cbs = getseldevs();
		
		if(cbs == ""){
			layer.alert("请先选择云机！",{icon:7,id:'abstop',skin:'layui-layer-molv'});
			return false;
		}else{
			layer.open({
				id:'bstop',
				type: 2,
				title:['批量停止应用', 'font-size:18px;'],
				skin: 'layui-layer-molv',
				area: ['400px', '250px'],
				content: 'cardgroup!tobatchstop?id=10920&cbs='+cbs,
				success: function(){
					bpopup = 1;
				},
				cancel: function(index, layero){
				    layer.close(index);
				},
				end:function(){
					bpopup = 0;
				}
			});
		}
	}
	
}

/**
 * 恢复出厂值和重启
 */
function batchoper(i){
	if(zorogroupforbidden()){
		var devids = getseldevids();
		if(devids == ""){
			layer.alert("请先选择云机！",{icon:7,id:'abstop',skin:'layui-layer-molv'});
			return false;
		}else{
			
			var msg = "确定要进行恢复出厂值操作吗?";
			if(i == 1){msg = "确定要批量重启云机吗？";}
			if(i == 3){msg = "确定要执行一键HOME吗？";}
			if(i == 5){msg = "确定要批量切换IP(虚拟定位)吗？";}
			if(i == 6){msg = "确定要批量关闭IP代理吗？";}
			layer.confirm(msg,{icon: 3,id:'tips11', title:'提示'},function(index){

				top.layer.load(1, {
				shade: [0.4, '#393D49'],
				shadeClose : true
				});
				
				//ajax后台操作
				var lurl = "userWeb!batchoper?groupid=10920&mode="+i+"&ids="+devids;

				$.ajax({
					type:"POST",		
					url:lurl,
					success:function(data){
						
						var obj = data.split("#");
						if(obj[0] == 1){
							top.layer.closeAll('loading');
							layer.msg("不好意思,"+obj[1],{icon:0},function(index){refresh();layer.close(index);});
						}else{
							top.layer.closeAll('loading');
							var msg = "批量操作命令已发送！";
							if(i == 2)
								msg = "批量操作命令已发送！&nbsp;若分组下已勾选应用，在恢复出厂设置后，勾选云机将重新安装分组应用!";
							layer.confirm(msg, {
								skin:'layui-layer-molv',
								btn: ['确定'] //按钮
							},
							function(index){
									refresh();
									layer.close(index);
							});

						}
									
					}});
				
				layer.close(index);
			});
			
		}	
	}
	
	
}

/**
 * 
 */
function syncdesktop(){
	if(zorogroupforbidden()){
		var cbs = getseldevs();
		var ids = getseldevids();
		var id = 0;	
		if(cbs == ""){
			layer.alert("请先选择云机！",{icon:7,id:'asyncd',skin:'layui-layer-molv'});
			return false;
		}else{
			
			//选择第一台云机作为同步对象
			var len = cbs.split(",");
			
			if(len.length <2){
				layer.alert("请至少再选择一台待同步的云机！",{icon:7,id:'tips2',skin:'layui-layer-molv'});
				return false;
			}
			
			//获取选择的第一台云机ID
			var chkboxs = document.getElementsByName("devcb");
			for(var i=0;i<chkboxs.length;i++){
				if(chkboxs[i].checked == true){
					if(chkboxs[i].value == len[0]){
						id = chkboxs[i].id;
						syncid = id;
						syncip = chkboxs[i].value;
						break;
					}
				}
			}
			
			//首次提醒用户
			if(informflag.substring(2,3) == '0'){
				var index = layer.confirm("系统自动选择第一台云机作为示例云机。同步过程中有发生部分云手机画面延迟时，可直接操作云手机.",{icon:0},function(){
					var lurl = window.location.protocol+"://"+window.location.host+"/userWeb!setinformflag?flagposition=2";
					$.ajax({
						type:"POST",		
						url:lurl,		
						async:true,
						success:function(data){
							informflag = ''+data+'';
							top.layer.open({
								id: 'syncid',
								type: 2,
								//title:['云机同步操作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;同步过程中发生部分云机画面延迟时，可直接操作云机', 'font-size:14px;'],
								title:false,
								skin:'layui-layer-molv',
								area: ['100%', '100%'],
								scrollbar: false,
								resize: false,
								closeBtn: 0,//不显示关闭按钮
								shade: 0.3,
								offset: 'lt',
								content: 'userWeb!syncdesktop?ip='+syncip+'&id='+id+'&ips='+cbs+'&ids='+ids,
								//content: 'userWeb!toseldevsync?ips='+cbs+'&ids='+ids,
								success: function(){
									layer.close(index);
								},
								cancel: function(index, layero){					
										syncid = 0;		
									    layer.close(index);
								}
							});
						}
					});
				});
				
			}else{
				top.layer.open({
					id: 'syncid',
					type: 2,
					//title:['云机同步操作&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;同步过程中发生部分云机画面延迟时，可直接操作云机', 'font-size:14px;'],
					title:false,
					skin:'layui-layer-molv',
					area: ['100%', '100%'],
					scrollbar: false,
					resize: false,
					closeBtn: 0,//不显示关闭按钮
					shade: 0.3,
					offset: 'lt',
					content: 'userWeb!syncdesktop?ip='+syncip+'&id='+id+'&ips='+cbs+'&ids='+ids,
					//content: 'userWeb!toseldevsync?ips='+cbs+'&ids='+ids,
					success: function(){
						//layer.close(index);
					},
					cancel: function(index, layero){					
							syncid = 0;		
						    layer.close(index);
					}
				});
			}
		}
	}
	
}


/**
 * 重启某一设备
 */
function restart(m,ip){
	layer.confirm('确定要重启该云机吗?',{icon: 3,id:'tips3', title:'提示',skin:'layui-layer-molv'},function(index){	
		
		var lurl = "server!restart?hostip="+ip;
		$.ajax({
			type:"POST",		
			url:lurl,		
			async:true,
			success:function(data){
				
				layer.load(2, {
					shade: [0.5, '#393D49'],
					shadeClose : true
				});
				
				setTimeout(function(){
					  layer.closeAll('loading');
				}, 2000);
				
				document.getElementById(m).src="/snapshot/snaprestart.png";
				parent.refreshgroup();
				
				
			}
		});
		//document.getElementById(m).src="/snapshot/snaprestart.png";		
		layer.close(index);
	});
	

}

/**
 * 停止某一设备上的应用
 */
function stopapp(id){
	if(zorogroupforbidden()){
		layer.open({
			id:'stopapp',
			type: 2,
			title:['停止应用', 'font-size:18px;'],
			skin: 'layui-layer-molv',
			area: ['400px', '250px'],
			content: 'userWeb!tostopapp?id='+id,
			success: function(){
				bpopup = 1;
			},
			cancel: function(index, layero){
			    layer.close(index);
			},
			end:function(){
				bpopup = 0;
			}
		});
	}	
	
}

/**
 * 手动刷新按钮函数
 */
function refresh(){
	
	if(bpopup == 1 || syncid > 0 || layerids.length > 0){
		return false;
	}

	var ids = document.getElementById("ids").value;

	window.location.href = "userWeb!devsingroup?groupid=10920&bsmall="+bsmall+"&ids="+ids;
	
}

/**
 * 切换代理
 * mode = 0，随机 ， mode = 1，绑定
 */
function switchippoxy(mode,ip,ipbind){
	
	var lurl = window.location.protocol+"://"+window.location.host+"/userWeb!switchipproxy?mode="+mode+"&ip="+ip;
	
	$.ajax({
		
		type:"POST",		
		url:lurl,		
		async:true,
		success:function(data){
// 			if(ipidles > 0)
// 				ipidles--;
// 			layer.alert("切换代理命令已发送!");

		}
	
	});
	
	layer.alert("切换代理命令已发送!",{icon:7,skin:'layui-layer-molv'});
	
}

/**
 * 关闭代理
 */
function closeipproxy(ip,ipbind){

	var lurl = window.location.protocol+"://"+window.location.host+"/userWeb!closeipproxy?ip="+ip;
	
	$.ajax({
		
		type:"POST",		
		url:lurl,		
		async:true,
		success:function(data){
			
// 			layer.alert("关闭代理命令已发送!");

		}
	
	});
	
	layer.alert("关闭代理命令已发送!",{icon:7,id:'tips7',skin:'layui-layer-molv'});	

}

/**
 * 单击截图图片打开远程控制窗口
 */
function rchost(hostip,id,devsts){
	/*
	if(devsts == 1){
		layer.alert("已在别处打开远程控制窗口，请等待关闭后再刷新页面重试!",{icon:7,skin:'layui-layer-molv'});
		return false;
	}
	*/
	if(syncid > 0){
		 layer.alert("当前正在进行云机同步,不支持远程操作!",{icon:7,id:'tips8',skin:'layui-layer-molv'});
		 return false;
	}
	
	//遍历数组,查看是否已弹出该设备
// 	var haspopup = false;
	
// 	if(layerids.indexOf(id) > -1){
// 		haspopup = true;
// 	}
	
// 	if(haspopup){
// 		top.layer.alert("该云机已打开远程控制窗口!",{icon:7,id:'tips9',skin:'layui-layer-molv'});
// 		return false;
// 	}else{
// 		layerids.push(id);
// 	}
	
// 	if(layerids.indexOf(","+id) > -1){
// 		return false;
// 	}else{
// 		layerids = layerids +","+id;
// 	}
	

	if(layernum == 0){
		top.layer.alert("一屏最多提供1个云机的远程控制！",{icon:7,id:'tips10',skin:'layui-layer-molv'});
		return false;
	}
	if(layernum > 0)
		layernum --;
	
	if(informflag.substring(4,5) == '0'){
		var index = layer.confirm("由于云手机内下载应用涉及到流量费用，如有该需求的用户，请前往配套服务页面订购[云机内下载]服务，订购成功后即可在云手机内下载.",{icon:0},function(){
			var lurl = window.location.protocol+"://"+window.location.host+"/userWeb!setinformflag?flagposition=4";
			$.ajax({
				type:"POST",		
				url:lurl,		
				async:true,
				success:function(data){
					layer.close(index);
					informflag = ''+data+'';
					top.layer.open({
						id:'rchost',
						type: 2,
						title:['云手机远程控制-ID: '+id, 'font-size:12px;height:30px;margin-top:0;'],
						//title:false,
						//closeBtn:0,
						offset:'t',
						area: ['288px', '580px'],
						scrollbar: false,
						resize: false,
						shade: 0.2,
						//content: 'server!h5view?hostip='+hostip,
						content: 'userWeb!h5view?id='+id+'&ip='+hostip,
						cancel: function(index, layero){
							layernum = layernum + 1;
							var j = layerids.indexOf(id);
							layerids.splice(j,1);
						    layer.close(index);
						    
						}
					});
				}
			});
		});
	}else{
		top.layer.open({
			id:'rchost',
			type: 2,
			title:['云手机远程控制-ID: '+id, 'font-size:12px;height:30px;margin-top:0;'],
			//title:false,
			//closeBtn:0,
			offset:'t',
			area: ['288px', '580px'],
			scrollbar: false,
			resize: false,
			shade: 0.2,
			//content: 'server!h5view?hostip='+hostip,
			content: 'userWeb!h5view?id='+id+'&ip='+hostip,
			cancel: function(index, layero){
				layernum = layernum + 1;
				var j = layerids.indexOf(id);
				layerids.splice(j,1);
			    layer.close(index);
			    
			}
		});
	}
	


	
}

/**
 * 页面初始化函数，判断当前页面是大图显示还是小图显示，默认为小图显示
 */
function init(){
	//将所有的div扩大
	var divimgs = document.getElementsByName("imgwindow");
	for(var j=0;j<divimgs.length;j++){
		if(bsmall == 1){
			divimgs[j].style.width = "216px";
			divimgs[j].style.height = "444px";
		}else{
			divimgs[j].style.width = "144px";
			divimgs[j].style.height = "316px";
		}
	}
	
	var picscreen = document.getElementsByName("picscreen");
	for(var k=0;k<picscreen.length;k++){
		if(bsmall == 1){
			picscreen[k].setAttribute("class", "bigscreenPic");
		}else{
			picscreen[k].setAttribute("class", "screenPic");
		}
			
	}
	
	//获取所有的img图像
	var imgs = document.getElementsByName("snapimgs");
	for(var i=0;i<imgs.length;i++){
		if(bsmall == 1){
			imgs[i].style.width = "216px";
			imgs[i].style.height = "384px";
		}else{
			imgs[i].style.width = "144px";
			imgs[i].style.height = "256px";
		}
	}
	
}

function lockbigscale() {
	
	var lockbig = document.getElementById("lockbigscale");
	var changeto = 0;
	if(lockbig.checked == true){
		changeto = 1;
	}
	
	//锁定用户选择
	var lurl = window.location.protocol+"://"+window.location.host+"/userWeb!lockscale?bsmall="+changeto;
	$.ajax({
		type:"POST",		
		url:lurl,		
		async:true,
		success:function(data){
			picscale();
		}
	});
	
}

/**
 * 大小图切换函数
 */
function picscale(){
	var divimgs = document.getElementsByName("imgwindow");
	for(var j=0;j<divimgs.length;j++){
		if(bsmall == 0){
			divimgs[j].style.width = "216px";
			divimgs[j].style.height = "444px";
		}else{
			divimgs[j].style.width = "144px";
			divimgs[j].style.height = "316px";
		}
	}
	
	var picscreen = document.getElementsByName("picscreen");
	for(var k=0;k<picscreen.length;k++){
		if(bsmall == 0){
			picscreen[k].setAttribute("class", "bigscreenPic");
		}else{
			picscreen[k].setAttribute("class", "screenPic");
		}
			
	}
	
	//获取所有的img图像
	var imgs = document.getElementsByName("snapimgs");
	for(var i=0;i<imgs.length;i++){
		if(bsmall == 0){
			imgs[i].style.width = "216px";
			imgs[i].style.height = "384px";
		}else{
			imgs[i].style.width = "144px";
			imgs[i].style.height = "256px";
		}
	}
	
	if(bsmall == 0){
		bsmall = 1;
	}
	else{
		bsmall = 0;
	}
		
}

/**
 * 云机同步时将页面改为小图模式
 */
function picscaletosmall(){
	
	var divimgs = document.getElementsByName("imgwindow");
	for(var j=0;j<divimgs.length;j++){
		divimgs[j].style.width = "144px";
		divimgs[j].style.height = "316px";
	}
	
	var picscreen = document.getElementsByName("picscreen");
	for(var k=0;k<picscreen.length;k++){
		picscreen[k].setAttribute("class", "screenPic");
	}
	
	//获取所有的img图像
	var imgs = document.getElementsByName("snapimgs");
	for(var i=0;i<imgs.length;i++){
		imgs[i].style.width = "144px";
		imgs[i].style.height = "256px";
	}
	
	bsmall = 0;
	
}

/**
 * 
 */
function showimg(id){
	layer.photos({
		  photos: '#layer-photos-'+id
		  ,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
	});
}

/**
 * 删除设备函数
 */
function deletedev(id,ip){
	if(zorogroupforbidden()){
		layer.confirm('确定要回收该云机吗?',{icon: 3,id:'tips11', title:'提示'},function(index){
			
			var lurl = window.location.protocol+"://"+window.location.host+"/userWeb!deleteVm?ip="+ip;
			$.ajax({
				type:"POST",		
				url:lurl,		
				async:true,
				success:function(data){
					var ids = document.getElementById("ids").value;
					var obj = ids.split(",");
					var remainids = "";
					for(var i=1;i<obj.length;i++){
						if(obj[i] != id){
							remainids = remainids +","+obj[i];
						}
					}
					if(remainids != "")
						remainids = remainids.substring(1);
					document.getElementById("ids").value = remainids;
					//window.location.href = "userWeb!devsingroup?groupid=10920&bsmall="+bsmall+"&ids="+remainids;
					parent.selids = remainids;
					
					//parent.refreshafteroperate();
					parent.window.location.reload();
				}
			});
			layer.close(index);
		});
	}
	
	
}

function softlblshow(){
	
	var id = layer.msg("应用安装/卸载需要1-2分钟的同步时间，同步完成后应用开始安装，您可在左侧列表或云手机上可见正在安装的应用图标，安装时图标为置灰状态。",{icon: 0,skin:'layui-layer-molv',time:false},function(index){
		var objs = document.getElementsByName("softlbl");
		for(var i=0;i<objs.length;i++){
			objs[i].innerHTML="应用同步中...";
		}
	});
	
	setTimeout(function () {
        layer.close(id);
    }, 6000);
}

function newphonetips() {
	var id = layer.msg("批量一键新机需要较长时间，请耐心等待。",{icon: 0,skin:'layui-layer-molv',time:false},function(index){
		
		var bids = getseldevids();
		var objs = bids.split(",");
		for(var i=0;i<objs.length;i++){
			var obj = 'softlbl'+objs[i]+'';
			document.getElementById(''+obj+'').innerHTML="一键新机中...";
		}
	});
	
	setTimeout(function () {
        layer.close(id);
    }, 5000);	
}

/**
 * 增减云机函数
 */
function modifygroup(id){
	if(zorogroupforbidden()){
		var groupid = top.window.parent.groupid;
		var openUrl = "userWeb!editgroup?groupid="+groupid;//弹出窗口的url
	    top.layer.open({
	    	id:'mgroup',
			type: 2,
			title:['组内云机管理', 'font-size:18px;'],
			resize: false,
			skin: 'layui-layer-molv',
			area: ['400px', '250px'],
			shade: [0.8, '#393D49'],
			content: openUrl,
			success: function(){
				bpopup = 1;
			},
			cancel: function(index, layero){
			    layer.close(index);
			},
			end:function(){
				bpopup = 0;
			}
		});
	}
	
	
}

/**
 * 分组应用管理
 */
function issueapk(id){
	if(zorogroupforbidden()){
		var groupid = top.window.parent.groupid;
//	 	var openUrl = "cardgroup!toSelectApk?id="+groupid;//弹出窗口的url
//	     top.layer.open({
//	     	id:'issueapk',
//	 		type: 2,
//	 		title:['分组应用管理', 'font-size:18px;'],
//	 		resize: false,
//	 		skin: 'layui-layer-molv',
//	 		area: ['600px', '400px'],
//	 		shade: [0.8, '#393D49'],
//	 		content: openUrl,
//	 		cancel: function(index, layero){				
//	 		    layer.close(index);
//	 		}
//	     });
		
		top.layer.open({
			type: 2,
			title:false,
			closeBtn:0,
			shadeClose: false,
			resize: false,
			skin: 'layui-layer-molv',
			area: ['960px', '620px'],
			shade: [0.9, '#393D49'],
			content: 'userWeb!toselectapk?groupid='+groupid,
			success: function(){
				bpopup = 1;
			},
			//content: 'cardGroup!toSelectApk?id='+groupid,
			cancel: function(index, layero){
				//parent.window.location.reload();
			    layer.close(index);
			},
			end:function(){
				bpopup = 0;
			}
		});
	}

	
}

function noqx(){
	layer.alert("demo用户没有删除云机的权限!",{icon: 5,skin:'layui-layer-molv'});
}

function addsubdev(gid){
	if(zorogroupforbidden()){
		var groupid = top.window.parent.groupid;
		top.layer.open({
			type: 2,
			title:false,
			closeBtn:0,
			shadeClose: false,
			resize: false,
			skin: 'layui-layer-molv',
			area: ['960px', '620px'],
			shade: [0.9, '#393D49'],
			content: 'userWeb!addsubdev?groupid='+groupid,
			success: function(){
				bpopup = 1;
			},
			cancel: function(index, layero){
				//parent.window.location.reload();
			    layer.close(index);
			},
			end:function(){
				bpopup = 0;
			}
		});
	}

}

function movedev(gid){
	if(zorogroupforbidden()){
		clearInterval(top.window.parent.timer);//关闭首页的定时器
		var groupid = top.window.parent.groupid;
		top.layer.open({
			type: 2,
			title:false,
			closeBtn:0,
			shadeClose: false,
			resize: false,
			skin: 'layui-layer-molv',
			area: ['960px', '620px'],
			shade: [0.9, '#393D49'],
			content: 'userWeb!movedev?groupid='+groupid,
			success: function(){
				bpopup = 1;
			},
			cancel: function(index, layero){
				//parent.window.location.reload();
			    layer.close(index);
			},
			end:function(){
				bpopup = 0;
			}
		});
	}
	
}

function claimdev(gid){
	if(zorogroupforbidden()){
		var groupid = top.window.parent.groupid;
		var openUrl = "userWeb!claimdev?groupid="+groupid;//弹出窗口的url
	    top.layer.open({
	    	id:'issueapk',
			type: 2,
			title:false,
			closeBtn:0,
			resize: false,
			skin: 'layui-layer-molv',
			area: ['960px', '620px'],
			shade: [0.8, '#393D49'],
			content: openUrl,
			success: function(){
				bpopup = 1;
			},
			cancel: function(index, layero){	
			    layer.close(index);
			},
			end:function(){
				bpopup = 0;
			}
		});
	}
	
}

function adb(id){

	var lurl = "userWeb!devadb?id="+id;//弹出窗口的url
	$.ajax({
		type:"POST",		
		url:lurl,		
		async:true,
		success:function(data){
			if(data == '0'){
				top.layer.open({
			    	id:'adbwin',
					type: 2,
					title:['日志调试信息', 'font-size:18px;'],
					resize: false,
					skin: 'layui-layer-molv',
					area: ['960px', '620px'],
					shade: [0.8, '#393D49'],
					content: 'userWeb!toadbdebug?id='+id,
					success: function(){
						bpopup = 1;
					},
					cancel: function(index, layero){	
					    layer.close(index);
					},
					end:function(){
						bpopup = 0;
					}
				});
			}else{
				layer.alert("日志程序启动失败!",{icon: 5,id:'adb',skin:'layui-layer-molv'});
			}
		}
	});
	
}

function wxscan(){
	if(zorogroupforbidden()){
		var cbs = getseldevs();
		var ids = getseldevids();
		var id = 0;	
		if(cbs == ""){
			layer.alert("请先选择云机！",{icon:7,id:'asyncd',skin:'layui-layer-molv'});
			return false;
		}else{
			
			//选择第一台云机作为同步对象
			var len = cbs.split(",");
			
			if(len.length <1){
				layer.alert("请至少选择一台云机！",{icon:7,id:'tips2',skin:'layui-layer-molv'});
				return false;
			}

			top.layer.open({
				id: 'wxscan',
				type: 2,
				//title:['扫码操作', 'font-size:14px;'],
				title:false,
				skin:'layui-layer-molv',
				area: ['100%', '100%'],
				scrollbar: false,
				closeBtn: 0,//不显示关闭按钮
				resize: false,
				shade: 0.3,
				offset: 'lt',
				content: 'userWeb!toseldev?groupid=10920&ips='+cbs+'&ids='+ids,
				success: function(){
					//layer.close(index);
				},
				cancel: function(index, layero){					
					    layer.close(index);
				}
			});
		}	
	}
	
	
}

/*
 * 页面刷新间隔参数设置
 */
function redraw(i){
	
	var lurl = window.location.protocol+"://"+window.location.host+"/userWeb!refreshinterval?refreshinterval="+i;
	$.ajax({
		type:"POST",		
		url:lurl,
		success:function(data){
			if(i == 0){refreshinterval = 0;refresh();}
			if(i == 20000){refreshinterval = 20000;refresh();}
			if(i == 10000){refreshinterval = 10000;refresh();}
		}
	});
}

if(refreshinterval > 0){
	setInterval(refresh, refreshinterval);
}
//setInterval(refresh, 300000);
</script>
</head>

<body class="scroll" onload="init()">

	<div class="content">
		<div class="device-data ">
			<div class="data-block">
				<div class="device-name">订购云机&nbsp;&nbsp;<span class="red">1</span></div>
			</div>
			<div class="data-block">
				<div class="device-name">订购IP&nbsp;&nbsp;<span class="red">0</span></div>
			</div>
			<div class="data-block">
				<div class="device-name">订购一键新机&nbsp;&nbsp;<span class="red">0</span></div>
			</div>
			<div class="data-block"><font color="red"><b>建议使用谷歌chrome 64及以上版本浏览器，safari浏览器下部分功能可能无法正常使用。</b></font></div>
		</div>
		<div class="tool-bar">


			<div class="group-btn pull-left">
				<div class="inline dropdown"> 
					<div class="dropdown-toggle btn btn-primary " data-toggle="dropdown" >
						<i class="icon-plus"></i>
						增减云机
						<span class="icon-caret-down"></span>
					</div>
					
					<ul class="dropdown-menu">
					  <li><a href="#" onclick="addsubdev(10920)">增加云机</a></li>
	                  <li><a href="#" onclick="claimdev(10920)">回收云机</a></li>
	                  <li><a href="#" onclick="movedev(10920)">移动云机</a></li>
	                </ul>
				</div>
				<div class="btn btn-default" onclick="issueapk(10920)">
					<i class="icon-android">
					</i>
					应用安装/卸载
				</div>
			</div>
			<div class="line-shu pull-left"></div>
			<div class="group-btn pull-left">
				<div class="checkbox checkbox-small">
					<input name="selall" id="selall" type="checkbox" onclick="qx();"><label></label><span>全选</span>
				</div>
				<div class="dropdown inline" style="margin-right:10px;">
					<a class="dropdown-toggle  btn btn-default" data-toggle="dropdown">批量操作 <span class="icon-caret-down"></span></a>				
					<ul class="dropdown-menu">
					  <li><a href="#" onclick="wxscan()">云机扫码</a></li>
	                  <li><a href="#" onclick="batchstart()">启动应用</a></li>
	                  <li><a href="#" onclick="batchstop()">停止应用</a></li>
	                  <li><a href="#" onclick="batchoper(1)">重启云机</a></li>
	                  <li><a href="#" onclick="batchoper(3)">一键HOME</a></li>
 	                  <li><a href="#" onclick="batchnewphone();">一键新机</a></li>
	                  <li><a href="#" onclick="batchoper(5)">切换IP与定位</a></li>
	                  <li><a href="#" onclick="batchoper(6)">关闭IP代理</a></li>
	                  <li><a href="#" onclick="batchoper(2)">恢复出厂设置</a></li>
	                </ul>
                </div>
                <a class="btn btn-default" onclick="syncdesktop()"><span class="icon-retweet"></span>云机同步</a>	
			</div>
			<div class="line-shu pull-left"></div>			
			
			<div class="group-btn pull-left">
				<div class="dropdown inline" style="margin-right:10px;">
					<a class="dropdown-toggle  btn btn-default" data-toggle="dropdown" id="snapset">
					截屏不刷新&nbsp;
					<span class="icon-caret-down"></span></a>				
					<ul class="dropdown-menu">
	                  <li><a href="#" onclick="redraw(0)"><i class="icon-ok"></i>截屏不刷新</a></li>
	                  <li><a href="#" onclick="redraw(20000)">间隔20秒刷新</a></li>
	                  <li><a href="#" onclick="redraw(10000)">间隔10秒刷新</a></li>
	                </ul>
                </div>			
				<div class="checkbox checkbox-small">
					<input name="lockbigscale" id="lockbigscale" type="checkbox"  onchange="lockbigscale()"><label></label><span>锁定大图</span>
				</div>
			
				<a class="refresh-btn" onclick="refresh();">
					<i class="icon-refresh"></i>刷新
				</a>
			</div>			
		</div>	
		<div class="ask-btn">
			<a href="http://lgdxt.longene.com.cn/workorder/checkQuestion/?username=繁华&password=8e310df5da170452d5fe1bca11f1e5cc" target="_blank"><img src="/images/ask.png">咨询</a>
		</div>		
		<div>
		<input type="hidden" name="ids" id="ids" value="2232"/>
		<ul class="window-list" id="devsingroup">
			<li>
				<div name="imgwindow" class="window-panel" style="width:144; height: 144;">
					<div class="window-header">
						<div class="checkbox checkbox-small"> 
						<input name="devcb" id="2232" type="checkbox" title="10.0.0.39" value="10.0.0.39"><label></label><span class="id-device" title="167772199">ID:2232</span>	
						</div>
						
						<div class="level-label level-low">高级版</div>
						
						
					</div>
					
					<div class="window-body">
						<div name="picscreen" class="screenPic">
  							<img  name="snapimgs" id="snapimg_2232" width="144" height="256" src="./河马 · 云手机群控平台_files/10.0.0.39.jpg" 
  							alt="10.0.0.39" onclick="rchost('10.0.0.39',2232,0)">
  							<div class="label-area">
  								
  								
  								
  							</div>
  							<div class="state-area">
  							<span name="softlbl" id="softlbl2232"></span>
  							<br><span name="disklbl" id="disklbl2232"></span>
  							<br><span name="newphonelbl" id="newphonelbl2232">
  							
  							</span>
  							</div>
  							<ul name="ulmenu" class="window-btn">
								<li>
									<button class="btn btn-primary btn-tiny" onclick="restart('snapimg_2232','10.0.0.39')">重启云机</button>
								</li>
								<li>
									<button class="btn btn-default btn-tiny" onclick="stopapp(2232)">停止应用</button>
								</li>
								<li>
								
								
									<button class="btn btn-default btn-tiny" onclick="deletedev(2232,'10.0.0.39')">回收云机</button>
								
								</li>
								
								
							</ul>
  							
  							
  							<div class="screenMask" onclick="rchost('10.0.0.39',2232,0)"></div>
						</div>
					</div>

					<div class="window-footer">
							<div><span  class="state-ip">
							
							
									
							</span>
							</div>				
					</div>
				</div>
			</li>
			
		</ul>
		</div>
	</div>
</body>

</html>
