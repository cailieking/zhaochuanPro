<!DOCTYPE html>
<html>
<head>
<title>运价搜索</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/shipping_search.css" />
<asset:javascript src="/c_js/common.js" />
<asset:javascript src="/c_js/searchbox.js" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js"/>
</head>   
<body>
    <div class="manage_md_right">    
        <!--右侧主体-->
            <div class="rControlLine" id="searchPortBg">
            	<span class="label0">查询条件:</span>
            	<span class="label1">起始港:</span>
            	<input class="box1" type="text" name="startPort" id="start_port_input"/>
            	<span class="label1">目的港:</span>
            	<input class="box1" type="text" name="endPort" id="dest_port_input"/>
            	<span class="label1">船公司:</span>
            	<input class="box1" type="text" name="shipCompany" id="s_company_input"/>
            	<input style="display:none;" id="port_search_btn" />
            </div>
            <div class="rControlLine">
            	<!--  <span class="label1" style="margin-left:90px;">供应商:</span>
            	<input class="box1" type="text" name="companyName"/>-->
            	<span class="label1" style="margin-left:90px;">有效期:</span>
            	<input class="box1" type="text" style="width:150px;" name="startDate"  onClick="WdatePicker()"/>
            	<span class="label1" style="width:20px;">--</span>
            	<input class="box1" type="text" style="width:150px;" name="endDate" onClick="WdatePicker()"/>
            	
            	<select class="select1"  name="priceType" id="priceType" style="margin-left:15px;">
            		<option value="">全部运价</option>
            		<option value="forFront">对外运价</option>
            		<option value="forInner">对内运价</option>
            		
            	</select>
            	
            	<div id="search" class="btnL btnMod1">查询</div>
            </div>
            <div class="rControlLine">
            	<span class="txt1">查询结果：<span id="totalCount" style="color:#f00;">${map.total}</span></span>
            	<span class="txt1" style="color:#2a9de9;margin-left:400px;">蓝色为公开价</span>
            	<span class="txt1" style="color:#f00;">红色为优惠价</span>
            	<span class="txt1" style="float:right;" id='pageSize'>
            		<a href="#">10</a>
            		<a href="#">20</a>
            		<a href="#">50</a>
            		<a href="#">100</a>
            		<a href="#">200</a>
            	</span>
            	<span class="txt1" style="float:right;">每页记录数：</span>
            </div>
            <div class="rGridTop" style="width:1500px;">
            	<div class="w1">运价</div>
                <div class="w2">起始港</div>
                <div class="w3">目的港</div>
                <div class="w4">船公司</div>
                <div class="w5" onclick="shippingSort($(this))" data-type="gp20">20GP<span class="sort"></span></div>
                <div class="w6" onClick="shippingSort($(this))" data-type="gp40">40GP<span class="sort"></span></div>
                <div class="w7" onClick="shippingSort($(this))" data-type="hq40" >40HQ<span class="sort"></span></div>
                <g:if test="${map.user.role!='业务员'}">
                </g:if>
                <div class="w9" >船期</div>
                <div class="w8">有效期</div>
                <div class="w10">来源</div>
            </div>
           
            <input id="contactInfoText" value="${map.user.name }||${map.user.mobile }||${map.user.email }||来自找船网的真诚报价，保舱位！" style="display:none" />
            <ul class="shipping_search_list rGridList" style="width:1500px;">
            	<g:each in="${map.rows}" var="row" status="m">
            	<li>
            		<g:if test="${row.fromBy == '商务'}">
            		<div class="w01" id="w1"><div>${row.id}</div></div>
            		</g:if>
            		<g:else>
            		<div class="w1" id="w1"><div>${row.id}</div></div>
            		</g:else>
                	
                    <div class="w2">${row.startPort}</div>
                    <div class="w3" title="${row.endPort}">${row.endPort}</div>
                    <div class="w4">${row.shipCompany}</div>
                    <div class="w5">
                    	<div class="price1" title="${row.gp20?row.gp20:'-'}">${row.gp20?row.gp20:'-'}</div>
                    	<div class="price2" title="${row.gp20Vip?row.gp20Vip:'-'}">${row.gp20Vip?row.gp20Vip:'-'}</div>
                    </div>
                    <div class="w6">
                    	<div class="price1" title="${row.gp20Vip?gp20Vip:'-'}">${row.gp40?row.gp40:'-'}</div>
                    	<div class="price2" title="${row.gp40Vip?row.gp40Vip:'-'}">${row.gp40Vip?row.gp40Vip:'-'}</div>
                    </div>
                    <div class="w7">
                    	<div class="price1" title="${row.hq40?row.hq40:'-'}">${row.hq40?row.hq40:'-'}</div>
                    	<div class="price2" title="${row.hq40Vip?row.hq40Vip:'-'}">${row.hq40Vip?row.hq40Vip:'-'}</div>
					</div>
					<g:if test="${map.user.role!='业务员'}">
					</g:if>
                    <div class="w9" title="${row.shippingDay}" >${row.shippingDay}</div>
                     <div class="w8">${row.startDate}-${row.endDate}</div>
                    <div class="w10" >${row.fromBy}</div>
                </li>
                </g:each>
            </ul>
            <div class="search_log_bottom"></div><input  type="hidden" value="${map.total}"/>
             <div style="color:red">特别提醒：红色编号的价格为对内价格，不要对外发布！</div>
        <!--右侧主体-->
    </div>
