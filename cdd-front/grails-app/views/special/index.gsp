<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta name="description" content="港口 - 找船网">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/biz/biz.css">
<link rel="stylesheet" type="text/css" href="/css/index/index.css">
<link rel="stylesheet" type="text/css" href="/css/commodity_price_page/special-offer.css">
<script src="/js/jquery.js"></script>
<script src="/js/js.js"></script>
<script src="/js/common.js"></script>
<script src="/js/commodity_price_page/special-offer.js"></script>
 <script>
 $(function(){
	    var settingDateStr = settingDateStr ;
	   // var settingDate = new Date(Date.parse(settingDateStr.replace(/-/g,"/")));
	     var currentDate = new Date().getTime();
	    var mainAreaList = $('.main-area-list');
        var routeData =  mainAreaList.toArray();
        var collection = routeData.sort(function(item1,item2){
        	   var shippingEndDate1 = $(item1).find('.shipping-end-date').html();
        	       shippingEndDate1 = new Date(Date.parse(shippingEndDate1.replace(/-/g,"/")));
        	   var shippingEndDate2 = $(item2).find('.shipping-end-date').html();
        	       shippingEndDate2 = new Date(Date.parse(shippingEndDate2.replace(/-/g,"/")));
        	       if(shippingEndDate1 > currentDate && shippingEndDate2 > currentDate){
            	       return shippingEndDate1.getTime() -shippingEndDate2.getTime(); 
            	    }
        	   return  shippingEndDate2.getTime() -shippingEndDate1.getTime(); 
        	   
            })
	    
	    var countdouwnEnd = function(el){
			if(el.length === 0)return;
			var el = el;
			return function(){
				el.html('<div class="main-area-list-box">\
				<p>限时特价 坐等抢购</p>\
				<a >点击订舱</a>\
				</div>').addClass("main-area-list-li");
				el.click(function(){
					window.location.href="http://www.zhao-chuan.com";
				})
			 }
		 };
			
	   
	    $.each(collection,function(index,item){
		     var ind = ++index;
	    	 var shippingEndDate = $(item).find('.shipping-end-date').html();
	    	 timer_1(shippingEndDate,$('#infoid'+ind),countdouwnEnd($('#discount-item-'+index)));
		 });
	    placeElCentre($('.special-header>img'));
	    placeElCentre($('.main-area'));
	    $('.special-routes>img').css({marginLeft:$('.special-header>img').css('margin-left')} );
	    $(".box-ul-four span").each( function(){
				var box_price =parseInt($(this).html().substr(1));
				$(this).text("$"+box_price);
	    });
	    $(".routes-inf s").each(function(){
		  var $shippingDay=  $(this).html().length;
		  if($shippingDay>10){
			  $(this).html($(this).html().substr(0,10)+"...")

			  }
		    });
   
     
	})
	 
 </script>
</head>
<body style="overflow-x:hidden">
<div class="special-offer-area" >
	<div class="special-header">
		<img src="../images/commodity_price_page/main-ad.png" alt="图片" title="main-ad"/>
	</div>
	<div class="special-routes">
		<img src="../images/commodity_price_page/sp-title.png" alt="指示"/>
	</div>
	<div class="main-area">
		<g:each  in="${map.data.cargoShip.list}" var="d" status="b">
		<ul class="main-area-list">
			<li  id="discount-item-${b+1}" onclick="window.location.href='/publish/findship?infoId=${d.infoId }&startPort=${d.startPort }&endPort=${d.endPort }'">
				<div class="main-area-list-box">
					<ul class="box-ul">
						<li class="box-ul-one">
							<b></b>
							<span id="infoid${b+1}"></span>
						</li>
						<li class="box-ul-two">
							<b>${d.startPort}</b>
							<img src="../images/commodity_price_page/down-arrow.png" alt="down-arrow">
							<b>${d.endPort}</b>
						</li>
						<li class="box-ul-three">
							<span style="margin-right:9px">20'GP</span>
							<span style="margin-right:9px">40'GP</span>
							<span >40'HQ</span>
						</li>
						<li class="box-ul-four">
							
							<span style="margin-right: 8px">$${d.gp20}</span>
							<span style="margin-right: 8px">$${d.gp40}</span>
							<span >$${d.hq40 }</span>
							<g:javascript>
								
							</g:javascript>
						</li>
						<li class="box-ul-five">
							<ul class="routes-inf">
								<li>
									<b>船期:</b>
									
									<s title=${d.shippingDay}>${d.shippingDay}</s>
								</li>
								<li>航程：<b>${d.shippingDays }天</b></li>
								<li>
									有效期: <span>${d.startDate }</span>至 <span class="shipping-end-date">${d.endDate }</span>
								</li>
								<li class="box-ul-six" >
									<a href="javascript:void(0)">点击订舱</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</li>
	
		</ul>
        </g:each>
        <div></div>
	</div>
</div>
	<div style="clear: both"></div>
	<div class="specialpage needtop needsearch needservice"></div>
</body>
</html>