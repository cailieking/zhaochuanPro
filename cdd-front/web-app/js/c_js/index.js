$(function(){
	$('.index_news>.left>.title').css('cursor','pointer');
	console.log('windows_tart_port_list',window['start_port_list']);
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(0);//添加找船网公用顶部UI
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
	loadIndexDatas();//读取首页表格数据 运价信息和货盘信息
	loadNewsDatas();//读取首页新闻数据
	loadSearchData();//读取搜索输入框数据
})
//读取首页表格数据 运价信息和货盘信息
function loadIndexDatas(){
	console.log('首页开始读取');
	var url=SITE_URL+'index/dataInfo';
	console.log('url=',url);
	$.ajax(
		{
		url:SITE_URL+'index/dataInfo',
		type:"get",
		success:function(rs)
		{
			doShippingHtml(rs.data.cargoShip);//组装运价信息页面
			//doFreightHtml(0,rs.data.furniture);//组装货盘信息页面
			doFreightHtml(1,rs.data.building);//组装货盘信息页面
			doFreightHtml(2,rs.data.clothing);//组装货盘信息页面
			doFreightHtml(3,rs.data.pinxiang);//组装货盘信息页面
			doPartnerImage();//组装合作伙伴图片
			freightTabChange();//货盘tabs切换事件
			//businessListAni();//分隔条_交易信息滚动动画
			
			//组装运价信息页面 data运价信息数据
			function doShippingHtml(data){
				clearDatas(data.list,'');//清理数据中的null、undefined等错误数据
				var dataList=data.list;
				console.log('运价信息数据',data);
				var dataHtml='';
				if(dataList){
					for(var i=0;i<data.list.length;i++){
						if(i<6){
							dataHtml+='<li>';
							dataHtml+='<div class="trText">HOT</div>';
							dataHtml+='<div class="startPort">'+dataList[i].startPort+'</div>';
							dataHtml+='<div class="endPort">'+dataList[i].endPort+'</div>';
							dataHtml+='<div class="type">';
							dataHtml+='<div>20GP</div>';
							dataHtml+='<div>40GP</div>';
							dataHtml+='<div>40HQ</div>';
							dataHtml+='</div>';
							dataHtml+='<div class="price">';
							if(dataList[i].endPort=="TAICHUNG"||dataList[i].endPort=="KEELUNG"||dataList[i].endPort=="KAOHSIUNG"){
								dataHtml+='<div>￥'+dataList[i].gp20+'</div>';
								dataHtml+='<div>￥'+dataList[i].gp40+'</div>';
								dataHtml+='<div>￥'+dataList[i].hq40+'</div>';
							}else{
							dataHtml+='<div>$'+dataList[i].gp20+'</div>';
							dataHtml+='<div>$'+dataList[i].gp40+'</div>';
							dataHtml+='<div>$'+dataList[i].hq40+'</div>';
							}
							dataHtml+='</div>';
							dataHtml+='<div class="details"><a href="/publish/findship?verify=&infoId='+dataList[i].infoId+'&startPort='+dataList[i].startPort+'&endPort='+dataList[i].endPort+'&startPortCn=&endPortCn=" target="_blank">在线订舱</a></div>';
							dataHtml+='</li>';
						}
					}
					$('#index_shippingList').html(dataHtml);
				}
			}
			//组装运价信息页面 end
			
			//组装货盘信息页面 index 0家具1建材2服装3拼箱 data货盘信息数据
			function doFreightHtml(index,data){
				console.log('货盘信息',data);
				clearDatas(data.list,'');//清理数据中的null、undefined等错误数据
				var dataList=data.list;
				var dataHtml='';
				if(dataList){
					for(var i=0;i<dataList.length;i++){
						dataHtml+='<li>';
						dataHtml+='<div class="startPort">'+dataList[i].startPort+'</div>';
						dataHtml+='<div class="endPort">'+dataList[i].endPort+'</div>';
						if(index!=3){
							dataHtml+='<div class="column5">$'+dataList[i].cargoBoxType+'*'+dataList[i].cargoBoxNums+'</div>';
						}else{
							dataHtml+='<div class="column5">';
							dataHtml+='<div>件数：'+dataList[i].cargoNums+' 重量：'+dataList[i].cargoWeight+'KG<br/>体积：'+dataList[i].cargoCube+'CBM</div>';
							dataHtml+='</div>';
						}
						dataHtml+='<div class="column3">HOT</div>';
						dataHtml+='<div class="column4">'+dataList[i].cargoName+'</div>';
						dataHtml+='<div class="details"><a href="/member/ship?orderId='+dataList[i].orderId+'&startPort='+dataList[i].startPort+'&endPort='+dataList[i].endPort+'" target="_blank">我要报价</a></div>';
						dataHtml+='</li>';
					}
					$('#index_freightList'+index).html(dataHtml);
				}
				//组装货盘信息页面 end
				
				//滚动信息加载
				/*clearDatas(data.orders,'');//清理数据中的null、undefined等错误数据
				var oderList=data.orders;
				var oderHtml="";
				if (oderList) {
					for (var i=0; i<oderList.length; i++) {
						var name=oderList[i].contactName;
						var sPort=oderList[i].startPort;
						var ePort=oderList[i].endPort;
						var lastTime=oderList[i].lastUpdated;
						var btnStr,statusStr;
						if(oderList[i].orderStatus.name=="UnTrade"){
							btnStr='交易状态';
							statusStr=sPort+'——'+ePort+'，正在洽谈中...';
						}
						if(oderList[i].orderStatus.name=="InTrade"){
							btnStr='订单摘要';
							statusStr=sPort+'——'+ePort+'，交易成功';
						}
						oderHtml+='<li>';
						oderHtml+='<div>'+name+'</div>';
						oderHtml+='<div>'+statusStr+'</div>';
						oderHtml+='<div>'+lastTime+'</div>';
						oderHtml+='<div class="btn">'+btnStr+'</div>';
						oderHtml+='</li>';
					}
					$('#indexBusinessList'+index).html(oderHtml);
				}*/
			}
			//滚动信息加载 end
			
			//组装合作伙伴图片
			function doPartnerImage(){
				var partnerHtml='';
				var imageLinks=[
					['http://www.picc.com/',
					'http://www.made-in-china.com/',
					'http://www.globalsources.com/',
					'http://www.chinaguoben.com/'],
					['http://www.jfholdings.cn/',
					'http://www.toprungroup.com/',
					'http://www.siffa.org.cn/',
					'http://www.kuajingbiz.com/'],
					['http://www.focusie.com',
						'http://www.winbons.com/',
						'http://www.4px.com/',
						'https://www.xiaoman.cn/']
				]
				for(var i=0;i<3;i++){
					var data;
					if(i==0){data=rs.data.furniture.imageInfos;}
					if(i==1){data=rs.data.building.imageInfos;}
				    if(i==2){data=rs.data.pinxiang.imageInfos;}
					//if(i==3){data=rs.data.pinxiang.imageInfos;}
					for(var j=0;j<data.length;j++){
						if(j<4){
							partnerHtml+='<li>';
							partnerHtml+='<a target="_blank" href="'+imageLinks[i][j]+'"  onfocus="this.blur();"><img src="'+ossDomain+data[j].image+'" /></a>';
							partnerHtml+='</li>';
						}
					}
				}
				$('.partnerList').html(partnerHtml);
			}
			//组装合作伙伴图片 end
			
			//货盘tabs切换事件
			function freightTabChange(){
				$('#freightTabs li').click(function(){
					//获取选中序列号
					var lis=$('#freightTabs li');
					var index=lis.index($(this));
					//设置tab选中
					lis.removeClass('sel');
					$(this).addClass('sel');
					//设置tab页面隐藏显示
					$('#freightRight>ul').hide();
					$('#index_freightList'+index).show();
					//设置滚动页隐藏显示
					var odersListBg=$('.index_separateBg0 .businessList');
					odersListBg.hide();
					if(index==0||index==1){
						odersListBg.eq(0).show();
						odersListBg.eq(1).show();
					}
					if(index==2||index==3){
						odersListBg.eq(2).show();
						odersListBg.eq(3).show();
					}
				});
			}
			//货盘tabs切换事件 end
			
			//分隔条_交易信息滚动动画
			function businessListAni(){
				var ul=$('.businessList');
				for(var i=0;i<ul.length;i++){
					setAni(ul.eq(i));
				}
				//设置动画
				function setAni($ul){
					var timer;
					var speed=1;
					var pos=0;
					var index=0;
					aniStart();
					function aniStart(){
						timer=setInterval(function(){doAni()},20); 
					}
					function aniStop(){
						clearInterval(timer);
					}
					function doAni(){
						var li_first=$ul.children('li').eq(index);
						var li_last=$ul.children('li').eq($ul.children('li').length-1);
						$ul.css({left:-pos});
						pos+=speed;
						if(pos>li_first.width()){
							li_first.insertAfter(li_last);
							pos=0;
							$ul.css({left:-pos});
						}
					}
					$ul.hover(function(){
						aniStop();
					},
					function(){
						aniStart();
					});
				}
			}
			//分隔条_交易信息滚动动画 end
		},
		error:function(rs){
			console.log('首页数据读取失败',rs);
		}
	});
}
//读取首页表格数据 运价信息和货盘信息 end

