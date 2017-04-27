var cacheStore = {
     flag: !!window.sessionStorage,
     expires: 5*60*1000,
     getAllCached :function(){
         var data = {};
         var cookieData = {};
         var store = null;
         var key = '';
         if(this.flag){
            store = window.sessionStorage;
            for(var i= 0,len= store.length;i<len;i++){
                key = store.key(i);
                data[key] = store.getItem(key);
            }
         }else{
             cookieData = document.cookie.replace(/\s+/g,'').split(';');
             for(var ind in cookieData){
                 key = cookieData[ind].split('=')
                 data[key[0]] = key[1];
             }
         }
         return data;

     },
     getCacheValByKey:function(key){
         var store  = null;
         var val = '';
         var keyReg = new RegExp('(^|\\s*|;)'+key+'=(\\w+)','g'); //这儿是个坑
        if(!key)return;
        if(this.flag){
            store = window.sessionStorage;
            val = store.getItem(key)
        }else{
            val =  keyReg.exec(document.cookie)[2];
			console.log(val)
        }
        return val;
     },
     setData2CacheStore:function(options){
         var options = options;
         var data = '';
         var store = null;
		 var linkData = '';
         if(!options)return;
         if(this.flag){
             store = window.sessionStorage;
             for(var key in options){
				 if(key != 'expires'){
					 store.setItem(key,options[key]);
				 }                
             }
         }else{
             for(var key in options){    
				  if(key != 'expires'){
					  linkData =  key +'='+options[key];
				  }				    
			      this.setCookieAttrs(linkData,options['expires']);			  
             }  
         }

     },
     setCookieAttrs:function(linkData,expires){
       var path = '/';
       var date = new Date();
	   var linkData = linkData;
           date.setTime(date.getTime()+(expires || this.expires));//默认5分钟后过期
           expires = date.toUTCString();
           document.cookie =linkData+';path='+path+';expires='+expires;// 不能缓存document.cookie;又是一个坑

     },
     isExsitInCacheStore:function(name){
         var val = '';
         val = this.getCacheValByKey(name);
         if(val)return true;
         return false;

     },
     clearAllCacheData:function(names){
        var key = [];
        var store = null;   
        var val = '';
        var temp = '';
        if(!names)return;
        if(typeof names ==='string') key.push(names);
        if(Object.prototype.toString.call(names) === '[object Array]')key = names;
        for(var i = 0; i<key.length;i++){
            if(this.flag){
				store = window.sessionStorage;
                store.removeItem(key[i]);
            }else{
				this.clearOneCahceData(key[i]); 
            }
        }
       
     },
     clearOneCahceData:function(name){
        var store =  null;
        var val = '';
        var options = {};
        var linkData = '';
        if(!name)return;
        if(this.flag){
		   store = window.localStorage; 
           store.removeItem(name);
        }else{
            val = this.getCacheValByKey(name);
            options[name] = val;
			options['expires'] = -this.expires;
            linkData = this.setData2CacheStore(options);
        }
     }

}
//全局变量
var SITE_URL='http://'+window.location.host+'/';
var STATIC_URL=SITE_URL;
var IMAGE_URL=SITE_URL;
var FILE_URL=SITE_URL;
document.write('<script type="text/javascript">');
document.write('_atrk_opts = { atrk_acct:"XBojm1akKd60em", domain:"zhao-chuan.com",dynamic: true};');
document.write('(function() { var as = document.createElement("script"); as.type = "text/javascript"; as.async = true; as.src = "https://d31qbv1cthcecs.cloudfront.net/atrk.js"; var s = document.getElementsByTagName("script")[0];s.parentNode.insertBefore(as, s); })();');
document.write('</script>');
document.write('<noscript><img src="https://d5nxst8fruw4z.cloudfront.net/atrk.gif?account=XBojm1akKd60em" style="display:none" height="1" width="1" alt="" /></noscript>');
var userName = '';
host = 'http://'+location.host;
$.extend({
	  getUrlVars: function(){
	    var vars = [], hash;
		var href = window.location.href;
		if (href.indexOf('#') > -1) {
			href = href.split("#")[0];
		}
	    var hashes = href.slice(href.indexOf('?') + 1).split('&');
	    for(var i = 0; i < hashes.length; i++) {
	      hash = hashes[i].split('=');
	      vars.push(hash[0]);
	      vars[hash[0]] = hash[1];
	    }
	    return vars;
	  },
	  getUrlVar: function(name){
	    return $.getUrlVars()[name];
	  }
});
//显示登录对话框
function show_dialog_login()
{
    var referer=escape(location.href);
    art.dialog({id:'login_dialog',iframe:SITE_URL+'?app=user&act=login&ajax=1&referer='+referer, title:'会员登录', width:'380', height:'310', lock:true});
}

//提示开闭市消息
function tip_open_time()
{
    var open_time=$.getcookie('is_open_time');
    if(open_time<0)
    {
        return confirm('找船网交易时间为工作日9：00~17：30，非工作时间发布的委托采购会延迟处理，给您带来不便，请见谅。');
    }
    return true;
}

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
        countdown.target=$(".countdown");
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
        countdown.source.show().next(".countdown").remove();
        countdown.source.parent('p').find('#success_tip').html('');
        
    }
};

//自动变换背景框宽度
var auto_bg={
    "max_width":1920,
    "site_width":1200,
    "o":null,
    "set":function()
    {
        var window_width=$(window).width();
        var w=(auto_bg.max_width-window_width)/2;
        if(w>360)
        {
            auto_bg.o.width(auto_bg.site_width);
        }
        else
        {
            auto_bg.o.css("width","100%");
        }
    },
    "event":function()
    {
        window.onresize=auto_bg.set;
    },
    "init":function(o)
    {
        auto_bg.o=o;
        auto_bg.set();
        auto_bg.event();
    }
};

