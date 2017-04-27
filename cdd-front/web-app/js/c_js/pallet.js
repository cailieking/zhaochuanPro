$(function(){
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(2);//添加找船网公用顶部UI
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
	palletMoreFilterShowHide();//更多条件筛选面板隐藏/隐藏
	loadSearchData();//读取搜索输入框数据
	getPalletData(1,1,1,10);//获取货盘信息数据
	myCalendar.init($('#search_time'));//给更多条件_有效期添加日期控件 与common.js中定义
})
/**
func:获取货盘信息数据
@operType 操作类型 1筛选2翻页
@searchType 搜索操作类型 1顶部的搜索按钮 2更多条件中的确定按钮
@pageIndex 当前页序
@pageSize  每页数量
*/
var localPalletData;
function getPalletData(operType,searchType,pageIndex,pageSize){
	$('.tbLoading').show();
	var queryPallet={};//筛选条件
	if(searchType==1){
		queryPallet.startPort=$('#start_port_input').val();
		queryPallet.endPort=$('#dest_port_input').val();
	}
	if(searchType==2){
		//起始港
		if($('#search_startPort').html()!=''){
			queryPallet.startPort=$('#search_startPort').find('.name').attr('title');
		}else{
			queryPallet.startPort='';
		}
		//目的港
		if($('#search_endPort').html()!=''){
			queryPallet.destPort=$('#search_endPort').find('.name').html();
		}else{
			queryPallet.destPort='';
		}
		//运输类型
		if($('#search_carry').html()!=''){
			queryPallet.transType=$('#search_carry').find('.name').attr('title');
		}else{
			queryPallet.transType='';
		}
		//货物类型
		if($('#search_palletType').html()!=''){
			queryPallet.orderType=$('#search_palletType').find('.name').attr('title');
		}else{
			queryPallet.orderType='';
		}
		//时间
		//var reg=new RegExp("-","g");
		//queryPallet.endDate=$('#search_time').val().replace(reg,".");
		queryPallet.endDate=$('#search_time').val();
		/*
		case 'startPort': 
          filterConditionData['startPortFilter'] = seletedVal;
          break;
       case 'destPort':
          filterConditionData['destPortFilter'] = seletedVal;
          break;
       case 'boxType':
          filterConditionData['boxType'] = seletedVal;
          break;
       case 'commodityType':
          filterConditionData['commodityType'] = seletedVal;
          break;
       case 'outputDate':
          filterConditionData['outputDate'] = seletedVal;
          break;
		*/
	}
	queryPallet.limit=pageSize;
	queryPallet.offset=(pageIndex-1)*pageSize;
	$.ajax({
		url:'/order/list',
		dataType:'json',
		type:"get",
		data:queryPallet,
		success:function(rs){
			if(rs.total>0){
				localPalletData=rs.rows;
				switch(operType){
					case 1:{//筛选
						var total=rs.total;
						var maxPage=total%pageSize==0?parseInt(total/pageSize):parseInt(total/pageSize)+1;//计算最大页数
						commonPageChange(1);
						doPalletHtml(rs.rows);//组装货盘信息表格
						setCommonPageEvent(maxPage,function(pageNo){//公用翻页控件 common.js中定义
							getPalletData(2,searchType,pageNo,pageSize);
						})
					}
					break;
					case 2:{//翻页
						doPalletHtml(rs.rows);//组装货盘信息表格
					}
					break;
				}
			}else{
				localPalletData=null;
				$('.pallet_table .rowBg').html('没有符合条件的货盘信息');
				$('.common_pageBK').html('');
				$('.tbLoading').hide();
			}
		},
		error:function(rs){
			localPalletData=null;
			console.log('货盘信息数据读取失败',rs);
			$('.tbLoading').hide();
		}
	});
	
	//组装货盘信息表格
	function doPalletHtml(data){
		clearDatas(data,'');//清理数据中的null、undefined等错误数据 与common.js中定义
		var shippingHtml="";
		for(var i=0;i<data.length;i++){
			/*
			<div class="row">
                <div class="grid1">
                    <div class="startPort">SHENZHEN</div>
                    <div class="endPort">MEIGUO</div>
                </div>
                <div class="grid2">其他</div>
                <div class="grid3">40GP</div>
                <div class="grid4">1</div>
                <div class="grid5">2015/11/24</div>
                <div class="grid6">2016/12/01</div>
                <div class="grid7">整箱</div>
                <div class="grid8">
                    <div class="mdTxtBg">
                        <div class="mdTxt">
                            <a>我要报价</a>
                        </div>
                    </div>
                </div>
            </div>
			
			*/
			shippingHtml+='<div class="row"><div class="grid1">';
			shippingHtml+='<div class="startPort">'+data[i].startPort+'</div>';
			shippingHtml+='<div class="endPort">'+data[i].endPort+'</div></div>';
			shippingHtml+='<div class="grid2">'+data[i].orderType+'</div>';
			shippingHtml+='<div class="grid3">'+data[i].cargoBoxType+'</div>';
			shippingHtml+='<div class="grid4">'+data[i].cargoBoxNums+'</div>';
			shippingHtml+='<div class="grid5">'+data[i].endDate+'</div>';
			shippingHtml+='<div class="grid6">'+data[i].startDate+'</div>';
			shippingHtml+='<div class="grid7">'+data[i].transType+'</div>';
			shippingHtml+='<div class="grid8"><div class="mdTxtBg"><div class="mdTxt">';
			shippingHtml+='<a class="inquery" href="/publish/findcargo?orderId='+data[i].orderId+'&startPort='+data[i].startPort+'&endPort='+data[i].endPort+'&startPortCn='+data[i].startPortCn+'&endPortCn='+data[i].endPortCn+'"  target="_blank">我要报价</a>';
			shippingHtml+='</div></div></div></div>';
		}
		$('.rowBg').html(shippingHtml);
		$('.tbLoading').hide();
	}
	//组装货盘信息表格 end
}
/**
 * Fun:更多条件筛选面板隐藏/隐藏
 */
