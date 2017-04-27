//全局变量
var SITE_URL='http://'+window.location.host+'/';
var STATIC_URL=SITE_URL;
var IMAGE_URL=SITE_URL;
var FILE_URL=SITE_URL;
var userName = '';
var folder = "/news"
host = 'http://'+location.host;
//var start_port_list = window['start_port_list'] ? window['start_port_list'] : '';
//var end_port_list = window['end_port_list'] ? window['end_port_list'] :'';
//var s_company_list = window['s_company_list'] ? window['s_company_list'] :'';
//var ossDomain = 'http://oss-cn-shenzhen.aliyuncs.com/cdd-public-prod/';
var ossDomain = '';
$(function(){
	$.ajax(
		{
		url:'/index/ossDomains',
		type:"get",
		success:function(rs)
		{
			//console.log('oss地址读取成功',rs);
			ossDomain='http://'+rs.ossDomain;
		},
		error:function(rs){
			//console.log('oss地址读取失败',rs);
		}
	})
	//统一修改页面的title和keywords
//	if($('head title')){
//		$('head title').html('国际物流供应链|国际货代|海运平台|在线订舱|船期查询-深圳找船网');
//	}else{
//		var tiHtml=
//		'<title>国际物流供应链|国际货代|海运平台|在线订舱|船期查询-深圳找船网</title>';
//		$('head').prepend($(tiHtml));
//	}
	/*if($('head title')){
		$('head title').html('找船网');
	}
	if($('head meta[name="keywords"]')){
		$('head meta[name="keywords"]').attr('content','货代平台,国际货代,货代,海运,在线订舱,集装箱海运,深圳货代公司,,国际货运代理,深圳海运代理,海运查询');
	}*/
	/*
	if($('head meta[name="keywords"]')){
		$('head meta[name="keywords"]').attr('content','货代平台,国际货代,货代,海运,在线订舱,集装箱海运,深圳货代公司,国际货运代理,深圳海运代理,海运查询');
	}else{
		var kwHtml='<meta name="keywords" content="货代平台,国际货代,货代,海运,在线订舱,集装箱海运,深圳货代公司,国际货运代理,深圳海运代理,海运查询">'
		$('head').prepend($(kwHtml));
	}*/
})
//百度商桥
/*var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?829cb235b2a06f6447f7f0bc146a188d";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
  console.log('s.parentNode',s.parentNode);
})();*/ 
//百度统计
/*var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?2de986e52f27154fe1219440d75a852f";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
  console.log('s.parentNode',s.parentNode);
})();*/
//添加右侧的QQ联系UI 
function addRightQQ(){
	var qqHtml = '';

	qqHtml+='<div class="kf"><div class="kf_box">';
	qqHtml+='<dl class="b"><dt>在线客服</dt><dd>';
	qqHtml+='<div class="b1">服务时间</div>';
	qqHtml+='<div class="b2">9:00-18:00</div>';
	
	qqHtml+='<div class="b3"><a target="_self" href="javascript:void(0)"></a></div>';

	qqHtml+='<div class="b4">客服热线</div>';
	qqHtml+='<div class="b5">4008755156</div>';
	qqHtml+='</dd></dl>';
	qqHtml+='<div class="t"><a onclick="javascript:void(0);"></a></div></div></div>';
	
	$("body").append($(qqHtml));
	var $script =['<script src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODE5MDYzNF8zNDc0NzBfNDAwODc1NTE1Nl8">','</script>'].join('');
	if($('.b3>a').children("iframe").length===0){
		$(".b3>a").append($script);
	}
	
	//客服qq
    $(".kf").hover(function(){
        $(".kf").animate({width:"170px"},200);
    	$(".kf_box .b").show(201);
        $(this).removeClass("s");
		var $script =['<script src="http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODE5MDYzNF8zNDc0NzBfNDAwODc1NTE1Nl8">','</script>'].join('');
		if($('.b3>a').children("iframe").length===0){
			$(".b3>a").append($script);
		}
    },function(){
    	$(".kf_box .b").hide(200);
    	$(".kf").animate({width:"36px"},201);
        $(this).addClass("s");
        
    });
	
	
	//百度
	var hm = document.createElement("script");
	hm.src = "//hm.baidu.com/hm.js?2de986e52f27154fe1219440d75a852f";
	var s = document.getElementsByTagName("script")[0]; 
	s.parentNode.insertBefore(hm, s);
}
/**
 *func 添加找船网公用顶部UI
 *@index 0-6顶部tab从左至右选中序列号 -2、-1无选中 右侧有登录、注册 -3无选中 右侧无登录、注册
 */
