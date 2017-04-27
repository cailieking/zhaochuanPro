//添加后台管理顶部UI
function manageAddTopHtml(){
	var doHtml=
'<!--后台管理顶部-->'+
'<div class="manage_topBg0">'+
	'<div class="manage_topBg">'+
    	'<div class="logoBg">'+
        	'<img src="c_images/logo.png" />'+
        	'<div class="txt">SaaS云平台管理系统</div>'+
        '</div>'+
		'<ul class="userBg">'+
            '<li><a href="http://www.zhaochuan.cn/" target="_blank">找船网</a></li>'+
            '<li><a href="http://sw.zhao-chuan.com/index.html" target="_blank">网站前台</a></li>'+
            '<li>'+
            	'<div class="userName">蔡金宏</div>'+
                '<ul class="userMenu">'+
                	'<li><a href="myAccount_info.html">账号设置</a></li>'+
                    '<li><a href="login.html">退出</a></li>'+
                '</ul>'+
            '</li>'+
        '</ul>'+
	'</div>'+
'</div>'+
'<!--后台管理顶部 end-->';
	$('body').prepend($(doHtml));
	manageTopUserMenuEvent();//顶部用户下拉菜单事件关联
}


//添加后台管理左侧导航UI
function manageAddLeftHtml(){
	var doHtml=   
		'<div class="lTitle">Sass云平台</div>'+
        '<ul class="lNavList">'+
        	'<li><a href="index.html">首页</a></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="index.html">管理首页</a></li>'+
				'<div class="btmBorder"></div>'+
            '</ul>'+
            '<li><a href="spread.html">优化推广</a></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="spread.html">搜索引擎优化</a></li>'+ 
				'<div class="btmBorder"></div>'+
            '</ul>'+
            '<li><a>客户管理</a><div class="arrow"></div></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="guest_manage.html">客户管理</a></li>'+
                '<li><a href="guest_need.html">需求分类</a></li>'+
                '<li><a href="guest_type.html">客户类型</a></li>'+
                '<li><a href="guest_group.html">群组管理</a></li>'+
                '<li><a href="guest_label.html">标签管理</a></li>'+
				'<div class="btmBorder"></div>'+
            '</ul>'+
            '<li><a>邮件营销</a><div class="arrow"></div></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="mail_send.html">发送邮件</a></li>'+
                '<li><a href="mail_manage.html">邮件管理</a></li>'+
                '<li><a href="mail_mod.html">模板管理</a></li>'+
                '<li><a href="mail_set.html">邮件设置</a></li>'+
				'<div class="btmBorder"></div>'+
            '</ul>'+
            '<li><a>网站管理</a><div class="arrow"></div></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="web_base.html">基本信息</a></li>'+
                '<li><a href="web_banner.html">首页滚动广告设置</a></li>'+
                '<li><a href="web_nav.html">导航栏设置</a></li>'+
                '<li><a href="web_sets1.html">【公司概况】设置</a></li>'+
                '<li><a href="web_sets2.html">【服务内容】设置</a></li>'+
                '<li><a href="web_sets3.html">【业务优势】设置</a></li>'+
                '<li><a href="web_sets4.html">【联系我们】设置</a></li>'+
                '<div class="btmBorder"></div>'+
            '</ul>'+
            '<li><a>运价</a><div class="arrow"></div></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="shipping_manage.html">运价管理</a></li>'+
                '<li><a href="shipping_send.html">运价发布</a></li>'+
                '<li><a href="shipping_data.html">找船实时运价</a></li>'+
                '<div class="btmBorder"></div>'+
            '</ul>'+
            '<li><a>咨询</a><div class="arrow"></div></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="consult_list.html">咨询列表</a></li>'+
                '<li><a href="consult_tishi.html">提醒设置</a></li>'+
                '<div class="btmBorder"></div>'+
            '</ul>'+
            '<li><a href="accountLimit.html">权限</a></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="accountLimit.html">账号权限</a></li>'+
                '<div class="btmBorder"></div>'+
            '</ul>'+
            '<li><a>设置</a><div class="arrow"></div></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="myAccount_info.html">个人信息</a></li>'+
                '<li><a href="myAccount_pwd.html">密码修改</a></li>'+
            '</ul>'+
			'<li><a>搜索管理</a><div class="arrow"></div></li>'+
            '<ul class="menuList">'+
				'<div class="topBorder"></div>'+
            	'<li><a href="#">搜索日志</a></li>'+
                '<li><a href="#">周排名</a></li>'+
            '</ul>'+
        '</ul>';
	$('.manage_md_left').html(doHtml);
	manageLeftNavEvent();//左侧导航事件关联
}
//添加后台管理底部UI
function manageAddBottomHtml(){
	var doHtml=
'<!--后台管理底部-->'+
'<div class="manage_bottom">'+
	'<a href="http://www.zhao-chuan.com" target="_blank">找船网</a>© 2015-2016 zhaochuan.cn 版权所有 粤ICP备15038148号'+
'</div>'+
'<!--后台管理底部 end-->';
	$('body').append($(doHtml));
}
//顶部用户下拉菜单事件关联
function manageTopUserMenuEvent(){
	$('.manage_topBg .userName').click(function(){
		var menu=$('.manage_topBg .userMenu');
		if(menu.css('display')=="none"){
			menu.show();
		}else{
			menu.hide();
		}
	})
}
//左侧导航事件关联
function manageLeftNavEvent(){
	//导航父节点点击
	$('.manage_md_left .lNavList>li').click(function(){
		var lis=$('.manage_md_left .lNavList>li');
		var uls=$('.manage_md_left .lNavList>.menuList');
		var lastSel=$('.manage_md_left .lNavList>.open');
		var thisEle=$(this);
		var selIndex=-1;
		if(lastSel){
			var selIndex=lis.index(lastSel);
		}
		var clickIndex=lis.index(thisEle);
		if(selIndex!=clickIndex){
			var lastMenu=lastSel.next();
			var thisMenu=thisEle.next();
			var maxHeight=thisMenu.find('li').length*36+1;
			if(maxHeight<40){maxHeight=0;}
			var minHeight=0;
			lastMenu.animate({
				height:minHeight,
				duration:'fast',
				queue:false
			}, function() {
				lastSel.removeClass('open');
			});
			if(lastSel.find('.arrow')){
				var lastAr=lastSel.find('.arrow');
				lastAr.addClass('round1');
				setTimeout(function(){
					lastAr.removeClass('round1');
					lastAr.removeClass('arrow_d');
				},500);
			}
			thisMenu.animate({
				height:maxHeight,
				duration:'fast',
				queue:false
			}, function() {
				thisEle.addClass('open');
			});
			if(thisEle.find('.arrow')){
				var thisAr=thisEle.find('.arrow');
				thisAr.addClass('round2');
				setTimeout(function(){
					thisAr.removeClass('round2');
					thisAr.addClass('arrow_d');
				},500);
			}
		}
	})
}
//设置左侧导航选中状态
//@index1 导航父节点序列 从0开始
//@index2 导航子节点序列 从-1开始
function setManageLeftNavSel(index1,index2){
	var selLi1=$('.manage_md_left .lNavList>li').eq(index1);
	var selMenu=$('.manage_md_left .lNavList>.menuList').eq(index1);
	var selMenu_li=selMenu.find('li').eq(index2);
	var selMenu_height=selMenu.find('li').length*36+1;
	selLi1.addClass('open');
	if(index1!=0&&index1!=1&&index1!=7){
		selMenu.height(selMenu_height);
		selMenu_li.addClass('sel');
		selLi1.find('.arrow').addClass('arrow_d');
	}
}