<div class="winModBg0" style="display:none;">
	<div class="winModBg wEditMod shipping_details">
    	<div class="titleBg">
        	<div class="caption">运价详情<span class="shippingNum">运价编号：<span class="num"></span><span class="num2"></span></span></div>
            <div class="closeBtn">X</div>
        </div>
        <div class="details_content">
        	<div>
        		<div class="startPort">起始港：<span id="startPort"></span></div>
        		<div class="endPort">目的港：<span id="endPort"></span></div>
        	</div>
        	<!-- <div class="supplier">
        		<div class="dLabel">供应商：</div>
        		<div class="sName" id="supplier"></div>
        	</div> -->
        	<div class="priceBg">
        		<div class="dLabel">运&nbsp;&nbsp;&nbsp;费：</div>
        		<div class="pGrid">
        			<div class="boxtype">20GP</div>
        			<div class="price1"><span id="20GP_1"></span></div>
        			<div class="price2"><span id="20GP_2"></span></div>
        		</div>
        		<div class="pGrid">
        			<div class="boxtype">40GP</div>
        			<div class="price1"><span id="40GP_1"></span></div>
        			<div class="price2"><span id="40GP_2"></span></div>
        		</div>
        		<div class="pGrid">
        			<div class="boxtype">40HQ</div>
        			<div class="price1"><span id="40HQ_1"></span></div>
        			<div class="price2"><span id="40HQ_2"></span></div>
        		</div>
        	</div>
        	<div>
        		<div class="bg50" style="margin-right:8px;">
        			<div class="dLabel">船公司：</div>
        			<div class="bName" id="shipCompany"></div>
        		</div>
        		<div class="bg50">
        			<div class="dLabel">中转港：</div>
        			<div class="bName" id="mdPort"></div>
        		</div>
        	</div>
        	<div>
        		<div class="bg50" style="margin-right:8px;">
        			<div class="dLabel">船&nbsp;&nbsp;&nbsp;期：</div>
        			<div class="bName" id="shipDay"></div>
        		</div>
        		<div class="bg50">
        			<div class="dLabel">限&nbsp;&nbsp;&nbsp;重：</div>
        			<div class="bName" id="shipWeight"></div>
        		</div>
        	</div>
        	<div>
        		<div class="bg50" style="margin-right:8px;">
        			<div class="dLabel">航&nbsp;&nbsp;&nbsp;程：</div>
        			<div class="bName" id="shipLong"></div>
        		</div>
        		<div class="bg50">
        			<div class="dLabel">运输类型：</div>
        			<div class="bName" id="shipType"></div>
        		</div>
        	</div>
        	<div>
        		<div class="bg50" style="margin-right:8px;">
        			<div class="dLabel">有效期：</div>
        			<div class="bName" id="shipValidity"></div>
        		</div>
        		<div class="bg50">
        			
        		</div>
        	</div>
        	<div class="fjPrice">
        		<div class="dLabel">附加费：</div>
        		<ul class="fjPriceList" id="fjPriceList">
        			<li class="fTitle">
        				<div class="fw1">名称</div>
        				<div class="fw2">单位</div>
        				<div class="fw3">币种</div>
        				<div class="fw4">20GP</div>
        				<div class="fw5">40GP</div>
        				<div class="fw6">40HQ</div>
        				<div class="fw7">单票价格</div>
        			</li>
        		</ul>
        	</div>
        	<div class="mark">
        		<div class="dLabel">备&nbsp;&nbsp;&nbsp;注：</div>
        		<div class="mTxt" id="shipMark"></div>
        	</div>
        	
        </div>
        <div class="details_config">
        	<div class="chooseBg">
        		<!-- <div>
        			<div class="cLabel">供应商：</div>
        			<input type="checkbox" id="hideSupplier" />
        			<label for="hideSupplier">不显示供应商</label>
        		</div> -->
        		<div>
        			<div class="cLabel">运&nbsp;&nbsp;&nbsp;价：</div>
        			<input type="radio" id="hideBluePrice" name="hidePrice" />
        			<label for="hideBluePrice">不显示公开报价<span style="color:2a9de9;">(蓝色)</span></label>
        			<input type="radio" id="hideRedPrice" name="hidePrice" />
        			<label for="hideRedPrice">不显示优惠价<span style="color:f00;">(红色)</span></label>
        		</div>
        		<div>
        			<div class="cLabel">联系方式：</div>
        			<input type="checkbox" id="contactInfo" checked="checked" />
        			<label for="contactInfo">个人联系方式</label>
        		</div>
        	</div>
        	<div class="btnBg">
        		
        		<div class="cBtn btnMod1" id="shipping_details_close">关闭</div>
        		<div class="cBtn btnMod1" id="shipping_details_copy">复制运价到剪贴板</div>
        		<textarea id="shippingCopyText" style="width:0px;height:0px;opacity:0;filter:alpha(opacity=0);"></textarea>
        	</div>
        	
        </div>
        <div style = "text-align:center"><span  id="specialRemind" style="color:red;"></span></div>
        <div class="noCopyBg">
        	<div class="noCopy_close">X</div>
        	<div class="noCopy_txt">抱歉，由于浏览器版本或安全设置的原因，复制操作没能执行，你可以在下面文本框中手动复制。</div>
        	<textarea class="noCopy_area"></textarea>
        </div>
    </div>
