$(function(){
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(3);//添加找船网公用顶部UI
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
	loadSpecialData();//获取限时特价数据
})
//获取限时特价数据
function loadSpecialData(){
	$.ajax({
		url:'/index/dataInfoSix',
		type:"get",
		success:function(rs){
			console.log('特价数据读取成功',rs);
			var specialData=rs.map.data.cargoShip.list;
			doSpecialHtml(specialData);//组合限时特价页面
		},
		error:function(rs){
			console.log('特价数据读取失败',rs);
			$('.tbLoading').hide();
		}
	});
}
/**
 *func 组合限时特价页面
 *@data 限时特价数据
 */
function doSpecialHtml(data){
	var doHtml="";
	for(var i=0;i<data.length;i++){
		if(i==0||i==4){
			doHtml+='<li style="margin-left:0;">';
		}else{
			doHtml+='<li>';
		}
		doHtml+='<div class="topTime" data-etime="'+data[i].endDate+'"></div>'+
			'<div class="startPort">起：'+data[i].startPort+'</div>'+
			'<div class="endPort">目：'+data[i].endPort+'</div>'+
			'<div class="priceBg">'+
				'<div class="leftTxt">20GP</div>'+
				'<div class="rightTxt">$'+data[i].gp20+'</div>'+
			'</div>'+
			'<div class="priceBg">'+
				'<div class="leftTxt">40GP</div>'+
				'<div class="rightTxt">$'+data[i].gp40+'</div>'+
			'</div>'+
			'<div class="priceBg">'+
				'<div class="leftTxt">40HQ</div>'+
				'<div class="rightTxt">$'+data[i].hq40+'</div>'+
			'</div>'+
			'<div class="dateBg">'+
				'<div class="txt1">船期：'+data[i].shippingDay+'</div>'+
				'<div class="txt2">航程：'+data[i].shippingDays+'天</div>'+
				'<div class="txt3">有效期：'+data[i].startDate+'至'+data[i].endDate+'</div>'+
			'</div>'+
			/**/
			'<div class="sbtn"><a href="/publish/findship?verify=&infoId='+data[i].infoId+'&startPort='+data[i].startPort+'&endPort='+data[i].endPort+'&startPortCn=&endPortCn=" target="_blank">订&nbsp;&nbsp;&nbsp;&nbsp;舱</a></div>'+
		'</li>';
	}
	$('.bargain_List').html(doHtml);
	specialCountDown();//限时特价倒计时效果
}
//限时特价倒计时效果
function specialCountDown(){
	var timeDivs=$('.bargain_List .topTime');
	window.setInterval(getCountDown,1000);
	function getCountDown(){
		var now=new Date();
		var startTime=TimeUtil.getSpecTimeByTimeStamp(now.getFullYear(),now.getMonth()+1,now.getDate(),now.getHours(),now.getMinutes(),now.getSeconds(),0);
		for(var i=0;i<timeDivs.length;i++){
			var endTimeAry=timeDivs.eq(i).attr('data-etime').split('-');
			var endTime=TimeUtil.getSpecTimeByTimeStamp(endTimeAry[0],endTimeAry[1],endTimeAry[2],0,0,0,0);
			var difTime=TimeUtil.getTimeSpan(startTime,endTime);
			var timeStr='';
			if(difTime.days>0){
				timeStr+=difTime.days+'天';
			}
			if(difTime.days>0||difTime.hours>0){
				timeStr+=difTime.hours+':';
			}
			if(difTime.days>0||difTime.hours>0||difTime.minutes>0){
				if(difTime.minutes<10){
					timeStr+='0'+difTime.minutes+':';
				}else{
					timeStr+=difTime.minutes+':';
				}
			}
			if(difTime.days>0||difTime.hours>0||difTime.minutes>0||difTime.seconds>0){
				if(difTime.seconds<10){
					timeStr+='0'+difTime.seconds;
				}else{
					timeStr+=difTime.seconds;
				}
			}
			timeDivs.eq(i).html(timeStr);
		}
	}
}