function GetQueryString(name)
{
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if(r!=null)return unescape(r[2]); return null;
}


/*信息提示框*/
function zcAlert(msg){
	var alertHtml=
'<div class="winModBg0" style="z-index:1001;">'+
	'<div class="winModBg alertMod">'+
    	'<div class="titleBg">'+
        	'<div class="caption">提示窗口</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<div class="alertContent">'+
        	'<div class="tishiIcon"></div>'+
            '<div class="rightBg">'+
            	'<div class="vertMdTxtBg0 txtBg" style="width:150px">'+
                	'<div class="vertMdTxtBg">'+
                    	'<div class="vertMdTxt alertTxt">'+msg+'</div>'+
                    '</div>'+
                '</div>'+
                '<div class="btnBg">'+
                	'<div class="btnMod1 alertBtn okBtn">返回</div>'+
                '</div>'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append(alertHtml);

	setEleMiddle($('.alertMod'));//使元素居中
	setEleMove($('.alertMod .titleBg'));//通过标头拖动窗口
	$('.alertMod .closeBtn').on('click',function(){
		zcAlertClose();
	});
	$('.alertMod .okBtn').on('click',function(){
		zcAlertClose();
	});
	$('body').on("keypress.zcalertclose",function(){
		zcAlertClose();
	}); 
	function zcAlertClose(){
		$('body').off('.zcalertclose');
		$('.alertMod').parent().remove();
	}
}

function zcAlertrt(msg){
	var alertHtml=
'<div class="winModBg0" style="z-index:1001;">'+
	'<div class="winModBg alertMod">'+
    	'<div class="titleBg">'+
        	'<div class="caption">提示窗口</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<div class="alertContent">'+
        	'<div class="tishiIcon"></div>'+
            '<div class="rightBg">'+
            	'<div class="vertMdTxtBg0 txtBg">'+
                	'<div class="vertMdTxtBg">'+
                    	'<div class="vertMdTxt alertTxt">'+msg+'</div>'+
                    '</div>'+
                '</div>'+
                '<div class="btnBg">'+
                	'<div class="btnMod1 alertBtn okBtn">确定</div>'+
                '</div>'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append(alertHtml);

	setEleMiddle($('.alertMod'));//使元素居中
	setEleMove($('.alertMod .titleBg'));//通过标头拖动窗口
	$('.alertMod .closeBtn').on('click',function(){
		zcAlertClose();
	});
	$('.alertMod .okBtn').on('click',function(){
		zcAlertClose();
	});
	$('body').on("keypress.zcalertclose",function(){
		zcAlertClose();
	}); 
	function zcAlertClose(){
		$('body').off('.zcalertclose');
		$('.alertMod').parent().remove();
	}
}

