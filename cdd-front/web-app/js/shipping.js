$(function(){
	search_more_click();//更多搜索条件点击事件
	shippingCheckboxEvents();//复选框事件关联
})

//更多搜索条件点击事件
function search_more_click(){
	$('.filterBg .more').click(function(){
		if($(this).hasClass('ar_down')){//按钮箭头为下
			$('.filterList li').eq(2).show();
			$('.filterList li').eq(3).show();
			$(this).removeClass('ar_down');
			$(this).addClass('ar_up');
		}else{
			$('.filterList li').eq(2).hide();
			$('.filterList li').eq(3).hide();
			$(this).removeClass('ar_up');
			$(this).addClass('ar_down');
		}
	});
}
//复选框事件关联
function shippingCheckboxEvents(){
	var topCheck=$('#shippingAllCheck');//顶部全选
	var btmCheck=$('#shippingAllCheck_b');//底部全选
	var tableChecks=$('.issueBg input[type="checkbox"]');//表格内的复选框
	var issueChecks=$('.issueTitle input[type="checkbox"]');//发布列的复选框
	//顶部全选点击
	topCheck.off('click').on('click',function(){
		tableChecks.prop('checked',$(this).prop('checked'));
		btmCheck.prop('checked',$(this).prop('checked'));
	})
	//底部全选点击
	btmCheck.off('click').on('click',function(){
		tableChecks.prop('checked',$(this).prop('checked'));
		topCheck.prop('checked',$(this).prop('checked'));
	})
	//表格内复选框点击
	tableChecks.click(function(){
		isAllChecked();//检测是否所有选项选中
	})
	//发布列复选框点击
	issueChecks.click(function(){
		var issueChecked=$(this).prop('checked');
		var pirceChecks=$(this).parents('.issueBg').find('.pirceTitle input[type="checkbox"]');
		pirceChecks.each(function(index, element) {
            $(this).prop('checked',issueChecked);
        });
		isAllChecked();//检测是否所有选项选中
	})
	//检测是否所有选项选中
	function isAllChecked(){
		var isAllCheck=true;
		tableChecks.each(function(index,element) {
			if($(this).prop('checked')==false){
				isAllCheck=false;
				return false;
			}
		});
		topCheck.prop('checked',isAllCheck);
		btmCheck.prop('checked',isAllCheck);
	}
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
