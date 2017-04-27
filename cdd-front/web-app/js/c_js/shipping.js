$(function(){
	console.log('windows_tart_port_list',window['start_port_list']);
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(1);//添加找船网公用顶部UI
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
	shippingMoreFilterShowHide();//更多条件筛选面板隐藏/隐藏
	setEleMove($('.sDetail'));//使详情可拖拽移动
	loadSearchData();//读取搜索输入框数据
	getShippingData(1,1,1,10,null);//获取运价信息数据
	myCalendar.init($('#search_time'));//给更多条件_有效期添加日期控件 与common.js中定义
})
/**
func:获取运价信息数据
@operType 操作类型 1筛选2翻页
@searchType 搜索操作类型 1顶部的搜索按钮 2更多条件中的确定按钮
@pageIndex 当前页序
@pageSize  每页数量
*/
var localShippingData;
var queryShipping={}
function getShippingData(operType,searchType,pageIndex,pageSize,dtd){
	$('.tbLoading').show();
	var indexSearchData=JSON.parse(sessionStorage.getItem("indexToShippingSearchData"));//
	if(indexSearchData){//如果是刚从首页搜索转过来的
		$('#start_port_input').val(indexSearchData.startPort);
		$('#dest_port_input').val(indexSearchData.endPort);
		sessionStorage.removeItem("indexToShippingSearchData");
	}
	//var queryShipping={};//筛选条件
	if(searchType==1){
		queryShipping.startPort=$('#start_port_input').val();
		queryShipping.endPort=$('#dest_port_input').val();
		queryShipping.shipCompany=$('#s_company_input').val();
	}
	if(searchType==2){
		if($('#search_startPort').html()!=''){
			queryShipping.startPort=$('#search_startPort').find('.name').attr('title');
		}else{
			queryShipping.startPort='';
		}
		if($('#search_endPort').html()!=''){
			queryShipping.endPort=$('#search_endPort').find('.name').html();
		}else{
			queryShipping.endPort='';
		}
		queryShipping.cargoBoxType=$('#search_boxType').find("option:selected").text();
		queryShipping.startPrice=$('#search_price1').val();
		queryShipping.endPrice=$('#search_price2').val();
		if($('#search_company').html()!=''){
			queryShipping.shipCompany=$('#search_company').find('.name').html();
		}else{
			queryShipping.shipCompany='';
		}
		queryShipping.endDate=$('#search_time').val();
	}
	/*params['cargoBoxType'] = q['cargoBoxType'] ? q['cargoBoxType']['en'] : '',
       params['startPrice'] = q['startPrice']? q['startPrice']['en'] : '',
       params['endPrice'] = q['endPrice'] ? q['endPrice']['en'] : '',
       params['shipCompany'] = q['shipCompany']?q['shipCompany']['cn']:'';
       params['endDate'] = q['expireDate']?q['expireDate']['en'] :'';*/
	queryShipping.limit=pageSize;
	queryShipping.offset=(pageIndex-1)*pageSize;
	console.log('查询条件',queryShipping);
	$.ajax({
		url:'/ship/list',
		dataType:'json',
		type:"get",
		data:queryShipping,
		success:function(rs){
			console.log(rs);
			if(rs.total>0){
				localShippingData=rs.rows;
				switch(operType){
					case 1:{//筛选
						var total=rs.total;
						var maxPage=total%pageSize==0?parseInt(total/pageSize):parseInt(total/pageSize)+1;//计算最大页数
						commonPageChange(1);
						console.log(rs.total)
						doShippingHtml(rs.rows,rs.verified,rs.total);//组装运价信息表格
						setCommonPageEvent(maxPage,function(pageNo){//公用翻页控件 common.js中定义
							getShippingData(2,searchType,pageNo,pageSize,null);
						})
						if(dtd != null){
							dtd.resolve()
						}
					}
					break;
					case 2:{//翻页
						doShippingHtml(rs.rows,rs.verified,rs.total);//组装运价信息表格
					}
					break;
				}
			}else{
				$("#totalCount").val(0)
				localShippingData=null;
				$('.shipping_table .rowBg').html('没有符合条件的运价信息');
				$('.common_pageBK').html('');
				$('.tbLoading').hide();
				if(dtd != null){
					dtd.resolve()
				}
			}
		},
		error:function(rs){
			/*localShippingData=null;
			console.log('运价信息数据读取失败',rs);
			console.log('username',userName);
			if(!userName){
				window.location = "/denglu.html";
			}*/
			$('.tbLoading').hide();
		}
	});
	
		
//	function InfoRelevantTime(dtd){
//		getShippingData(1,1,1,10,dtd);
//		return dtd
//	}
	
	//组装运价信息表格
	function doShippingHtml(data,verify,resultCount){
		clearDatas(data,'');//清理数据中的null、undefined等错误数据 与common.js中定义
		$("#totalCount").val(resultCount)
		var shippingHtml='';
		for(var i=0;i<data.length;i++){
			shippingHtml+='<div class="row"><div class="grid1">';
			shippingHtml+='<div class="startPort">'+data[i].startPort+'</div>';
			shippingHtml+='<div class="endPort">'+data[i].endPort+'</div></div>';
			if(data[i].companyName == "泛亚航运"){
				if(verify==true){
					if(data[i].gp20Vip===''){
						shippingHtml+='<div class="grid2"><div class="redPrice">优惠价</div>';
					}else{
						shippingHtml+='<div class="grid2"><div class="redPrice">￥'+data[i].gp20Vip+'</div>';
					}
				}else{
					shippingHtml+='<div class="grid2"><div class="redPrice">优惠价</div>';
				}
				shippingHtml+='<div class="grayPrice">￥'+data[i].gp20+'</div></div>';
				if(verify==true){
					if(data[i].gp40Vip===''){
						shippingHtml+='<div class="grid3"><div class="redPrice">优惠价</div>';
					}else{
						shippingHtml+='<div class="grid3"><div class="redPrice">￥'+data[i].gp40Vip+'</div>';
					}
				}else{
					shippingHtml+='<div class="grid3"><div class="redPrice">优惠价</div>';
				}
				shippingHtml+='<div class="grayPrice">￥'+data[i].gp40+'</div></div>';
				if(verify==true){
					if(data[i].hq40Vip===''){
						shippingHtml+='<div class="grid4"><div class="redPrice">优惠价</div>';
					}else{
						shippingHtml+='<div class="grid4"><div class="redPrice">￥'+data[i].hq40Vip+'</div>';
					}
				}else{
					shippingHtml+='<div class="grid4"><div class="redPrice">优惠价</div>';
				}
				shippingHtml+='<div class="grayPrice">￥'+data[i].hq40+'</div></div>';
			}else{
			
			if(verify==true){
				if(data[i].gp20Vip===''){
					shippingHtml+='<div class="grid2"><div class="redPrice">优惠价</div>';
				}else{
					shippingHtml+='<div class="grid2"><div class="redPrice">$'+data[i].gp20Vip+'</div>';
				}
			}else{
				shippingHtml+='<div class="grid2"><div class="redPrice">优惠价</div>';
			}
			shippingHtml+='<div class="grayPrice">$'+data[i].gp20+'</div></div>';
			if(verify==true){
				if(data[i].gp40Vip===''){
					shippingHtml+='<div class="grid3"><div class="redPrice">优惠价</div>';
				}else{
					shippingHtml+='<div class="grid3"><div class="redPrice">$'+data[i].gp40Vip+'</div>';
				}
			}else{
				shippingHtml+='<div class="grid3"><div class="redPrice">优惠价</div>';
			}
			shippingHtml+='<div class="grayPrice">$'+data[i].gp40+'</div></div>';
			if(verify==true){
				if(data[i].hq40Vip===''){
					shippingHtml+='<div class="grid4"><div class="redPrice">优惠价</div>';
				}else{
					shippingHtml+='<div class="grid4"><div class="redPrice">$'+data[i].hq40Vip+'</div>';
				}
			}else{
				shippingHtml+='<div class="grid4"><div class="redPrice">优惠价</div>';
			}
			shippingHtml+='<div class="grayPrice">$'+data[i].hq40+'</div></div>';
			
			}
			
			shippingHtml+='<div class="grid5">'+data[i].shipCompany+'</div>';
			shippingHtml+='<div class="grid6"><div><div>'+data[i].shippingDay+'</div></div></div>';
			shippingHtml+='<div class="grid7"><div class="mdTxtBg">';
			shippingHtml+='<div class="mdTxt">'+data[i].startDate+'<br/>丨<br/>'+data[i].endDate+'</div></div></div>';
			shippingHtml+='<div class="grid8"><div class="mdTxtBg"><div class="mdTxt">';
			shippingHtml+='<a class="details">详情</a><br/><a class="inquery" href="/publish/findship?verify=&infoId='+data[i].infoId+'&startPort='+data[i].startPort+'&endPort='+data[i].endPort+'&startPortCn=&endPortCn=" target="_blank">在线订舱</a>';
			shippingHtml+='</div></div></div></div>';
		}
		$('.rowBg').html(shippingHtml);
		shippingTableTipsShowHide();//运价信息详情提示显示/隐藏
		$('.tbLoading').hide();
	}
	//组装运价信息表格 end
}
/**
 * Fun:更多条件筛选面板隐藏/隐藏
 */
