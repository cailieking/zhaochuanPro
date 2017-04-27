$(function(){
	initTurnState();//初始化开关状态
	adTurnClick();//广告栏设置开关点击
	timesStatus();
})
//时间状态判断
function timesStatus(){
	var infoList=$('.infoList');
	for(var i=0;i<infoList.length;i++){
		var listTxt=infoList.eq(i).find('.txt');
		//转换时间为毫秒数
		var today=new Date();
		var sTime=[today.getFullYear(),today.getMonth()+1,today.getDate()];
		var eTime=listTxt.eq(3).html().split('-');
		//console.log('sTime',sTime);
		//console.log('eTime',eTime);
		var sTime_num=TimeUtil.getSpecTimeByTimeStamp(parseInt(sTime[0]),parseInt(sTime[1]),parseInt(sTime[2]),0,0,0,0);
		var eTime_num=TimeUtil.getSpecTimeByTimeStamp(parseInt(eTime[0]),parseInt(eTime[1]),parseInt(eTime[2]),0,0,0,0);
		var defNum=30*24*60*60*1000;//一个月的毫秒数
		var isOpen=listTxt.eq(0).attr('data-status');
		//对时间进行判断
		if(isOpen==1){
			listTxt.eq(3).css('color','black');
			listTxt.eq(0).css('color','red');
			listTxt.eq(0).html('禁用');
		}else if(sTime_num>=eTime_num){
			listTxt.eq(3).css('color','red');
			listTxt.eq(0).css('color','red');
			listTxt.eq(0).html('已到期');
		}else if(eTime_num-sTime_num<defNum){
			listTxt.eq(3).css('color','red');
			listTxt.eq(0).css('color','red');
			listTxt.eq(0).html('月内到期');
		}else{
			listTxt.eq(3).css('color','black');
			listTxt.eq(0).css('color','green');
			listTxt.eq(0).html('启用');
		}
	}
}
//初始化开关状态
function initTurnState(){
	if($('div[name="shipBottomState"]')){
		var state=$('div[name="shipBottomState"]').attr('data-status');
		console.log('state',state)
		if(state==0){
			$('.turn .turnTxt').parents('.turn').removeClass('off');
			$('.turn .turnTxt').parents('.turn').addClass('on');
			$('.turn .turnTxt').html('ON');
		}else{
			$('.turn .turnTxt').parents('.turn').removeClass('on');
			$('.turn .turnTxt').parents('.turn').addClass('off');
			$('.turn .turnTxt').html('OFF');
		}
	}
}
//广告栏设置开关点击
function adTurnClick(){
	$('.turn .turnTxt').click(function(){
		var isOn=$(this).parents('.turn').hasClass('on');
		if(isOn){
			if(confirm("是否关闭？"))
			{
				$(this).parents('.turn').removeClass('on');
				$(this).parents('.turn').addClass('off');
				$(this).html('OFF');
				window.location.href='/advManage/changeStatus/?status=off';
			}
			
		}else{
			if(confirm("是否开启？")){
				$(this).parents('.turn').removeClass('off');
				$(this).parents('.turn').addClass('on');
				$(this).html('ON');
				window.location.href='/advManage/changeStatus/?status=on';
			}
		}
	})
}

//banner创建弹出框显示
function shipBottomCreateShow(){
	
	$('#shipBottomCreate').show();
}
//banner创建弹出框隐藏
function shipBottomCreateHide(){
	$('#shipBottomCreate').hide();
}
//广告修改弹出框隐藏
function adEditHide(){
	$('#adEdit').hide();
}
//shipBottom修改弹出框显示
function adEditShow($this){
	var txts=$this.parents('.tr').find('.txt');
	var title=txts.eq(4).html();
	var alt=txts.eq(5).html();
	var href=txts.eq(6).html();
	var endDate=txts.eq(3).html();
	var customName=txts.eq(7).html();
	var contractNumber=txts.eq(8).html();
	var sales=txts.eq(9).html();
	var order=txts.eq(3).attr('data-order');
	var image=$this.parents('.tr').find('.image').attr('src');
	$('#title').val(title);
	$('#alt').val(alt);
	$('#href').val(href);
	$('#endDate').val(endDate);
	$('#customName').val(customName);
	$('#contractNumber').val(contractNumber);
	$('#sales').val(sales);
	$('#order').val(order);
	$('#image').attr('src',image);
	$('#editId').val($this.attr('data-id'));
	$('#adEdit').show();
}
//shipBottom修改弹出框清理
function adEditClear(){
	$('#title').val('');
	$('#alt').val('');
	$('#href').val('');
	$('#endDate').val('');
	$('#order').val('');
	$('#customName').val('');
	$('#contractNumber').val('');
	$('#sales').val('');
	$('#image').attr('src','');
}

//shipBottom创建 提交
function createSubmit(){
	if($('#createEndDate').val()==''){alert('到期时间必填！');return;}
	if($('#createOrder').val()==''){alert('顺序为空');return;}
	if($('#createImageFile').val()==''&&$('#editImage').attr('src')==''){alert('图片为空');return;}
	$('#dataFormCreate').submit();
	//adEditHide();
}

//shipBottom修改 提交
function editSubmit(){
	if($('#editEndDate').val()==''){alert('到期时间必填！');return;}
	if($('#editOrder').val()==''){alert('顺序为空');return;}
	if($('#editImageFile').val()==''&&$('#editImage').attr('src')==''){alert('图片为空');return;}
	$('#dataFormEdit').submit();
	//adEditHide();
}
//banner修改弹出框清理
function shipBottomCreateClear(){
	$('#createTitle').val('');
    $('#createAlt').val('');
    $('#createHref').val('');
    $('#createEndDate').val('');
    $('#createCustom').val('');
    $('#createContractNumber').val('');
    $('#createSales').val('');
    $('#createOrder').val('');
}
//指定删除
function shipBottomDelete(id){
	if(confirm("确定要删除该数据吗？"))
	{
		window.location.href='/advManage/delete/?ids=' + id;
	}
}