function addZcTopUI(index){
	$.ajax({
        url:'/user/loginInfo',
        type:"get",
        success:function(rs){
			var userHtml="";
			if(rs.data!=null){
				userName=rs.data.name;
				userHtml=
					'<div class="en" onclick="window.open('+"'http://en.zhao-chuan.com'"+')" >'+
					'<a style="color:#46b3ff" href="javascript:void(0)"><img src="/images/USA.png" style="width: 21px;margin-top: auto;height: 12px">&nbsp;&nbsp;English</a></div>'+
					'<div class="welcome"><a href="/member" style="color:red;">'+rs.data.name+'</a><a href="/logout">【退出】</a></div><div class="hotPhone">客服热线：4008-755-156</div>';
			}else{
				//console.log('未登录',rs);
				if(index!=0&&index!=2&&index!=3&&index!=5&&index!=6&&index!=-2&&index!=-3){
					var url = ""
					if(index == 1){
						url = "shipping.html"
//					}else if(index == 3){
//						url = "special.html"
					}else if(index == 4){
						url = "companys.html"
					}		
					window.location="/myLogin?url="+url;
					//window.location="/login";
					return;
				}
				userName='';
				if(index!=-3){
//					userHtml=
//					'<div class="en" onclick="window.open('+"'http://en.zhao-chuan.com'"+')" >'+
//					'<a style="color:#46b3ff" href="javascript:void(0)"><img src="/images/USA.png" style="width: 21px;margin-top: auto;height: 12px">&nbsp;&nbsp;English</a></div>'+
////					'<div class="register"><a href="/register/step1">注册</a></div>'+
//					'<div class="register"><a href="/register/registerMobile">注册</a></div>'+
//					'<div class="login"><a href="/myLogin">登录</a></div>'+
//					'<div class="hotPhone">客服热线：4008-755-156</div>'
				}
			}
			var domHtml=
		'<!--顶部导航-->'+
		'<div class="topBg">'+
			'<div class="top md1200">'+ 
			'<a href="http://www.zhao-chuan.com"><div class="logoBg" style="background: rgba(0, 0, 0, 0) url(/images/c_images/logo-new.jpg) no-repeat scroll 0 0 / 100% 100%;margin: 0 10px;max-width: 100px;min-height: 40px;min-width: 60px;padding-top: 0">'+
			/*//					'<a href="http://www.zhao-chuan.com"><img class="zclogo" src="/images/c_images/logo-new.jpg" /></a>'+width:360px;
			*/				'</div></a>'+
				'<div calss="middle_s" style=" text-align: center; max-width: 768px;min-height: 200px min-width: 320px;vertical-align:center ">'+
				'<ul class="nav_mobile">'+
					'<li><a href="/" >首页</a></li>'+ 
					'<li><a href="/shipping.html" >运价查询</a></li>'+
					'<li><a href="/show/7.html">货运保险<div style="position: absolute; background-color:red;margin:  -23px 0 20px 35px;width: 21px;height: 15px;text-align: center;line-height: 15px;color:#fff">new</div></a></li>'+
					'<li><a href="/show/6.html">拖车报关<div style="position: absolute; background-color:red;margin:  -23px 0 20px 35px;width: 21px;height: 15px;text-align: center;line-height: 15px;color:#fff">new</div></a></li>'+
					'<li><a href="/companys.html">企业名录</a></li>'+
					'<li><a href="/tools/port.html">实用工具</a></li>'+
					'<li><a href="/newsList.html">资讯动态</a></li>'+
				'</ul></div>'+ 
				//userHtml+
			'</div>'+
			/*'<div class="en" onclick="window.open('+"'http://en.zhao-chuan.com'"+')" >'+
			'<a style="color:#46b3ff" href="javascript:void(0)"><img src="/images/USA.png" style="width: 21px;margin-top: auto;height: 12px">&nbsp;&nbsp;English</a></div>'+
			 '<div class="en" onclick="window.location='+"'www.baidu.com'"+'"><a style="color:#46b3ff" href="javascript:void(0)"><img src="/images/USA.png" >&nbsp;&nbsp;English</a></div>' onclick="window.open('+"'www.baidu.com'"+')"*/
		'</div>'+
		'<!--顶部导航 end-->';
			$('body').prepend($(domHtml));
			var navs=$('.topBg .nav a');
			if(index>-1&&index<navs.length){
				navs.eq(index).addClass('sel');
			}
			
//			$("#aaaa").on("click",function(){
//				console.log("22")
//			})
			//topNavClick();//顶部导航点击事件
		}
	});
}
//顶部导航点击事件
function topNavClick(){
	//导航
	var navs=$('.topBg .nav a');
	navs.click(function(){
		var index=navs.index($(this));
		switch(index){
			case 0:{//首页
				window.location="/indexPage.html";
			}
			break;
			case 1:{//运价查询
				window.location="/shipping.html";
			}
			break;
			case 2:{//货盘信息
				window.location="/pallet.html";
			}
			break;
			case 3:{//限时特价
				window.location="/special.html";
			}
			break;
			case 4:{//企业名录
				window.location="/companys.html";
			}
			break;
			case 5:{//船期查询
				window.location="/times.html";
			}
			break;
			case 6:{//实用工具
				window.location="/tools/port.html";
			}
			break;
		}
	});
	//注册
	$('.topBg .register>a').click(function(){
		window.location="/register/step1";
	});
	//登录
	$('.topBg .login>a').click(function(){
		window.location="/myLogin";
	});
}
//添加找船网公用底部UI(有微信图片那个)
function addZcFootUI(){
	var domHtml=
'<div class="footerBg">'+
    '<div class="footer md1200">'+
        '<ul class="footerList">'+
        	'<li>'+
            	'<div class="c_text title">登录注册</div>'+
                '<div class="c_text"><a>如何登陆</a></div>'+
                '<div class="c_text"><a href="/help/user.html#user1" target="_self">如何注册</a></div>'+
                '<div class="c_text"><a href="/help/user.html#user2" target="_self">忘记密码</a></div>'+
            '</li>'+
            '<li>'+
            	'<div class="c_text title">发布货盘</div>'+
                '<div class="c_text"><a href="/help/trade.html#trade1" target="_self">发布货盘</a></div>'+
                '<div class="c_text"><a href="/help/trade.html#trade2" target="_self">批量发布</a></div>'+
                '<div class="c_text"><a href="/help/trade.html#trade4" target="_self">管理货盘</a></div>'+
            '</li>'+
            '<li>'+
            	'<div class="c_text title">发布运价</div>'+
                '<div class="c_text"><a href="/help/trade.html#trade1" target="_self">发布运价</a></div>'+
                '<div class="c_text"><a href="/help/trade.html#trade2" target="_self">批量发布</a></div>'+
                '<div class="c_text"><a href="/help/trade.html#trade4" target="_self">管理运价</a></div>'+
            '</li>'+
            /*'<li>'+
            	'<div class="c_text title">在线咨询</div>'+
                '<div class="c_text">查询信息</div>'+
                '<div class="c_text">在线咨询</div>'+
                '<div class="c_text"><a href="/list.gsp" target="_self">管理咨询</a></div>'+
            '</li>'+*/
            '<li class="long">'+
            	'<div class="c_text title"></div>'+
                '<div class="wxImageBg">'+
                	'<img class="wxImage" src="/images/c_images/btmWxImage1.png" />'+
                    '<div class="wxName">微信公众号</div>'+
                '</div>'+
                '<div class="wxImageBg">'+
                	'<img class="wxImage" src="/images/c_images/btmWxImage2.png" />'+
                    '<div class="wbName">微博公众号</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(domHtml));
}
//添加找船网公用底部UI(最下面黑底的那个)
function addZcBtmUI(){
	var domHtml=
'<div class="bottomBg">'+
    '<div class="bottom md1200">'+
        '<div class="topTxt">'+
            '<a href="/about.html" target="_self">关于我们</a><span>丨</span>'+
            '<a href="/fankui.html" target="_self">意见反馈</a><span>丨</span>'+
            '<a href="/law.html" target="_self">法律声明</a><span>丨</span>'+
            '<a href="/job.html" target="_self">诚聘英才</a><span>丨</span>'+
            '<a href="/contact.html" target="_self">联系我们</a><span>丨</span>'+
            '<a href="/ceo_mailbox.html" target="_self">总裁信箱</a><span>丨</span>'+
			'<a href="/sitemap.xml" target="_self">网站地图</a>'+
            '<a id="gongshang" target="_blank" style="position:relative;left:48px;top:24px;display:inline-block;"><img style="float:left;" /><span style="float:left;padding-left:8px;width:50px;height:40px;color:#fff;">工商网监<br/>电子标识</span></a>'+
        '</div>'+
        '<div class="btmTxt">'+
        	'Copyright <a href="http://www.zhao-chuan.com/">国际货代 货代平台 找船网 www.zhao-chuan.com</a> 粤IPC备15038148号'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append($(domHtml));
	
	//工商编码处理
	function GetRequest() {
		var d = 'http://szcert.ebs.org.cn/govicon.js?id=cee580df-35e8-4b1f-9880-b2a4380e118e&width=26&height=36&type=1';
		var theRequest = /govicon.js\?id=([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})&width=([0-9]+)&height=([0-9]+)/.test(d) ? RegExp.$1 : "error";
		var iconwidth = /govicon.js\?id=([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})&width=([0-9]+)&height=([0-9]+)&type=([0-9]+)/.test(d) ? RegExp.$2 : "36"; //default height
		var iconheight = /govicon.js\?id=([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})&width=([0-9]+)&height=([0-9]+)&type=([0-9]+)/.test(d) ? RegExp.$3 : "50"; //default width
		var type = /govicon.js\?id=([0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12})&width=([0-9]+)&height=([0-9]+)&type=([0-9]+)/.test(d) ? RegExp.$4 : "1"; //default width
		var retstr = { "id": theRequest, "width": iconwidth, "height": iconheight, "type": type };
		return retstr;
	}
	var webprefix = "http://szcert.ebs.org.cn/"
	var iconImageURL = "http://szcert.ebs.org.cn/Images/govIcon.gif";
	var niconImageURL = "http://szcert.ebs.org.cn/Images/newGovIcon.gif";
	var tempiconImageURL = "";
	
	var params = GetRequest();
	if (params.type == "1") {
		tempiconImageURL = iconImageURL;
	}
	if (params.type == "2") {
		tempiconImageURL = niconImageURL;
	}
	$('#gongshang').attr('href',webprefix + params.id);
	$('#gongshang img').attr('src',tempiconImageURL);
	$('#gongshang img').attr('title','深圳市市场监督管理局企业主体身份公示');
	$('#gongshang img').attr('alt','深圳市市场监督管理局企业主体身份公示');
	$('#gongshang img').attr('src',tempiconImageURL);
	$('#gongshang img').attr('width',params.width);
	$('#gongshang img').attr('height',params.height);
	$('#gongshang img').attr('border','0');
	
	loadJs('http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js',function(){});
	//工商编码处理 end
}