function palletMoreFilterShowHide(){
	//筛选面板收起/展开
	$('.shipping_bannerBg0 .moreBtn').click(function(){
		var more=$('.shipping_moreBg0');
		var btn=$(this);
		var h_more=$('.shipping_moreBg0').height();
		var minHeight=0;
		var maxHeight=5;
		var more_childs=$('.shipping_moreBg').children('div');
		for(var i=0;i<more_childs.length;i++){
			maxHeight+=more_childs.eq(i).height();
		}
		if(h_more<10){
			btn.html('收起');
			more.animate({
				height: maxHeight,
				duration: 300,
				queue: false
			}, function() {
				more.css('height','auto');
			});
		}else{
			btn.html('更多条件');
			more.animate({height:minHeight}, 300);
		}
	});
}

//读取搜索输入框数据
function loadSearchData(){
	$.ajax({
		url:'/Route/port',
		dataType:'json',
		success:function(rs){
			if(rs.status === 1){
				window['start_port_list'] = start_port_list =  rs.result.startPort;
				window['end_port_list'] = end_port_list = rs.result.endPort;
				$('.searchBg').searchComp({
					dataSource: {
						start_port_list: start_port_list,
						end_port_list: end_port_list
					}
				});
				getMoreFilterData();//设置更多条件中数据信息
			}
		},
		error:function(rs){
			console.log('读取失败',rs);
		}
	});
}
//设置更多条件中数据信息
function getMoreFilterData(){
	//常用的目的港数据
	var miniEndPort = [
		{endPortCn:'巴生港' ,endPort:'PORT KELANG'},  
		{endPortCn:'蒙巴萨' ,endPort:'MOMBASA'},    
		{endPortCn:'德班' ,endPort:'DURBAN'},  
		{endPortCn:'廷坎' ,endPort:'TINCAN'},  
		{endPortCn:'卡萨布兰卡' ,endPort:'CASABLANCA'},  
		{endPortCn:'卡拉奇' ,endPort:'KARACHI'},  
		{endPortCn:'迪拜' ,endPort:'DUBAI'},  
		{endPortCn:'安特卫普' ,endPort:'ANTWERP'},    
		{endPortCn:'桑托斯' ,endPort:'SANTOS'}, 
		{endPortCn:'瓜亚基尔' ,endPort:'GUAYAQUIL'}, 
		{endPortCn:'纽约' ,endPort:'NEW YORK'},  
		{endPortCn:'长滩' ,endPort:'LONG BEACH'}
	]
	//运输类型数据数据
	var carryData = [
		{cname:'整箱' ,ename:'Whole'},
		{cname:'拼箱' ,ename:'Together'}
	];
	//货物类型数据数据
	var palletTypeData = [
		{cname:'家具/家居' ,ename:'家居'},
		{cname:'建材/五金' ,ename:'建材'},
		{cname:'服装/配饰' ,ename:'服装'},
		{cname:'其他' ,ename:'其他'}
	];
	doMoreSpListHtml(start_port_list);//绑定起始港数据
	doMoreEpListHtml(miniEndPort);//绑定目的港数据
	doMoreCtListHtml(carryData);//绑定运输类型数据
	doMorePtListHtml(palletTypeData);//绑定货物类型数据
	//筛选数据项收起/展开 --起始港和船公司
	function moreSearchSilder(ele){
		var btn=ele.parent().children('.openCloseBtn');
		btn.unbind('click').click(function(){
			var dataBg=$(this).parent();
			var dataList=dataBg.children('.dataList');
			var maxHeight=dataList.height()+18;
			var minHeight=38;
			if(maxHeight==minHeight){
				return;
			}else{
				var btnTxt=btn.html();
				var patt1=new RegExp("收起");
				if(patt1.test(btnTxt)){//判断按钮文本中是否包括'收起'
					btn.html('展开&nbsp;&nbsp;∨');
					dataBg.animate({height:minHeight}, 300);
				}else{
					btn.html('收起&nbsp;&nbsp;∧');
					dataBg.animate({
						height: maxHeight,
						duration: 300,
						queue: false
					}, function() {
						dataBg.css('height','auto');
					});
				}
			}
		});
	}
	//绑定起始港数据
	function doMoreSpListHtml(data){
		var spList=$('#shipping_more_startList');
		spList.html('');
		var doHtml="";
		if(data){
			for(var i=0;i<data.length;i++){
				doHtml+='<li><span title='+data[i].label+'>'+data[i].title+'</span></li>'
			}
		}
		spList.html(doHtml);
		moreSearchSilder(spList);//筛选数据项收起/展开
		spList.parent().children('.openCloseBtn').trigger('click');
		//起始港列表点击事件
		spList.find('span').click(function(){
			setShippingMore_startPort($(this).attr('title'),$(this).html());
		})
	}
	//绑定船公司数据
	function doMoreCtListHtml(data){
		var ctList=$('#shipping_more_carryList');
		ctList.html('');
		var doHtml="";
		if(data){
			for(var i=0;i<data.length;i++){
				doHtml+='<li><span data-name='+data[i].ename+'>'+data[i].cname+'</span></li>'
			}
		}
		ctList.html(doHtml);
		//运输类型列表点击事件
		ctList.find('span').click(function(){
			setShippingMore_carry($(this).html(),$(this).attr('data-name'));
		})
	}
	//绑定货物类型数据
	function doMorePtListHtml(data){
		var ctList=$('#shipping_more_palletTypeList');
		ctList.html('');
		var doHtml="";
		if(data){
			for(var i=0;i<data.length;i++){
				doHtml+='<li><span data-name='+data[i].ename+'>'+data[i].cname+'</span></li>'
			}
		}
		ctList.html(doHtml);
		//货物类型列表点击事件
		ctList.find('span').click(function(){
			setShippingMore_pallet($(this).html(),$(this).attr('data-name'));
		})
	}
	//绑定目的港数据
	function doMoreEpListHtml(data){
		//推荐目的港
		var epList=$('#shipping_more_endList');
		epList.html('');
		var doHtml="";
		if(data){
			for(var i=0;i<data.length;i++){
				doHtml+='<li><span title='+data[i].endPortCn+'>'+data[i].endPort+'</span></li>'
			}
		}
		epList.parent().find('.openCloseBtn').click(function(){
			var btn=$(this);
			var btnTxt=btn.html();
			var patt1=new RegExp("收起");
			if(patt1.test(btnTxt)){//判断按钮文本中是否包括'收起'
				btn.html('展开&nbsp;&nbsp;∨');
				$('#shipping_more_endList').show();
				$('#shipping_more_endList_details').hide();
			}else{
				btn.html('收起&nbsp;&nbsp;∧');
				$('#shipping_more_endList').hide();
				$('#shipping_more_endList_details').show();
			}
		})
		epList.html(doHtml);
		//推荐目的港列表点击事件
		epList.find('span').click(function(){
			setShippingMore_endPort($(this).html(),$(this).attr('title'));
		})
		//推荐目的港 end
		//所有目的港
		filterEpListDetails('');
		$('#shipping_more_endList_details .wordList>li>span').click(function(){
			$('#shipping_more_endList_details .topFilter .box').val($(this).html());
			$('#shipping_more_endList_details .topFilter .box').trigger('keyup');
		})
		$('#shipping_more_endList_details .topFilter .box').keyup(function(){
			filterEpListDetails($(this).val());
		})
		//所有目的港 end
	}
	//筛选目的港数据
	function filterEpListDetails(str){
		var tempData=[];
		
		//只有一个字符时查找名称首字母
		if(str.length==1){
			str=str.toUpperCase();
			for(var i=0;i<end_port_list.length;i++){
				var el_FirstWord=end_port_list[i].label.slice(0,1).toUpperCase();
				if(str==el_FirstWord){
					tempData.push(end_port_list[i]);
				}
			}
		}
		//大于一个字符查找名称中是否包含该字符串
		if(str.length>1){
			var patt1=new RegExp(str,'i');
			for(var i=0;i<end_port_list.length;i++){
				var el_name=end_port_list[i].label;
				if(patt1.test(el_name)){
					tempData.push(end_port_list[i]);
				}
			}
		}
		//组合目的港html
		var ep_deailList=$('#shipping_more_endList_details .dataList');
		if(tempData.length>0){
			var epHtml="";
			for(var i=0;i<tempData.length;i++){
				epHtml+='<li><span title='+tempData[i].title+'>'+tempData[i].label+'</span></li>'
			}
			ep_deailList.html(epHtml);
			//目的港列表点击事件
			$('#shipping_more_endList_details .dataList span').click(function(){
				setShippingMore_endPort($(this).html(),$(this).attr('title'));
			})
		}else{
			ep_deailList.html('没有符合要求的港口');
		}
		if(str==''){
			ep_deailList.html('输入港口名称');
		}
	}
	
	//设置筛选项_起始港
	function setShippingMore_startPort(ename,cname){
		$('#search_startPort').html('<li><div class="name" title="'+ename+'">'+cname+'</div><div class="del"></div></li>')
		$('#search_startPort .del').click(function(){
			$('#search_startPort').html('');
		})
	}
	//设置筛选项_运输类型
	function setShippingMore_carry(ename,cname){
		$('#search_carry').html('<li><div class="name" title="'+cname+'">'+ename+'</div><div class="del"></div></li>')
		$('#search_carry .del').click(function(){
			$('#search_carry').html('');
		})
	}
	//设置筛选项_货物类型
	function setShippingMore_pallet(ename,cname){
		$('#search_palletType').html('<li><div class="name" title="'+cname+'">'+ename+'</div><div class="del"></div></li>')
		$('#search_palletType .del').click(function(){
			$('#search_palletType').html('');
		})
	}
	//设置筛选项_目的港
	function setShippingMore_endPort(ename,cname){
		$('#search_endPort').html('<li><div class="name" title="'+cname+'">'+ename+'</div><div class="del"></div></li>')
		$('#search_endPort .del').click(function(){
			$('#search_endPort').html('');
		})
	}
	
	//更多条件中的确定按钮点击
	$('#pallet_more_search').click(function(){
		getPalletData(1,2,1,10);//获取货盘信息数据
	})
}
