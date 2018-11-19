<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html style="height:100%;overflow:hidden;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="keywords" content="河马云手机,河马云,手机群控系统,云手机群控平台,云手机去群控,云手机群控登录页">
<meta name="description" content="什么是云手机群控? 简而言之就是通过电脑网页即可控制成千上万台云手机设备（每台云手机相当安卓真机非模拟器），屏幕实时查看，同步操作管理。">
<title>升级兔 · 云手机群控平台</title>
<link type="text/css" rel="stylesheet"  media="all" href="css/default.css" />
<link type="text/css" rel="stylesheet" media="all" href="css/bootstrap.css" />
<link type="text/css" rel="stylesheet" media="all" href="css/style.css" />
<link type="text/css" rel="stylesheet" media="all" href="css/layermodel.css">
<link type="text/css" rel="stylesheet" media="all" href="css/font-awesome.min.css" />
<style type="text/css">
	.footer-bar{
		position: absolute;bottom: 18px;width: 100%;height: 340px;
		background: url(images/footerbar_bg.png) bottom repeat-x;
	}
	.footer-content{
		position: absolute;
		left: 0;right: 0;top: 0;bottom: 0;
		background: url(images/xcx_content3.png) center bottom  no-repeat;
	}
</style>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/bootstrap.js"></script>
<script src="js/jquery.layermodel.js"></script>
<script src="js/underscore-min.js"></script>
<script src="js/layer.js"></script>
<link rel="shortcut icon" href="images/favicon.ico" type="image/png">
    
<script type="text/javascript">
function handelclick(){
	//获取账号密码
	if($('#username').val()==='admin' && $('#userpwd').val()==='admin'){
		//跳转到index
		window.open('index.jsp');
	}
}
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "https://hm.baidu.com/hm.js?fcd1487e8e1d6620e8dc18748b804a6b";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();

// var direct = "";
// if (document.referrer!="") {
// 	direct = document.referrer;
// 	alert(direct);
// }

if(0!=""){
	register();
}

if(self!=top){
	top.location.href = self;
}

var ips = "";
var wwwip = "";
var domainname = "";

$.ajax({
    type:"POST",
    url:"https://httpdns.longene.com.cn/lcwebservice/LcloudHttpdnsServlet",
    async:true,
    success:function(data){
        var obj = eval('(' + data + ')'); 
        ips = obj.ips;
        wwwip = obj.wwwip;
        domainname = obj.domainname;
    },
    error:function(){
        ips = "";
        wwwip = "";
        domainname = "";
    }
});
$(function(){
	//绑定输入框，这里只能 是ID
	$("#userpwd").keydown(function(event){
	    event=document.all?window.event:event;
	    if((event.keyCode || event.which)==13){
	    	document.getElementById('form').submit();
	    }
	});
	
});

function forgotpwd(){
	window.location.href = "login!toFindPw";
// 	layer.open({
// 		id: 'fpwd',
// 		type: 2,
// 		title:['找回密码', 'font-size:14px;'],
// 		//title:false,
// 		zIndex:10,
// 		skin: 'layui-layer-molv',
// 		area: ['420px', '360px'],
// 		scrollbar: false,
// 		resize: false,
// 		shade: 0.4,
// 		content: 'login!toFindPw',
// 		cancel: function(index, layero){
// 		    layer.close(index);
// 		}
// 	});
}

function register(){
	
	window.location.href = "login!toRegistered";
// 	layer.open({
// 		id: 'usrregist',
// 		type: 2,
// 		title:['账号注册', 'font-size:14px;'],
// 		//title:false,
// 		zIndex:10,
// 		skin: 'layui-layer-molv',
// 		area: ['450px', '650px'],
// 		scrollbar: false,
// 		resize: false,
// 		shade: 0.4,
// 		content: 'login!toRegistered',
// 		cancel: function(index, layero){
// 		    layer.close(index);
// 		}
// 	});
	
}