/**
 * Fun:分页设置
 * @maxPage:总页数
 * @callback:回调函数
 */
function setCommonPageEvent(maxPage,callback){
    var tempPage=3;
    if(maxPage<3){
        tempPage=maxPage;
    }
    //页面加载
    var thisPageHtml = '';
    thisPageHtml +='<div class="common_pageBK">';
	thisPageHtml +='<div class="common_page_first disabled">首页</div>';
    thisPageHtml +='<div class="common_page_up disabled">上一页</div>';
	thisPageHtml +='<div class="common_page_LPoint">…</div>';
    for(var i = 1;i<=tempPage;i++){
        if(i == 1){
            thisPageHtml +='<div class="common_page_number common_page_number_sel">'+i+'</div>';
        }else{
            thisPageHtml +='<div class="common_page_number">'+i+'</div>';
        }
    }
	thisPageHtml +='<div class="common_page_RPoint">…</div>';
    thisPageHtml +='<div class="common_page_down">下一页</div>';
	thisPageHtml +='<div class="common_page_last">尾页</div>';
    thisPageHtml +='<div class="common_page_sum">共<span>'+maxPage+'</span>页</div>';
    thisPageHtml +='<input type="text" class="common_page_input_number" value="1"/>';
	thisPageHtml +='<div class="common_page_go">go</div>';
    $('.common_pageBK').parent().html(thisPageHtml);
	
    if(maxPage == 1){
        $('.common_page_down').addClass('disabled');
		$('.common_page_last').addClass('disabled');
    }
	if(maxPage >3){
		$('.common_page_RPoint').show();
	}
	if(maxPage <= 0){
        $('.common_pageBK').hide();
    }
    //页面加载 end

    //点击事件
    $('.common_page_number').click(function(){
        if(!$(this).hasClass('common_page_number_sel')){
			var changePage = parseInt($(this).html());
			callback(changePage);
            commonPageChange(changePage,maxPage);
        }
    });
	$('.common_page_first').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = 1;
			callback(changePage);
            commonPageChange(changePage,maxPage);
        }
    });
    $('.common_page_up').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = parseInt($('.common_page_number_sel').html())-1;
			callback(changePage);
            commonPageChange(changePage,maxPage);
        }
    });
    $('.common_page_down').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = parseInt($('.common_page_number_sel').html())+1;
			callback(changePage);
            commonPageChange(changePage,maxPage);
        }
    });
	$('.common_page_last').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = maxPage;
			callback(changePage);
            commonPageChange(changePage,maxPage);
        }
    });
    $('.common_page_go').click(function(){
        var changePage = parseInt($('.common_page_input_number').val());
		if(changePage>0&&changePage<=maxPage){
			callback(changePage);
        	commonPageChange(changePage,maxPage);
		}
    });
    //点击事件 end
}
/**
 * Fun:执行翻页
 * @pageNo:页数
 * @maxPage:总页数
 */
