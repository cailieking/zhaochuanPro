$(function(){
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(4);//添加找船网公用顶部UI
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
	loadCompanysData(1,1,8);//读取公司数据
})
/**
 *@func 读取公司数据
 *@operType 操作类型 1初始化2翻页
 *@pageIndex 当前页序
 *@pageSize  每页数量
 */
function loadCompanysData(operType,pageIndex,pageSize){
	///enterpriseDirectory/list
	var queryCompanys={curPage:1};
	$.ajax({
		url:'/enterpriseDirectory/list',
		dataType:'json',
		type:"get",
		data:queryCompanys,
		success:function(rs){
			console.log('公司信息读取成功',rs);
			switch(operType){
				case 1:{//初始化
					var total=rs.map.total;
						var maxPage=total%pageSize==0?parseInt(total/pageSize):parseInt(total/pageSize)+1;//计算最大页数
						commonPageChange(1);
						doCompanyHtml(rs.map.list,rs.verified,1,pageSize);//组装运价信息表格
						setCommonPageEvent(maxPage,function(pageNo){//公用翻页控件 common.js中定义
							doCompanyHtml(rs.map.list,rs.verified,pageNo,pageSize)
						})
				}
				break;
				case 2:{//翻页
				}
				break;
			}
		},
		error:function(rs){
			console.log('公司信息读取失败',rs);
		}
	});
	/**
	 *@func 组合企业Html
	 *@data 企业数据
	 *@verify 是否认证
	 *@pageN0  当前页序
	 *@pageSize  每页数量
	 */
	function doCompanyHtml(data,verify,pageN0,pageSize){
		//截取、处理数据
		var length=data.length;
		var start=(pageN0-1)*pageSize;
		var end=start+pageSize;
		if(start>length){return;}
		if(end>=length){end=length;}
		var tempData=[];
		for(var i=start;i<end;i++){
			tempData.push(data[i]);
		}
		clearDatas(tempData,'');
		//截取、处理数据 end
		var cpHtml="";
		if(verify==true){
			$('#companysList_omit').hide();
			$('#companysList_details').show();
			for(var i=0;i<tempData.length;i++){
				cpHtml+='<li>'+
					'<div class="title">'+tempData[i].companyName+'</div>'+
					'<div class="txtBg">'+
						'<div class="txt">联系人：'+tempData[i].contactName+'</div>'+
						'<div class="txt">手&nbsp;&nbsp;&nbsp;机：'+tempData[i].mobile+'</div>'+
						'<div class="txt">Q&nbsp;&nbsp;&nbsp;Q：'+tempData[i].qq+'</div>'+
						'<div class="txt">邮&nbsp;&nbsp;&nbsp;箱：'+tempData[i].email+'</div>'+
						'<div class="txt">电&nbsp;&nbsp;&nbsp;话：'+tempData[i].telephone+'</div>'+
						'<div class="txt" title="'+tempData[i].address+'">地&nbsp;&nbsp;&nbsp;址：'+tempData[i].address+'</div>'+
					'</div>'+
					'<div class="rTxtBg">'+
						'<div class="mdTxtBg">'+
							'<div class="mdTxt">'+tempData[i].city+'</div>'+
						'</div>'+
					'</div>'+
				'</li>';
			}
			$('#companysList_details').html(cpHtml);
		}else{
			$('#companysList_omit').show();
			$('#companysList_details').hide();
			for(var i=0;i<tempData.length;i++){
				cpHtml+='<li>'+
					'<div class="title">'+tempData[i].companyName+'</div>'+
					'<div class="txtBg">'+
						'<div class="txt">联系人：'+tempData[i].contactName+'</div>'+
						'<div class="txt" title="'+tempData[i].address+'">地&nbsp;&nbsp;&nbsp;址：'+tempData[i].address+'</div>'+
					'</div>'+
					'<div class="rTxtBg">'+
						'<div class="mdTxtBg">'+
							'<div class="mdTxt">'+tempData[i].city+'</div>'+
						'</div>'+
					'</div>'+
				'</li>';
			}
			$('#companysList_omit').html(cpHtml);
		}
	}
}