function checkexplorer(){
	if(ips == ""){
		$.ajax({
		    type:"POST",
		    url:"https://httpdns.longene.com.cn/lcwebservice/LcloudHttpdnsServlet",
		    success:function(data){
		        var obj = eval('(' + data + ')'); 
		        ips = obj.ips;
		        
		        document.getElementById("loginip").value=''+ips+'';
		    	document.getElementById("wwwip").value=''+wwwip+'';
		    	document.getElementById("domainname").value=''+domainname+'';
		    	return true;
		        
		    },
		    error:function(){
		        ips = "";
		        document.getElementById("loginip").value=''+ips+'';
		    	document.getElementById("wwwip").value=''+wwwip+'';
		    	document.getElementById("domainname").value=''+domainname+'';
		    	return true;
		    }
		});
	}	
}

</script>

</head>
<body style="height:100%;overflow:hiden;">
	
	<div class="fullscreen">

		<div class="login-page-wrapper" style="min-height:690px;">
			<div class="footer-bar" style="z-index:99;">
				<div class="footer-content" style="width:100%;height:100%;"></div>
			</div>
<!-- 			<div class="copyright"> -->

<!-- 	        	<br>浙ICP备14021365号-1  浙公网安备 33010602001428号 -->
<!-- 	        </div> -->
			<div class="container">
				<div class="row">
					<div class="col-md-8 intro-wrapper">
						<div class="logo-wrapper">
					      <a href="#">
					        <span class="logo"></span>
						<div class="text">河马 · 云手机</div>
					      </a>
					    </div>
					    <h4 class="title">
			             集控部署,一台电脑控制上万台云手机
			            </h4>
			            <ul class="details">
			              <li>IP代理在线切换，一键新机全新上线</li>
			              <li>日志调试，一键输出云机进程日志</li>
			              <li>同步操作、XP框架安装...</li>
			            </ul>
					</div>
					<div class="col-md-4 login-wrapper"  style="z-index:9999;">
						<div class="login-box" >
							<div class="login">
								<div class="web-login">
									<div class="tips">
										<div class="title" id="title_2">帐号登录</div>
										<div id="qlogin_entry" style="font-size:13px;">
											建议使用Chrome浏览器操作河马云手机系统
										</div>
									</div>
									<div class="bottom" id="bottom_web" style="display: block;">  
										<a href="javascript:forgotpwd();" class="link" id="forgetpwd" target="_blank" style="font-size:14px">忘了密码？</a>  
										<span class="dotted">|</span> 
										<a href="login!toRegistered" class="link" style="font-size:14px">注册新帐号</a>  
									</div>
									<div class="login_form">
										<form method="post" id="form" onsubmit="handelclick()"  style="height:250px;">
											<input type="hidden" name="loginip" id="loginip" />
											<input type="hidden" name="wwwip" id="wwwip" />
											<input type="hidden" name="domainname" id="domainname" />
											<div class="form-group has-error">
												<span id="helpBlock2" class="help-block"></span>
											</div>
											<div class="form-group">
												 <input type="text" class="form-control" id="username" name="username" aria-describedby="helpBlock2" placeholder="手机号/邮箱地址">
											</div>
											<div class="form-group">
												 <input type="password" class="form-control" id="userpwd" name="password" aria-describedby="helpBlock2" placeholder="密码">
											</div>
											<div class="form-group">
												<button class="form-control btn btn-primary" type="submit" onclick="document.getElementById('form').submit();">登录</button>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="copyright" style="position:fixed;z-index:9999;bottom:0;width:100%;height:18px;background:#2ac4c4;color:#54dfdf;text-align:center;">
      Copyright &copy; 2015-<script type="text/javascript">var now = new Date(); var year = now.getFullYear(); document.write(year);</script> All Rights Reserved 龙境科技版权所有 &nbsp;&nbsp;浙ICP备14021365号-1  浙公网安备 33010602001428号
    </div>
</body>
</html>