function commonPageChange(pageNo, maxPage){
    if(maxPage ==1||pageNo<1||pageNo>maxPage){
        return;
    }
	var pageLPoint=$('.common_page_LPoint');
    var pageRPoint=$('.common_page_RPoint');
	pageLPoint.hide();
	pageRPoint.hide();
	if(pageNo-1>1){
		pageLPoint.show();
	}
	if(pageNo+1<maxPage){
		pageRPoint.show();
	}
	
	
	var pageFirst=$('.common_page_first');
    var pageUp=$('.common_page_up');
    var pageDown=$('.common_page_down');
	var pageLast=$('.common_page_last');
    var pageNum=$('.common_page_number');
		
    if(pageNo==1){
        pageFirst.addClass('disabled');
		pageUp.addClass('disabled');
        pageDown.removeClass('disabled');
		pageLast.removeClass('disabled');
        pageNum.removeClass('common_page_number_sel');
        pageNum.eq(0).addClass('common_page_number_sel');
        if(maxPage==2){
            pageNum.eq(0).html(1);
            pageNum.eq(1).html(2);
        }else{
            pageNum.eq(0).html(1);
            pageNum.eq(1).html(2);
            pageNum.eq(2).html(3);
        }
    }else if(pageNo==maxPage){
		pageFirst.removeClass('disabled');
        pageUp.removeClass('disabled');
        pageDown.addClass('disabled');
		pageLast.addClass('disabled');
        pageNum.removeClass('common_page_number_sel');
        pageNum.eq(pageNum.length-1).addClass('common_page_number_sel');
        if(maxPage==2){
            pageNum.eq(0).html(1);
            pageNum.eq(1).html(2);
        }else{
            pageNum.eq(0).html(maxPage-2);
            pageNum.eq(1).html(maxPage-1);
            pageNum.eq(2).html(maxPage);
        }
    }else{
		pageFirst.removeClass('disabled');
        pageUp.removeClass('disabled');
        pageDown.removeClass('disabled');
		pageLast.removeClass('disabled');
        pageNum.removeClass('common_page_number_sel');
        pageNum.eq(1).addClass('common_page_number_sel');
        pageNum.eq(0).html(pageNo-1);
        pageNum.eq(1).html(pageNo);
        pageNum.eq(2).html(parseInt(pageNo)+1);
    }
}
//读取js文件
function loadJs(url,callback) {
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = url;
	//document.body.appendChild(script);
	document.getElementsByTagName('head')[0].appendChild(script);
	script.onload = callback;
}
//读取css文件
function loadCss(url,callback) {
	var css = document.createElement("link");
	css.type = "text/css";
	css.rel = 'stylesheet';
	css.href = url;
	//document.body.appendChild(css);
	document.getElementsByTagName('head')[0].appendChild(css);
	css.onload = callback;
}