//显示消息
$.showmessage=function(msg,modal,timeout,html)
{
    var id='windowmessage';

    var close=function()
    {
        $("#windowmask").remove();
        $("#"+id).remove();
    };

    if($("#"+id).length)
    {
        close();
    }

    var tid='windowmessagetitle';
    var cid='windowmessagecontent';
    var xid='windowmessageclose';

    modal=modal ? modal : 0;
    timeout=timeout ? timeout : 0;

    $("body").append('<div id="windowmask"></div>');
    if(modal)
    {
        $("#windowmask").attr("class","windowmask").css("width",$(document).width()).css("height",$(document).height());
    }
    $("body").append('<div id="'+id+'"></div>');
    $("#"+id).attr("class","msgbox").append('<div id="'+tid+'"></div>').append('<div id="'+cid+'"></div>');
    $("#"+tid).attr("class","title");
    $("#"+cid).attr("class","content");
    $("#"+tid).html('<div class="l">'+'提示'+'</div><div class="r"><a onclick="javascript:void(0);" class="close" id="'+xid+'">&nbsp;</a></div>');
    $("#"+id).hide();

    if(timeout)
    {
        setTimeout(function()
        {
            close();
        },timeout);
    }

    html ? $("#"+cid).html(msg) : $("#"+cid).html(msg);
    $("#"+id).css("margin-left","-"+parseInt($("#"+id).css("width"))/2+"px").css("margin-top","-"+parseInt($("#"+id).css("height"))/2+"px");

    $("#"+xid+",[act='close']").click(function()
    {
        close();
    });

    $("#"+id).show();
};

function searchOrder() {
	var searchOrderVal = $.trim($("#searchOrderId").val());
	if (searchOrderVal.length > 0) {
		$("#searchOrderForm").submit();
	}
}


