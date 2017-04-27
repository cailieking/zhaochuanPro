<!DOCTYPE html>
<html>
<head>
<title>搜索排行</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/search_bang.css" />
<asset:javascript src="c_js/common.js" />
</head>
<body>
	<input type="hidden" value="${data[0].type}" id="selType"/>
	<input type="hidden" value="${weeks}" id="weeksNum"/>
    <div class="manage_md_right">
        <!--右侧主体-->
            <div class="rControlLine">
            	<span class="label0">查询条件:</span>
            </div>
            <div class="rControlLine" style="position:relative;">
            	<span class="label1">查询项目:</span>
            	<select class="select1" id="type">
            		<option value="startPort">起始港</option>
            		<option value="endPort">目的港</option>
            		<option value="shipCompany">船公司</option>
            	</select>
            	<span class="label1">时间段:</span>
            	<select class="select1" id="weeks">
            		<option value="4">最后4周</option>
            		<option value="12">最后12周</option>
            		<option value="24">最后24周</option>
            		<option value="all">所有周数</option>
            	</select>
            	<div class="btnL btnMod1" id="weekRankSearch">查询</div>
            	<div class="search_bang_tishi1 modTishiBg">
                    <div class="modTishiTxt">周排名按照周一至周日，共计七天的自然周进行统计；</div>
                    <div class="modTishiTxt">查询项目中选择起始港、目的港或者船公司；</div>
                    <div class="modTishiTxt">根据时间段的选择，查询相应数据。</div>
                </div>
            </div>
            <div class="rControlLine">
            	<span class="txt1">最后${weeks}周排名：</span>
            </div>
              
            <ul class="search_bang_List">
            <g:each in="${data}" var="oneData">
            	<li>
                	<div class="bTime">${oneData.startTime}~${oneData.endTime}</div>
                	<div class="bTitle">
                		<div class="wIndex">排名</div>
                		<g:if test="${oneData.type=='startPort'}">
                		<div class="wName">起始港</div>
                		</g:if>
                		<g:if test="${oneData.type=='endPort'}">
                		<div class="wName">目的港</div>
                		</g:if>
                		<g:if test="${oneData.type=='shipCompany'}">
                		<div class="wName">船公司</div>
                		</g:if>
                	</div>
                	<input type="hidden" class = "one_data" value="${oneData.rankData}" />
                	<ul class="search_bang dataDetail" >
                		
                	</ul>
                </li>
                </g:each>
            </ul>
            
            <div class="search_log_bottom"></div>
        <!--右侧主体-->
    </div>
<script>
$(function(){
	 $('#type').val($('#selType').val());
	 $('#weeks').val($('#weeksNum').val());

	 $('#weekRankSearch').click(function(){
			weekRankSearch();
		})


		//
	var lists=$('.dataDetail');
	for(var i=0;i<$('.dataDetail').length;i++){
		var oneData =$('.dataDetail').eq(i).prev('.one_data').val().split(',');
		 doBangHtml($('.dataDetail').eq(i),oneData);
	}
})

//搜索查询
function weekRankSearch(){
	var weekSel=$('#weeks').val();
	var typeSel=$('#type').val();
	console.log('week',weekSel);
	console.log('type',typeSel);
	window.location.href="/searchManage/doSearch?weeks="+weekSel+"&type="+typeSel;
	console.log("ok!")
}

function doBangHtml(ele,ary){
	var bangHtml="";
	for(var i=0;i<ary.length;i++){
		var index=i+1;
		if(ary[i].length>1){
			bangHtml+='<li><div class="wIndex">'+index+'</div><div class="wName">'+ary[i]+'</div></li>';
		}
	}
	ele.html(bangHtml);
}


</script>
</body>
</html>