//去除字符窜中的标签、空白、换行
function removeHTMLTag(str) {
	str = str.replace(/<\/?[^>]*>/g,''); //去除HTML tag
	str = str.replace(/[ | ]*\n/g,'\n'); //去除行尾空白
	str = str.replace(/\n[\s| | ]*\r/g,'\n'); //去除多余空行
	str=str.replace(/&nbsp;/ig,'');//去掉&nbsp;
	return str;
}


function iFrameHeight() {   
	var ifm= document.getElementById("soushipping");   
	var subWeb = document.frames ? document.frames["soushipping"].document : ifm.contentDocument;   
	if(ifm != null && subWeb != null) {
	   ifm.height = subWeb.body.scrollHeight;
	   ifm.width = subWeb.body.scrollWidth;
	}   
}

//使元素可拖拽移动
function setEleMove($ele){
	var diffX,diffY;
	$ele.mousedown(function(e){
		diffX = e.pageX-$ele.offset().left;
		diffY = e.pageY-$ele.offset().top;
		$("body").on("mousemove", mousemove)
		$("body").on("mouseup", removeEvent)
	});
	function mousemove(e){
		$ele.css({
			left:e.pageX-diffX,
			top:e.pageY-diffY
		});
	}
	function removeEvent(){
		objDiv = '';
		$("body").off("mousemove", mousemove)
		$("body").off("mouseup", removeEvent)
	}
}
//清理数据中的null、undefined等错误数据
function clearDatas(data,changeString){
	if(data==null||data.length<1){
		return;
	}
	for(var i=0;i< data.length;i++){
		for(var key in data[i]){
			if(data[i][key]==null||data[i][key]==undefined){
				data[i][key]=changeString;
			}
		}
	}
}

