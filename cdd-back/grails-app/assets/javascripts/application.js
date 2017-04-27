// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better 
// to create separate JavaScript files as needed.
//
//= require jquery
//= require jquery-ui
//= require bootstrap
//= require bootstrap-select
//= require select2.full
//= require bootstrap-dialog
//= require_self
$(document).ready(function() {
	$(".datepicker").datepicker({
		yearRange: "-100:+20"
	});
	$(".numberTextbox").keydown(function(event) {
		if(!(event.which == 16 || event.which == 8 || event.which == 13
			|| event.which > 36 && event.which < 41 
			|| event.which > 47 && event.which < 58
			|| event.which > 95 && event.which < 106)) {
			return false;
		}
	});
	$('.selectpicker').selectpicker({
		size: 10
	});
	$('.selectautocomplete').select2();
	
	//左侧列表选中
	var leftNavIndex=sessionStorage.getItem('zcBackLeftNavIndex')?sessionStorage.getItem('zcBackLeftNavIndex'):'0,0';
	var leftNavIndexAry=leftNavIndex.split(',');
	$('.panel-body>ul').eq(leftNavIndexAry[0]).parents('.panel-collapse').addClass('in');
	$('.panel-body>ul').eq(leftNavIndexAry[0]).children('li').eq(leftNavIndexAry[1]).addClass('sel');
	$('.panel-body>ul').eq(leftNavIndexAry[0]).parents('.panel-collapse').prev().addClass('sel');
	$('li[name="menuchild"]>a').click(function(){
		var uls=$('.panel-body>ul');
		var thisUl=$(this).parents('ul');
		var lis=thisUl.children('li');
		var thisLi=$(this).parents('li')
		var ulIndex=uls.index(thisUl);
		var liIndex=lis.index(thisLi);
		sessionStorage.setItem('zcBackLeftNavIndex',ulIndex+','+liIndex);
		console.log(sessionStorage.getItem('zcBackLeftNavIndex'));
	})
	$('.panel-heading>a').click(function(){
		$('.aside-md').removeClass('aside-md-short');
		$('.zc-navbar-left').removeClass('zc-navbar-left-short');
	})
	//左侧列表选中 end
	//左侧菜单宽度变化
	$('.zc-navbar-hideBtn').click(function(){
		if($('.aside-md').hasClass('aside-md-short')){
			$('.aside-md').removeClass('aside-md-short');
			$('.zc-navbar-left').removeClass('zc-navbar-left-short');
		}else{
			$('.aside-md').addClass('aside-md-short');
			$('.zc-navbar-left').addClass('zc-navbar-left-short');
			$('.panel-collapse').removeClass('in'); 
		}
	})
	//左侧菜单宽度变化end
});

function finishUpload() {
	currentDialog.close();
	$(".datatable-search-btn").click();
}