</div>
<script>
var shippingDetailsInitHtml;
var searchArguments = {
		startPort:'',
		endPort:'',
	    shipCompany:'',
	    companyName:'',
		startDate:'',
		endDate:'',
		sort:'',
		priceType:'',
		order:''
}
var  pageSize = 10;
var dtd = $.Deferred();
$(function(){
	loadSearchData();//读取搜索输入框数据
	shippingDetailsInitHtml=$('.shipping_details').html();
	
	
	
	var total = $('.search_log_bottom').next().val()
	var pageTotal = total % pageSize > 0 ? Math.floor(total / pageSize) + 1 :  total / pageSize
			
	initTotalPage(pageTotal)
	
	/*$('.shipping_search_list .w1>div').on('click',function(){
		$('.shipping_details').parent().show();
		setEleMiddle($('.shipping_details'));//使元素居中
	});*/
	
	
	
	shippingDetailsEvent();//运价详情事件
		

	
	$("#search").click(function(){
		 searchArguments.startPort =	$("input[name=startPort]").val()
	    searchArguments.endPort = $("input[name=endPort]").val()
	    searchArguments.shipCompany = $("input[name=shipCompany]").val()
	   	searchArguments.priceType = $('#priceType').val()
		var mydate = new Date();
		var firstTime = mydate.getTime()
		$.when(InfoRelevantTime(dtd)).done(function(){
				var lastTime = new Date().getTime()
				var consuming = (lastTime - firstTime)/1000
				var resultCount = $("#totalCount").text()
				$.post("/shipInfo/saveInfoConsuming",{priceType:searchArguments.priceType,startPort:searchArguments.startPort,endPort:searchArguments.endPort,shipCompany: searchArguments.shipCompany ,resultCount:resultCount,consuming:consuming},function(data){
				})
			})
	});
	
	$('#pageSize >a').click(function(){
			pageSize = $(this).text()
			initPageData(dtd);
				
	})
	
	
	$('body').on('click','.shipping_search_list #w1>div',function(){
		var	id = $(this).text()
		$('#fjPriceList').empty();
			$.ajax({
						type:'post',
						url:"/shipInfo/data?id="+id,
						dataType:'json',
						data:searchArguments,
						success:function(rs){
								var fromBy = rs.cargo.fromBy
								if(fromBy=="商务"){
									$('.shippingNum .num2').text(rs.cargo.id+'(内部价格)')
									$('#specialRemind').text('特别提醒：以上价格为对内价格，不得向外发布！')
								}else{
									$('.shippingNum .num').text(rs.cargo.id)
								}
								
								$('#startPort').text(rs.cargo.startPort)
								$('#endPort').text(rs.cargo.endPort)
								//$('#supplier').text(rs.cargo.companyName)
								$('#20GP_1').text(rs.prices.gp20 || '-')
								$('#20GP_2').text(rs.prices.gp20Vip || '-')
								$('#40GP_1').text(rs.prices.gp40 || '-')
								$('#40GP_2').text(rs.prices.gp40Vip || '-')
								$('#40HQ_1').text(rs.prices.hq40 || '-')
								$('#40HQ_2').text(rs.prices.hq40Vip || '-')
								$('#shipCompany').text(rs.cargo.shipCompany)
								$('#mdPort').text(rs.cargo.middlePort ||'-')
								$('#shipDay').text(rs.cargo.shippingDay)
								$('#shipDay').attr("title",rs.cargo.shippingDay)
								$('#shipWeight').text(rs.cargo.weightLimit || '-')
								$('#shipLong').text(rs.cargo.shippingDays || '-')
								$('#shipType').text((rs.cargo.transType.name=='Whole')?'整箱':'拼箱')
								var startDate = new Date(rs.cargo.startDate).toLocaleDateString()
								var endDate = new Date(rs.cargo.endDate).toLocaleDateString()
								//var startDate = rs.cargo.startDate.substr(0,10)
								
								
								
								//var endDate = rs.cargo.endDate.substr(0,10)
								$('#shipValidity').text(startDate+'至'+endDate)
								$('#shipMark').text(rs.cargo.remark || '-')
								
							if(getStrLength(rs.prices.extra)>3){
								
								$('#fjPriceList').append('<li class="fTitle">'+
        								'<div class="fw1">名称</div>'+
        								'<div class="fw2">单位</div>'+
        								'<div class="fw3">币种</div>'+
        								'<div class="fw4">20GP</div>'+
        								'<div class="fw5">40GP</div>'+
        								'<div class="fw6">40HQ</div>'+
        								'<div class="fw7">单票价格</div>'+
        							'</li>')
        						if(rs.prices.extra != null){
        							var extra = rs.prices.extra.split(';')
									for(var i in extra){
									var extraSplit = extra[i].split('-')
									var genre;
									var cost;
									if(extraSplit.length>1){
										if(extraSplit[1].trim()=='box'){
												var genre = '箱'
										}else{
											var genre = '票'
										}
										
										if(extraSplit[5] != '0'){
											cost = extraSplit[5]
										}else{
											cost = '-'
										}
									$('#fjPriceList').append('<li>'+
        										'<div class="fw1 fName">'+extraSplit[0]+'</div>'+
        										'<div class="fw2">'+genre+'</div>'+
        										'<div class="fw3">'+extraSplit[6]+'</div>'+
        										'<div class="fw4">'+extraSplit[2]+'</div>'+
        										'<div class="fw5">'+extraSplit[3]+'</div>'+
        										'<div class="fw6">'+extraSplit[4]+'</div>'+
        										'<div class="fw7">'+cost+'</div>'+
        									'</li>'	)
									
									}
								
								}
        						}	
        						
        					}else{
        						$('#fjPriceList').html(rs.prices.extra);
        					}
							},
						error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
						}
	
		})
		
		$('.shipping_details').parent().show();
		setEleMiddle($('.shipping_details'));//使元素居中
	});
	

})