var myCalendar={
	getData:function(year,month){//获取数据
		var calendarDays={};
		var today = new Date(year,month,1);
		var thisDay;
		var monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
		thisDay = today.getDate();
		if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) monthDays[1] = 29;
		var nDays = monthDays[today.getMonth()];
		var firstDay = today;
		firstDay.setDate(1);
		testMe = firstDay.getDate();
		if (testMe == 2) firstDay.setDate(0);
		var startDay = firstDay.getDay();
		
		calendarDays.startDay=startDay;
		calendarDays.firstDay=firstDay;
		calendarDays.nDays=nDays;
		calendarDays.curYear=year;
		calendarDays.curMonth=month;
		
		return calendarDays;
	},
	create:function(data,timesBg,callback){//创建控件
		var dateHtml="";
		dateHtml+="<div data-year='"+data.curYear+"' data-month='"+data.curMonth+"' class='cjhCalendar'>";
		var monthNames = new Array("1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月");
		dateHtml+="<div class='rl_top'>"
		dateHtml+="<button class='rl_btn' id='myDateLeft'><</button><div class='rl_title'>公元 "+data.curYear+"年" + monthNames[data.curMonth]+"</div><button class='rl_btn' id='myDateRight'>></button>";
		dateHtml+="</div>"
		dateHtml+="<div class='rl_head'>";
		dateHtml+="<div class='grid'>日</div>";
		dateHtml+="<div class='grid'>一</div>";
		dateHtml+="<div class='grid'>二</div>";
		dateHtml+="<div class='grid'>三</div>";
		dateHtml+="<div class='grid'>四</div>";
		dateHtml+="<div class='grid'>五</div>";
		dateHtml+="<div class='grid'>六</div>";
		dateHtml+="</div>";
		dateHtml+="<div class='rl_body'>";
		column = 0;
		for (i=0; i<data.startDay; i++) {
			var borderStyle="";
			if(i==0){
				borderStyle="border-right-color:#fff;"
			}else if(i==data.startDay-1){
				borderStyle="border-left-color:#fff;"
			}else{
				borderStyle="border-left-color:#fff;border-right-color:#fff;"
			}
			dateHtml+="<div class='grid' style='"+borderStyle+"'></div>";
			column++;
		}
		for (i=1; i<=data.nDays; i++) {
			if (i == data.thisDay&&parseInt(now.getYear())+1900==data.curYear&&now.getMonth()==data.curMonth) {
				dateHtml+="<div class='grid day'>"+i+"</div>";
			}
			else {
				dateHtml+="<div class='grid day'>"+i+"</div>";
			}
			column++;
			if (column == 7) {
				column = 0;
			}
		}
		dateHtml+="</div></div>";
		timesBg.append($(dateHtml));
		callback(timesBg);
	},
	change:function(data,timesBg){//时间翻页
		timesBg.find('.cjhCalendar').attr('data-year',data.curYear);
		timesBg.find('.cjhCalendar').attr('data-month',data.curMonth);
		var monthNames = new Array("1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月");
		timesBg.find('.rl_title').html("公元 "+data.curYear+"年" + monthNames[data.curMonth]);
		timesBg.find('.rl_body').html('');
		var daysHtml="";
		var column = 0;
		for (i=0; i<data.startDay; i++) {
			var borderStyle="";
			if(i==0){
				borderStyle="border-right-color:#fff;"
			}else if(i==data.startDay-1){
				borderStyle="border-left-color:#fff;"
			}else{
				borderStyle="border-left-color:#fff;border-right-color:#fff;"
			}
			daysHtml+="<div class='grid' style='"+borderStyle+"'></div>";
			column++;
		}
		for (i=1; i<=data.nDays; i++) {
			if (i == data.thisDay&&parseInt(now.getYear())+1900==data.curYear&&now.getMonth()==data.curMonth) {
				daysHtml+="<div class='grid day'>"+i+"</div>";
			}
			else {
				daysHtml+="<div class='grid day'>"+i+"</div>";
			}
			column++;
			if (column == 7) {
				column = 0;
			}
		}
		timesBg.find('.rl_body').html(daysHtml);
		timesBg.find('.day').click(function(){
			var day=$(this).html();
			if(day<10){day='0'+day;}
			var times=timesBg.find('.cjhCalendar');
			var year=times.attr('data-year');
			var month=parseInt(times.attr('data-month'))+1;
			if(month<10){month='0'+month;}
			timesBg.find('input[type="text"]').val(year+'-'+month+'-'+day);
		});
	},
	addEvents:function(timesBg){//添加控件事件
		var calendar=this;
		var times=timesBg.find('.cjhCalendar');
		
		timesBg.click(function(){
			if(times.css('display')=='none'){
				times.show();
			}else{
				times.hide();
			}
		});
		timesBg.hover(function(){
		},function(){
			times.hide();
		});
		timesBg.find('.day').click(function(){
			var day=$(this).html();
			if(day<10){day='0'+day;}
			var year=times.attr('data-year');
			var month=parseInt(times.attr('data-month'))+1;
			if(month<10){month='0'+month;}
			timesBg.find('input[type="text"]').val(year+'-'+month+'-'+day);
		});
		timesBg.find('#myDateLeft').click(function(e){
			if (e && e.stopPropagation) {//非IE浏览器 
				e.stopPropagation(); 
			}else {//IE浏览器 
				window.event.cancelBubble = true; 
			} 
			var year=parseInt(times.attr('data-year'));
			var month=parseInt(times.attr('data-month'));
			month--;
			if(month<0){
				month=11;
				year--;
			}
			var dateData=calendar.getData(year,month);
			calendar.change(dateData,timesBg);
		})
		timesBg.find('#myDateRight').click(function(e){
			if (e && e.stopPropagation) {//非IE浏览器 
				e.stopPropagation(); 
			}else {//IE浏览器 
				window.event.cancelBubble = true; 
			} 
			var year=parseInt(times.attr('data-year'));
			var month=parseInt(times.attr('data-month'));
			month++;
			if(month>11){
				month=0;
				year++;
			}
			var dateData=calendar.getData(year,month);
			calendar.change(dateData,timesBg);
		})
	},
	init:function(ele){
		var calendar=this;
		var timesBg=ele.parent();
		var now = new Date();
		var dateData=this.getData(parseInt(now.getYear())+1900,now.getMonth());
		calendar.create(dateData,timesBg,function(timesBg){
			calendar.addEvents(timesBg);
		});
	}
}


var loadScript = function(options,context){
    var doc = context || document;
    var script = doc.createElement('script');
    var callback = options.callback || function(){};
    var head = null;
    var isPackNeed = options['isPackNeed'];
    if(!options['url'])throw new Error('请输入脚本的路径');
    if(isPackNeed){
    	script.src = SITE_URL+'js/module/'+options['url']+'?rnd='+Math.random();
    }else{
    	script.src = SITE_URL+'js/'+options['url']+'?rnd='+Math.random();
    }
    script.type = 'text/javascript';
    script.async = options['async'] || 'async';
    script.defer = options['defer'] || '';
    head = doc.getElementsByTagName('head')[0];
    head.appendChild(script);
   if(script.readyState){
       script.onreadystatechange = function(){
           if(script.readyState === 'loaded' || script.readyState === 'complete'){
               script.onreadystatechange = null;
               callback();
           }
       }
   }else{
       script.onload = function(){
           callback()
       }
   }
}





