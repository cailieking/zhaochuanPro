<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>港口 - 找船网</title>
<meta name="keywords" content="找船网">
<meta name="description" content="找船网">
<!-- <link rel="stylesheet" type="text/css" href="../css/module/common.min.css">-->
<link rel="stylesheet" type="text/css" href="../css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/module/lib_pack.css">
<link rel="stylesheet" type="text/css" href="../css/cargoInquery.css">
<script src="../js/module/lib_pack.js"></script>
<!--<script src="../js/module/common.min.js"></script>-->
<script src="../js/c_js/common.js"></script>
</head>
<body>
	<div class="booking_bannerBg0">
    </div>
	<div>
		
		<!-- <div class="headline">
			<h2>根据运价详情，您可以通过在线提交表单，QQ,或找船网热线电话进行询价。</h2>
		</div> -->
			<div id="shipping-inf" class="shipping-inf" style="height:2330px">
		    <g:if test="${data}">
				<h3>
					编号：${data.id}
					<input type="hidden" name="infoId" value="${data.id}"> 
				</h3>
				<div class="inf">
					<ul style="border-color: #dfdfdf">
						<!--<li class="list-one">
							<div>
								<div class="route">
									<b class="start-port"> 
									</b>
									<div class="line"></div>
									<b class="end-port"> 
									</b>
								</div>
								<div class="split"></div>
								<div class="anchor">
									<a class="text" href="#submitOnline"></a>
									<a class="QQ" href="#qqOnline"></a>
									<a class="tel" href="#telOnline"></a>
								</div>
							</div>
						</li>-->
						<div class="list-one">
			                <div class="start-port">${data.startPort}</div>
			                <div class="end-port">${data.endPort}</div>
			            </div>
						<li class="list-two">
						
							<h3 class="title">运&nbsp;费:</h3>
							<ul class="price-box">
							<g:if test="${data.companyName =='泛亚航运'}">
								<li class="price-20gp">
									<div class="box-style">20GP</div>
									<div class="price" id="price-20gp">
									
										<g:if test="${data.companyName =='深圳市长帆国际物流有限公司'}">
										<span class='gp20' style="color:#329AEF">
										￥<g:if test="${data.prices && data.prices.gp20&&data.prices.gp20>500}">${data.prices.gp20 +100}
										</g:if><g:else>
										${data.prices.gp20 +50}
										</g:else>
										</span>
										</g:if><g:else>
										<span class='gp20' style="color:#329AEF">
										￥<g:if test="${data.prices && data.prices.gp20}">${data.prices.gp20}
										</g:if>
										</span>
										</g:else>
										
										<b>|</b>
										<span class='gp20Vip' style="color:red;">￥<g:if test="${data.prices && data.prices.gp20Vip}">${data.prices.gp20Vip}
										</g:if>
										</span>
										
									</div>

								</li>
								<li style="width: 10px;">
									<div class="split-line"></div>
								</li>
								<li class="price-40gp">
									<div class="box-style">40GP</div>
									<div class="price" >
									<g:if test="${data.companyName =='深圳市长帆国际物流有限公司'}">
										<span class='gp40' style="color:#329AEF">￥<g:if test="${data.prices && data.prices.gp40&&data.prices.gp40>500}">${data.prices.gp40+100}
										</g:if><g:else>
										${data.prices.gp40+50}
										</g:else>
										</span>
									</g:if><g:else>
										<span class='gp40' style="color:#329AEF">￥<g:if test="${data.prices && data.prices.gp40}">${data.prices.gp40}
										</g:if>
										</span>
									</g:else>
										<b>|</b>
										<span class='gp40Vip' style="color:red;">￥<g:if test="${data.prices && data.prices.gp40Vip}">${data.prices.gp40Vip}
										</g:if>
										</span>
									</div>
								</li>
								<li style="width: 10px;">
									<div class="split-line"></div>
								</li>
								<li class="price-40hq">
									<div class="box-style">40HQ</div>
									<div class="price" >
									<g:if test="${data.companyName =='深圳市长帆国际物流有限公司'}">
										<span class='hq40' style="color:#329AEF">￥<g:if test="${data.prices && data.prices.hq40&& data.prices.hq40>500}">${data.prices.hq40+100}
										</g:if><g:else>
										${data.prices.hq40+50}
										</g:else>
										</span>
									</g:if><g:else>
										<span class='hq40' style="color:#329AEF">￥<g:if test="${data.prices && data.prices.hq40}">${data.prices.hq40}
										</g:if>
										</span>
									</g:else>
										<b>|</b>
										<span class='hq40Vip' style="color:red;">￥<g:if test="${data.prices && data.prices.hq40Vip}">${data.prices.hq40Vip}
										</g:if>
										</span>
									</div>
								</li>
							</g:if><g:else>
							
							<li class="price-20gp">
									<div class="box-style">20GP</div>
									<div class="price" id="price-20gp">
									
										<g:if test="${data.companyName =='深圳市长帆国际物流有限公司'}">
										<span class='gp20' style="color:#329AEF">
										$<g:if test="${data.prices && data.prices.gp20&&data.prices.gp20>500}">${data.prices.gp20 +100}
										</g:if><g:else>
										${data.prices.gp20 +50}
										</g:else>
										</span>
										</g:if><g:else>
										<span class='gp20' style="color:#329AEF">
										$<g:if test="${data.prices && data.prices.gp20}">${data.prices.gp20}
										</g:if>
										</span>
										</g:else>
										
										<b>|</b>
										<span class='gp20Vip' style="color:red;">$<g:if test="${data.prices && data.prices.gp20Vip}">${data.prices.gp20Vip}
										</g:if>
										</span>
										
									</div>

								</li>
								<li style="width: 10px;">
									<div class="split-line"></div>
								</li>
								<li class="price-40gp">
									<div class="box-style">40GP</div>
									<div class="price" >
									<g:if test="${data.companyName =='深圳市长帆国际物流有限公司'}">
										<span class='gp40' style="color:#329AEF">$<g:if test="${data.prices && data.prices.gp40&&data.prices.gp40>500}">${data.prices.gp40+100}
										</g:if><g:else>
										${data.prices.gp40+50}
										</g:else>
										</span>
									</g:if><g:else>
										<span class='gp40' style="color:#329AEF">$<g:if test="${data.prices && data.prices.gp40}">${data.prices.gp40}
										</g:if>
										</span>
									</g:else>
										<b>|</b>
										<span class='gp40Vip' style="color:red;">$<g:if test="${data.prices && data.prices.gp40Vip}">${data.prices.gp40Vip}
										</g:if>
										</span>
									</div>
								</li>
								<li style="width: 10px;">
									<div class="split-line"></div>
								</li>
								<li class="price-40hq">
									<div class="box-style">40HQ</div>
									<div class="price" >
									<g:if test="${data.companyName =='深圳市长帆国际物流有限公司'}">
										<span class='hq40' style="color:#329AEF">$<g:if test="${data.prices && data.prices.hq40&& data.prices.hq40>500}">${data.prices.hq40+100}
										</g:if><g:else>
										${data.prices.hq40+50}
										</g:else>
										</span>
									</g:if><g:else>
										<span class='hq40' style="color:#329AEF">$<g:if test="${data.prices && data.prices.hq40}">${data.prices.hq40}
										</g:if>
										</span>
									</g:else>
										<b>|</b>
										<span class='hq40Vip' style="color:red;">$<g:if test="${data.prices && data.prices.hq40Vip}">${data.prices.hq40Vip}
										</g:if>
										</span>
									</div>
								</li>
							
							</g:else>
							</ul>
						</li>
						<li class="list-three">
							<div class="sailing-date b_r_e2">
								<b class="data-title">有效期:</b> <b class="data-inf expire-date">${startDate}
									- ${endDate}
								</b>
							</div>
							<div class="shipping-date b_r_e2">
								<!-- <b class="data-title">船 期:</b> <b class="data-inf" ></b> -->
								<b class="data-title">运输类型:</b> <b class="data-inf"> ${data.transType.text}
								</b>
							</div>
							<div class="voyage">
								<b class="data-title">航 程:</b> <b class="data-inf"> ${data.shippingDays}天
								</b>
							</div>
						</li>
						<li class="list-four">
							
							<div class="middle-port b_r_e2">
								<b class="data-title">中转港:</b> <b class="data-inf"> ${data.middlePort}
								</b>
							</div>
							<div class="valid-date b_r_e2">
								<b class="data-title">船公司:</b> <b class="data-inf shippingCmp"> ${data.shipCompany}
								</b>
							</div>
							<div class="ship-company">
								
								<b class="data-title">限 重:</b> <b class="data-inf limit-weight"  >${data.weightLimit?data.weightLimit:"---"}</b>
							</div>
						</li>
						<!-- <li class="list-five">
							
						</li> -->
						<li class="list-six">
							<div class="weight-limited" style="width:100%">
								<!-- <b class="data-title">限 重:</b> <b class="data-inf limit-weight" style="width:700px;text-align:left;margin-left:30px;"  title=""></b> -->
								<b class="data-title">船 期:</b> <b class="data-inf" style="width:700px;text-align:left;margin-left:30px;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;" title="${data.shippingDay}" > ${data.shippingDay}</b>
							</div>
							
						</li>
						<li class="list-seven" style="height:35px;">
							<div style="width: 80px">
								<b class="data-title">附加费:</b>
								<input type="hidden" name="locaL-total"  class="locaL-total" value="<g:if test="${data.prices && data.prices.extra}">
										${data.prices.extra}
									</g:if>">
							</div>
							<div style="width: 800px; margin-left: 20px;" class="additional">
								
									<ul class="title_list">
							         <li class="list_one">名称</li>
							         <li class="list_two">单位</li>
							         <li class="list_three">柜型</li>
							         <li class="list_four">单票</li>
							         <li class="list_five">币种</li>
   							  		</ul>
   							  		
   							  		
   							  		
   							  		
								<%--<b title="${data.prices.extra}" class="additional-info"><g:if test="${data.prices && data.prices.extra}">
										${data.prices.extra}
									</g:if></b>
							--%></div>
						</li>
						<li class="list-eight" style="height: 100px">
							<div style="width: 180px; height: 100px">
								<b class="data-title">备注: </b>
							</div>
							<div style="height:100px;overflow:auto;width:700px;padding-left:15px;line-height:24px;">${data.remark}</div>
						</li>
					</ul>
				</div>
		</g:if>
		<div class="consultant">
			<ul class="list">
			    <li class="sel">
			      <a title="bookingOnline" id="bookingOnline"><b class="bookingOnline"></b>在线订舱</a>
			    </li>
				<%--<li class="list-first">订舱咨询:</li>
				--%><li class="list-second"><a name="submitOnline" id="inquiryOnline"><b class="text"></b> 在线咨询</a></li>
				<li class="list-third">
					<a href="javascript:void(0)"  name="QQ" title="请点击右边找船网客服"><b class="QQ" style="float: left;margin-top: 6px;margin-left: 125px;"></b>在线QQ咨询</a> 
				</li>
				<li class="list-fourth"><a name="telOnline"><b class="tel"></b> 联系我们 Tel：</a> <span
					style="color: red">4008755156</span></li>
			</ul>
		</div>
		<div class="enquiry-inf">
			<div class="registrant-inf" style="display:none;">
				<div style="width: 100%; line-height: 25px">
					<h3
						style="float: right; margin-right: 20px; font-size: 12px; color: red">*使用注册信息，将自动为您填写您的个人信息</h3>
				</div>

				<table width="100%" style="margin-top: 10px;" id="common-input">
					<tr>
						<td rowspan="4" class="message"><span>询价人详情:</span></td>
						<td class="td-list-one"><b>*</b> <span>姓名:</span></td>
						<td class="td-list-two"><input type="text" name="userName"/>
						</td>
						<td rowspan="4" class="td-list-three">
							<!-- <span>使用注册信息，将自动为您填写您的个人信息</span> -->
						</td>
					</tr>
					<tr>
						<td class="td-list-one"><b>*</b> <span>公司名称:</span></td>
						<td class="td-list-two"><input type="text" name="companyName"/>
						</td>
					</tr>
					<tr>
						<td class="td-list-one"><b>*</b> <span>联系电话:</span></td>
						<td class="td-list-two"><input type="text" maxlength="15"
							name="mobile"/></td>
					</tr>
					<tr>
						<td class="td-list-one"><span>QQ号码:</span></td>
						<td class="td-list-two"><input type="text" name="qq" /></td>
					</tr>
				</table>

				<div id="ajax-tab-container" class="tab-container">
					<ul class='tabs' id="cargo-tabs">
						<li
							style="width: 270px; border-bottom: 1px solid #ddd; padding-bottom: 1px; border-right: 1px solid #ddd"></li>
						<li class='tab active'><a href="#tab-cargo-description">货盘描述</a></li>
						<li class='tab '><a href="#tab-create-cargo">新建货盘</a></li>
						<li
							style="width: 420px; border-bottom: 1px solid #ddd; padding-bottom: 1px; border-left: 1px solid #ddd"></li>
					</ul>
					
					<div class='panel-container'>
						<div id="tab-cargo-description" class="tabs-query" style="">
							<div>

								<form name="tab-cargo-description" id="cargo-descript"
									action="/InqueryPrice/saveinquery">
									<input type="hidden" name="userName" value=""> <input
										type="hidden" name="companyName" value=""> <input
										type="hidden" name="mobile" value=""> <input
										type="hidden" name="qq" value="">
										<input type="hidden" name="infoId" value="">
										

									<div class="introductions">
										<p>对货盘的总要信息进行简述，我们会根据您填写的信息，为您匹配报价，您还可以通过新增货盘进行询价。货盘的信息越详细，找到合适报价的几率就越高。赶快去发布新的货盘吧。</p>
									</div>
									<div class="remark">
										<textarea name="remark" id="" cols="120" rows="10"
											placeholder="例如货盘信息，起始港 目的港等信息"></textarea>
									</div>
									<div class="btn-area-one">
										<a href="javascript:void(0)" name="inquiry" class="submit-btn"></a>
										<!--<input type="reset" value="" class="reset-btn"/>-->
									</div>
								</form>

							</div>
						</div>
						<div id="tab-create-cargo" class="tabs-new-pallet">
							<form name="form2" id="create-cargo"
								action="/InqueryPrice/saveorder">
								<!--  <input type="hidden" name="userName" value="2342">
                                        <input type="hidden" name="companyName" value="2342">
                                        <input type="hidden" name="mobile" value="2342">
                                        <input type="hidden" name="qq" value="2342"> -->
								<table width="750">
									<tr>
										<td class="box-one"><b>*</b> <span>起始港</span></td>
										<td class="box-two"><input type="text"
											class="ui-autocomplete-input" autocomplete="on"
											name="startPort" /></td>
									</tr>
									<tr>
										<td class="box-one"><b>*</b> <span>目的港</span></td>
										<td class="box-two"><input type="text" name="endPort" />
										</td>
									</tr>
									<tr>
										<td class="box-one"><b>*</b> <span>货物类型</span></td>
										<td class="box-two"><input type="radio" checked
											name="orderType" class="radio-box" value="家具"/> <b class="box-style" >家具</b>
											<input type="radio" name="orderType" class="radio-box" value="建材">
											<b class="box-style" >建材</b> <input type="radio"
											name="orderType" class="radio-box" value="服装"/> <b class="box-style">服装</b>
											<input type="radio" name="orderType" class="radio-box" value="其他"/> <b
											class="box-style">其他</b></td>
									</tr>
									<tr>
										<td class="box-one"><b></b> 
										<span>船公司</span>
										
										</td>
										<td class="box-two" style="position: relative"><input
											type="text" name="shipCompany" />
											<div class="shipping-company-list"
												style="width: 0; display: none;">
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
											
											
											</div></td>
									</tr>
									<tr>
										<td class="box-one"><b>*</b> <span>货物名称</span></td>
										<td class="box-two"><input type="text" name="cargoName" />
										</td>
									</tr>
									<tr>
										<td class="box-one"><b>*</b> <span>运输类别</span></td>
										<td class="box-two"><input type="radio" checked
											name="transType" class="radio-box" value="Whole"/> <b class="box-style">整箱</b>
											<input type="radio" name="transType" class="radio-box" value="Together"/> <b
											class="box-style">拼箱</b></td>
									</tr>
									<tr>
										<td class="box-one"><b>*</b> <span>预计出货日</span></td>
										<td class="box-two"><input type="text" name="endDate" />
										</td>
									</tr>
									<tr class="box-size">
										<td class="box-one"><b>*</b> <span>箱型</span></td>
										<td class="box-three">
											<div class="box-list" style="margin-left: 30px;">
												<b>20GP:</b> <input type="number" min="0" name="box20GP" />
											</div>
											<div class="box-list">
												<b>40GP:</b> <input type="number" min="0" name="box40GP" />
											</div>
											<div class="box-list">
												<b>40HQ:</b> <input type="number" min="0" name="box40HQ" />
											</div>
											<%--<div class="box-list">
												<b>45HQ:</b> <input type="number" min="0" name="box45HQ" />
											</div>
										--%></td>
									</tr>
									<tr>
										<td class="box-one"><b>*</b> <span>毛重(KG)</span></td>
										<td class="box-two"><input type="text" name="cargoWeight" />
                                         

										</td>
									</tr>
									<tr>
										<td class="box-one"><b>*</b> <span>体积(CBM)</span></td>
										<td class="box-two"><input type="text" name="cargoCube" />
                                        
										</td>
									</tr>
									<tr  id="piece" style="display:none">
										<td class="box-one"><b>*</b> <span>件数(件)</span></td>
										<td class="box-two"><input type="text" name="cargoNums" />
                                         
										</td>
									</tr>
									<tr>
										<td class="box-four">
											<div class="remark-inf">
												<b style="color: red"></b> <span>备注</span>
											</div>
										</td>
										<td class="box-five"><textarea name="orderDescript"
												cols="60" rows="6" placeholder="请控制在150字以内"></textarea></td>
									</tr>
									<tr>
										<td colspan="2">
											<div class="sub-word">
												<input type="checkbox"/> <span>将询价货盘发布为新增货盘（勾选后，货盘信息将在货盘列表中显示）</span>
											</div>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<div class="btn-area-two">
												<a type="submit" send-query="false" name="cargo-create"
													value="" class="submit-btn"></a> <input type="reset"
													value="" class="reset-btn" />
											</div>
										</td>
									</tr>
								</table>
                               <input type="hidden" name="infoId" value="">
							</form>
						</div>
					</div>
				</div>		
			</div>
			 <div class="booking-online-ctn">
                     <div class="booking-main-container">
   <div class="specification">
	   <div>认证用户享有更优惠的舱位运价。点击<a href="/member/certificate" style="color:#3398ED">公司认证</a>前往认证</div>
	   <div> 您可以通过订舱，在线QQ和热线电话实时在线咨询</div>
   </div>
   <hr/>
   <form action="/booking/saveBooking" name="form_booking_online">
   <input type="hidden" name="infoId" value="${data.id}">
      <div class="ui-left-subtitle">填写BOOKING</div>
      <div class="booking-main-content">
	   <h1 style="margin:50px auto"> BOOKING FORM</h1>
	   <hr/>
       <div class="input-collection-zone">
           <div class="book-1">
             <h1><span style="color:red">*</span>Booking By (订舱人)(complete name)</h1>
             <ul class="common-info">
               <li>
                  <label title="公司名">Name&nbsp;</label><input type="text" name="bookingName"/>
               </li>
               <li>
                   <label title="联系人名称">Contact&nbsp;</label><input type="text" name="bookingContact"/>
               </li>
               <li>
                   <label>E-mail&nbsp;</label><input type="text" name="bookingEmail"/>
               </li>
               <li>
                   <label>TEL&nbsp;</label><input type="text" maxlength=20 name="bookingPhone"/>
               </li>
              </ul>
            </div>
           <div class="book-2">
           <h1>Shipper (托运人)(complete name )</h1>
           <ul class="common-info">
               <li>
                   <label title="公司名">Name&nbsp;</label><input type="text" name="shipperName"/>
               </li>
               <li>
                   <label title="联系人名称">Contact&nbsp;</label><input type="text" name="shipperContact"/>
               </li>
               <li>
                   <label>E-mail&nbsp;</label><input type="text" name="shipperEmail"/>
               </li>
               <li>
                   <label>TEL&nbsp;</label><input type="text" maxlength=20  name="shipperPhone"/>
               </li>
           </ul>
       </div>
           <div class="section-3">
             <div class="book-3">
               <h1>Consignee(收货人)</h1>
               <ul class="common-info">
                   <li>
                       <label title="公司名">Name&nbsp;</label><input type="text" name="consigneeName"/>
                   </li>
                   <li>
                       <label title="联系人名称">Contact&nbsp;</label><input type="text" name="consigneeContact"/>
                   </li>
                   <li>
                       <label>E-mail&nbsp;</label><input type="text" name="consigneeEmail"/>
                   </li>
                   <li>
                       <label>TEL&nbsp;</label><input type="text" maxlength=20  name="consigneePhone"/>
                   </li>
               </ul>
           </div>
               <div class="book-4">
                 <h1>Notify Party(到货通知人)</h1>
                 <ul class="common-info">
                   <li>
                       <label title="公司名">Name&nbsp;</label><input type="text" name="notifyPartyName"/>
                   </li>
                   <li>
                       <label title="联系人名称">Contact&nbsp;</label><input type="text" name="notifyPartyContact"/>
                   </li>
                   <li>
                       <label>E-mail&nbsp;</label><input type="text" name="notifyPartyEmail"/>
                   </li>
                   <li>
                       <label>TEL&nbsp;</label><input type="text" maxlength=20 name="notifyPartyPhone"/>
                   </li>
                  </ul>
               </div>
       </div>
           <div class="book-5 local-fee" style="border:none">

               <h1>本地费（Local）</h1>
               <div class="local_total_charge"  style="width:99%;height:270px;margin-top:-20px;border:1px solid #ddd;font-size:16px;" >
               		<ul  class="local_total">
               			
               		</ul>
               		</div>
             
       </div>
           <hr/>
           <table  class="table-1" style="height:271px;">
               <tr class="row1">
                   <td><span style="color:red">*</span>Place of Receipt（装货地）</td>
                   <td class="td2">Port of Loading（装货港）</td>
                   <td class="td3"><b style="color:red;font-weigth:normal">*</b>Service Mode at Origin (起始港运输方式)</td>
               </tr>
               
               <tr class="row-even">
                  <td><input type="text" name="placeReceipt" value="${data.startPort}"></td>
                   <td class="td2"><input type="text" name="portLoading" value="${data.startPort}"></td>
                   <td class="td3">
                      <span> <input type="radio" name="serviceOrigin" value="CY" checked/>CY</span>
                      <span> <input type="radio" name="serviceOrigin" value="CFS" />CFS</span>
                      <span> <input type="radio" name="serviceOrigin" value="DOOR" />DOOR</span>
                   </td>
               </tr>
               <tr>
                <td colspan="3">
                  <hr style="width:100%;"/> 
               </td></tr>
               <tr>
                   <td>Port of Discharge（卸货港）</td>
                   <td class="td2"><span style="color:red">*</span>Place of Delivery(目的地)</td>
                   <td class="td3"><b style="color:red;font-weigth:normal">*</b>Service Mode at Destination (目的港运输方式)</td>
               </tr>

               <tr class="row-even">
                   <td><input type="text" name="portDischarge" value="${data.endPort}"></td>
                   <td class="td2"><input type="text" name="placeDelivery" value="${data.endPort}"></td>
                   <td class="td3">
                      <span> <input type="radio" name="serviceDestination" value="CY" checked/>CY</span>
                       <span><input type="radio" name="serviceDestination" value="CFS" />CFS</span>
                       <span><input type="radio" name="serviceDestination" value="DOOR" />DOOR</span>
                   </td>
               </tr>
                <tr>
                <td colspan="3">
                  <hr style="width:100%;"/> 
               </td></tr>
               <tr>
                   <td>VName / VNo.(船名/航次)</td>
                   <td class="td2">Pre-Carriage By（前段运输）</td>
                   <td class="td3"><span><b style="color:red;font-weigth:normal">*</b>ETD(Y/M/D) (开船时间)</span><span>Final Destination (for information only)</span></td>

               </tr>
               <tr row-last>
                   <td><input type="text" name="voyageNo"></td>
                   <td class="td2"><input type="text" name="preCarriageBy"></td>
                   <td class="td3"><input type="text" placeholder="yyyy/mm/dd" name="etd" style="width:150px;"><input type="text" name="finalDestination" style="width:150px;margin-left:20px;"></td>

               </tr>
           </table>
           <hr/>
           <table class="table-2">
               <thead>
               <tr>
                   <td><span style="color:red">*</span>CT(集装箱型)</td>
                   <td><span style="color:red">*</span>Quant(集装箱数量)</td>
                   <td><span style="color:red">*</span>NP（包装/件数）</td>
                   <td>TV(CBM)(体积
                       ：立方米)</td>
                   <td>TW(KGS)(毛重：公斤)</td>
                   <td><span style="color:red">*</span>Commod(货品描述)</td>
               </tr>
               </thead>
               <tbody>
               <tr data-name="gp20">
                   <td class="tbody-td1">20GP</td>
                   <td><input type="text" name="gp20Num" id="gp20Nums"/></td>
                   <td><input type="text" name="gp20Quantity"/></td>
                   <td><input type="text" name="gp20Volume"/></td>
                   <td><input type="text" name="gp20Weight"/></td>
                   <td rowspan="3"><textarea name="commodity" style="resize:none"  maxlength="120"></textarea></td>
               </tr>
               <tr data-name="gp40">
                   <td class="tbody-td1">40GP</td>
                   <td><input type="text" name="gp40Num" id="gp40Nums"/></td>
                   <td><input type="text" name="gp40Quantity"/></td>
                   <td><input type="text" name="gp40Volume"/></td>
                   <td><input type="text" name="gp40Weight"/></td>
               </tr>
               <tr data-name="hq40">
                   <td class="tbody-td1">40HQ</td>
                   <td><input type="text" name="hq40Num" id="hq40Nums"></td>
                   <td><input type="text" name="hq40Quantity"></td>
                   <td><input type="text" name="hq40Volume"></td>
                   <td><input type="text" name="hq40Weight"></td>
               </tr>
               <tbody>
           </table>
           <hr/>
           <div class="shipping-price-zone">
               <div class="shipping-price">Rate（运费）</div>
               <div class="shipping-price-detail">
                   <div class="currency" style="float:left;height:90px;">
                       <div class="rate-row1">
                           <span style="float:left;padding-top:5px;margin-right:10px;width:35px;text-align:right">O/F</span>
                           	<div style="float:left;width:300px;">
                           	<input type="text"  readOnly style="width:100px;float:left;margin-left:20px;height:29px;"  name="of_money" id="of_money"/>
                              <span class="money" style="float:left;margin-left:0px;">USD</span>
                              
                        	</div>
                        </div>	
                        <div style="clear:both"></div>
                        <div class="rate-row1">
                           <span style="float:left;padding-top:5px;margin-right:10px;width:35px;text-align:right">Local</span>
                           <div style="float:left;width:300px;">
                              <input type="text"  readOnly style="width:140px;float:left;margin-left:20px;height:29px;" name="local_money" id="local_money"/>
                              
                           </div>
                      </div>
                   </div>
                   <div class="currency" style="margin-left:40px;float:right;height:82px;">
						<div style="width:65px;float:left">
                         <div class="totalPrice" style="margin-bottom:15px;">价格合计</div>
                         <div style="width:130px">
                         	<input type="checkbox" name="isVip" style="width:15px;height:15px;margin-left:20px;margin-top:3px;">
                         	<span>不使用优惠价</span>
                         </div>
                         </div>
                           <div class="money-collection">
                              <span class="money-term"  ><b id="money" style="margin-left:10px;font-weight:normal"></b></span>
                              <span class="money-term"></span>
                              <h5>(仅供参考，实际费用请以最终账单为准。)</h5>
                            </div>
                       </div>
                   </div>
               </div>
           </div>
           <hr style="display:inline-block;"/>
           <div style="margin-left:25px;">
               <div>
                   <span>Remarks(订舱人备注)</span>
                   <span style="padding-left:380px;">Singnature & chop of booked by party: (订舱人签字盖章)</span>
               </div>
               <div>
                   <textarea style="width:438px;height:100px;resize:none" maxlength="120" name="bookingRemark"></textarea>
                   <div class="booker-remark">
                       <div><input type="text" style="width:350px;" name="bookingRemarks"/></div>
                       <div>Person in charge: (经办人)<input type="text" name="personInCharge"/></div>
                       <div class="last-signature">
                           <span>TEL</span><input type="text"  maxlength=20 style="margin-right:30px;" name="chargeTel"/>
                           <span>E-mail</span><input type="text" name="chargeEmail"/>
                       </div>
                   </div>
               </div>
               <div class="agreement">
                   <input type="checkbox" name="agree"  value="agreement"/>我同意<span class="publish">《找船网在线订舱协议》</span>
               </div>
           </div>
           <div class="booking-footer">
               <a href="javascript:void(0)" id="booking_ensure">订舱</a>
               <input type="reset" value="清空"/>
           </div>
       </div>
    </form></div>                   
            </div> 
		</div>
	</div>
	</div>
	
	<!--  <div id="dialog" title="Hi" style="display:block">
        hello

    </div> -->
 
	<div class=" cargoInquery  helppage needtop needsearch">
<div id="spec_area"></div></div>
<script>
$(function(){
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(-1);//添加找船网公用顶部UI
	addZcFootUI();//添加找船网公用底部UI(有微信图片那个)
	addZcBtmUI();//添加找船网公用底部UI(最下面黑底的那个)
	 setTimeout(function(){
		 $('#common-input').find('input[name="userName"]').val("${userName}"); 	
		 $('#common-input').find('input[name="companyName"]').val("${companyName}"); 
         $('#common-input').find('input[name="mobile"]').val("${mobile}");
         $('#common-input').find('input[name="qq"]').val("${qq}");
         $('#common-input').find('input[name="remark"]').val("${orderDescript}");
     },200)
     loadScript({
	       url:'../cargoInquery.js',
	isPackNeed:true 	
})
     
     
     
 });
</script>
</body>
</html>