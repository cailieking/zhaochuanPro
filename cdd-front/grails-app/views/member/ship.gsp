 	<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/module/common.min.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/module/lib_pack.css">
<link rel="stylesheet" type="text/css" href="../css/module/memberShip.min.css">
<script src="../js/module/lib_pack.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="../js/module/common.min.js"></script>
</head>
<body>

	<div class="w960">
		<form id="myform" method="post" action="/Ship/issue">
			<div class="right release_single">
				<div class="head-title">
					<b></b> 
					<span class="adds">新增运价</span>
					 <span class="model">（<b>*</b>为必填项）</span>
				</div>
				<div class="content">
					<ul class="info_freight">
						<li>
							<div class="title_area">
								<b class="title">*</b>
								<span>起始港</span>
							</div>
							<div class="input_area">
								<input type="text" name="startPort"  class="region">
							</div>							
						</li>
						<li>
							<div class="title_area">
								<b class="title">*</b>
								<span>目的港</span>
							</div>
							<div class="input_area">
								<input type="text" name="endPort"  class="region">
							</div>							
						</li>
						<li>
							<div class="title_area">
								<b class="title">*</b>
								<span>直航/中转</span>
							</div>
							<div class="input_area">
								<input type="radio" name="route_style"  checked value="direact">直航
								<input type="radio" name="route_style"  class="" style="margin-left:50px;" value="middle" >中转
								<span class="middle_port" style="margin-left:150px;display:none"> 
									<b style="font-weight:normal">中转港</b>
								<input type="text" name="middlePort" class="region" style="margin-left:10px;widht:80px;">
								</span>
							</div>							
						</li>
						<li>
							<div class="title_area">
								<b class="title">*</b>
								<span>航程</span>
							</div>
							<div class="input_area">
								<input type="text" name="shippingDays"  class="region">
							</div>							
						</li>
						<li>
							<div class="title_area">
								<b class="title">*</b>
								<span>船公司</span>
							</div>
							<div class="input_area" style="position:relative">
								<input type="text" name="shipCompany"  class="region">
								<div class="shipping-company-list" style="width: 0; display: none;z-index:1000;left:210px;top:-100px;background:#F3F3F3">
												<h3 style="margin:5px;">
												请选择船公司
												<%--<span style="color:red;font-size:12px;font-weight:normal"></span>
												--%></h3>
												<div class="list-title">A-G</div>
												<ul class="listOne">

													<li>ANL</li>
													<li>APL</li>
													<li>CMA</li>
													<li>COSCO</li>
													<li>CSCL</li>
													<li>DELMAS</li>
													<li>EMC</li>
													<li>ESL</li>
												</ul>
												<div class="list-title">H-J</div>
												<ul class="listTwo">
													<li>HMM</li>
													<li>HPL</li>
													<li>IAL</li>
													<li>HANJIN</li>
													<li style="width: 90px;">HEUNG-A</li>
													<li style="width: 100px;">HAMBURG-SUD</li>
												</ul>
												<div class="list-title">K-N</div>
												<ul class="listThree">
													<li>K-LINE</li>
													<li>KMTC</li>
													<li>MARIANA</li>
													<li>MCC</li>
													<li>MOL</li>
													<li>MSC</li>
													<li>MSK</li>
													<li>NYK</li>
													<li style="width: 100px;">NAMSUNG</li>
												</ul>
												<div class="list-title">O-Z</div>
												<ul class="listFour">

													<li>OOCL</li>
													<li>PHL</li>
													<li>PIL</li>
													<li>RCL</li>
													<li>SAF</li>
													<li>SITC</li>
													<li>TSL</li>
													<li>UASC</li>
													<li>WHL</li>
													<li>YML</li>
													<li>ZIM</li>
													<li style="width: 100px;">SINOTRANS</li>
												</ul>									
											<div class="list-title" style="margin-top:5px;">其他</div>
											<ul style="width:410px;float:left">
											<li style="width:360px;margin:5px;">
											不指定船公司
											<%--<span style="color:red;font-size:12px;">(如以上没有您要的船公司或者您无需指定船公司请选择其他)</span>
											--%></li>
											
											</ul>
								</div>			
							</div>							
						</li>
						<li>
							<div class="title_area" style="float:left">
								<b class="title">*</b>
								<span>船期</span>
							</div>
							<div class="input_area shipping_date_area"  >
							<div class="shipping_date">
								<div  class="stopping_date">
								  <b  class="minus"></b>
                                   <input type="text" class="num_box" name="">
                                   <b class="addition"></b>
                                   	<span style="line-height:30px;margin-left:5px;">截</span>			
                                 </div>
                                 <div  class="starting_date">
								  <b  class="minus"></b>
                                   <input type="text" class="num_box" name="">
                                   <b class="addition"></b>
									<span style="line-height:30px;margin-left:5px;">开</span>
                                 </div>
                                 <div class="add_shipping_date">
                                 	<a href="javascript:void(0)" class='add_shipping_btn'></a>
                                 </div>
							 </div>
							</div>							
							<input type='hidden' name="total_shipping_date"  >
						</li>
						<li>
							<div class="title_area">
								<b class="title">*</b>
								<span>运输类型</span>
							</div>
							<div class="input_area">
								<input type="radio" name="box_style" checked  value="Whole">整箱
								<input type="radio" name="box_style"  value="Together" style="margin-left:50px;">拼箱
							</div>
												
						</li>
						<li>
							
							<div class="title_area">
								<b class="title">*</b>
								<span>有效期</span>
							</div>
							<div class="input_area">
								<input type="text" name="startDate"  class="region">
								<span>至</span>
								<input type="text" name="endDate"  class="region">
							</div>
												
						</li>
						<li style="width:100%;height:85px;"  class="route_price">
							
							<div class="" style="width:100%;margin-top:20px;">
								<b class="title" style="color:red;margin-left:60px;">*</b>
								<span>运费<b  style=" font-weight:normal;color:red;font-size:12px">(至少填写一种费用)</b></span>
							</div>
							<div class="box_price_area">
								<ul class="box_price">
									<li class="list">
										<div style="height:30px;">
											<span class="box_name"></span>
											<span class="commom_price">普通价</span>
											<span class="special_price">会员价</span>
											
										</div>
										<div>
											<span class="box_name">20GP</span>
											<span class="commom_price" >
												<input type="text"  name='gp20_commom_price' class="normal_price" >
											</span>
											<span class="special_price" >
												<input type="text" name='gp20_specical_price' class="specical_prcie" >
											</span>
											
										</div>
									</li>
									<li class="list">
										<div style="height:30px;">
											<span class="box_name"></span>
											<span class="commom_price">普通价</span>
											<span class="special_price">会员价</span>
											
										</div>
										<div>
											<span class="box_name">40GP</span>
											<span class="commom_price" >
												<input type="text"  name='gp40_commom_price' class="normal_price" >
											</span>
											<span class="special_price" >
												<input type="text" name='gp40_specical_price' class="specical_prcie" >
											</span>
											
										</div>
									</li>
									<li class="list">
										<div style="height:30px;">
											<span class="box_name"></span>
											<span class="commom_price">普通价</span>
											<span class="special_price">会员价</span>
											
										</div>
										<div>
											<span class="box_name">40HQ</span>
											<span class="commom_price" >
												<input type="text"  name='hq40_commom_price' class="normal_price" >
											</span>
											<span class="special_price" >
												<input type="text" name='hq40_specical_price'  class="specical_prcie" >
											</span>
											
										</div>
									</li>
								</ul>
							</div>
												
						</li>
						<li class="together_style" style="display:none">
							<ul>
								<li>
									<div class="title_area">
										<b class="title">*</b>
										<span>单价(USD/CBM)</span>
									</div>
									<div class="input_area">
										<input type="text" name="per_price"  class="region">
									</div>
								</li>
								<li>
									<div class="title_area">
										<b class="title">*</b>
										<span>最低消费(USD)</span>
									</div>
									<div class="input_area">
										<input type="text" name="min_charge"  class="region">
									</div>
								</li>
								<li>
									<div class="title_area">
										<b class="title"></b>
										<span>始发仓库</span>
									</div>
									<div class="input_area">
										<input type="text" name="starting_depot"  class="region">
									</div>
								</li>
							</ul>
						</li>
						<li>
							<div class="" style="width:100%;margin-top:20px;">
								<b class="title" style="color:red;margin-left:60px;"></b>
								<span>附加费<b  style=" font-weight:normal;color:red;font-size:12px">(如无则不用填)</b></span>
							</div>
							<div class="main-content">
							</div>
							<input type='hidden' name="total_local_cost"  >
						</li>
						
						<%--<li>
							<div class="title_area" style='float:left'>
								<b class="title"></b>
								<span>其他</span>
							</div>
							<div class="input_area">
								<textarea  name="other" class="other" placeholder="附加费，数字，币种"></textarea>
							</div>							
						</li>
						--%><li>
							<div class="title_area" >
								<b class="title"></b>
								<span>限重(T)</span>
							</div>
							<div class="input_area">
								<input type="text" name="limit_weight"  class="region" style="margin-left:-3px;">
							</div>							
						</li>
						<li>
							<div class="title_area" style='float:left'>
								<b class="title"></b>
								<span>备注</span>
							</div>
							<div class="input_area">
								<textarea  class="remark"  name="remark" maxlength="150" placeholder="请控制其他在150字以内" maxlength="100"></textarea>
							</div>							
						</li>
					<li>
						<div class="btn_area">
							<a href="javascript:void(0)" class="make_sure"></a>
							<a href="javascript:void(0)" class="cancel"></a>
							<a href="javascript:void(0)" class="back"></a>
						</div>
					
					</li>	
					</ul>
					
				</div>
			</div>
		</form>
	</div>
	<div class=" shipPrice backpage backship needtop"></div>
	<script>
 $(function(){
	 loadScript({
		 url:'memberShip.min.js',
		 isPackNeed:true

		 });
 })
</script>

</body>
</html>