/**
 * 
 *
 * @author yangjiupei
 * @version 1.0
 * Fun:TimeSpan
 * @param totalMilliseconds
 * @param 
 * @return 
 */
function TimeSpan(totalMilliseconds){
	
	this.totalMilliseconds = parseInt(totalMilliseconds);
	this.totalSeconds = parseInt(this.totalMilliseconds / 1000) ;	
	this.seconds = this.totalSeconds % 60;
	this.totalMinutes = parseInt(this.totalSeconds / 60);
    this.minutes = this.totalMinutes % 60; 
	this.totalHours = parseInt(this.totalMinutes / 60);
    this.hours = this.totalHours % 24; 
	
	this.days = parseInt(this.totalHours / 24);
   		
}

var DateTimeConvert = {
    /**
      * Fun:日期字符串转日期
      * @str:日期字符串
	  * @author yangjiupei
      *  
    */	
	str2Date : function(str){
		return new Date(Date.parse(str));
	},
    /**
      * Fun:日期转time stamp
      * @ptime:日期
	  * @author yangjiupei
      *  
    */		
	date2TimeStamp : function(ptime){
		return ptime.valueOf();
	},

    /**
      * Fun:日期字符串转日期
      * @str:日期字符串
	  * @author yangjiupei
      *  
    */		
	str2TimeStamp : function(str){		
		return DateTimeConvert.date2TimeStamp(DateTimeConvert.str2Date(str));
	},
	
    /**
      * Fun:time stamp转日期
      * @ts:time statmp，日期毫秒
	  * @author yangjiupei
      *  
    */		
	timestamp2Date : function(ts){
		return new Date(parseInt(ts));
	},	
    /**
      * Fun:time 格式化时间
      * @pdate:pdate，要格式化字符串的时间
	  * @pformat:格式，"yyyy-MM-dd hh:mm:ss"; 
	  * @author yangjiupei
      *  
    */		
	formatTime : function(pdate,pformat){
		//alert('pdate=' + pdate + ';;pformat::' + pformat);
        var o = {  
                  "M+" : pdate.getMonth() + 1, // month  
                  "d+" : pdate.getDate(), // day  
                  "h+" : pdate.getHours(), // hour  
                  "m+" : pdate.getMinutes(), // minute  
                  "s+" : pdate.getSeconds(), // second  
                  "q+" : Math.floor((pdate.getMonth() + 3) / 3), // quarter  
                  "S" : pdate.getMilliseconds()  
                  // millisecond  
               }  
	   if (/(y+)/.test(pformat)) {  
           pformat = pformat.replace(RegExp.$1, (pdate.getFullYear() + "").substr(4  
                        - RegExp.$1.length));  
       } 
	   
       for (var k in o) {  
          if (new RegExp("(" + k + ")").test(pformat)) {  
              pformat = pformat.replace(RegExp.$1, RegExp.$1.length == 1  
                            ? o[k]  
                            : ("00" + o[k]).substr(("" + o[k]).length));  
          }  
       }  	   	   
	
	  //alert('pformat::' + pformat);	
	  return pformat;		
	},
    /**
      * Fun:格式化日期
      * @ts:time statmp，日期毫秒
	  * @pformat:格式 如：yyyy-MM-dd hh:mm:ss
      *  
	  * @author yangjiupei
    */	
	formatTimeStamp : function(ts,pformat){        	  	
	  return DateTimeConvert.formatTime(DateTimeConvert.timestamp2Date(ts),pformat);
	}		
}; 