$(function()
{
	//动态添加页头页脚
	var headerArr = new Array();
	if ($(".backpage").length < 1) {
		if ($(".needsearch").length > 0) {
			var searchHTMLModule = [
              '<div class="ui-tab-type">',
                 '<span class="ui-tab-whole" data-category="Whole">整&nbsp;箱</span>',
                 '<span class="ui-tab-together" data-category="Together" style="margin-left:-4px;">拼&nbsp;箱</span>',
              '</div>',
              '<form action="/ships" target="_self" style="position:relative;margin-top: 5px;">',
                '<div class="ui-search-area">',
                     '<div class="ui-parent-port">',
                         '<input type="text" class="ui-input-port" id="start_port_input" placeholder="请输入起运港">',
                     '</div>',
                      '<label class="ui-label-hook">至</label>',
                     '<div class="ui-parent-port">',
                         '<input type="text" class="ui-input-port" id="dest_port_input" placeholder="请输入目的港">',
                     '</div>',
                ' </div>',
                '<span class="ui-search-button" role="button"></span>',
              '</form>',
           ].join('');
			headerArr.push('<div id="new_logo">')
			headerArr.push('<div class="new_logo_content">')
			headerArr.push('<a href="/"><img alt="找船网；深圳市找船网络科技有限公司"  class="logo_img" src="  ')
			headerArr.push('/images/logo.png')
			headerArr.push('" alt="" height="105"><div class="logotext"><img class="logo_img" src="')
			headerArr.push('/images/logotext.png')
			headerArr.push('" alt="找船网-免费帮里找好船"></div></a>')
			headerArr.push('<div class="ui-search-widget">')
			headerArr.push(searchHTMLModule);
			headerArr.push('</div>')
			headerArr.push('<div class="logo_img2">');
			headerArr.push('<img src="/images/call.jpg" alt="找船网客服电话4008755156" />')
			headerArr.push('</div>');
			headerArr.push('</div></div>')
			//导航
			headerArr.push('<div id="new_nav"><div class="new_nav_content">')
			headerArr.push('<a id="categoryShipsMenu" onclick="javascript:void(0)">航线分类<div id="categoryShips"></div></a>')
			headerArr.push('<a href="/" ');
			if ($(".indexpage").length > 0) {
				headerArr.push(' class="hover" ');
			}
			headerArr.push('>首页</a> ')
			/* headerArr.push('<a href="/company" target="_self"')
			if ($(".companypage").length > 0) {
				headerArr.push(' class="hover" ');
			}
			headerArr.push('>货代资源</a>') */
			headerArr.push('<a href="javascript:void(0)" class="ship_inquery" target="_self"') ///ships/ship.html
			if ($(".shippage").length > 0) {
				headerArr.push(' class="hover" ');
			}
			headerArr.push('>运价查询</a>')
			
			headerArr.push('<a href="'+host+'/cargo/cargo.html" target="_self" ')
			if ($(".cargoSel").length > 0) {
				headerArr.push(' class="hover" ');
			}
			headerArr.push(' >货盘信息<i class="hot"></i></a>')
		
			headerArr.push('<a href="/special" target="_self" ')
			if ($(".specialpage").length > 0) {
				headerArr.push(' class="hover" ');
			}
			headerArr.push(' >限时特价</a>')
			
			headerArr.push('<a href="/tools/shipment.html" target="_self" ')
			if ($(".shipmentSel").length > 0) {
				headerArr.push(' class="hover" ');
			}
			headerArr.push(' >船期查询</a>')
				headerArr.push('<a href="/enterpriseDirectory" target="_self" ')
		if ($(".enterpriselpage").length > 0) {
			headerArr.push(' class="hover" ');
		}
		headerArr.push(' >企业名录</a>')

        headerArr.push('<a href="/tools/port.html" target="_self" ')
			if ($(".portSel").length > 0) {
				headerArr.push(' class="hover" ');
			}
			headerArr.push(' >实用工具</a>')
		} else {
			headerArr.push('<div class="w960"><a href="/" style="display:block;width:960px;margin:30px auto" class="logo"><img src="/images/logo.png" title="找船网" height="105"><img src="/images/logotext.png" title="找船网" height="85" style="margin-top: -5px;"></a></div>');
		}
		
		$("body").prepend(headerArr.join(""));

		$("body").append('<ul class="ui-autocomplete" id="search-port-result1" style="z-index: 2500; display: none; top: 0px; left: 0px;"></ul><ul class="ui-autocomplete" id="search-port-result2" style="z-index: 2500; display: none; top: 0px; left: 0px;"></ul>');
		
		
	} else {
		headerArr.push('<div class="member_left">');

		headerArr.push('<p class="title" style="margin-top:0;"><b class="publish-tab"></b>信息发布</p>');

		headerArr.push('<p><a href="/member/ship" style="display:none" id="menu_pubship" ')
		if ($(".shipPrice").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>发布运价信息</a></p>');

		headerArr.push('<p><a href="/member/uploadship" style="display:none; font-size:13px" id="menu_batchship" ')
		if ($(".backbatchship").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>批量发布运价</a></p>');

		headerArr.push('<p><a href="/shiplist.gsp" style="display:none; font-size:13px" id="menu_pubcargo" ');
		if ($(".shiplist").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>发布货盘信息</a></p>');

		
		headerArr.push('<p><a href="/member/uploadcargo" style="display:none" id="menu_batchcargo" ')
		if ($(".backbatchcargo").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>批量发布货盘</a></p>');

		

		headerArr.push('<p class="title"><b class="trade-tab"></b>我的交易信息</p>');
		headerArr.push('<p><a href="/member/shiplist" style="display:none" id="menu_shiplist" ')
		if ($(".backshiplist").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>运价管理</a></p>');
		
		headerArr.push('<p><a href="/member/cargolist" style="display:none" id="menu_cargolist" ')
		if ($(".backcargolist").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>货盘管理</a></p>');
		headerArr.push('<p><a href="/list.gsp" style="display:" id="menu_list" ')
		if ($(".enquiryList").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>询价管理</a></p>');
	

		headerArr.push('<p><a href="/bookingManage.gsp" style="display:none" id="menu_shipcargolist" ')
		if ($(".bookingManage").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>订单管理</a></p>');
		
		
		headerArr.push('<p class="title"><b class="account-tab"></b>账户管理</p>');

		headerArr.push('<p><a href="/member/account" ')
		if ($(".backaccount").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>账户信息</a></p>');

		headerArr.push('<p><a href="/member/changepassword"')
		if ($(".backchangepass").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>修改密码</a></p>');
		headerArr.push('<p><a href="/member/certificate"')
		if ($(".backcertificate").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>公司认证注册</a></p>');
		
    
		headerArr.push('<p><a href="/member/tools/port.html" id="menu_tools" ')
		if ($(".backtools").length > 0) {
			headerArr.push(' class="on" ');
		}
		headerArr.push('>实用工具</a></p>');

		$(".w960").prepend(headerArr.join(""));
	}
    setTimeout(function(){
    	$('.login_flag').click(function(evt){
    		if(!userName){
    			location.href = host+"/login";
    		}else{
    			var href = $(this).data('ship')
    			$(this).attr('href',href);
    		}		
    	});
    	
    },1000)
    	
   
	
    $('.ship_inquery').click(function(evt){
        if(userName){
        	$(this).attr('href',host+'/ships/ship.html')
        }else{
          location.href = host+"/login"
        }
    })
	var topArr = new Array();
	if ($(".backpage").length < 1) {
		topArr.push('<div id="new_top" >');
		topArr.push('<div class="new_top_content clearfix">');
	    topArr.push('<span id="new_top_content" class="login fl" style="display: none">您好，欢迎来到找船网! 【<a href="/login">会员登录</a> | <a href="/register/step1">免费注册</a>】 </span>');
		topArr.push('<ul class="fr message">');
		topArr.push('<li class="message_list"><a href="/member">我的找船网</a></li>');
		topArr.push('<li class="message_list">交易时间：工作日 9:00-17:00</li>');
		topArr.push('<li class="message_list2 none">');
		
		topArr.push('<div class="free_div_top">');
		topArr.push('<div>');
		topArr.push('<form id="searchOrderForm" action="process/data" target="_self" style="display: inline;">'); 
		topArr.push('<input id="searchOrderId" name="number" class="free_search_order" type="text"');
		topArr.push(' value="" title="请输入订单号查询订单状态" placeholder="请输入订单号查询订单状态" />');
		topArr.push('<button type="button" id="search_order_submit"');
		topArr.push(' class="btn-cdd btn-orange btn-sizem2"');
		topArr.push(' onclick="searchOrder()">订单查询</button>');
		topArr.push('</form>');
		topArr.push('</div>');
		topArr.push('</div>');
	
		topArr.push('</li>');
		topArr.push('</ul>');
		topArr.push('</div>');
		topArr.push('</div>');
        $.ajax(
        {
            url:SITE_URL+'user/loginInfo',
            type:"get",
            cache:false,
            success:function(rs)
            {
                if(rs && rs.data)
                {    userName = rs.data.name;
                    $("#new_top_content").html('尊敬的<a href="/member" style="color: red;">&nbsp;'+rs.data.name+'&nbsp;</a><a href="/logout">【退出】</a>&nbsp;&nbsp;欢迎来到找船网!&nbsp;&nbsp;');
                    if($('#index_login_box').length > 0){
                    	$('#index_login_box').html('\
							<p class="free_title">登录成功<span class="title_icon"></span></p>\
							<div class="free_div_bottom login_box">\
								<div class="free_div_bottom_detail">尊敬的 <span style="color:red;">'+rs.data.name+'</span>，欢迎来到找船网!</div>\
								<a href="/member" class="btn btn-blue btn-sizem4">进入会员中心</a>\
							</div>\
						');
                    }
                }
                $("#new_top_content").show();
            }
        });

		
	} else {
		topArr.push('<div class="top"><div class="top_t"><div class="w960"><div class="r"><span id="new_top_content"></span>&nbsp;&nbsp;<i>|</i>&nbsp;&nbsp;<span><i class="phone"></i>交易热线：<span class="color">4008755156</span></span>&nbsp;&nbsp;<i>|</i>&nbsp;&nbsp;交易时间：工作日 9:00-17:00');
		topArr.push('</div><a href="/" target="_self">回到首页</a>&nbsp;&nbsp;<i>|</i>&nbsp;&nbsp;<a href="/member">我的找船网</a></div></div>');
		topArr.push('<div class="logo"><div class="w960" style=" overflow:hidden;"><a href="../../" ><img src="/images/member/member_logo.png" title="找船网"  ></a><img  src="/images/member/separation.png" title="找船网" style="float:left;margin:10px;margin-bottom:0px;"><a  href="../member"><img src="/images/member/member_center_log.png" title="找船网" style="margin-top:20px;"></a></div></div></div>');
        $.ajax( {
            url:SITE_URL+'user/loginInfo',
            type:"get",
            cache:false,
            success:function(rs)
            {
                if(rs && rs.data) {
                    $("#new_top_content").html('您好，'+rs.data.name+'（'+rs.data.username+'）<a href="/logout">【退出】</a>');
                    
                    
                    var role = rs.data.role;
                    if (role == 'cargo') {
                    	$("#menu_pubcargo").show();
                    	$("#menu_batchcargo").show();
                    	$("#menu_cargolist").show();
                    	$("#menu_list").show();
                    	$("#menu_shipcargolist").show();
                    } else if (role == 'ship') {
                    	$("#menu_pubship").show();
                    	$("#menu_batchship").show();
                    	$("#menu_shiplist").show();
                    	$("#menu_shipcargolist").show();

                    	$("#menu_pubcargo").show();
                    	$("#menu_batchcargo").show();
                    	$("#menu_cargolist").show();
                    }
                    (typeof(userDataLoadDone)=='function') && userDataLoadDone(rs.data);
                }
                $("#new_top_content").show();
            }
		});
	}
	if ($(".needtop").length > 0) {
		$("body").prepend(topArr.join(""));
	}
	
	var footerArr = new Array();
	
	
	
	//if ($(".backpage").length < 1) {
		footerArr.push('<div class="kf"><div class="kf_box">');
		footerArr.push('<dl class="b"><dt>在线客服</dt><dd>');
		footerArr.push('<div class="b1">服务时间</div>');
		footerArr.push('<div class="b2">9:00-17:00</div>');
		
		footerArr.push('<div class="b3"><a target="_self" href="javascript:void(0)"></a></div>');
	
		footerArr.push('<div class="b4">客服热线</div>');
		footerArr.push('<div class="b5">4008755156</div>');
		footerArr.push('</dd></dl>');
		footerArr.push('<div class="t"><a onclick="javascript:void(0);"></a></div></div></div>');
	
	
	footerArr.push('<div class="foot_out">');
	footerArr.push('<div class="in_footer">');
	
	
	footerArr.push('<div class="friendlink">');
	footerArr.push('<div class="hzhb">合作伙伴：</div>');
	footerArr.push('<div class="leftarrow" id="fl-left-arrow"></div>');
	footerArr.push('<div class="friendlinkScoll"><div class="friendlinkScollInner" id="fl-inner-box">');
	footerArr.push('<a target="blank" href="http://www.made-in-china.com"><img src="/images/friends/zgzz.png" ></a>');
	footerArr.push('<a target="blank" href="http://www.4px.com"><img src="/images/friends/dlwl.png" ></a>');
	footerArr.push('<a target="blank" href="http://www.focusie.com"><img src="/images/friends/jdjck.png" ></a>');
	footerArr.push('<a target="blank" href="http://www.winbons.com"><img src="/images/friends/hby.png" ></a>');
	footerArr.push('<a target="blank" href="http://www.fsboyida.com"><img src="/images/friends/fsboyida.png" ></a>');
	footerArr.push('<a target="blank" href="http://www.bmic.org.cn"><img src="/images/friends/zgzzzm.png" ></a>');
	footerArr.push('<a target="blank" href="http://www.bv-logistics.com"><img src="/images/friends/bowei.png" ></a>');
	footerArr.push('<a target="blank" href="https://www.xiaoman.cn"><img src="/images/friends/xiaoman.jpg" ></a>')
	footerArr.push('</div></div>');
	footerArr.push('<div class="rigtharrow" id="fl-rigth-arrow"></div>');
	footerArr.push('</div>');
	footerArr.push('<div style="clear: both;"><div>');
	
	footerArr.push('<div class="foot_l"><a href="/" target="_self"><img src="/images/logo.png"  alt="找船网；深圳市找船网络科技有限公司"/></a></div>');
		
	footerArr.push('<div class="foot_c">');
	footerArr.push('<ul>');
	footerArr.push('<li>');
	footerArr.push('<h3><i class="ne_coin1"></i>我要交易</h3>');
	footerArr.push('<a href="/help/trade.html#trade1" target="_self"><b></b>如何交易</a>');
	footerArr.push('<a href="/help/trade.html#trade2" target="_self"><b></b>如何委托交易</a>');
	footerArr.push('<a href="/help/trade.html#trade3" target="_self"><b></b>如何自己交易</a>');
	footerArr.push('</li>');
	footerArr.push('<li>');
	footerArr.push('<h3><i class="ne_coin2"></i>我的找船网</h3>');
	footerArr.push('<a href="/help/trade.html#trade4" target="_self"><b></b>如何查看订购单</a>');
	footerArr.push('<a href="/help/trade.html#trade5" target="_self"><b></b>如何提供交易</a>');
	footerArr.push('</li>');
	footerArr.push('<li class="list3">');
	footerArr.push('<h3><i class="ne_coin3"></i>常见问题</h3>');
	footerArr.push('<a href="/help/user.html#user1" target="_self"><b></b>注册流程</a>');
	footerArr.push('<a href="/help/user.html#user2" target="_self"><b></b>无法登录/忘记密码</a>');
	footerArr.push('<a href="/help/user.html#user3" target="_self"><b></b>修改账户信息</a>');
	footerArr.push('</li>');
	footerArr.push('</ul>');
	footerArr.push('</div>');
	
	footerArr.push('<div class="foot_r"><img src="/images/wxqrcode.jpg" alt="找船网；找船网微信公众账号" /><p>微信公众号：zhao-chuan-com</p></div>');
	footerArr.push('<div style="clear: both;"><div>');
	footerArr.push('<div class="banquanxx">');
	footerArr.push('<div class="lianj">');
	 
	footerArr.push('<a href="/about.html" target="_self">关于我们</a> | ');
	footerArr.push('<a href="/fankui.html" target="_self">意见反馈</a> | ');
	footerArr.push('<a href="/law.html" target="_self">法律声明</a> | ');
	footerArr.push('<a href="/job.html" target="_self">诚聘英才</a> | ');
	footerArr.push('<a href="/contact.html" target="_self">联系我们</a> | ');
	footerArr.push('<a href="/ceo_mailbox.html" target="_self">CEO邮箱</a>');
	footerArr.push('</div>');
	footerArr.push('<div class="banquan">');
	footerArr.push('Copyright ? <a href="http://www.zhao-chuan.com/">国际货代 货代平台 找船网 www.zhao-chuan.com</a> <a href="http://www.miitbeian.gov.cn/">粤ICP备15038148号</a>&nbsp;');
	footerArr.push('<br/><a href="http://webscan.360.cn/index/checkwebsite/url/www.zhao-chuan.com"><img border="0" src="http://img.webscan.360.cn/status/pai/hash/075ae8117e788ca8e9afba40c1d9031a"/></a>&nbsp;');
	/*footerArr.push('<a href="http://www.bj.cyberpolice.cn/"><img border="0"   src="http://112.74.81.205/files/adv/corporation/aqlm.png"/></a>&nbsp;');*/
	footerArr.push('<a href="http://www.miitbeian.gov.cn/"><img border="0"   src="http://112.74.81.205/files/adv/corporation/gswj.png"/></a>&nbsp;');
	footerArr.push('</div>');
	footerArr.push('<div class="renzhengt"></div>');
	footerArr.push('</div>');
	footerArr.push('</div>');
	footerArr.push('</div>');
	
	//$("body").append(footerArr.join(""));
	//friendLinkScoll();
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
	
    //搜索1
    $(".sear_cont").find(".sear_sub").on("click",function()
    {
    	var transType=$.trim($(".sear_cont").find("select[name='queryTransType']").val());
        var startPort=$.trim($(".sear_cont").find("input[name='queryStartPort']").val());
        var endPort=$.trim($(".sear_cont").find("input[name='queryEndPort']").val());
        //var index=$(".search .sear_title").find(".on").index();
        location.href=SITE_URL+"ships?startPort="+startPort+"&endPort="+endPort+"&transType="+transType;
    });
    $(".sear_cont").on("keydown","form",function(e)
    {
        if(e.keyCode=="13")
        {
            $(".sear_cont").find(".sear_sub").trigger("click");
        }
    });
 

    $(".Dwt").find("#close_purchase").bind("click",function(){
        $(".Dwt").hide();
    });


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
    
    
	
	/**导航nav移入效果**/
    $(".new_nav_content a").each(function(){
    		if(typeof $(this).attr('class')=='undefined'){
    			$(this).mouseover(function(){
    				$(this).css('background','#3088D2');
    			}).mouseout(function(){
    				$(this).css('background','');
    			});
    		}	
    });
   
			
	
    

    /**  搜索tab效果***/
    $(".sear_title span").click(function(){
    	$(".sear_title span").removeClass("on");
    	$(this).addClass("on");
    });
    
    
    
    if ($(".backpage").length < 1) {
	    /** 航线分类 ****/
	    $.ajax(
	    {
	        url:SITE_URL+'route/endPortList',
	        type:"get",
	        cache:false,
	        success:function(rs)
	        {
	        	var ShipMeijia = [];
	        	var ShipOuDi = [];
	        	var ShipFeiZhou = [];
	        	var ShipZhongNanMei = [];
	        	var ShipYinBa = [];
	        	var ShipYuanDong = [];
	        	var ShipDongNanYa = [];
	        	var ShipAoXin = [];
	            if(rs)
	            {
	            	for (var i=0; i<rs.length; i++){
	            		var theData = rs[i];
	            		if (theData.category == 'MeiJia') {
	            			ShipMeijia.push('<dd><a href="/ships/ship.html?startPort=&transType=&endPort=')
	            			ShipMeijia.push(theData.port);
	            			ShipMeijia.push('">');
	            			ShipMeijia.push(theData.port);
	            			ShipMeijia.push('</a></dd>');
	            		} else if (theData.category == 'OuDi') {
	            			ShipOuDi.push('<dd><a href="/ships/ship.html?startPort=&transType=&endPort=')
	            			ShipOuDi.push(theData.port);
	            			ShipOuDi.push('">');
	            			ShipOuDi.push(theData.port);
	            			ShipOuDi.push('</a></dd>');
	            		} else if (theData.category == 'FeiZhou') {
	            			ShipFeiZhou.push('<dd><a href="/ships/ship.html?startPort=&transType=&endPort=')
	            			ShipFeiZhou.push(theData.port);
	            			ShipFeiZhou.push('">');
	            			ShipFeiZhou.push(theData.port);
	            			ShipFeiZhou.push('</a></dd>');
	            		} else if (theData.category == 'ZhongNanMei') {
	            			ShipZhongNanMei.push('<dd><a href="/ships/ship.html?startPort=&transType=&endPort=')
	            			ShipZhongNanMei.push(theData.port);
	            			ShipZhongNanMei.push('">');
	            			ShipZhongNanMei.push(theData.port);
	            			ShipZhongNanMei.push('</a></dd>');
	            		} else if (theData.category == 'YinBa') {
	            			ShipYinBa.push('<dd><a href="/ships/ship.html?startPort=&transType=&endPort=')
	            			ShipYinBa.push(theData.port);
	            			ShipYinBa.push('">');
	            			ShipYinBa.push(theData.port);
	            			ShipYinBa.push('</a></dd>');
	            		} else if (theData.category == 'YuanDong') {
	            			ShipYuanDong.push('<dd><a href="/ships/ship.html?startPort=&transType=&endPort=')
	            			ShipYuanDong.push(theData.port);
	            			ShipYuanDong.push('">');
	            			ShipYuanDong.push(theData.port);
	            			ShipYuanDong.push('</a></dd>');
	            		} else if (theData.category == 'DongNanYa') {
	            			ShipDongNanYa.push('<dd><a href="/ships/ship.html?startPort=&transType=&endPort=')
	            			ShipDongNanYa.push(theData.port);
	            			ShipDongNanYa.push('">');
	            			ShipDongNanYa.push(theData.port);
	            			ShipDongNanYa.push('</a></dd>');
	            		} else if (theData.category == 'AoXin') {
	            			ShipAoXin.push('<dd><a href="/ships/ship.html?startPort=&transType=&endPort=')
	            			ShipAoXin.push(theData.port);
	            			ShipAoXin.push('">');
	            			ShipAoXin.push(theData.port);
	            			ShipAoXin.push('</a></dd>');
	            		}
	            	}
	            }
	            initCategory(ShipMeijia, ShipOuDi, ShipFeiZhou, ShipZhongNanMei, ShipYinBa, ShipYuanDong, ShipDongNanYa, ShipAoXin);
	        }
	    });
    }
});

function initCategory(ShipMeijia, ShipOuDi, ShipFeiZhou, ShipZhongNanMei, ShipYinBa, ShipYuanDong, ShipDongNanYa, ShipAoXin){
	
	var shipLines = new Array();
	shipLines.push('<div class="listBox"><ul>');
	shipLines.push(initCategoryDetail("美加线", ShipMeijia));
	shipLines.push(initCategoryDetail("欧地线", ShipOuDi));
	shipLines.push(initCategoryDetail("非洲线", ShipFeiZhou));
	shipLines.push(initCategoryDetail("中南美线", ShipZhongNanMei));
	shipLines.push(initCategoryDetail("中东印巴红海线", ShipYinBa));
	shipLines.push(initCategoryDetail("日韩港澳台远东线", ShipYuanDong));
	shipLines.push(initCategoryDetail("东南亚线", ShipDongNanYa));
	shipLines.push(initCategoryDetail("澳新线", ShipAoXin));
	shipLines.push('</ul></div>'); 
	
   	$("#categoryShips").append(shipLines.join(''));
    $("#categoryShipsMenu").hover(function(){
    	$("#categoryShips").show();
        },function(){
        	$("#categoryShips").hide();
      });
    
   	
   	$("#categoryShips .listBox li").mouseover(function(){
   		$(this).find(".showBox").show();
   		$(this).addClass("liOver");
   	}).mouseout(function(){
   		$(this).find(".showBox").hide();
   		$(this).removeClass("liOver");
   	});	
   	
   	
   	$(".btnAndTxtSlide").click(
   		function(){
   			if ($(this).hasClass("shouqi")) {
   				$(this).removeClass("shouqi");
   				$(this).find(".btnSlide").removeClass("btnUp");
   				$(this).find(".txtSlide").html("显示全部");
   				$(this).parent().next().height("336px");
   				$(this).parent().parent().height("336px");
   				$(this).parent().next().css("overflow-y", "hidden");
   			} else {
   				$(this).addClass("shouqi");
   				$(this).find(".btnSlide").addClass("btnUp");
   				$(this).find(".txtSlide").html("收起全部");
   				$(this).parent().next().height("430px");
   				$(this).parent().parent().height("500px");
   				$(this).parent().next().css("overflow-y", "auto");
   			}
   		}
   	);
	
}
$(".new_nav_content a").click(function(){
	$(this).css('background','#333333');
	
})

function initCategoryDetail(cataName, data) {
	return [
	   '<li class="">',
       '<div class="cell">',
           '<span class="aBox">',
               '<a class="aLink" onclick="javascript:void(0);">',
               cataName,
           	   '</a>',
           '</span>',
           '<span class="arrow"></span>',
       '</div>',
       '<div class="showBox">',
           '<div class="topBox">',
               '<span class="title">目的港</span>',
               '<a class="more btnAndTxtSlide" onclick="javascript:void(0);"><em class="btnSlide"></em><em class="txtSlide">显示全部</em></a>',
               '<a class="more" href="/ships">更多</a>',
          '</div>',
          '<div class="dataList">',
               '<dl>',
               data.join(''),
               '</dl>',
           '</div>',
       '</div>',
	'</li>'].join('')
}


function iePlaceHolder() {
	
	var doc = document, inputs = doc
			.getElementsByTagName('input'), supportPlaceholder = 'placeholder' in doc
			.createElement('input'), placeholder = function(
			input) {
		var text = input.getAttribute('placeholder'), defaultValue = input.defaultValue;
		if (defaultValue == '') {
			input.value = text
		}
		input.onfocus = function() {
			if (input.value === text) {
				this.value = ''
			}
		};
		input.onblur = function() {
			if (input.value === '') {
				this.value = text
			}
		}
	};
	if (!supportPlaceholder) {
		for (var i = 0, len = inputs.length; i < len; i++) {
			var input = inputs[i], text = input
					.getAttribute('placeholder');
			if (input.type === 'text' && text) {
				placeholder(input)
			}
		}
	}
}

function friendLinkScoll(){
	var $leftArrow = $('#fl-left-arrow');
	var $rigthArrow = $('#fl-rigth-arrow');
	var $innerBox = $('#fl-inner-box');
	var interval = 50;
	var timer = 0;
	var fangxiang = -1; // -1左边 1右边
	var marginLeft = 0;
	$leftArrow.mouseenter(function(event) {
		interval = 5;
		fangxiang = -1;
		clearInterval(timer);
		run();
	}).mouseleave(function(event) {
		interval = 50;
		fangxiang = -1;
		clearInterval(timer);
		run();
	});
	$rigthArrow.mouseenter(function(event) {
		interval = 5;
		fangxiang = 1;
		clearInterval(timer);
		run();
	}).mouseleave(function(event) {
		interval = 50;
		fangxiang = -1;
		clearInterval(timer);
		run();
	});
	$innerBox.find('a').css({'margin-left':'0px'});
	function run(){
		var isChange = true;
		var $firstItem;
		timer = setInterval(function(){
			if(isChange){
				$firstItem = $innerBox.find('a').eq(0);
				isChange = false;
			}
			marginLeft += fangxiang; 
			$firstItem.css({'margin-left':marginLeft+'px'});
			if(fangxiang == -1){
				if(Math.abs(marginLeft) > $firstItem.width()+10){
					marginLeft = 0;
					$firstItem.css({'margin-left':'0px'});
					$innerBox.append($firstItem);
					isChange = true;
				}
			}else if(fangxiang == 1){
				if(marginLeft > 0){
					var $lastItem = $innerBox.find('a').last();
					marginLeft = -($lastItem.width() + 10);
					$lastItem.css({'margin-left':marginLeft+'px'});
					$innerBox.prepend($lastItem);
					isChange = true;
				}
			}
			
		}, interval);
	}
	run();
}

//IE支持placeholder
$(document).ready(function(){
	iePlaceHolder();
})
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?2de986e52f27154fe1219440d75a852f";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();

// 搜索框数据源
var start_port_list = window['start_port_list'] ? window['start_port_list'] : '';
var end_port_list = window['end_port_list'] ? window['start_port_list'] :'';
if(!start_port_list){
	$.ajax({
		url:'/Route/port',
		dataType:'json',
		success:function(rs){
			if(rs.status === 1){
				window['start_port_list'] = start_port_list =  rs.result.startPort;
				window['end_port_list'] = end_port_list = rs.result.endPort;
			}
		},
		error:function(rs){
		}
	});
}
setTimeout(function(){
	$(function() {
		$('.ui-search-widget').searchComp({
			dataSource: {
				start_port_list: start_port_list,
				end_port_list: end_port_list
			}
		});
		$(".tools_nav").click(function(){

			chuanQi.hide();
		});
	})
},3000);





var SearchComponent = function (element,options){
     if(!element)return;
     this.el = $(element);
     this.dataSource = options.dataSource || [];
     this.options = options;
     this.initEvent();
     return this;
};
SearchComponent.prototype  = {
    Constructor : SearchComponent,
    initEvent:function(){
         var me = this;
         me.start_port_el = $('#start_port_input');
         me.end_port_el = $('#dest_port_input');
         me.tabParentEl =  $('.ui-tab-type');
         me.tabParentEl.click(function(e){
             var targetEl = $(e.target);
             me.toggleTab(targetEl);
        });
        $('.ui-search-button').click(function(){
            me.sendPortQuery();
        });
        me.bindingDataSource();
        return me;
    },
    bindingDataSource:function(){
        var me = this;
        var start_port_el = this.start_port_el;
        var end_port_el = this.end_port_el;
        start_port_el.typeahead({
            source: me.dataSource.start_port_list　|| [],
            items: me.options.items || 8
        })
        end_port_el.typeahead({
           source: me.dataSource.end_port_list || [],
            items: me.options.items || 8
        })
        return me;
    },
    sendPortQuery:function(){
        var start_port_val = this.start_port_el.val();
        var dest_port_val = this.end_port_el.val();
        var category = this.tabParentEl.find('.ui-tab-whole').data('category');
        var isRequire = !start_port_val && !dest_port_val || start_port_val == '没有找到对应的港口' || dest_port_val == '没有找到对应的港口';
        if(!userName){
        	location.href= host+'/login';
        	return ;
        }
        if(!isRequire){
        	if($('.datatable-search-btn').length === 0){
        		location.href = host + '/ships/ship.html?transType='+category+'&startPort='+start_port_val+'&endPort='+dest_port_val;
        	}else{
                location.href = location.pathname+'?transType='+category+'&startPort='+start_port_val+'&endPort='+dest_port_val;
            }
        }
        return this;

    },
    toggleTab:function(selectedTab){
        if(!selectedTab || selectedTab && selectedTab.hasClass('.ui-tab-whole')) return;
        var tabParentEl = this.tabParentEl;
        tabParentEl.find('span').removeClass();
        selectedTab.addClass('ui-tab-whole');
        selectedTab.siblings().addClass('ui-tab-together');
    }
}
$.fn.searchComp = function(options){
     if(typeof options === 'object')
     new SearchComponent(this,options
    		 );
    return this;

};
$.fn.searchComp.Constructor = SearchComponent;

!function($) {
    "use strict"; // jshint ;_;
    var Typeahead = function(element, options) {
        this.$element = $(element);
        this.options = $.extend({}, $.fn.typeahead.defaults, options);
        this.focusShow = this.options.focusShow || false;
        this.matcher = this.options.matcher || this.matcher;
        this.sorter = this.options.sorter || this.sorter;
        this.highlighter = this.options.highlighter || this.highlighter;
        this.updater = this.options.updater || this.updater;
        this.source = this.options.source;
        this.$menu = $(this.options.menu);
        this.shown = false;
        this.listen();

    };
    Typeahead.prototype = {
        constructor: Typeahead,
        select: function() {
            var val = this.$menu.find('.active').data('value');
            var lab = this.$menu.find('.active').data('label');
            this.$element.val(this.updater(lab)).change();
            $('#' + this.input_id).val(val);
            return this.hide();
        },
        updater: function(item) {
            return item;
        },
        show: function(result) {
            var pos = $.extend({}, this.$element.position(), {
                height: this.$element[0].offsetHeight
            });
            this.$menu.insertAfter('.ui-search-button').css({top: pos.top + pos.height, left: pos.left}).show();
            this.shown = true;
            if (this.options.width) {
                this.$menu.css({width: this.options.width + 'px'});
            } else {
                result.isLongResult ? this.$menu.css({width: this.$element.parent('.ui-parent-port').width() + result.countExceed}):this.$menu.css({width: this.$element.parent('.ui-parent-port').width()});

            }

            /*     this._element_width = this.$element.width();
             this._menu_width = this.$menu.width();
             if (this._element_width > this._menu_width) {
             this.$menu.css({width: this._element_width + 'px'});
             }*/
            return this;
        },
        hide: function(blurTrigger) {

            var val = this.$menu.find('.active').data('value');
            var lab = this.$menu.find('.active').data('label');
            if (this.$element.val() === '') {
                val = '';
                lab = '';
            }
            if(!blurTrigger){ this.$element.val(lab);} //能让用户输入
            $('#' + this.input_id).val(val);
            this.$menu.hide();
            this.shown = false;
            return this;
        },
        lookup: function(event) {
            var items;
            this.query = this.$element.val();
            if ((!this.query && !this.focusShow) || this.query.length < this.options.minLength) {
                return this.shown ? this.hide() : this;
            }
            items = $.isFunction(this.source) ? this.source(this.query, $.proxy(this.process, this)) : this.source;
            return items ? this.process(items) : this;
        },
        process: function(items) {
            var that = this;
            var result = null;
            items = $.grep(items, function(item) {
                if (typeof (item) !== 'object') {
                    item = {label: item, value: item};
                }

                item.value = item.value || item;
                item.label = item.label || item.value;

                return that.matcher(item.label, item.title);
            });
            items = this.sorter(items);

            if (!items.length) {
                items = [{value: this.options.noneValue || '', label: this.options.noneLabel}];
            }
            this.items = items.length;
             result = this.checkLongResult(items.slice(0, this.options.items));
            return this.render(items.slice(0, this.options.items)).show(result);
        },
        matcher: function(item, ititle) {
            var result = false;
            var item = item.toLowerCase().replace(/\s+/g,'');
            var query = this.query.toLowerCase().replace(/\s+/g,'');
            var ititle = ititle.toLowerCase().replace(/\s+/g,'');

            var index = ~item.indexOf(query);
            if (!index && ititle && ~ititle.indexOf(query)) {
                index =  ~ititle.indexOf(query);
            }
            result = (index <= -1 ? true : false);
            return result;
        },
        sorter: function(items) {
            if (this.query === '') {
                return items;
            }
            var that = this;
            return items.sort(function(a, b) {
                return a.label.toLowerCase().indexOf(that.query.toLowerCase())
                    - b.label.toLowerCase().indexOf(that.query.toLowerCase());
            });
        },
        highlighter: function(item) {
            return '<span>'+ item + '</span>';
        },
        render: function(items) {

            var that = this;
            items = $(items).map(function(i, item) {  //TODO jquery的高级属性
                i = $(that.options.item);
                for (var b in item) {
                    i.attr('data-' + b, item[b]);
                }
                i.html(that.highlighter(item.label) + '<b>' + (item.title || '') + ' </b>');
                return i[0];
            });

            items.first().addClass('active');
            this.$menu.html(items);
            return this;
        },
        checkLongResult :function(items){
        	var  result = {
        		isLongResult:false,
        		countExceed:0
        	};
        	var  diff = 0;
            if(!items || items[0].label == this.options.noneLabel)return false;//有可能是nonelabel的值  
            for(var i in items){
            	diff = items[i].label.length + items[i].title.length -21;
                if(diff > 0){
                     result.isLongResult = true;
                     result.countExceed = result.countExceed <= diff ? diff : result.countExceed ;
                }
            }
            result.countExceed = result.countExceed *8;
            return result;
        },
        next: function(event) {
            var active = this.$menu.find('.active').removeClass('active'), next = active.next();
            if (!next.length) {
                next = $(this.$menu.find('li')[0]);
            }
            next.addClass('active');
        },
        prev: function(event) {
            var active = this.$menu.find('.active').removeClass('active'), prev = active.prev();
            if (!prev.length) {
                prev = this.$menu.find('li').last();
            }
            prev.addClass('active');
        },
        element_click: function() {
            if (this.$element.val() === this.options.noneLabel) {
                this.$element.val('');
            }
        },
        listen: function() {
            this.$element
                .on('focus', $.proxy(this.focus, this))
                .on('blur', $.proxy(this.blur, this))
                .on('keypress', $.proxy(this.keypress, this))
                .on('keyup', $.proxy(this.keyup, this))
                .on('click', $.proxy(this.element_click, this));
            if (this.eventSupported('keydown')) {
                this.$element.on('keydown', $.proxy(this.keydown, this));
            }
            this.$menu
                .on('click', $.proxy(this.click, this))
                .on('mouseenter', 'li', $.proxy(this.mouseenter, this))
                .on('mouseleave', 'li', $.proxy(this.mouseleave, this))
        },
        eventSupported: function(eventName) {
            var isSupported = eventName in this.$element;
            if (!isSupported) {
                this.$element.setAttribute(eventName, 'return;');
                isSupported = typeof this.$element[eventName] === 'function';
            }
            return isSupported;
        },
        move: function(e) {
            if (!this.shown) {
                return;
            }
            switch (e.keyCode) {
                case 9: // tab
                case 13: // enter
                case 27: // escape
                    e.preventDefault();
                    break
                case 38: // up arrow
                    e.preventDefault();
                    this.prev();
                    break
                case 40: // down arrow
                    e.preventDefault();
                    this.next();
                    break
            }
            e.stopPropagation();
        },
        keydown: function(e) {
            this.suppressKeyPressRepeat = ~$.inArray(e.keyCode, [40, 38, 9, 13, 27]);
            this.move(e);
        },
        keypress: function(e) {
            if (this.suppressKeyPressRepeat) {
                return;
            }
            this.move(e);
        },
        keyup: function(e) {
            switch (e.keyCode) {
                case 40: // down arrow
                case 38: // up arrow
                    var val = this.$menu.find('.active').data('value');
                    var lab = this.$menu.find('.active').data('label');
                    this.$element.val(this.updater(lab)).change();
                    $('#' + this.input_id).val(val);
                    break;
                case 16: // shift
                case 17: // ctrl
                case 18: // alt
                    break
                case 9: // tab
                    if (this.$menu.find('li').index('.active') > 0) {
                        return;
                    }
                case 13: // enter
                    if (!this.shown) {
                        return;
                    }
                    this.select();
                    break;
                case 27: // escape
                    if (!this.shown) {
                        return;
                    }
                    this.hide();
                    break;
                default:
                    this.shown = true;
                    this.lookup();
            }
            e.stopPropagation();
            e.preventDefault();
        },
        focus: function(e) {
            this.shown = true;
            this.lookup();
            this.focused = true;
        },
        blur: function() {
            this.focused = false;
            if (!this.mousedover && this.shown) {
                this.hide(true);
            }
        },
        click: function(e) {
            e.stopPropagation();
            e.preventDefault();
            this.select();
// this.$element.focus();
        },
        mouseenter: function(e) {
            this.mousedover = true;
            this.$menu.find('.active').removeClass('active');
            $(e.currentTarget).addClass('active');
        },
        mouseleave: function(e) {
            this.mousedover = false;
            if (!this.focused && this.shown) {
                this.hide();
            }
        }
    };
    /* TYPEAHEAD PLUGIN DEFINITION
     * =========================== */
    var old = $.fn.typeahead;
    $.fn.typeahead = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data('typeahead'), options = typeof (option) === 'object' && option;
            if (!data) {
                $this.data('typeahead', (data = new Typeahead(this, options)));
            }
            if (typeof (option) === 'string') {
                data[option]();
            }
        });
    };
    $.fn.typeahead.defaults = {
        noneLabel: '没有找到对应的港口',
        source: [],
        items: 8,
        menu: '<ul class="typeahead ui-port-list" style="font-size:12px;position:absolute;margin-top:2px;"></ul>',
        item: '<li></li>',
        minLength: 0,
        focusShow: true
    };
    $.fn.typeahead.Constructor = Typeahead;
    /* TYPEAHEAD NO CONFLICT
     * =================== */
    $.fn.typeahead.noConflict = function() {
        $.fn.typeahead = old;
        return this;
    };
    /* TYPEAHEAD DATA-API
     * ================== */
    $(document).on('focus.typeahead.data-api', '[data-provide="typeahead"]', function(e) {
        var $this = $(this);
        if ($this.data('typeahead')) {
            return;
        }
        $this.typeahead($this.data());
    });
}(window.jQuery);

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