function zcConfirm(msg,callback){
	var alertHtml=
'<div class="winModBg0">'+
	'<div class="winModBg alertMod">'+
    	'<div class="titleBg">'+
        	'<div class="caption">确认窗口</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<div class="alertContent">'+
        	'<div class="tishiIcon"></div>'+
            '<div class="rightBg">'+
            	'<div class="vertMdTxtBg0 txtBg">'+
                	'<div class="vertMdTxtBg">'+
                    	'<div class="vertMdTxt alertTxt">'+msg+'</div>'+
                    '</div>'+
                '</div>'+
                '<div class="btnBg">'+
                	'<div class="btnMod1 alertBtn noBtn">取消</div>'+
                    '<div class="btnMod1 alertBtn yesBtn">确定</div>'+
                '</div>'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append(alertHtml);
	modDlgEvent($('.alertMod'));
	$('.alertMod .yesBtn').on('click',function(){
		$('.alertMod .closeBtn').trigger('click');
		callback(true);
	});
	$('.alertMod .noBtn').on('click',function(){
		$('.alertMod .closeBtn').trigger('click');
		callback(false);
	});
}


function zcConfirm1(msg,callback){
	var alertHtml=
'<div class="winModBg0">'+
	'<div class="winModBg alertMod">'+
    	'<div class="titleBg">'+
        	'<div class="caption">确认窗口</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<div class="alertContent">'+
        	'<div class="tishiIcon"></div>'+
            '<div class="rightBg">'+
            	'<div class="vertMdTxtBg0 txtBg" >'+
                	'<div class="vertMdTxtBg">'+
                    	'<div class="vertMdTxt alertTxt">'+msg+'</div>'+
                    '</div>'+
                '</div>'+
                '<div class="btnBg">'+
                	'<div class="btnMod1 alertBtn noBtn">发布</div>'+
                    '<div class="btnMod1 alertBtn yesBtn">添加</div>'+
                '</div>'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append(alertHtml);
	modDlgEvent($('.alertMod'));
	$('.alertMod .yesBtn').on('click',function(){
		callback(true);
		$('.alertMod .closeBtn').trigger('click');
	});
	$('.alertMod .noBtn').on('click',function(){
		callback(false);
		$('.alertMod .closeBtn').trigger('click');
	});
}

function zcConfirm2(msg,callback){
	var alertHtml=
'<div class="winModBg0">'+
	'<div class="winModBg alertMod">'+
    	'<div class="titleBg">'+
        	'<div class="caption">确认窗口</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<div class="alertContent">'+
        	'<div class="tishiIcon"></div>'+
            '<div class="rightBg">'+
            	'<div class="vertMdTxtBg0 txtBg">'+
                	'<div class="vertMdTxtBg">'+
                    	'<div class="vertMdTxt alertTxt">'+msg+'</div>'+
                    '</div>'+
                '</div>'+
                '<div class="btnBg">'+
                	'<div class="btnMod1 alertBtn noBtn">返回</div>'+
                    '<div class="btnMod1 alertBtn yesBtn">发布</div>'+
                '</div>'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append(alertHtml);
	modDlgEvent($('.alertMod'));
	$('.alertMod .yesBtn').on('click',function(){
		callback(true);
		$('.alertMod .closeBtn').trigger('click');
	});
	$('.alertMod .noBtn').on('click',function(){
		callback(false);
		$('.alertMod .closeBtn').trigger('click');
	});
}


function zcConfirm3(msg){
	var alertHtml=
'<div class="winModBg0">'+
	'<div class="winModBg alertMod">'+
    	'<div class="titleBg">'+
        	'<div class="caption">成功窗口</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<div class="alertContent">'+
        	'<div class="tishiIcon"></div>'+
            '<div class="rightBg">'+
            	'<div class="vertMdTxtBg0 txtBg">'+
                	'<div class="vertMdTxtBg">'+
                    	'<div class="vertMdTxt alertTxt">'+msg+'</div>'+
                    '</div>'+
                '</div>'+
                '<div class="btnBg">'+
                    '<div class="btnMod1 alertBtn yesBtn">确定</div>'+
                '</div>'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>';
	$('body').append(alertHtml);
	modDlgEvent($('.alertMod'));
	$('.alertMod .yesBtn').on('click',function(){
		$('.alertMod .closeBtn').trigger('click');
	});
}

/*信息提示框 end*/