function shippingMoreFilterShowHide(){
	//筛选面板收起/展开
	$('.shipping_bannerBg0 .moreBtn').click(function(){
		var more=$('.shipping_moreBg0');
		var btn=$(this);
		var h_more=$('.shipping_moreBg0').height();
		var btnTxt=$(this).html();
		var minHeight=0;
		var maxHeight=5;
		var more_childs=$('.shipping_moreBg').children('div');
		for(var i=0;i<more_childs.length;i++){
			maxHeight+=more_childs.eq(i).height();
		}
		if(btnTxt=="更多条件"){
			btn.html('收起');
			more.animate({
				height: maxHeight,
				duration: 300,
				queue: false
			}, function() {
				more.css({'height':'auto','overflow':'visible'});
			});
		}else{
			btn.html('更多条件');
			more.css('overflow','hidden');
			more.animate({height:minHeight}, 300);
		}
	});
}
/**
 * Fun:运价信息详情提示显示/隐藏
 */
function shippingTableTipsShowHide(){
	var tips=$('.sDetail');
	//显示
	$('.shipping_table .grid8 .details').click(function(){	
		//调整显示的位置
		var thisLeft=$(this).offset().left;
		var thisTop=$(this).offset().top;
		var thisWidth=$(this).width();
		var thisHeight=$(this).height();
		var tipsWidth=tips.width();
		tips.css({
			left:thisLeft-tipsWidth,
			top:thisTop
		});
		var tipsHeight=tips.height();
		var tipsBottom=parseInt(tips.css('top'))+tips.height();
		var w_scrollHeight=$(window).scrollTop()+$(window).height();
		if(tipsBottom>w_scrollHeight){
			var h_diff=tipsBottom-w_scrollHeight;
			var tipsTop=parseInt(tips.css('top'))-h_diff;
			tips.css({top:tipsTop});
		}
		//调整显示的位置 end
		
		//加载数据
		var detailBtns=$('.shipping_table .grid8 .details');
		var index=detailBtns.index($(this));
		var thisRow=localShippingData[index];
		console.log(thisRow.extra)
		console.log(getStrLength(thisRow.extra));
		if(thisRow.extra){
			if(getStrLength(thisRow.extra)>3){//数据中有至少4个'-'，表示有正规表格数据
				var extraData=[];
				var temp1=thisRow.extra.split(';');
				for(var i=0;i<temp1.length;i++){
					if(temp1[i].length>2){
						var temp2=temp1[i].split('-');
						if(temp2[1]=='box'){temp2[1]='箱';}
						if(temp2[1]=='piece'){temp2[1]='票';}
						extraData.push(temp2);
					}
				}
				var extraHtml='<tr><th>名称</th><th>单位</th><th>20GP</th><th>40GP</th><th>40HQ</th><th>单票</th><th>币种</th></tr>';
				for(var i=0;i<extraData.length;i++){
					for(var j=0;j<extraData[i].length;j++){
						if(extraData[i][2]==0){extraData[i][2]='-';}
						if(extraData[i][3]==0){extraData[i][3]='-';}
						if(extraData[i][4]==0){extraData[i][4]='-';}
						if(extraData[i][5]==0){extraData[i][5]='-';}
					}
					extraHtml+='<tr><td>'+extraData[i][0]+'</td><td>'+extraData[i][1]+'</td>'
								+'<td>'+extraData[i][2]+'</td>'
								+'<td>'+extraData[i][3]+'</td>'
								+'<td>'+extraData[i][4]+'</td>'
								+'<td>'+extraData[i][5]+'</td><td>'+extraData[i][6]+'</td></tr>';
				}
				$('.sDetailContent .row1 .tableBK table').html(extraHtml);
			}else{
				$('.sDetailContent .row1 .tableBK table').html('<span style="color:#f00;">'+thisRow.extra+'<span>');
			}
		}else{
			$('.sDetailContent .row1 .tableBK table').html('');
		}
		console.log('thisRow.shippingDays',thisRow.shippingDays);
		console.log('thisRow.weightLimit',thisRow.weightLimit);
		if(thisRow.shippingDays){
			$('.sDetailContent .row2 .txt').eq(0).html('<span>'+thisRow.shippingDays+'天</span>');
		}else{
			$('.sDetailContent .row2 .txt').eq(0).html('<span>-</span>');
		}
		if(thisRow.middlePort){
			$('.sDetailContent .row2 .txt').eq(1).html('<span>'+thisRow.middlePort+'</span>');
		}else{
			$('.sDetailContent .row2 .txt').eq(1).html('<span>-</span>');
		}
		if(thisRow.weightLimit){
			$('.sDetailContent .row2 .txt').eq(2).html('<span>'+thisRow.weightLimit+'</span>');
		}else{
			$('.sDetailContent .row2 .txt').eq(2).html('<span>-</span>');
		}
		
		if(thisRow.remark!=''&&thisRow.remark!=null&&thisRow.remark!='null'){
			$('.sDetailContent .row3 .txt').html(thisRow.remark.replace("LONGSAIL","套约SHIPPER"));
		}else{
			$('.sDetailContent .row3 .txt').html('-');
		}
		
		//加载数据end
		
		tips.show();
	});
	//隐藏
	$('.sDetail .close').click(function(){
		tips.hide();
	});
	//获取'-'字符数量
	function getStrLength(str){
		if(/\-/i.test(str)){
			return str.match(/\-/ig).length;
		}
		return 0;
	}
}
//读取搜索输入框数据
function loadSearchData(){
	if(window.sessionStorage){
		console.log('支持sessionStorage')
		//sessionStorage.setItem("indexToShippingSearchData", JSON.stringify(indexSearchData));
		var zcPort=JSON.parse(sessionStorage.getItem("zhaochuanSearchtPort"));
		if(zcPort){//如果已有港口数据
			console.log('本地储存有港口数据',zcPort);
			initSearchBox(zcPort.startPort,zcPort.endPort);
		}else{
			console.log('没有本地储存港口数据',zcPort);
			$.ajax({
				url:'/Route/port',
				dataType:'json',
				success:function(rs){
					if(rs.status === 1){
						//本地储存港口数据
						var portData={};
						portData.startPort=rs.result.startPort;
						portData.endPort=rs.result.endPort;
						sessionStorage.setItem("zhaochuanSearchtPort", JSON.stringify(portData));
						console.log('本地储存港口数据结束',portData);
						//本地储存港口数据 end
						initSearchBox(rs.result.startPort,rs.result.endPort);
					}
				},
				error:function(rs){
					console.log('读取输入框数据失败',rs);
				}
			});
		}
	}else{
		$.ajax({
			url:'/Route/port',
			dataType:'json',
			success:function(rs){
				if(rs.status === 1){
					initSearchBox(rs.result.startPort,rs.result.endPort);
				}
			},
			error:function(rs){
				console.log('读取输入框数据失败',rs);
			}
		});
	}
//	$.ajax({
//		url:'/Route/port',
//		dataType:'json',
//		success:function(rs){
//			if(rs.status === 1){
//				initSearchBox(rs.result.startPort,rs.result.endPort);
//			}
//		},
//		error:function(rs){
//			console.log('读取失败',rs);
//		}
//	});
}
function initSearchBox(sPort,ePort){
	//船公司数据
	var companyData = [
		{title:'中远',label:'COSCO'},
		{title:'现代商船',label:'HMM'},
		{title:'高丽海运',label:'KMTC'},
		{title:'马士基',label:'MSK'},
		{title:'MCC运输',label:'MCC'},
		{title:'地中海航运',label:'MSC'},
		{title:'宏海箱运',label:'RCL'},
		{title:'阿拉伯轮船',label:'UASC'},
		{title:'以星',label:'ZIM'},
		{title:'澳航',label:'ANL'},
		{title:'法国达飞',label:'CMA'},
		{title:'达贸',label:'DELMAS'},
		{title:'长荣',label:'EMC'},
		{title:'赫伯罗特',label:'HPL'},
		{title:'日本邮船',label:'NYK'},
		{title:'浦海',label:'PHL'},
		{title:'南非航运',label:'SAF'},
		{title:'山东海丰',label:'SITC'},
		{title:'万海',label:'WHL'},
		{title:'美国总统',label:'APL'},
		{title:'韩进海运',label:'HANJIN'},
		{title:'川崎汽船',label:'K-LINE'},
		{title:'太平船务',label:'PIL'},
		{title:'德翔航运',label:'TSL'},
		{title:'阳明海运',label:'YML'},
		{title:'中海',label:'CSCL'},
		{title:'阿联酋航运',label:'ESL'},
		{title:'兴亚海运',label:'HEUNG-A'},
		{title:'亚川船务',label:'IAL'},
		{title:'大阪三井',label:'MOL'},
		{title:'东方海外',label:'OOCL'},
		{title:'南星海运',label:'NAMSUNG'},
		{title:'中外运',label:'SINOTRANS'},
		{title:'玛丽亚那',label:'MARIANA'},
		{title:'汉堡南美',label:'HAMBURG-SUD'}
	];
	var sPortAlways = [];
	var ePortAlways = [];
	var cpAlways = [];
	window['start_port_list'] = start_port_list =  sPort;
	window['end_port_list'] = end_port_list = ePort;
	window['s_company_list'] = s_company_list = companyData;
	$('.searchBg').searchComp({
		dataSource: {
			start_port_list: start_port_list,
			start_port_list_always : sPortAlways,
			end_port_list: end_port_list,
			end_port_list_always : ePortAlways,
			s_company_list: s_company_list,
			s_company_list_always : cpAlways
		}
	});
	getMoreFilterData();//设置更多条件中数据信息
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
	//船公司数据
	var companyData = [
		{shipCompanyCn:'中远',shipCompany:'COSCO'},
		{shipCompanyCn:'现代商船',shipCompany:'HMM'},
		{shipCompanyCn:'高丽海运',shipCompany:'KMTC'},
		{shipCompanyCn:'马士基',shipCompany:'MSK'},
		{shipCompanyCn:'MCC运输',shipCompany:'MCC'},
		{shipCompanyCn:'地中海航运',shipCompany:'MSC'},
		{shipCompanyCn:'宏海箱运',shipCompany:'RCL'},
		{shipCompanyCn:'阿拉伯轮船',shipCompany:'UASC'},
		{shipCompanyCn:'以星',shipCompany:'ZIM'},
		{shipCompanyCn:'澳航',shipCompany:'ANL'},
		{shipCompanyCn:'法国达飞',shipCompany:'CMA'},
		{shipCompanyCn:'达贸',shipCompany:'DELMAS'},
		{shipCompanyCn:'长荣',shipCompany:'EMC'},
		{shipCompanyCn:'赫伯罗特',shipCompany:'HPL'},
		{shipCompanyCn:'日本邮船',shipCompany:'NYK'},
		{shipCompanyCn:'浦海',shipCompany:'PHL'},
		{shipCompanyCn:'南非航运',shipCompany:'SAF'},
		{shipCompanyCn:'山东海丰',shipCompany:'SITC'},
		{shipCompanyCn:'万海',shipCompany:'WHL'},
		{shipCompanyCn:'美国总统',shipCompany:'APL'},
		{shipCompanyCn:'韩进海运',shipCompany:'HANJIN'},
		{shipCompanyCn:'川崎汽船',shipCompany:'K-LINE'},
		{shipCompanyCn:'太平船务',shipCompany:'PIL'},
		{shipCompanyCn:'德翔航运',shipCompany:'TSL'},
		{shipCompanyCn:'阳明海运',shipCompany:'YML'},
		{shipCompanyCn:'中海',shipCompany:'CSCL'},
		{shipCompanyCn:'阿联酋航运',shipCompany:'ESL'},
		{shipCompanyCn:'兴亚海运',shipCompany:'HEUNG-A'},
		{shipCompanyCn:'亚川船务',shipCompany:'IAL'},
		{shipCompanyCn:'大阪三井',shipCompany:'MOL'},
		{shipCompanyCn:'东方海外',shipCompany:'OOCL'},
		{shipCompanyCn:'南星海运',shipCompany:'NAMSUNG'},
		{shipCompanyCn:'中外运',shipCompany:'SINOTRANS'},
		{shipCompanyCn:'玛丽亚那',shipCompany:'MARIANA'},
		{shipCompanyCn:'汉堡南美',shipCompany:'HAMBURG-SUD'}
	];
	doMoreSpListHtml(start_port_list);//绑定起始港数据
	doMoreCpListHtml(companyData);//绑定船公司数据
	doMoreEpListHtml(miniEndPort);//绑定目的港数据
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
	function doMoreCpListHtml(data){
		var cpList=$('#shipping_more_companyList');
		cpList.html('');
		var doHtml="";
		if(data){
			for(var i=0;i<data.length;i++){
				doHtml+='<li><span title='+data[i].shipCompanyCn+'>'+data[i].shipCompany+'</span></li>'
			}
		}
		cpList.html(doHtml);
		moreSearchSilder(cpList);//筛选数据项收起/展开
		cpList.parent().children('.openCloseBtn').trigger('click');
		//船公司列表点击事件
		cpList.find('span').click(function(){
			setShippingMore_company($(this).html(),$(this).attr('title'));
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
	//设置筛选项_船公司
	function setShippingMore_company(ename,cname){
		$('#search_company').html('<li><div class="name" title="'+cname+'">'+ename+'</div><div class="del"></div></li>')
		$('#search_company .del').click(function(){
			$('#search_company').html('');
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
	$('#shipping_more_search').click(function(){
		getShippingData(1,2,1,10);//获取运价信息数据
	})
}

function shippingSort(ele){
	var sorts=$('.shipping_table .head .sort');
	var sortType=ele.attr('data-type');
	for(var i=0;i<sorts.length;i++){
		if(sorts.eq(i).parent().attr('data-type')!=sortType){
			sorts.eq(i).html('');
		}
	}
	var sortNum=ele.find('.sort').html();
	queryShipping.sort = sortType
	if(sortNum=='↑'){
		ele.find('.sort').html('↓');
		queryShipping.order = "desc"
	}else if(sortNum="↓"){
		ele.find('.sort').html('↑');
		queryShipping.order = "asc"
	}else if(sortNum=""){
		ele.find('.sort').html('↑');
		queryShipping.order= "asc"
	}
	getShippingData(1,1,1,10,null);
}
