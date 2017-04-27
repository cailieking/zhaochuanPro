
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
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<link rel="stylesheet" type="text/css" href="../css/personalCenter.css">

<script src="../js/jquery.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/js.js"></script>
<script src="../js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<%--<script src="../js/dialog.js"></script>--%>
<script src="../js/cargoInquery.js"></script>

</head>
<body>







	<div class="w960">
		<div class=" right release_single">
			<div class="head-title">
				<b></b> 
				<span class="adds">新增货盘</span>
				 <span class="model">（<b>*</b>为必填项）</span>
			</div>
			<g:if test="${data}">
			
			<form name="form2" id="create-cargo"
								action="/InqueryPrice/saveorder">
				<table>
				
					<tr>
						<td class="box-one">
							<b>*</b> 
							<span>起始港</span>
						</td>
						<td class="box-two">
						
							<input type="text"  class="ui-autocomplete-input" autocomplete="on" name="startPort" value="${data.startPort}" /></td>
					</tr>
					<tr>
						<td class="box-one">
							<b>*</b> 
							<span>目的港</span>
						</td>
						<td class="box-two">
							<input type="text" name="endPort" value="${data.endPort}" />
						</td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>货物类型</span></td>
						<g:if test="${data.orderType == '家具'}" >
						<td>
						<td>
						<input type="radio"  name="orderType" class="radio-box" value="家具" checked/>
						<b class="box-style">家具</b>
						<input type="radio"  name="orderType" class="radio-box"  value="建材"/>
						<b class="box-style" >建材</b>
						<input type="radio" name="orderType" class="radio-box" value="服装"/>
						<b class="box-style">服装</b>
						<input type="radio" name="orderType" class="radio-box" value="其他"/>
						<b class="box-style">其他</b>
						</td>
						</td>
						</g:if>
						<g:elseif test="${data.orderType == '建材'}" >
						<td>
						<input type="radio"  name="orderType" class="radio-box" value="家具"/>
						<b class="box-style">家具</b>
						<input type="radio"  name="orderType" class="radio-box" checked value="建材"/>
						<b class="box-style" >建材</b>
						<input type="radio" name="orderType" class="radio-box" value="服装"/>
						<b class="box-style">服装</b>
						<input type="radio" name="orderType" class="radio-box" value="其他"/>
						<b class="box-style">其他</b>
						</td>
						</g:elseif>
						<g:elseif test="${data.orderType == '服装'}" >
						<td>
						<input type="radio"  name="orderType" class="radio-box" value="家具"/>
						<b class="box-style">家具</b>
						<input type="radio"  name="orderType" class="radio-box"  value="建材"/>
						<b class="box-style" >建材</b>
						<input type="radio" name="orderType" class="radio-box" value="服装" checked/>
						<b class="box-style">服装</b>
						<input type="radio" name="orderType" class="radio-box" value="其他"/>
						<b class="box-style">其他</b>
						</td>
						</g:elseif>
						<g:else >
						<td>
						<input type="radio"  name="orderType" class="radio-box" value="家具"/>
						<b class="box-style">家具</b>
						<input type="radio"  name="orderType" class="radio-box"  value="建材"/>
						<b class="box-style" >建材</b>
						<input type="radio" name="orderType" class="radio-box" value="服装"/>
						<b class="box-style">服装</b>
						<input type="radio" name="orderType" class="radio-box" value="其他" checked/>
						<b class="box-style">其他</b>
						</td>
						</g:else>
					</tr>
					<tr>
						<td class="box-one"><b></b> <span>船公司</span>
						   
						</td>
						<td class="box-two" style="position:relative;"><input type="text" name="shipCompany" value="${data.companyName}" />
							<div class="shipping-company-list"
												style="width: 0; display: absolute;">
												<h3>请选择船公司</h3>
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

											</div>
						</td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>货物名称</span></td>
						<td class="box-two"><input type="text" name="cargoName"
							value="${data.cargoName}" /></td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>运输类别 </span></td>

						<g:if test="${data.transType}">
							<td class="box-two"><input type="radio" checked
								name="transType" class="radio-box container-size" value="Whole"/> <b class="box-style">整箱</b>
								<input type="radio" name="transType" class="radio-box container-size " value="Together"/> <b
								class="box-style">拼箱</b></td>
						</g:if>
						<g:else>
							<td class="box-two">
							<input type="radio" name="transType" class="radio-box container-size" value="Whole"/> 
							<b class="box-style">整箱</b> 
							<input type="radio" name="transType" checked class="radio-box container-size" value="Together"/>
							 <b class="box-style" value="Together">拼箱</b></td>

						</g:else>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>预计出货日</span></td>
						<td class="box-two"><input type="text" name="endDate"
							value="${endDate}" /></td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>箱型</span></td>
						<td class="box-three">
							<div class="box-list" style="margin-left: 30px;">
								<b>20GP:</b> <input type="number" min="0"
									name="box20GP" value="${data.cargoBoxNums[0]}" />
							</div>
							<div class="box-list">
								<b>40GP:</b> <input type="number" min="0"
									name="box40GP" value="${data.cargoBoxNums[2]}" />
							</div>
							<div class="box-list">
								<b>40HQ:</b> <input type="number" min="0"
									name="box40HQ" value="${data.cargoBoxNums[4]}" />
							</div>
							<%--<div class="box-list">
								<b>45HQ:</b> <input type="number" min="0"
									name="box45HQ" value="${data.cargoBoxNums[6]}" />
							</div>
						--%></td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>毛重(KG)</span></td>
						<td class="box-two"><input type="text" name="cargoWeight"
							value="${data.cargoWeight}" /></td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>体积(CBM)</span></td>
						<td class="box-two"><input type="text" name="cargoCube"
							value="${data.cargoCube}" /></td>
					</tr>
					<tr id="piece" style="display:none;">
						<td class="box-one" style="display:none;"><b>*</b> <span>件数</span></td>
						<td class="box-two"><input type="text" name="cargoNums"
							value="${data.cargoNums}" /></td>
					</tr>
					<tr>
						<td class="box-four">
							<div class="remark-inf">
								<b style="color: red"></b> <span>备注</span>
							</div>
						</td>
						<td class="box-five"><textarea name="orderDescript" cols="60"
								rows="6" placeholder="请控制在150字以内">
								${data.remark}
							</textarea></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="btn-area-two">
							   <a role="button" class="submit-btn" href="javasript:void(0)"></a>
							   <input type="reset" class="reset-btn" value="重置"/>
							</div>
						</td>
					</tr>
                   
				</table>
				<%--<input type="hidden" name="infoId" value="${data.info.id}"> 
				--%></form>
			</g:if>

			<g:else>
			<form name="form2" id="create-cargo"
								action="/InqueryPrice/saveorder">
				<table>
					<tr>
						<td class="box-one"><b>*</b> <span>起始港</span></td>
						<td class="box-two"><input type="text"
							class="ui-autocomplete-input" autocomplete="on" name="startPort" />
						</td>
					</tr>
					<tr>
						<td class="box-one">
							<b>*</b> 
							<span>目的港</span>
						</td>
						<td class="box-two">
							<input type="text" name="endPort" value=" " />
						</td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>货物类型</span></td>
						<td class="box-two"><input type="radio" checked
							name="orderType" class="radio-box" /> <b class="box-style">家具</b>
							<input type="radio" name="orderType" class="radio-box"> <b
							class="box-style">建材</b> <input type="radio" name="orderType"
							class="radio-box" /> <b class="box-style">服装</b> <input
							type="radio" name="orderType" class="radio-box" /> <b
							class="box-style">其他</b></td>
					</tr>
					<tr>
						<td class="box-one"><b></b> <span>船公司</span>
						</td>
						<td class="box-two" style="position:relative;"><input type="text" name="shipCompany" />
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
						</td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>货物名称</span></td>
						<td class="box-two"><input type="text" name="cargoName" /></td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>运输类别</span></td>
						<td class="box-two"><input type="radio" checked
							name="transType" class="radio-box container-size" value="Whole"/> <b class="box-style">整箱</b>
							<input type="radio" name="transType" class="radio-box container-size" value="Together" /> <b
							class="box-style">拼箱</b></td>
					</tr>
					<tr>
						<td class="box-one"><b>*</b> <span>预计出货日</span></td>
						<td class="box-two"><input type="text" name="endDate" /></td>
					</tr>
					<tr class="box-size">
						<td class="box-one"><b>*</b> <span>箱型</span></td>
						<td class="box-three">
							<div class="box-list" style="margin-left: 30px;">
								<b>20GP:</b> <input type="number" min="0"
									name="box20GP" />
							</div>
							<div class="box-list">
								<b>40GP:</b> <input type="number" min="0"
									name="box40GP" />
							</div>
							<div class="box-list">
								<b>40HQ:</b> <input type="number" min="0"
									name="box40HQ" />
							</div>
							<%--<div class="box-list">
								<b>45HQ:</b> <input type="number" min="0"
									name="box45HQ" />
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
						<td class="box-two"><input type="text" name="cargoCube" /></td>
					</tr>
					<tr id="piece" style="display:none;">
						<td class="box-one"><b>*</b> <span>件数</span></td>
						<td class="box-two"><input type="text" name="cargoNums" /></td>
					</tr>
					<tr>
						<td class="box-four">
							<div class="remark-inf">
								<b style="color: red"></b> <span>备注</span>
							</div>
						</td>
						<td class="box-five"><textarea name="orderDescript" cols="60"
								rows="6" placeholder="请控制在150字以内"></textarea></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td colspan="2">
							<div class="btn-area-two">
								<a role="button" class="submit-btn" href="javascript:void(0)"></a> 
								<input type="reset" class="reset-btn" value=" " />
							</div>
						</td>
					</tr>
				</table>
				</form>
			</g:else>

		</div>

	
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\.ie
	<div class=" shiplist backpage backship needtop"></div>
<script>
      $(function(){
			loadScript({
			   url:'shiplist.js',
			   defer:'defer'
			})
      })
  </script>
</body>
</html>