//自制弹出框公用事件
//@ele 弹出框元素的jq对象
function modDlgEvent(ele){
	setEleMiddle(ele);//使元素居中
	setEleMove(ele.find('.titleBg'));//通过标头拖动窗口
	//顶部关闭按钮
	ele.find('.closeBtn').on('click',function(){
		modDlgClose();
	});
	//关闭
	function modDlgClose(){
		ele.parent().remove();
	}
}
//使元素拖拽时移动其父元素
//@$ele为jq元素对象，该元素需要是拖动元素的子元素(主要为模态窗口使用)
function setEleMove($ele){
	var diffX,diffY;
	$ele.mousedown(function(e){
		diffX = e.pageX-$ele.parent().offset().left;
		diffY = e.pageY-$ele.parent().offset().top+$('body').scrollTop();
		$("body").on("mousemove", mousemove)
		$("body").on("mouseup", removeEvent)
	});
	function mousemove(e){
		$ele.parent().css({
			left:e.pageX-diffX,
			top:e.pageY-diffY
		});
	}
	function removeEvent(){
		$("body").off("mousemove", mousemove)
		$("body").off("mouseup", removeEvent)
	}
}
//使元素本身可拖拽移动
//@$ele为jq元素对象
function setEleSelfMove($ele){
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
		$("body").off("mousemove", mousemove)
		$("body").off("mouseup", removeEvent)
	}
}
//使元素居中 元素及其父窗口必须为绝对定位或固定定位
function setEleMiddle($ele){
	var e_w=$ele.width();
	var e_h=$ele.height();
	var p_w=$ele.parent().width();
	var p_h=$ele.parent().height();
	var e_left=(p_w-e_w)/2;
	var e_top=(p_h-e_h)/2;
	if(e_top<0){e_top=0;}
	$ele.css({
		left:e_left,
		top:e_top
	})
}
//开关按钮点击事件
function turnBtnEvent(callback){
	$('.modTurnBg .changeBtn').off('click').on('click',function(){
		var turn=$(this).parent();
		if(turn.hasClass('tOn')){
			turn.removeClass('tOn');
			turn.addClass('tOff');
			callback(turn,'off');
		}else{
			turn.removeClass('tOff');
			turn.addClass('tOn');
			callback(turn,'on');
		}
	})
}
//设置自制复选框状态
//@$ele 元素的jq对象
//@state 复选框状态 0空 1部分选中 2全选
function setModCheckState($ele,state){
	for(var i=0;i<3;i++){
		$ele.removeClass('modCheckbox'+i);
	}
	$ele.addClass('modCheckbox'+state)
}
//获取自制复选框状态
//@$ele 元素的jq对象
//返回值 0空 1部分选中 2全选
function getModCheckState($ele){
	var state=0;
	if($ele.hasClass('modCheckbox1')){
		state=1;
	}
	if($ele.hasClass('modCheckbox2')){
		state=2;
	}
	return state;
}
var guest_label_color=['#f00','#0f0','#00f','#444','#a64da6','#c0c0c0','#0ff','#ffb7ff','#ff0'];
//初始化用户颜色标签控件
//@ele 颜色标签控件的jq对象
//@colorArray 9个颜色值字符串组成的数组
//@startColor 初始颜色
function initGuestLabel(ele,colorArray,startColor){
	ele.css("background-color",startColor);
	var lis=ele.find('li');
	for(var i=0;i<lis.length;i++){
		lis.eq(i).css("background-color",colorArray[i]);
	}
	guestLabelEvents(ele);//用户标签控件的事件
}
//用户标签控件的事件
//@ele 用户颜色标签控件的jq对象
function guestLabelEvents(ele){
	$(ele).unbind()
	var labelList=ele.find('.guestLabelList');
	var lis=labelList.find('li');
	//颜色列表隐藏/显示
	ele.click(function(){
		if(labelList.css('display')=='none'){
			labelList.show();
		}else{
			labelList.hide();
		}
	})
	ele.hover(function(){
	},function(){
		labelList.hide();
	})
	//颜色列表点击
	lis.click(function(){
		var color=$(this).css("background-color");
		if(ele.children('span')){
			ele.children('span').html('');
		}
		ele.css("background-color",color);
	})
}
/**
 * Fun:分页设置
 * @$ele:分页控件父元素的jq对象
 * @maxPage:总页数
 * @callback:回调函数
 */
function setCommonPageEvent($ele,maxPage,callback){
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
    $ele.html(thisPageHtml);
	
    if(maxPage == 1){
        $ele.find('.common_page_down').addClass('disabled');
		$ele.find('.common_page_last').addClass('disabled');
    }
	if(maxPage >3){
		$ele.find('.common_page_RPoint').show();
	}
	if(maxPage <= 0){
        $ele.find('.common_pageBK').hide();
    }
    //页面加载 end

    //点击事件
    $ele.find('.common_page_number').click(function(){
        if(!$(this).hasClass('common_page_number_sel')){
			var changePage = parseInt($(this).html());
			callback(changePage);
            commonPageChange($ele,changePage,maxPage);
        }
    });
	$ele.find('.common_page_first').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = 1;
			callback(changePage);
            commonPageChange($ele,changePage,maxPage);
        }
    });
    $ele.find('.common_page_up').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = parseInt($ele.find('.common_page_number_sel').html())-1;
			callback(changePage);
            commonPageChange($ele,changePage,maxPage);
        }
    });
    $ele.find('.common_page_down').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = parseInt($ele.find('.common_page_number_sel').html())+1;
			callback(changePage);
            commonPageChange($ele,changePage,maxPage);
        }
    });
	$ele.find('.common_page_last').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = maxPage;
			callback(changePage);
            commonPageChange($ele,changePage,maxPage);
        }
    });
    $ele.find('.common_page_go').click(function(){
        var changePage = parseInt($ele.find('.common_page_input_number').val());
		if(changePage>0&&changePage<=maxPage){
			callback(changePage);
        	commonPageChange($ele,changePage,maxPage);
		}
    });
    //点击事件 end
}
/**
 * Fun:执行翻页
 * @$ele:翻页控件父元素的jq对象
 * @pageNo:页数
 * @maxPage:总页数
 */
