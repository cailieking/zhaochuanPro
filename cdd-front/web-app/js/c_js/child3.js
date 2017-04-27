$(function(){
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(-2);//添加找船网公用顶部UI
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
	//loadNewsData();//读取新闻数据
})
//读取新闻数据
function loadNewsData(){
	var newsId=parseInt(sessionStorage.getItem("zcCurNewsId"));
	var queryNews={id:newsId};
	$.ajax({
		url:'/article/data',
		dataType:'json',
		type:"get",
		data:queryNews,
		success:function(rs){
			doNewsHtml(rs);//组装新闻Html
		},
		error:function(rs){
			console.log('新闻数据读取失败',rs);
		}
	});
}
//组装新闻Html @data 新闻数据
function doNewsHtml(data){
	
	$('.child3_left .title').html(data.title);
	$('.child3_left .from>span').eq(0).children('span').html(data.comes);
	$('.child3_left .from>span').eq(1).children('span').html(data.issueDate.split('T')[0]);
	$('.child3_left .image').hide();
	//$('.child3_left .image').attr('src',ossDomain+data.image);
	//$("meta[http-equiv='content-type']").attr('content',"text/html;charset=utf-8");
	//imageError();//图片读取错误处理
	$('.child3_left .msgContent').html(data.content);
	
	if(data.pageTag != null ){
		var tags = data.pageTag.split(",")
		for(var i = 0;i<tags.length;i++){
			if(tags[i] != null && tags[i] != "" ){
				$(".tag_li").append('<li >'+
				'<a class="nofocus" href="javascript:;">'+tags[i].substring(2)+'</a>'+
				'</li>')
				}
			}
		}
	var view_keyWords = document.querySelector("meta[name=keywords]");
	view_keyWords.setAttribute('content', data.keyWords);
    
    var view_description = document.querySelector("meta[name=description]");
    view_description.setAttribute('content', data.description);
    
    $("title").html(data.headTitle); 
    
}
//图片读取错误处理
function imageError(){
	var image=$('.child3_left .image');
	for(var i=0;i<image.length;i++){
		image.eq(i).get(0).onerror=function(e){
			image.hide();
		}
	}
}