<g:set var="ossRoot" value="http://${grailsApplication.config.oss.endpointDomain}/${grailsApplication.config.oss.publicbucket}/"></g:set>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>找船网</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="keywords" content="找船网">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<link rel="stylesheet" type="text/css" href="../css/shiplist.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">

<script src="../js/jquery.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/js.js"></script>
<script src="../js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
 <style>
.a1{
 width:80px;
 heigth:100px;

 
} 
 </style>
</head>
<body>

	<div class="w960">
		<div class=" right release_single">
			<div class="head-title">
				<b></b> <span class="adds">订单管理</span> <span class="model">（<b>*</b>为必填项）
				</span>
			</div>
			<form action="/inqueryPrice/list">
				<div class="search_area" style="height:125px;">
					<ul class="list" style="width:930px;height:125px">					
						<li class="list-title" style="margin-right:10px;">订单编号</li>
						<li class="list-import" style="width:140px;margin-right:10px;">
							<input type="text" placeholder="请输入订单编号" name="order_id" id="order_id">
						</li>
						<li class="list-title" style="margin-right:10px;">起始港</li>
						<li class="list-import" style="width:140px;margin-right:10px;">
							<input type="text"  placeholder="请输入起始港"   name="start_port" id="start_port">
						</li>
						<li class="list-title" style="margin-right:10px;">目的港</li>
						<li class="list-import" style="width:140px;margin-right:10px;">
							<input type="text"  placeholder="请输入目的港"   name="end_port" id="end_port">
						</li>
						<li class="list-title" style="margin-right:10px;">船公司</li>
						<li class="list-import" style="width:140px;margin-right:10px;">
							<input type="text" placeholder="请输入船公司"   name="company_name" id="company_name">
						</li>
						<li class="list-title" style="margin-right:10px;margin-top:20px;">下单时间</li>
						<li class="list-import" style="width:140px;margin-right:10px;margin-top:20px;">
							<input type="text" placeholder="年/月/日"   name="order_time" id="order_time">
						</li>
						<li class="list-title" style="margin-right:10px;margin-top:20px;">订单状态</li>
						<li class="list-import" style="width:140px;margin-right:10px;margin-top:20px;">
							<select style="display:inline-block;display:inline;zoom:1;width:140px;height:40px; color:#A9A9A9;" name="status" id="status">
								<option value="" >-请选择订单状态-</option>
								<option value="UnCheck"  >审核中</option>
								<option value="InBooking" >订舱中</option>
								<option value="NoPass" >不通过</option>
								<option value="ShippingSpaced"  >已放舱</option>
								<option value="FailBooking" >订舱失败</option>
																					
							</select>
							
						</li>
						
						<li class="list-title" style="margin-right:10px;margin-top:20px;">有效期</li>
						<li class="list-import" style="width:140px;margin-right:0px;margin-top:20px;">
							<input type="text" placeholder="年/月/日"   name="start_date" id="start_date" style="width:80%">
							
						</li>
						<li class="list-import" style="width:140px;margin-right:0px;margin-top:20px;">
							<span>--</span>
							<input type="text" placeholder="年/月/日"   name="end_date" id="end_date" style="width:80%">
						</li>
					</ul>

					</div>
					<div style="width:100%;height:50px;">
						
						 <a href="javascript:void(0)" class="search-btn"   id="inquery" style="margin-top:0px;margin-left:405px;background:#FF9900">查询</a>
						
					</div>
					</form>
				<div  style="font-size:16px;color:#FF9900;height:30px;width:100%;">订单列表</div>	
				<div id="list"></div>
		</div>

		<div class="bookingManage backpage backship needtop"></div>
		<script>
	$(function(){	
			
		$("#inquery").click(function() {
			var orderId = $("#order_id").val()?$("#order_id").val().match(/\d+/g)[0]:"";
			
			var startPort = $("#start_port").val()
			var endPort = $("#end_port").val()
			var companyName = $("#company_name").val()
			var orderTime = $("#order_time").val()
			var status = $("#status").val()
			var startDate =$("#start_date").val()
			var endDate = $("#end_date").val()
			var params = {
				}	
			params['orderId'] = orderId;
			params['startPort'] = startPort;	
			params['endPort'] = endPort;	
			params['companyName'] = companyName;	
			params['orderTime'] = orderTime;
			params['status'] = status;
			params['startDate'] = startDate;
			params['endDate'] = endDate;								
					$.ajax({
								url : "/Booking/list",
								type : "post",
								cache : true,
						        dataType : "json",
								data :params,
								success : function(rs) {
									var result = rs["result"];
									var list = $("#list")
									//if (rs.statu == "0") {
									list.children().remove();
										var t = 0;
										for (i = 0; i <result.length; i++) {
											    var project=result[i]
											
											if (true) {
												++t
												var options ={};
												options["id"]=project.id;
												options["status"]=project.status;
												options["shipCompany"]=project.shipCompany;
												options["dateCreated"]=project.dateCreated;
												options["startPort"]=project.startPort;
												options["endPort"]=project.endPort;
												options["gp20Num"]=project.gp20Num;
												options["gp40Num"]=project.gp40Num;
												options["hq40Num"]=project.hq40Num;
												options["startDate"]=project.startDate;
												options["endDate"]=project.endDate;
												options["soFilePath"]=project.soFilePath;																							
												var model = inquery(options);
												
														//console.log('model---->',model);
												list.append(model);
												var $status = $(".status");
												var $20gp_box =$(".gp20_box");
												var $40gp_box =$(".gp40_box");
												var $40hq_box =$(".hq40_box");
												$20gp_box.each(function(){
													if($(this).html().trim()){
														 $(this).parent().html($(this).html().trim()+"*20GP").css({'color':'red'});
														}else{
															$(this).parent().hide();
															}

													})
													$40gp_box.each(function(){
													if($(this).html().trim()){
														 $(this).parent().html($(this).html().trim()+"*40HQ").css({'color':'red'});
														}else{
															$(this).parent().hide();
															}

													})
													$40hq_box.each(function(){
														if($(this).html().trim()){
															 $(this).parent().html($(this).html().trim()+"*40GP").css({'color':'red'});
															}else{
																$(this).parent().hide();
																}

														})
												
												
												$status.each(function(){
													
													if($(this).html().trim()==="已放舱"){
														var dataSo =$(this).parent().parent().next().children().find("a").attr("data-so");
														$(this).parent().parent().next().children().find("a").attr("href",dataSo).css({'color':'#0099FF'})
														}
												 })
												
											}
										}
										if (t == 0) {
											
											list.children().remove();
											 var orderEmpty =
												 [
													 '<div style="width:990px;height:300px;border:1px solid #ddd ">',
														'<div style="width:400px;height:100px;margin:50px auto;">',
															'<div style="float:left">',
																'<img src="../images/feature.png" style="margin:20px 0 0 20px">',
															'</div>',
															'<div style="float:left;margin-left:30px;margin-top:15px;">',
																'<h3 style="font-size:18px;color:#666666"> 对不起，没有查到您要的订单 </h3>',
																'<a href="/shipping.html" style="color:#0099FF;text-decoration:none;margin-top:10px;display:block;font-size:16px;margin-left:40px">去订舱>></a>',
															'</div>',
														'</div>',

													 '</div>'
														

													].join("")
											list .append(orderEmpty);

										    }
									} 
								
								//error:function(rs){
									//console.log(rs);
								//}
							})
						})
			
			})

			
			
            
	           
			
	function inquery(options) {
		var msgTpl = [


   ' <ul class="details">',
       ' <li class="fl  ">',
          '  <b>订单编号：</b>',
          '<s><a href="Booking/view?id='+options['id']+'">','cs'+options['id']+'wyl','</a></s>',
          //'<s><a href="javascript:void(0)">','cs'+options['id']+'wyl','</a></s>',
        '</li>',
        '<li class="fl ">',
        '<b>订单状态：</b>',		
        '<s class="status">',options['status'],'</s>',
   ' </li>',
        '<li class="fl ">',
            '<b>船公司：</b>',
            '<s>',options['shipCompany'],'</s>',
       ' </li>',
       ' <li class="fl">',
            '<b>下单时间：</b>',
            '<s>',options['dateCreated'],'</s>',
        '</li>',
        //'<li class="fl" style="width:200px;text-align:right">',
        //	'<b>S/O的编号：</b>',     	
        //	'<s>',options['dateCreated'],'</s>',
      //  '</li>',	

    '</ul>',
    '<ul class="details-info" style="height:100px;">',
      '  <li class="port fl" >',
            '<div  class="list-01" style="margin-top:15px;">',
             '   <div class="start-port">',options['startPort'],'</div>',
                '<div style="height:20px;"> <b class="arrow"></b>	</div>',
                '<div class="end-port">',options['endPort'],'</div>',
           ' </div>',
            
        '</li>',
        '<li class="cost fl price-area"  style="width:200px;">',
            '<div class="a1">',
				'<div style="width:100%;height:20px;">箱型</div>',
				'<div class="height:60px;">',
					'<div style="width:100%;height:20px;line-height:20px; font-size:12px;margin-top:10px;">',
					'<b style="font-weight:normal;color:red" class="gp20_box">',options['gp20Num'],'</b>*20GP',
					'</div>',
					'<div style="width:100%;height:20px;line-height:20px; font-size:12px;"><b style="font-weight:normal;color:red" class="gp40_box">',options['gp40Num'],'</b>*40GP</div>',
					'<div style="width:100%;height:20px;line-height:20px; font-size:12px;"><b style="font-weight:normal;color:red" class="hq40_box">',options['hq40Num'],'</b>*40HQ</div>',
				'</div>',		
        	'</div>',
       ' </li>',
        '<li class="shipping-date fl" style="width:300px;">',
        	'<div style="width:250px;height:70px;">',
				'<div style="width:100%;text-align:center">有效期</div>',
				'<div style="width:100%;margin-top:25px">',
					'<span>',options['startDate'],'</span>',
					'---',
					'<span>',options['endDate'],'</span>',
				'</div>',
			'</div>',
        '</li>',
        '<li class="shipping-date fl >',
    		'<div style="width:100%;height:50px;">',
				'<div style="width:100%;text-align:center">操作</div>',
				'<div style="width:100%;">',
					'<a href="javascript:void(0)"  data-so=" ','${ossRoot}',options["soFilePath"], ' " style="color:#b4b4b4;text-decoration:none;display:inline-block;margin-top:30px;">下载S/O</a>',
				'</div>',
			'</div>',
   		'</li>', 
   ' </ul>'
].join('');
		return msgTpl;
                //var list=$("#list");
               //this.$("#dateCreated").html(dateCreated)
               //list.append($(msgTpl));
               // return msgTpl
	}

	
	var orderId = $("#order_id").val()
	var startPort = $("#start_port").val()
	var endPort = $("#end_port").val()
	var companyName = $("#company_name").val()
	var orderTime = $("#order_time").val()
	var status = $("#status").val()
	var startDate =$("#start_date").val()
	var endDate = $("#end_date").val()
	var params = {
		}	
	params['orderId'] = orderId;
	params['startPort'] = startPort;	
	params['endPort'] = endPort;	
	params['companyName'] = companyName;	
	params['orderTime'] = orderTime;
	params['status'] = status;
	params['startDate'] = startDate;
	params['endDate'] = endDate;

	$("#order_time").datepicker();
	$("#start_date").datepicker();
	$("#end_date").datepicker();

	$.ajax({
		url : "/Booking/list",
		type : "post",
		cache : true,
        dataType : "json",
		data :params,
		success : function(rs) {
			var result = rs["result"];
			var list = $("#list")
			//if (rs.statu == "0") {
			list.children().remove();
				var t = 0;
				for (i = 0; i <result.length; i++) {
					    var project=result[i]
					
					if (true) {
						++t
						var options ={};
						options["id"]=project.id;
						options["status"]=project.status;
						options["shipCompany"]=project.shipCompany;
						options["dateCreated"]=project.dateCreated;
						options["startPort"]=project.startPort;
						options["endPort"]=project.endPort;
						options["gp20Num"]=project.gp20Num;
						options["gp40Num"]=project.gp40Num;
						options["hq40Num"]=project.hq40Num;
						options["startDate"]=project.startDate;
						options["endDate"]=project.endDate;
						options["soFilePath"]=project.soFilePath;																							
						var model = inquery(options);						
								//console.log('model---->',model);
						list.append(model);
						var $status = $(".status");
						var $20gp_box =$(".gp20_box");
						var $40gp_box =$(".gp40_box");
						var $40hq_box =$(".hq40_box");
						$20gp_box.each(function(){
							if($(this).html().trim()){
								 $(this).parent().html($(this).html().trim()+"*20GP").css({'color':'red'});
								}else{
									$(this).parent().hide();
									}

							})
							$40gp_box.each(function(){
							if($(this).html().trim()){
								 $(this).parent().html($(this).html().trim()+"*40HQ").css({'color':'red'});
								}else{
									$(this).parent().hide();
									}

							})
							$40hq_box.each(function(){
								if($(this).html().trim()){
									 $(this).parent().html($(this).html().trim()+"*40GP").css({'color':'red'});
									}else{
										$(this).parent().hide();
										}

								})
						
						
						$status.each(function(){
							
							if($(this).html().trim()==="已放舱"){
								var dataSo =$(this).parent().parent().next().children().find("a").attr("data-so");
								$(this).parent().parent().next().children().find("a").attr("href",dataSo).css({'color':'#0099FF'})
								}
						 })

						
					}
				}
				if (t == 0) {
					list.children().remove();
					 var orderEmpty =
						 [
							 '<div style="width:990px;height:300px;border:1px solid #ddd ">',
								'<div style="width:400px;height:100px;margin:50px auto;">',
									'<div style="float:left">',
										'<img src="../images/feature.png" style="margin:20px 0 0 20px">',
									'</div>',
									'<div style="float:left;margin-left:30px;margin-top:15px;">',
										'<h3 style="font-size:18px;color:#666666"> 对不起，您还没有订单</h3>',
										'<a href="/shipping.html" style="color:#0099FF;text-decoration:none;margin-top:10px;display:block;font-size:16px;margin-left:40px">去订舱>></a>',
									'</div>',
								'</div>',

							 '</div>'
								

							].join("")
					list .append(orderEmpty)
				    }
			} 
		
		//error:function(rs){
			//console.log(rs);
		//}
	})


		
		$("#more").click(function(){
            $("#list1").is(':hidden') === true ? $("#list1").show():$("#list1").hide();
            $("#list2").is(':hidden') === true ? $("#list2").show():$("#list2").hide();
           

         })
	
		$("#endDate").datepicker();
		$("#validityStratDate").datepicker();
		$("#validityEndDate").datepicker();
		
		
		
		
	
</script>
</body>
</html>