function commonPageChange($ele,pageNo, maxPage){
    if(maxPage ==1||pageNo<1||pageNo>maxPage){
        return;
    }
	var pageLPoint=$ele.find('.common_page_LPoint');
    var pageRPoint=$ele.find('.common_page_RPoint');
	pageLPoint.hide();
	pageRPoint.hide();
	if(pageNo-1>1){
		pageLPoint.show();
	}
	if(pageNo+1<maxPage){
		pageRPoint.show();
	}
	
	
	var pageFirst=$ele.find('.common_page_first');
    var pageUp=$ele.find('.common_page_up');
    var pageDown=$ele.find('.common_page_down');
	var pageLast=$ele.find('.common_page_last');
    var pageNum=$ele.find('.common_page_number');
		
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

/**
 * Fun:分页设置2
 * @$ele:分页控件父元素的jq对象
 * @maxPage:总页数
 * @callback:回调函数
 */
function setCommonPage2Event($ele,maxPage,callback){
	console.log(maxPage)
	
    var tempPage=3;
    if(maxPage<3){
        tempPage=maxPage;
    }
    //页面加载
    var thisPageHtml = '';
    thisPageHtml +='<div class="common_page2BK">';
	thisPageHtml +='<div class="common_page2_first disabled"></div>';
    thisPageHtml +='<div class="common_page2_up disabled"></div>';
	thisPageHtml +='<div class="common_page2_LPoint">…</div>';
    for(var i = 1;i<=tempPage;i++){
        if(i == 1){
            thisPageHtml +='<div class="common_page2_number common_page2_number_sel">'+i+'</div>';
        }else{
            thisPageHtml +='<div class="common_page2_number">'+i+'</div>';
        }
    }
	thisPageHtml +='<div class="common_page2_RPoint">…</div>';
    thisPageHtml +='<div class="common_page2_down"></div>';
	thisPageHtml +='<div class="common_page2_last"></div>';
    $ele.html(thisPageHtml);
	
    if(maxPage == 1){
        $ele.find('.common_page2_down').addClass('disabled');
		$ele.find('.common_page2_last').addClass('disabled');
    }
	if(maxPage >3){
		$ele.find('.common_page2_RPoint').show();
	}
	if(maxPage <= 0){
        $ele.find('.common_page2BK').hide();
    }
    //页面加载 end

    //点击事件
    $ele.find('.common_page2_number').click(function(){
        if(!$(this).hasClass('common_page2_number_sel')){
			var changePage = parseInt($(this).html());
			callback(changePage);
            commonPage2Change($ele,changePage,maxPage);
        }
    });
	$ele.find('.common_page2_first').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = 1;
			callback(changePage);
            commonPage2Change($ele,changePage,maxPage);
        }
    });
    $ele.find('.common_page2_up').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = parseInt($ele.find('.common_page2_number_sel').html())-1;
			callback(changePage);
            commonPage2Change($ele,changePage,maxPage);
        }
    });
    $ele.find('.common_page2_down').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = parseInt($ele.find('.common_page2_number_sel').html())+1;
			callback(changePage);
            commonPage2Change($ele,changePage,maxPage);
        }
    });
	$ele.find('.common_page2_last').click(function(){
        if(!$(this).hasClass('disabled')){
			var changePage = maxPage;
			callback(changePage);
            commonPage2Change($ele,changePage,maxPage);
        }
    });
    //点击事件 end
}
/**
 * Fun:执行翻页2
 * @$ele:翻页控件父元素的jq对象
 * @pageNo:页数
 * @maxPage:总页数
 */
function commonPage2Change($ele,pageNo, maxPage){
    if(maxPage ==1||pageNo<1||pageNo>maxPage){
        return;
    }
	var pageLPoint=$ele.find('.common_page2_LPoint');
    var pageRPoint=$ele.find('.common_page2_RPoint');
	pageLPoint.hide();
	pageRPoint.hide();
	if(pageNo-1>1){
		pageLPoint.show();
	}
	if(pageNo+1<maxPage){
		pageRPoint.show();
	}
	
	
	var pageFirst=$ele.find('.common_page2_first');
    var pageUp=$ele.find('.common_page2_up');
    var pageDown=$ele.find('.common_page2_down');
	var pageLast=$ele.find('.common_page2_last');
    var pageNum=$ele.find('.common_page2_number');
		
    if(pageNo==1){
        pageFirst.addClass('disabled');
		pageUp.addClass('disabled');
        pageDown.removeClass('disabled');
		pageLast.removeClass('disabled');
        pageNum.removeClass('common_page2_number_sel');
        pageNum.eq(0).addClass('common_page2_number_sel');
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
        pageNum.removeClass('common_page2_number_sel');
        pageNum.eq(pageNum.length-1).addClass('common_page2_number_sel');
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
        pageNum.removeClass('common_page2_number_sel');
        pageNum.eq(1).addClass('common_page2_number_sel');
        pageNum.eq(0).html(pageNo-1);
        pageNum.eq(1).html(pageNo);
        pageNum.eq(2).html(parseInt(pageNo)+1);
    }
}

