/*网站主功能模块*/
$(function(){

/*筛选热门地区展开和收起效果**/
$(".open_1").click(function(){
       $(this).hide();
       $(".close_1").show();
       $(".rmdq_fl").show();
       $(this).siblings('p').hide();
       $(".sx_type").eq(0).addClass('bottom_line');
})
        
$(".close_1").click(function(){
       $(this).hide();
       $(".open_1").show();
       $(".rmdq_fl").hide();
       $(this).siblings('p').show();
       $(".sx_type").eq(0).removeClass('bottom_line');
})
/*****筛选品种种类的效果*****/     
$(".content_theme").on('click','.open',function(){
       var w=0;
       $(this).hide().siblings('.close').show();
       $(this).siblings('p').find('a').each(function(i){
             w+=$(this).width()+25;
       })   
       var bei=Math.ceil(w/$(this).siblings('p').width());
       var h=$(this).siblings('p').height();  
       $(this).siblings('p').css({'height':bei*h});
       w=0;
            
})
$(".content_theme").on('click','.close',function(){
      $(this).hide().siblings('.open').show();
      $(this).siblings('p').css('height','31');
})

/**有效时间移入显示下拉列表**/
$(".yxsj .select").mouseover(function(){
		$(".select_list").show();
	}).mouseout(function(){
		$(".select_list").hide();
})	

    //点击全部提交表单
    $(".sxtj_qb").on("click",function()
    {
      $("#form_filter :input").val("");
      $("#form_filter").submit();
    });
    //点击地区和品种列表提交表单
    $(".sx_type").find(".f").on("click",function()
    {
      $("#"+$(this).data("key")).val($(this).data("val"));
      $("#price_from,#price_to,#time,#pagesize,#sort,#sortmode").val("");
      $("#form_filter").submit();
    });
    //点击筛选关闭标签提交表单
    $(".sxtj").find("em").on("click",function()
    {
      $("#"+$(this).data("key")).val("");
      $("#price_from,#price_to,#time,#pagesize,#sort,#sortmode").val("");
      $("#form_filter").submit();
    });

    //选择时间提交
    $(".yxsj").find("li").on("click",function()
    {
      $("#time").val($(this).data("val"));
      $("#form_filter").submit();
    });
    //选择每页显示数提交
    $(".page_limit").find("span").on("click",function()
    {
      $("#pagesize").val($(this).data("val"));
      $("#form_filter").submit();
    });

});