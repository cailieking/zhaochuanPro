$(function(){
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(-2);//添加找船网公用顶部UI
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
	newsListEvents();//各控件的事件关联
	//读取新闻列表数据
	var newsType=sessionStorage.getItem("newsListType");
	if(newsType==null){
		newsType='ftlist';
	}
	loadNewsListData(newsType,1,function(index,data){
		doNewsList(0,index,data);//组装新闻列表Html
	});
})
//各控件的事件关联
function newsListEvents(){
	$('.child2_tabs li').click(function(){
		var lis=$('.child2_tabs li');
		var index=lis.index($(this));
		lis.removeClass('sel');
		$(this).addClass('sel');
		var typeAry=['ftlist','tplist','comlist'];
		sessionStorage.setItem("newsListType",typeAry[index]);
		loadNewsListData(typeAry[index],1,function(index,data){
			doNewsList(0,index,data);//组装新闻列表Html
		})
	});
	$('.child2_loadMore').click(function(){
		if($(this).html()!='新闻读取完毕'){
			var hasNum=$('.child2_newsList li').length;
			var hasPage=parseInt(hasNum/newsPageSize);
			var nextPage=hasPage+1;
			doNewsList(1,nextPage,localNewsData);//组装新闻列表Html
		}
	})
}
//读取新闻列表数据
var localNewsData;
var newsPageSize=8;
function loadNewsListData(newsType,pageIndex,callback){
	$('.newsLoading').show();
	var type='';
	var lastType=sessionStorage.getItem("newsListType");
	if(lastType!=null){
		type=lastType;
		var index=0;
		if(type=='ftlist'){index=0;}
		if(type=='tplist'){index=1;}
		if(type=='comlist'){index=2;}
		$('.child2_tabs li').removeClass('sel');
		$('.child2_tabs li').eq(index).addClass('sel');
		//sessionStorage.removeItem("newsListType");
	}else{
		type=newsType;
	}
	var queryNews={type:type,curPage:pageIndex};
	console.log('新闻读取条件',queryNews);
	$.ajax({
		url:'/news/articleList1',
		dataType:'json',
		type:"get",
		data:queryNews,
		success:function(rs){
			if(rs.total>0){
				console.log('读取新闻数据',rs);
				$('.newsLoading').hide();
				localNewsData=rs.list;
				callback(pageIndex,rs.list);
			}else{
				localNewsData=null;
				$('.child2_newsList').html('没有新闻');
				$('.newsLoading').hide();
			}
		},
		error:function(rs){
			localNewsData=null;
			console.log('新闻数据读取失败',rs);
			$('.newsLoading').hide();
		}
	});
}
/*组装新闻列表Html 
@type 0刷新 1添加 
@index页序 
@data新闻数据
**/
function doNewsList(type,index,data){
	var isLoadEnd=false;
	//截取、处理数据
	var pageSize=9;
	var length=data.length;
	var start=(index-1)*pageSize;
	var end=start+pageSize;
	if(start>length){return;}
	if(end>=length){end=length;isLoadEnd=true;}
	var tempData=[];
	for(var i=start;i<end;i++){
		data[i].content=removeHTMLTag(data[i].content);//清除内容的标签 common.js中定义
		data[i].content=data[i].content.slice(0,50);
		tempData.push(data[i]);
	}
	//截取、处理数据 end
	//组合Html字符
	var doHtml="";
	for(var i=0;i<tempData.length;i++){
		doHtml+='<li attr-id="'+tempData[i].id+'"><input type="hidden" value="'+tempData[i].newsUrl+'">'
		+'<img class="image" src="'+ossDomain+tempData[i].image+'" /><div class="right">'
		if(tempData[i].category != null){
			doHtml+='<div class="name"><div class="bit top right" data-position="top right" style="text-align:center;line-height: 30px" ><p style="text-align:center;color: #fff">要闻</span></div><span style="color:#d9534f">'+tempData[i].title+'</p></div><div class="from">'
		}else{
			doHtml+='<div class="name">'+tempData[i].title+'</div><div class="from">'
		}
		doHtml+='<div class="link">'+tempData[i].comes+'</div>'
		doHtml+='<div class="time">'+tempData[i].dateCreatedStr+'</div></div>'
		doHtml+='<div class="msg">'+tempData[i].content+'...</div></div></li>';
	}
	//组合Html字符 end
	switch(type){
		case 0:{//刷新
			$('.child2_newsList').html(doHtml);
			if(isLoadEnd){
				$('.child2_loadMore').html('新闻读取完毕');
			}else{
				$('.child2_loadMore').html('加载更多');
			}
		}
		break;
		case 1:{//添加
			$('.child2_newsList').append($(doHtml));
			if(isLoadEnd){
				$('.child2_loadMore').html('新闻读取完毕');
			}
		}
	}
	//新闻的点击事件
	$('.child2_newsList li').unbind('click').click(function(){
		var newsId=$(this).attr('attr-id');
		sessionStorage.setItem("zcCurNewsId",newsId);
		var newsHtml = $(this).find("input[type=hidden]").val()
		if(newsHtml != "null" && newsHtml != null && newsHtml != ""){
			window.open(newsHtml);
		}else{
			window.open("newsDetails.html")
		}
		
	})
}