var TimeUtil = {
    /**
      * Fun:获取两个时间差
      * @ts1:time statmp，日期毫秒
	  * @ts2:time statmp，日期毫秒
      *  
	  * @author yangjiupei
    */	
	getTimeSpan : function(ts1,ts2){
		//$.messager.alert('提示信息','ts1=' + ts1 + '\r\nts2=' + ts2,'info');
		return (new TimeSpan(Math.abs(parseInt(ts2))-parseInt(ts1)));
	},
    /**
      * Fun:会诊时间倒计时计算
      * @ts:time statmp，日期毫秒
	  * 
	  * @author yangjiupei
      *  
    */	
	countdownTimeSpan : function(ts){
		return TimeUtil.getTimeSpan(DateTimeConvert.date2TimeStamp(new Date()),ts);
	},
    /**
      * Fun:获取指定时间的星期几
      * @date:日期
	  * 
	  * @author yangjiupei
      *  
    */		
	getDayOfWeek : function(date){		
		return date.getDay(); //返回值是 0（周日） 到 6（周六） 之间的一个整数
	},
    /**
      * Fun:获取指定时间的星期几
      * @ts:time statmp，日期毫秒
	  * 
      *  
	  * @author yangjiupei
    */		
	getTimeSpanOfWeek : function(ts){
		return DateTimeConvert.timestamp2Date(ts).getDay();
	},
    /**
      * Fun:获取指定时间的增加指定天数后的time stamp
      * @ts:time statmp，日期毫秒
	  * @day:增加的天数
      *  
	  * @author yangjiupei
    */	
	addDayOfTimeSpan : function(ts,day){
		var date = DateTimeConvert.timestamp2Date(ts);
		return date.setDate(date.getDate() + day);
	},
    /**
      * Fun:获取指定时间的增加指定月数后的time stamp
      * @ts:time statmp，日期毫秒
	  * @month:增加的月数
      *  
	  * @author yangjiupei
    */		
	addMonthOfTimeSpan : function(ts,month){
		var date = DateTimeConvert.timestamp2Date(ts);
		return data.setDate(date.getMonth() + month);
	},
    /**
      * Fun:获取指定时间的指定小时、分钟、秒数后的时间
      * @ts:time statmp，日期毫秒
	  * @hour:几点
	  * @minutes:分钟
	  * @second:秒
      *  
	  * @author yangjiupei
    */	
	setHoursOfTimeSpan : function(ts,hour,minutes,second){
		var date = new Date(parseInt(ts));
		return date.setHours(hour,minutes,second,0);
	}, 
	addTimeOfTimeSpan : function(ts,addtime){			
		var times = addtime.split(":");
		if(times != null){
			if(times.length > 2){
				return TimeUtil.setHoursOfTimeSpan(ts,times[0],times[1],times[2]);
			}else{
				return TimeUtil.setHoursOfTimeSpan(ts,times[0],times[1],0);
			}
			
		}
	},
    /**
      * Fun:获取的星期几
      * @weekId:星期几的ID
	  * 
      *  
	  * @author yangjiupei
    */		
	getWeekOfDay : function(weekId){
		var ret = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"] ;
        return ret[weekId]; 
	},
	getYearOfTimeSpan : function(ts){
		return (DateTimeConvert.timestamp2Date(ts)).getFullYear();
	},
	getMonthOfTimeSpan : function(ts){
		return ((DateTimeConvert.timestamp2Date(ts)).getMonth() + 1);
	},
	getHoursOfTimeSpan : function(ts){
		return (DateTimeConvert.timestamp2Date(ts)).getHours();
	},
	getMinutesOfTimeSpan : function(ts){
		return (DateTimeConvert.timestamp2Date(ts)).getMinutes();
	},
	getMonthDays : function(year,month){
		return  (new Date(year, month-1, 1) - new Date(year, month, 1))/(1000 * 60 * 60 * 24); 
	},
	getMonthStartTimeStamp : function(year,month){
		return TimeUtil.getSpecTimeByTimeStamp(year,month,1,0,0,1); 
	},
	getMonthEndTimeStamp : function(year,month){
		return TimeUtil.getSpecTimeByTimeStamp(year,month,getMonthDays(year,month),23,59,59); 
	},
	getDayStartTimeStamp : function(year,month,day){
		return TimeUtil.getSpecTimeByTimeStamp(year,month,day,0,0,1);
	},
	getDayEndTimeStamp : function(year,month,day){
		return TimeUtil.getSpecTimeByTimeStamp(year,month,day,23,59,59);
	},
	getSpecTimeByTimeStamp : function(year,month,day,hours,minutes,seconds,microseconds){
		//alert(year+';' + month + ';' + day + ';' + hours + ';' + minutes + ';' + seconds + ';' + microseconds);		
		if(microseconds==undefined){	
		    if(seconds==undefined){
				return DateTimeConvert.date2TimeStamp(new Date(year,month-1,day,hours,minutes,0));
			}else{
				return DateTimeConvert.date2TimeStamp(new Date(year,month-1,day,hours,minutes,seconds));
			}
			
		}else{
			return DateTimeConvert.date2TimeStamp(new Date(year,month-1,day,hours,minutes,seconds,microseconds));
		}
		
	}
};


//倒计时
var countdown={
    second:60,
    timer:null,
    source:null,
    target:null,
    init:function(source)
    {
        var content='<div class="countdown"><span>'+countdown.second+'</span>秒后重新获取</div>';
        countdown.source=source;
        countdown.source.hide().after(content);
//        alert(countdown.source.after())
//        after(content);
        countdown.target=$(".countdown");
        alert($(countdown))
        countdown.timer=setInterval(countdown.play,1000);
    },
    play:function()
    {
        countdown.second--;
        countdown.second>0 ? countdown.target.find("span").text(countdown.second) : countdown.stop();
    },
    stop:function()
    {
        clearInterval(countdown.timer);
        countdown.second=60;
        alert($(".countdown"))
        countdown.source.show()
//        .next(".countdown").remove();
        alert($(".countdown"))
//        countdown.source.parent('li').find('#success_tip').html('');
        
    }
};