//获取邮件模板HTML
//@index 0无1航运主题2特价主题3业务主题4运价主题
function getMailModHtml(index){
	var modHtml=['',
'<div style="width:100%;height:100%;background:#efeed9;position:relative;clear:both;overflow:auto;">'+
	'<div style="width:820px;height:570px;background:url(c_images/mail/mailMod1_bg.png);font-family:Microsoft YaHei;margin:0 auto;">'+
    	'<div style="padding-top:158px;width:100%;height:142px;clear:both;">'+
        	'<div style="width:174px;height:96px;text-align:right;color:#557dce;font-size:18px;line-height:32px;float:left;">公司介绍：</div>'+
            '<div style="padding:3px;width:473px;height:84px;border:3px #fff solid;border-radius:4px;color:#557dce;font-size:14px;text-indent:28px;line-height:16px;overflow:hidden;float:left;">'+
            '公司介绍的内容'+
            '</div>'+
        '</div>'+
        '<div style="width:100%;height:132px;clear:both;">'+
        	'<div style="width:174px;height:96px;text-align:right;color:#557dce;font-size:18px;line-height:32px;float:left;">业务介绍：</div>'+
            '<div style="padding:3px;width:473px;height:84px;border:3px #fff solid;border-radius:4px;color:#557dce;font-size:14px;text-indent:28px;line-height:16px;overflow:hidden;float:left;">'+
            '业务介绍的内容'+
            '</div>'+
        '</div>'+
        '<div style="padding-left:35px;width:746px;height:108px;">'+
        	'<div style="padding:34px 0 0 62px;width:310px;height:74px;color:#fff;font-size:18px;line-height:22px;float:left;">'+
            	'深圳市南山区科技园北乌石头路<br/>天明科技大厦1202'+
            '</div>'+
            '<div style="padding:34px 0 0 62px;width:310px;height:74px;color:#fff;font-size:18px;line-height:22px;float:left;">'+
            	'15149864598<br/>www.zhaochuan.cn'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>',
'<div style="width:100%;height:100%;background:#fff;position:relative;clear:both;overflow:auto;">'+
	'<div style="width:820px;height:563px;background:url(c_images/mail/mailMod2_bg.png);font-family:Microsoft YaHei;margin:0 auto;">'+
    	'<div style="padding:244px 0 0 101px;width:618px;height:240px;color:#353535;font-size:14px;line-height:24px;overflow:hidden;">'+
        	'特价主题的内容。'+
        '</div>'+
    '</div>'+
'</div>',
'<div style="width:100%;height:100%;background:#000;position:relative;clear:both;overflow:auto;">'+
	'<div style="width:820px;height:500px;background:url(c_images/mail/mailMod3_bg.png);font-family:Microsoft YaHei;margin:0 auto;">'+
    	'<div style="width:266px;height:500px;color:#877f74;float:left;">'+
        	'<div style="width:100%;height:110px;line-height:110px;font-size:30px;text-align:center;float:left;">新业务推荐</div>'+
            '<div style="margin-left:50px;width:190px;height:380px;font-size:13px;line-height:31px;overflow:hidden;float:left;">'+
				'业务推荐的内容。'+
            '</div>'+
        '</div>'+
        '<div style="margin:400px 0 0 13px;width:540px;height:98px;color:#b15a4d;font-size:16px; font-weight:bold;line-height:25px;float:left;">'+
        	'电话：0757-4780000<br/>'+
            '网址：www.zhaochuan.cn<br/>'+
            '地址：深圳市南山区科技园北乌石头路天明科技大厦1202'+
        '</div>'+
    '</div>'+
'</div>',
'<div style="width:100%;height:100%;background:#fff;position:relative;clear:both;overflow:auto;">'+
	'<div style="width:820px;height:500px;background:url(c_images/mail/mailMod4_bg.png);font-family:Microsoft YaHei;margin:0 auto;">'+
    	'<div style="height:91px;color:#fff;font-size:14px;clear:both;">'+
        	'<div style="padding:0 22px;height:42px;line-height:42px;float:right;">报价时间：2016.06.07</div>'+
            '<div style="padding:0 22px;height:42px;line-height:42px;float:right;">有效期：2016.06.07-2016.06.25</div>'+
        '</div>'+
        '<div style="margin-left:44px;width:731px;height:345px;color:#fff;font-size:14px;float:left;">'+
        	'<div style="padding:2px 0 0 40px;height:36px;line-height:36px;clear:both;">'+
            	'<div style="height:36px;min-width:120px;float:left;">船期：</div>'+
                '<div style="height:36px;min-width:120px;float:left;">航程：</div>'+
            '</div>'+
            '<div style="margin-left:40px;width:647px;border:1px #fff solid;text-align:center;line-height:38px;float:left;">'+
                '<div style="border-bottom:1px #fff solid;width:100%;height:38px;float:left;">'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">起始港</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">目的港</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">中转港</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #fff solid;float:left;">20GP</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #fff solid;float:left;">40GP</div>'+
                    '<div style="width:95px;height:38px;float:left;">40HQ</div>'+
                '</div>'+
                '<div style="border-bottom:1px #fff solid;width:100%;height:38px;float:left;">'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">起始港名</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">目的港名</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">中转港名</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #fff solid;float:left;">123</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #fff solid;float:left;">123</div>'+
                    '<div style="width:95px;height:38px;float:left;">123</div>'+
                '</div>'+
                '<div style="width:100%;height:38px;float:left;">'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">起始港名</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">目的港名</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">中转港名</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #fff solid;float:left;">123</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #fff solid;float:left;">123</div>'+
                    '<div style="width:95px;height:38px;float:left;">123</div>'+
                '</div>'+
            '</div>'+
            '<div style="padding:17px 0 0 40px;height:36px;line-height:36px;clear:both;">'+
            	'<div style="height:36px;min-width:120px;float:left;">常用本地费</div>'+
            '</div>'+
            '<div style="margin-left:40px;width:460px;border:1px #fff solid;text-align:center;line-height:38px;float:left;">'+
                '<div style="border-bottom:1px #fff solid;width:100%;height:38px;float:left;">'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">费用类型</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">收费类型</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">价格</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">货币单位</div>'+
                    '<div style="width:91px;height:38px;float:left;">说明</div>'+
                '</div>'+
                '<div style="border-bottom:1px #fff solid;width:100%;height:38px;float:left;">'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">费用类型名</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">收费类型名</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">123</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">货币单位名</div>'+
                    '<div style="width:91px;height:38px;float:left;">说明内容</div>'+
                '</div>'+
                '<div style="width:100%;height:38px;float:left;">'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">费用类型名</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">收费类型名</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">123</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">货币单位名</div>'+
                    '<div style="width:91px;height:38px;float:left;">说明内容</div>'+
                '</div>'+
            '</div>'+
        '</div>'+
        '<div style="margin:10px 0 0 44px;width:731px;height:54px;color:#fff;font-size:14px;line-height:20px;float:left;">'+
        	'网址：www.zhaochuan.cn&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;电话：0757-4000000<br/>'+
            '地址：深圳市南山科技园乌石头路8号天明科技大厦1202'+
        '</div>'+
    '</div>'+
'</div>',
'<div style="width:100%;height:100%;background:#efeed9;position:relative;clear:both;overflow:auto;">'+
	'<div style="width:820px;height:550px;background:url(c_images/mail/mailMod5_bg.png) no-repeat top center;background-color:#53b8fc;font-family:Microsoft YaHei;margin:0 auto;">'+
    	'<div style="margin:180px 0 0 76px;width:668px;height:290px;background:#fff;border-radius:8px;float:left;">'+
        	'<div style="width:333px;height:290px;float:left;">'+
                '<div style="width:100%;height:88px;text-align:center;color:#53b8fc;font-size:16px;line-height:60px;float:left;">公司介绍：</div>'+
                '<div style="margin:0 15px;width:304px;height:200px;color:#53b8fc;font-size:14px;line-height:20px;overflow:hidden;text-align:center;float:left;">'+
                '公司介绍的内容公司介绍的内容公司介绍的内容公司介绍的内容公司介绍的内容'+
                '</div>'+
            '</div>'+
            '<div style="width:333px;height:290px;float:left;">'+
                '<div style="width:100%;height:88px;text-align:center;color:#53b8fc;font-size:16px;line-height:60px;float:left;">业务介绍：</div>'+
                '<div style="margin:0 15px;width:302px;height:200px;color:#53b8fc;font-size:14px;line-height:20px;overflow:hidden;text-align:center;float:left;">'+
                '业务介绍的内容'+
                '</div>'+
            '</div>'+
        '</div>'+
        '<div style="margin:17px 0 0 76px;width:668px;height:59px;font-family:KaiTi;float:left;">'+
        	'<div style="padding:0 0 0 13px;width:320px;height:58px;color:#fff;font-size:16px;line-height:22px;float:left;">'+
            	'电话：0757-123456789<br/>网址：www.xxx.com'+
            '</div>'+
            '<div style="padding:0 0 0 13px;width:320px;height:58px;color:#fff;font-size:16px;line-height:22px;float:left;">'+
            	'地址：深圳市南山区地址名地址名<br/>地址名地址名地址名'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>',
'<div style="width:100%;height:100%;background:#fff;position:relative;clear:both;overflow:auto;">'+
	'<div style="width:820px;height:500px;background:url(c_images/mail/mailMod6_bg.png);font-family:Microsoft YaHei;margin:0 auto;">'+
    	'<div style="padding:162px 0 0 100px;width:620px;height:300px;color:#5d320d;font-size:14px;line-height:28px;text-indent:28px;overflow:hidden;">'+
        	'特价主题的内容特价容特价主题的内容特价主题的内容特价主题的内容。'+
        '</div>'+
    '</div>'+
'</div>',
'<div style="width:100%;height:100%;background:#fff;position:relative;clear:both;overflow:auto;">'+
	'<div style="width:820px;height:500px;background:url(c_images/mail/mailMod7_bg.png);font-family:Microsoft YaHei;margin:0 auto;">'+
        '<div style="margin:200px 0 0 66px;width:680px;height:144px;color:#2f0e05;font-size:14px;line-height:28px;text-indent:28px;overflow:hidden;float:left;">'+
            '业务推荐的内容业务推荐的内容业务推荐的内容业务推荐的内容业务推荐的内容业务推荐的内容业务推荐的内容业务推荐的内容业务推荐的内容。'+
        '</div>'+
        '<div style="margin:0 0 0 66px;width:680px;height:90px;color:#2f0e05;font-size:14px;font-weight:bold;line-height:30px;float:left;">'+
        	'<div style="margin:0 25px 0 5px;width:275px;height:90px;float:left;">'+
            	'电话：0757-123456789<br/>'+
            	'网址：www.xxxx.cn'+
            '</div>'+
            '<div style="width:275px;height:90px;float:left;">'+
            	'地址：地址名地址名地址名地址名地址名地址名地址名地址名地址名'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>',
'<div style="width:100%;height:100%;background:#615756;position:relative;clear:both;overflow:auto;">'+
	'<div style="width:820px;height:500px;background:url(c_images/mail/mailMod8_bg.png);font-family:Microsoft YaHei;margin:0 auto;">'+
    	'<div style="padding:32px 0 0 266px;height:36px;color:#7fa2ed;font-size:15px;clear:both;">'+
        	'<div style="padding:0 22px;height:42px;line-height:42px;float:left;">报价时间：2016.06.07</div>'+
            '<div style="padding:0 22px;height:42px;line-height:42px;float:left;">有效期：2016.06.07-2016.06.25</div>'+
        '</div>'+
        '<div style="margin:0 0 0 44px;width:702px;height:345px;font-size:14px;float:left;">'+
        	'<div style="padding:2px 0 0 40px;height:36px;line-height:36px;color:#7fa2ed;clear:both;">'+
            	'<div style="height:36px;min-width:120px;float:left;">船期：</div>'+
                '<div style="height:36px;min-width:120px;float:left;">航程：</div>'+
            '</div>'+
            '<div style="margin-left:40px;width:647px;background:#fff;color:#7fa2ed;text-align:center;line-height:38px;float:left;">'+
                '<div style="width:100%;height:38px;color:#fff;background:#7ea2ec;background:-webkit-linear-gradient(left, #a57cda , #7ea2ec);background: -o-linear-gradient(right, #a57cda, #7ea2ec);background:-moz-linear-gradient(right, #a57cda, #7ea2ec);background: linear-gradient(to right, #a57cda , #7ea2ec);float:left;">'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">起始港</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">目的港</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #fff solid;float:left;">中转港</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #fff solid;float:left;">20GP</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #fff solid;float:left;">40GP</div>'+
                    '<div style="width:95px;height:38px;float:left;">40HQ</div>'+
                '</div>'+
                '<div style="border-bottom:1px #bbb solid;width:100%;height:38px;float:left;">'+
                    '<div style="width:118px;height:38px;border-right:1px #bbb solid;float:left;">起始港名</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #bbb solid;float:left;">目的港名</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #bbb solid;float:left;">中转港名</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #bbb solid;float:left;">123</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #bbb solid;float:left;">123</div>'+
                    '<div style="width:95px;height:38px;float:left;">123</div>'+
                '</div>'+
                '<div style="width:100%;height:38px;float:left;">'+
                    '<div style="width:118px;height:38px;border-right:1px #bbb solid;float:left;">起始港名</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #bbb solid;float:left;">目的港名</div>'+
                    '<div style="width:118px;height:38px;border-right:1px #bbb solid;float:left;">中转港名</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #bbb solid;float:left;">123</div>'+
                    '<div style="width:95px;height:38px;border-right:1px #bbb solid;float:left;">123</div>'+
                    '<div style="width:95px;height:38px;float:left;">123</div>'+
                '</div>'+
            '</div>'+
            '<div style="padding:17px 0 0 40px;height:36px;line-height:36px;clear:both;">'+
            	'<div style="height:36px;min-width:120px;color:#7fa2ed;float:left;">常用本地费</div>'+
            '</div>'+
            '<div style="margin-left:40px;width:460px;background:#fff;color:#7fa2ed;text-align:center;line-height:38px;float:left;">'+
                '<div style="width:100%;height:38px;color:#fff;background:#7ea2ec;background:-webkit-linear-gradient(left, #a57cda , #7ea2ec);background: -o-linear-gradient(right, #a57cda, #7ea2ec);background:-moz-linear-gradient(right, #a57cda, #7ea2ec);background: linear-gradient(to right, #a57cda , #7ea2ec);float:left;">'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">费用类型</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">收费类型</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">价格</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #fff solid;float:left;">货币单位</div>'+
                    '<div style="width:91px;height:38px;float:left;">说明</div>'+
                '</div>'+
                '<div style="border-bottom:1px #bbb solid;width:100%;height:38px;float:left;">'+
                    '<div style="width:91px;height:38px;border-right:1px #bbb solid;float:left;">费用类型名</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #bbb solid;float:left;">收费类型名</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #bbb solid;float:left;">123</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #bbb solid;float:left;">货币单位名</div>'+
                    '<div style="width:91px;height:38px;float:left;">说明内容</div>'+
                '</div>'+
                '<div style="width:100%;height:38px;float:left;">'+
                    '<div style="width:91px;height:38px;border-right:1px #bbb solid;float:left;">费用类型名</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #bbb solid;float:left;">收费类型名</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #bbb solid;float:left;">123</div>'+
                    '<div style="width:91px;height:38px;border-right:1px #bbb solid;float:left;">货币单位名</div>'+
                    '<div style="width:91px;height:38px;float:left;">说明内容</div>'+
                '</div>'+
            '</div>'+
        '</div>'+
        '<div style="margin:0 0 0 84px;width:680px;height:50px;color:#000;font-size:14px;line-height:24px;float:left;">'+
        	'<div style="width:264px;height:50px;float:left;">'+
            	'电话：0757-123456789<br/>'+
            	'网址：www.xxxx.cn'+
            '</div>'+
            '<div style="width:264px;height:50px;float:left;">'+
            	'地址：地址名地址名地址名地址名地址名地址名地址名地址名地址名'+
            '</div>'+
        '</div>'+
    '</div>'+
'</div>'
	]
	return modHtml[index];
}

var ossDomain = '';
$(function(){
	$.ajax(
		{
		url:'/article/ossDomains',
		type:"post",
		success:function(rs)
		{
			ossDomain='http://'+rs.ossDomain;
		},
		error:function(rs){
			console.log("oss 地址获取失败")
		}
	})
})