//读取首页新闻数据
function loadNewsDatas(){
	var url=SITE_URL+'index/advInfo';
	$.ajax({
        url:SITE_URL+'index/advInfo',
        type:"get",
        success:function(rs)
        {
			if(rs && rs.data){
				if (rs.data.article){
					loadLeftImageData(rs.data.article.imageInfo);//读取左侧图片新闻数据
				}
				if(rs.data.article.ftlist){
					loadNewList(0,rs.data.article.ftlist);//读取外贸信息
				}
				if(rs.data.article.tplist){
					loadNewList(1,rs.data.article.tplist);//读取运输动态
				}
				if(rs.data.article.comlist){
					loadNewList(2,rs.data.article.comlist);//读取公司新闻
				}
				newsMoreBtnClick();//新闻_更多按钮点击
				
				topNewsRandom();//顶部随机新闻设置
			}
			
			//读取左侧图片新闻数据
			function loadLeftImageData(data){
				if(data){
					var artImageInfo = rs.data.article.imageInfo;
					//$('.index_news .imageBg>a').attr('href','/article/data?id='+data.id);
					//$('.index_news .txtBg>a').attr('href','/article/data?id='+data.id);
					$('.index_news .txtBg .msg').html(data.title);
					$('.index_news .image').css('background-image','url('+ossDomain+data.image+')');
					//$('.index_news .image').css('background-image','url('+data.image+')');
					$('.index_news .txtBg>a,.index_news .imageBg>a').click(function(){
						var newsId=data.id;
						sessionStorage.setItem("zcCurNewsId",newsId);
						window.open(data.newsUrl);
					})
				}
			}
			//读取左侧图片新闻数据 end
			//读取新闻列表 0外贸信息1运输动态2公司新闻
			function loadNewList(index,data){
				var newsHtml="";
				for(var i=0;i<data.length;i++){
					if(i>5){break;}
					newsHtml+='<li>';
					if(data[i].articleCategory &&　data[i].newsUrl){
							newsHtml += '<a data-id="'+data[i].id+'" class="msg" href="'+ data[i].newsUrl +'" target="_blank"><span class="label label-danger" >要闻</span>'+data[i].title+'</a>';
					}else if(data[i].articleCategory){
							newsHtml += '<a data-id="'+data[i].id+'" class="msg" href="javascript:void(0)" ><span class="label label-danger" >要闻</span>'+data[i].title+'</a>';
					}else if(data[i].newsUrl){
							newsHtml += '<a data-id="'+data[i].id+'" class="msg" href="'+ data[i].newsUrl +'"  target="_blank">'+data[i].title+'</a>';
					}else {
					    	newsHtml += '<a data-id="'+data[i].id+'" class="msg" href="javascript:void(0)">'+data[i].title+'</a>';
					}
                    newsHtml += '<div class="time">'+data[i].dateCreatedStr+'</div>';
                    newsHtml += '</li>';
				}
				$('#indexNewsList'+index).html(newsHtml);
			
				$('#indexNewsList'+index).find('li>a[href="javascript:void(0)"]').unbind('click').click(function(){
					var newsId=$(this).attr('data-id');
					sessionStorage.setItem("zcCurNewsId",newsId);
					window.open('newsDetails.html');
				})
				
				$('#indexNewsList'+index).find('li>a[href!="javascript:void(0)"]').unbind('click').click(function(){
					var newsId=$(this).attr('data-id');
					loadNewsData(newsId)
				})
			}
			
			//读取新闻列表 end
			//新闻_更多按钮点击
			function newsMoreBtnClick(){
				$('.index_news .top .more').click(function(){
					var id=$(this).attr('id');
					var type=id.split('_')[1];
					sessionStorage.setItem("newsListType",type);
					window.open("newsList.html");
				})
				$('.index_news .top .title').click(function(){
					var id=$(this).attr('id');
					var type=id.split('_')[1];
					sessionStorage.setItem("newsListType",type);
					window.open("newsList.html");
				})
				$('.index_news>.left>.title').click(function(){
					sessionStorage.setItem("newsListType","ftlist");
					window.open("newsList.html");
				})
			}
			//新闻_更多按钮点击 end
			//顶部随机新闻设置
			function topNewsRandom(){
				var topTxt=$('.index_bannerBg0 .newsTxt');
				var type=parseInt(Math.random()*3);
				var data=rs.data.article.comlist;//随机新闻类型固定为公司新闻
				/*var data;
				switch(type){
					case 0:{//随机到外贸信息
						data=rs.data.article.ftlist;
					}
					break;
					case 1:{//随机到运输动态
						data=rs.data.article.tplist;
					}
					break;
					case 2:{//随机到公司新闻
						data=rs.data.article.comlist;
					}
					break;
				}*/
				var num=data.length;
				var index=parseInt(Math.random()*num);
				topTxt.attr('data-id',data[index].id);
				topTxt.html(data[index].title);
				topTxt.off('click').on('click',function(){
					sessionStorage.setItem("zcCurNewsId",$(this).attr('data-id'));
					window.open(data[index].newsUrl)
					//window.open('newsDetails.html');
				})
			}
			//顶部随机新闻设置 end
			
			//console.log('顶部图片数据',rs.data.imageInfos);
			//图片轮播数据设置
			for(var i=0;i<rs.data.imageInfos.length;i++){
				if(rs.data.imageInfos[i].state==0){
					var tempData={};
					tempData.image=ossDomain+rs.data.imageInfos[i].image;
					tempData.alt=rs.data.imageInfos[i].alt;
					tempData.href=rs.data.imageInfos[i].href;
					tempData.title=rs.data.imageInfos[i].title;
					imageChangeData.push(tempData);
				}
			}
			imageChangeAni(imageChangeData);
			//图片轮播数据设置end
        }
    });
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
	
	$('.index_bannerBg').searchComp({
		dataSource: {
			start_port_list: start_port_list,
			start_port_list_always : sPortAlways,
			end_port_list: end_port_list,
			end_port_list_always : ePortAlways,
			s_company_list: s_company_list,
			s_company_list_always : cpAlways
		}
	});
}
/*var imageChangeData=[
{image:'/images/c_images/index/index_newsLeftImage1.png',msg:'找船人风采之悭锵玫瑰1！',name:'———— 商务二部',src:'',picName:''},
{image:'/images/c_images/index/index_newsLeftImage1.png',msg:'找船人风采之悭锵玫瑰2！',name:'———— 商务二部',src:'',picName:''},
{image:'/images/c_images/index/index_newsLeftImage1.png',msg:'找船人风采之悭锵玫瑰3！',name:'———— 商务二部',src:'',picName:''}];
//咨询动态_轮播动画
function newsImageAni(data){
	var imageBg=$('.index_news .left .imageBg')
	var image=imageBg.find('.image');
	image.css('background-image','url('+data[0].image+')');
	var lBtn=imageBg.find('.leftBtn');
	var rBtn=imageBg.find('.rightBtn');
	var msg=imageBg.find('.msg');
	var name=imageBg.find('.name');
    var idx=1;
	var timer; 
	changeStart();
	function changeStart(){
		timer=setInterval(function(){imageChange(idx);idx++;},5000); 
	}
	function changeStop(){
		clearInterval(timer);
	}
	function imageChange(index){
		wImage=image.width();
		if(data.length > 1){
			if(idx > data.length-1){idx=0;}
			image.css({
				backgroundPosition:wImage
			});
			image.animate({
				backgroundPosition:0
			},'fast');
			
			image.css('background-image','url('+data[idx].image+')');
			msg.html(data[idx].msg);
			name.html(data[idx].name);
		}
		
	}
	imageBg.hover(function(){
		changeStop();
	},
	function(){
		changeStart();
	});
	lBtn.click(function(){
		idx--;
		if(idx<0){
			idx=data.length-1;
		}
		console.log(idx+'xx'+data.length);
		imageChange();
	});
	rBtn.click(function(){
		idx++;
		if(idx>data.length-1){
			idx=0;
		}
		console.log(idx+'xx'+data.length);
		imageChange();
	});
}*/
function loadNewsData(id){
	console.log(id)
	var newsId=id
	var queryNews={id:newsId};
	$.ajax({
		url:'/article/data',
		dataType:'json',
		type:"get",
		data:queryNews,
		success:function(rs){
			//doNewsHtml(rs);//组装新闻Html
		},
		error:function(rs){
			console.log('新闻数据读取失败',rs);
		}
	});
}