//获取'-'字符数量
				function getStrLength(str){
					if(/\-/i.test(str)){
						return str.match(/\-/ig).length;
					}
					return 0;
				}
//运价详情事件
function shippingDetailsEvent(){
	setEleMove($('.shipping_details .titleBg'));//通过标头拖动窗口
	//关闭窗口
	$('.shipping_details .closeBtn,#shipping_details_close').on('click',function(){
		$('.shipping_details').parent().hide();
		shippingDetailsReset();
	});
	//隐藏供应商
	/*$('#hideSupplier').on('click',function(){
		if($(this).prop('checked')==true){
			$('.details_content .supplier').hide();
		}else{
			$('.details_content .supplier').show();
		}
	});*/
	//隐藏价格
	$('input[name="hidePrice"]').on('click',function(){
		if($(this).attr('id')=='hideBluePrice'){
			$('.details_content .price1>span').hide();
			$('.details_content .price2>span').show();
		}
		if($(this).attr('id')=='hideRedPrice'){
			$('.details_content .price1>span').show();
			$('.details_content .price2>span').hide();
		}
	});
	$('.noCopy_close').click(function(){
		$('.noCopyBg').hide();
	})
	//复制运价
	$('#shipping_details_copy').on('click',function(){
		if($('#hideBluePrice').prop('checked')==false&&$('#hideRedPrice').prop('checked')==false){
			zcConfirm('运价详情包含公开报价和优惠价,是否继续!',function(re){
				if(re){
					copyShippingPrice();
				}
			});
		}else{
			copyShippingPrice();
		}
		/*if($('#hideSupplier').prop('checked')==false){
			zcConfirm('运价详情包含供应商,是否继续!',function(r){
				if(r){
					if($('#hideBluePrice').prop('checked')==false&&$('#hideRedPrice').prop('checked')==false){
						zcConfirm('运价详情包含公开报价和优惠价,是否继续!',function(re){
							if(re){
								copyShippingPrice();
							}
						});
					}else{
						copyShippingPrice();
					}
				}
			});
		}else if($('#hideBluePrice').prop('checked')==false&&$('#hideRedPrice').prop('checked')==false){
			zcConfirm('运价详情包含公开报价和优惠价,是否继续!',function(re){
				if(re){
					copyShippingPrice();
				}
			});
		}else{
			copyShippingPrice();
		}*/
	});
}	
function shippingDetailsReset(){
	$('.shipping_details').html(shippingDetailsInitHtml);
	shippingDetailsEvent();
}
//复制运价
function copyShippingPrice(){
	
	$('#shippingCopyText').html('');
	var shippingText="";
	shippingText+='------------------------------------------------------------------------------------------------------------&#13;&#10;';
	/*if($('#hideSupplier').prop('checked')!=true){
		shippingText+='供应商：'+$('#supplier').html()+'&#13;&#10;';//供应商
	}*/
	shippingText+='起始港：'+$('#startPort').html()+'&#13;&#10;';//起始港
	shippingText+='目的港：'+$('#endPort').html()+'&#13;&#10;';//目的港
	//运费
	if($('#hideRedPrice').prop('checked')==true){
		shippingText+='运费：20GP '+$('#20GP_1').html()+'     40GP '+$('#40GP_1').html()+'     40HQ '+$('#40HQ_1').html()+'&#13;&#10;';
	}
	if($('#hideBluePrice').prop('checked')==true){
		shippingText+='运费：20GPvip '+$('#20GP_2').html()+'     40GPvip '+$('#40GP_2').html()+'     40HQvip '+$('#40HQ_2').html()+'&#13;&#10;';
	}
	if($('#hideBluePrice').prop('checked')==false&&$('#hideRedPrice').prop('checked')==false){
		shippingText+='运费：20GP '+$('#20GP_1').html()+' '+$('#20GP_2').html()+'    40GP '+$('#40GP_1').html()+' '+$('#40GP_2').html()+'    40HQ '+$('#40HQ_1').html()+' '+$('#40HQ_2').html()+'&#13;&#10;';
	}
	//运费end
	shippingText+='船公司：'+$('#shipCompany').html()+'&#13;&#10;';//船公司
	shippingText+='中转港：'+$('#mdPort').html()+'&#13;&#10;';//中转港
	shippingText+='船期：'+$('#shipDay').html()+'&#13;&#10;';//船期
	shippingText+='限重：'+$('#shipWeight').html()+'&#13;&#10;';//限重
	shippingText+='运输类型：'+$('#shipType').html()+'&#13;&#10;';//运输类型
	shippingText+='航程：'+$('#shipLong').html()+'&#13;&#10;';//航程
	shippingText+='有效期：'+$('#shipValidity').html()+'&#13;&#10;';//有效期
	//附加费
	shippingText+='附加费：&#13;&#10;';
	if($('#fjPriceList li').length>1){
		for(var i=1;i<$('#fjPriceList li').length;i++){
			var thisLi=$('#fjPriceList li').eq(i);
			if(thisLi.find('.fw2').html()=="票"){
				shippingText+=thisLi.find('.fw1').html()+'：'+thisLi.find('.fw3').html()+thisLi.find('.fw7').html()+'/票；&#13;&#10;'
			}
			if(thisLi.find('.fw2').html()=="箱"){
				shippingText+=thisLi.find('.fw1').html()+
				'：20GP '+thisLi.find('.fw3').html()+thisLi.find('.fw4').html()+'/箱，'+
				'40GP '+thisLi.find('.fw3').html()+thisLi.find('.fw5').html()+'/箱，'+
				'40HQ '+thisLi.find('.fw3').html()+thisLi.find('.fw6').html()+'/箱；&#13;&#10;';
			}
		}
	}else{
		//shippingText+=$('#fjPriceList').html()+'&#13;&#10;';
		if($('#fjPriceList li').length>0){
			shippingText+='&#13;&#10;';
		}else{
			shippingText+=$('#fjPriceList').html()+'&#13;&#10;';
		}
	}
	//附加费end
	//备注
	shippingText+='备注：&#13;&#10;';
	shippingText+=$('#shipMark').html()+'&#13;&#10;';
	//备注end
	shippingText+='------------------------------------------------------------------------------------------------------------&#13;&#10;';
	//联系信息
	if($('#contactInfo').prop('checked')==true){
		var contactInfoAry=$('#contactInfoText').val().split('||');
		shippingText+=
		'联系信息：&#13;&#10;'+
		'姓名：'+contactInfoAry[0]+'&#13;&#10;'+
		'电话：'+contactInfoAry[1]+'&#13;&#10;'+
		'email：'+contactInfoAry[2]+'&#13;&#10;'+
		contactInfoAry[3]+'&#13;&#10;'+
		'------------------------------------------------------------------------------------------------------------';
	}
	//联系信息 end

	$('#shippingCopyText').html(shippingText);
	$('#shippingCopyText').get(0).select();
	if(document.execCommand("Copy")){
		document.execCommand("Copy");
		zcConfirm3("复制成功");
	}else{
		$('.noCopy_area').html($('#shippingCopyText').html());
		$('.noCopyBg').show();
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
	start_port_list =  sPort;
	end_port_list = ePort;
	s_company_list = companyData;
	$('#searchPortBg').searchComp({
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

function shippingSort(ele){
	var sorts=$('.rGridTop .sort');
	var sortType=ele.attr('data-type');
	for(var i=0;i<sorts.length;i++){
		if(sorts.eq(i).parent().attr('data-type')!=sortType){
			sorts.eq(i).html('');
		}
	}
	var sortNum=ele.find('.sort').html();
	searchArguments.sort = sortType
	console.log(searchArguments.sort)
	if(sortNum=='↑'){
		ele.find('.sort').html('↓');
		searchArguments.order = "desc"
	}else if(sortNum="↓"){
		ele.find('.sort').html('↑');
		searchArguments.order = "asc"
	}else if(sortNum=""){
		ele.find('.sort').html('↑');
		searchArguments.order= "asc"
	}
	var total = $('.search_log_bottom').next().val()
	var pageTotal = total % pageSize > 0 ? Math.floor(total / pageSize) + 1 :  total / pageSize
	initPageData(dtd)
}

	
	function init(data){
			$("#totalCount").text(data.total)
			$(".rGridList").empty()
				var rows = data.rows
				var body = ''
				var idStr = ''
				for(i in rows){
				
					if(rows[i].fromBy=='商务'){
						 idStr = '<div class="w01" id="w1"><div>'+rows[i].id+'</div></div>'
					}else{
						 idStr = '<div class="w1" id="w1"><div>'+rows[i].id+'</div></div>'
					}
						var gp20Vip = (rows[i].gp20Vip==undefined)?'-':rows[i].gp20Vip.toFixed(2)
						var gp40Vip = (rows[i].gp40Vip==undefined)?'-':rows[i].gp40Vip.toFixed(2)
						var hq40Vip = (rows[i].hq40Vip==undefined)?'-':rows[i].hq40Vip.toFixed(2)
						var gp20  = (rows[i].gp20==undefined)?'-':rows[i].gp20.toFixed(2)
						var gp40 = (rows[i].gp40==undefined)?'-':rows[i].gp40.toFixed(2)
						var hq40 = (rows[i].hq40==undefined)?'-':rows[i].hq40.toFixed(2)
						body += '<li>'+
		                	idStr+
		                    '<div class="w2">'+rows[i].startPort+'</div>'+
		                    '<div class="w3">'+rows[i].endPort+'</div>'+
		                    '<div class="w4">'+rows[i].shipCompany+'</div>'+
		                    '<div class="w5">'+
		                    	'<div class="price1">'+gp20+'</div>'+
		                    	'<div class="price2">'+gp20Vip+'</div>'+
		                    '</div>'+
		                    '<div class="w6">'+
		                    	'<div class="price1">'+gp40+'</div>'+
		                    	'<div class="price2">'+gp40Vip+'</div>'+
		                    '</div>'+
		                    '<div class="w7">'+
		                    	'<div class="price1">'+hq40+'</div>'+
		                    	'<div class="price2">'+hq40Vip+'</div>'+
							'</div>'+
							//'<div class="w8">'+rows[i].companyName+'</div>'+
		                    '<div class="w9" title="'+rows[i].shippingDay+'">'+rows[i].shippingDay+'</div>'+
		                    '<div class="w8">'+rows[i].startDate+'-'+rows[i].endDate+'</div>'+
		                    '<div class="w10">'+rows[i].fromBy+'</div>'+
		                '</li>'
				}
			$('.rGridList').append(body)
	
	}
function initTotalPage(pageTotal){
		
		setCommonPage2Event($('.search_log_bottom'),pageTotal,function(num){//初始化翻页控件 common.js中定义
			
			searchArguments.startPort = $("input[name=startPort]").val()
			searchArguments.endPort = $("input[name=endPort]").val()
			searchArguments.shipCompany = $("input[name=shipCompany]").val()
			//searchArguments.companyName = $("input[name=companyName]").val()
			searchArguments.startDate = $("input[name=startDate]").val()
			searchArguments.endDate = $("input[name=endDate]").val()
			
			/*$.post("/shipInfo/list",{offset:num-1,limit:pageSize,searchArguments,state:true},function(data){
					init(data)
			})*/
			//zcAlert(num+'页');
			var currentPage = (num-1)*pageSize
			$.ajax({
				type:'post',
				url:'/shipInfo/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
				dataType:'json',
		     	data:searchArguments,
				success:function(rs){
					init(rs)
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					console.log(XMLHttpRequest)
					console.log(textStatus)
					console.log(errorThrown)
				}
		});
		})
	}
	
	var initPageData = function(dtd){
			searchArguments.startPort = $("input[name=startPort]").val()
			searchArguments.endPort = $("input[name=endPort]").val()
			searchArguments.shipCompany = $("input[name=shipCompany]").val()
			//searchArguments.companyName = $("input[name=companyName]").val()
			searchArguments.startDate = $("input[name=startDate]").val()
			searchArguments.endDate = $("input[name=endDate]").val()
			var currentPage = 0
				$.ajax({
						type:'post',
						url:'/shipInfo/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
						dataType:'json',
						data:searchArguments,
						success:function(rs){
								init(rs)
								var pageTotal = rs.total % pageSize > 0 ? Math.floor(rs.total / pageSize) + 1 :  rs.total / pageSize
								initTotalPage(pageTotal)
								dtd.resolve()
								
							},
						error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
						}
	
		})
		}
		var InfoRelevantTime = function(dtd){
		initPageData(dtd);
		return dtd
	}
	  

	
</script>
</body>
</html>