/*模拟图数据*/
var imageChangeData=[];
/*模拟图数据 end*/
/*图片轮播动画*/
function imageChangeAni(imageChangeData){
	//添加动画控制点
	var changeHtml="";
	for(var i=0;i<imageChangeData.length;i++){
		if(i==0){
			changeHtml+='<li class="active"></li>'
		}else{
			changeHtml+='<li></li>'
		}
	}
	$('.index_bannerBg0 .toggle-box').html(changeHtml);
	//添加动画控制点 end
    var image=$('.index_bannerBg0')
    var changeBox=$('.toggle-box li');
	var txts=$('.headerBg .txts div');
    var idx=1;
	var len=imageChangeData.length;
	var timer;
	image.css('background-image','url('+imageChangeData[0].image+')');
	image.attr('title',imageChangeData[0].title);
	image.attr('alt',imageChangeData[0].alt);
	image.attr('data-href','http://'+imageChangeData[0].href);
	changeStart();
	//计时器开始
	function changeStart(){
		timer=setInterval(function(){imageChange()},5000);
	}
	//计时器停止
	function changeStop(){
		clearInterval(timer);
	}
	//图片切换执行函数
	function imageChange(){
		if(idx>len-1){idx=0;}
		image.css({
			backgroundPosition:'-100%',
			opacity:0.3
		});
		image.animate({
			backgroundPosition:'50%'
		},'fast');
		image.animate({
			opacity:1
		},'normal');
		changeBox.removeClass('active');
		changeBox.eq(idx).addClass('active');
		
		image.css('background-image','url('+imageChangeData[idx].image+')');
		image.attr('title',imageChangeData[idx].title);
		image.attr('alt',imageChangeData[idx].alt);
		var aaa = show_html= imageChangeData[idx].href.substring(imageChangeData[idx].href.indexOf("/"))
		image.attr('data-href',aaa)
		//image.attr('data-href','http://'+imageChangeData[idx].href);
		//txts.eq(0).html(imageChangeData[idx].bigTxt);
		//txts.eq(1).html(imageChangeData[idx].smlTxt);
		idx++;
	}
	//图片切换执行函数 end
	//图片切换控制
	image.click(function(){
		var thishref=$(this).attr('data-href');
		window.open(thishref);
	});
	changeBox.hover(function(){
		changeStop();
	},
	function(){
		changeStart();
	});
	changeBox.click(function(){
		idx=changeBox.index($(this));
		var selIndex=changeBox.index($('.toggle-box .active'));
		if(idx!=selIndex){
			imageChange();
		}
	});
	//图片切换控制 end
	//图片点击事件
	$('.index_bannerBg').click(function(){
		//alert('图片点击');
	})
	//图片内元素点击时阻止图片点击事件
	$('.index_bannerBg .list,.index_bannerBg .toggle-box,.index_bannerBg .newsTxt').click(function(e){
		if (e && e.stopPropagation) {//非IE浏览器
			e.stopPropagation();
		}else {//IE浏览器
			window.event.cancelBubble = true;
		}
	})
}
/*图片轮播动画 end*/