<g:set var="springSecurityService" bean="springSecurityService" />
<g:set var="userService" bean="userService" />
<%@page import="com.cdd.base.enums.TransportationType"%>
<%@page import="com.cdd.base.enums.Status"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<%@page import="com.cdd.base.enums.OrderType"%>
<g:set var="cityService" bean="cityService" />
<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE>
<html>
<head>
<title>货代信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
<asset:stylesheet src="shipInfo_edit.css" />
<script src="../../js/ExtraChargePlugin.js"></script>

</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">货代信息</div>
			
			<form action="${request.contextPath}/shipInfo/save" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.id}" />
				<div class="buttons">
				
				<div class="clearfix"></div>
			</div>
				<formTable:table>
					<g:if test="${springSecurityService.currentUser.isSupervisor() || springSecurityService.currentUser.isManager()}">
						<formTable:tr title='委派客服'>
							<select name="serviceId" class="selectpicker">
								<option value="">--请选择--</option>
								<g:each in="${userService.serviceList}" var="service">
									<g:if test="${data.service?.id == service.id}">
										<option selected="selected" value="${service.id}">${service.firstname}</option>
									</g:if>
									<g:else>
										<option value="${service.id}">${service.firstname}</option>
									</g:else>
								</g:each>
							</select>
						</formTable:tr>
					</g:if>
					<formTable:tr title='航线:'>
						<input name="routeName" type="text" value="${data.routeName}" placeholder="航线"/>
					</formTable:tr>
					<formTable:tr title='公司:'>
						<input name="companyName" type="text" value="${data.companyName}" placeholder="公司"/>
					</formTable:tr>
					<formTable:tr title='所在地'>
						<select name="cityId" class="selectautocomplete">
							<option value="">--请选择--</option>
							<g:each in="${Provinces.values()}" var="province">
								<optgroup label="${province.desc}">
									<g:each in="${cityService.getCities(province.code).list}" var="city">
										<g:if test="${data.city?.id == city.id}">
											<option selected="selected" value="${city.id}">${city.name}</option>
										</g:if>
										<g:else>
											<option value="${city.id}">${city.name}</option>
										</g:else>
									</g:each>
								</optgroup>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='首页显示'>
						<g:if test="${data.showOnIndex}">
							<input type="radio" name="showOnIndex" value="true" checked="checked" />是 
							<input style="margin-left: 20px;" type="radio" name="showOnIndex" value="false" />否 
						</g:if>
						<g:else>
							<input type="radio" name="showOnIndex" value="true"/>是 
							<input style="margin-left: 20px;" type="radio" name="showOnIndex" value="false" checked="checked" />否 
						</g:else>
					</formTable:tr>
					<formTable:tr title='地址:'>
						<input name="address" type="text" value="${data.address}" placeholder="地址"/>
					</formTable:tr>
					
					<formTable:tr title='联系人:'>
						<input name="contactName" type="text" value="${data.contactName}" placeholder="联系人"/>
					</formTable:tr>
					<formTable:tr title='联系方式:'>
						<input name="phone" type="text" value="${data.phone}" placeholder="联系方式" />
					</formTable:tr>
					<formTable:tr title='始发港:'>
						<input name="startPort" type="text" value="${data.startPort}" placeholder="始发港"/>
					</formTable:tr>
					
					<formTable:tr title='目的港'>
						<input name="endPort" type="text" value="${data.endPort}" placeholder="目的港"/>
					</formTable:tr>
					
					<formTable:tr title='中转港'>
						<input name="middlePort" type="text" value="${data.middlePort}" placeholder="中转港"/>
					</formTable:tr>
					
					<formTable:tr title='船公司:'>
						<input name="shipCompany" type="text" value="${data.shipCompany}" placeholder="船公司"/>
					</formTable:tr>
					<formTable:tr title='船期:'>
						<input name="shippingDay" type="text" value="${data.shippingDay}" placeholder="船期"/>
					</formTable:tr>
					<formTable:tr title='航程:'>
						<input name="shippingDays" type="text" value="${data.shippingDays}" placeholder="航程"/>
					</formTable:tr>
					<formTable:tr title='开始日期:'>
						<input name="startDate" class="datepicker" type="text" value="${data.startDate ? dateFormat.format(data.startDate): ''}" placeholder="开始日期" />
					</formTable:tr>
					<formTable:tr title='结束日期:'>
						<input name="endDate" class="datepicker" type="text" value="${data.endDate ? dateFormat.format(data.endDate): ''}" placeholder="结束日期"/>
					</formTable:tr>
					
					<formTable:tr title='运输类型'>
						<select name="transType" id="transTypeSelect" class="selectpicker">
							<g:each in="${TransportationType.values()}" var="type">
								<g:if test="${data.transType == type}">
									<option selected="selected" value="${type.name()}">${type.text}</option>
								</g:if>
								<g:else>
									<option value="${type.name()}">${type.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/20GP'>
						<input name="gp20"  placeholder="USD/20GP"    class="transData" type="text" value="${data.prices?.gp20}" />
					</formTable:tr>
					<formTable:tr type="trans"   name="trans_Whole" title='USD/20GPVIP'>
						<input name="gp20Vip"  placeholder="USD/20GPVIP"  class="transData" type="text" value="${data.prices?.gp20Vip}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/40GP'>
						<input name="gp40" placeholder="USD/40GP"  class="transData" type="text" value="${data.prices?.gp40}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/40GPVIP'>
						<input name="gp40Vip"  placeholder="USD/40GPVIP"  class="transData" type="text" value="${data.prices?.gp40Vip}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/40HQ'>
						<input name="hq40"   placeholder="USD/40HQ"  class="transData" type="text" value="${data.prices?.hq40}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/40HQVIP'>
						<input name="hq40Vip" placeholder="USD/40HQVIP"  class="transData" type="text" value="${data.prices?.hq40Vip}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='USD/cbm'>
						<input name="cbm"  placeholder="USD/cbm"  class="transData" type="text" value="${data.prices?.cbm}" />
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='最低消费'>
						<textarea class="transData" name="lowestCost">${data.prices?.lowestCost}</textarea>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='服务类型'>
						<input type="text" class="transData" name="pinServiceType" value="${data.pinServiceType}" />
					</formTable:tr>
					<formTable:tr title='附加费'>
					<input type="hidden" class="extra" name="extra" value=${data.prices?.extra} >
					
					
					<div style="width: 800px; border:1px solid #ddd" class="main-content">
								
									<ul class="title_list">
							         <li class="list_one">名称</li>
							         <li class="list_two">单位</li>
							         <li class="list_three">柜型</li>
							         <li class="list_four">单票</li>
							         <li class="list_five">币种</li>
   							  		</ul>
   							  		
   					</div>		  		
						<%--<textarea name="extra" placeholder="附加费">${data.prices?.extra}</textarea>
					--%></formTable:tr>
					<formTable:tr title='限重'>
						<textarea name="weightLimit" style="height:30px;resize:none" placeholder="限重">${data.weightLimit}</textarea>
					</formTable:tr>
					<formTable:tr title='货代备注'>
						<textarea name="remark" placeholder="货代备注">${data.remark}</textarea>
					</formTable:tr>
					<formTable:tr title='员工备注'>
						<textarea name="memo" placeholder="员工备注">${data.memo}</textarea>
					</formTable:tr>
				</formTable:table>
			</form>
			<div class="buttons">
				<a href="javascript:void(0);" id="save"  style="margin-left:200px;" class="button button-glow button-rounded button-raised button-primary pull-left">保存</a>
				<a href="javascript:;" onclick="window.history.back()" class="button button-glow button-rounded button-raised button-primary pull-left" id="back" style="margin-left:100px;">返回</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>
--%><script>
	$(function(){
		
		String.prototype.trim= function(){
  			 return this.replace(/^\s+|\s+$/img,'');
		};
		if($('input[name="extra"]').val()){
			var locaLTotal  =$('input[name="extra"]').val().trim();		    
			var Arr =locaLTotal.split(";")
			if(Arr.length>0){
			 $(".main-content").css({'height':35*(Arr.length+1)+"px"});
			// $("#shipping-inf").css({'height':35*Arr.length+2300+"px"});
				for(var i =0;i<Arr.length;i++){	
					var arrListMsg =Arr[i].split("-");
				 	 arrMsg =$.map(arrListMsg,function(item){
							if(item==="piece") return "票";
							if(item==="box") return "箱";
							if(item==="0") return "";
							return item 		 	
					}); 	
				   	var listMsg =[
							'<ul class="local_list">',
							'<li class="list_one">',
							   '<input type="text" name="extraCharge" style="width:50px;padding:0;height:20px;border-radius:0"   value="'+arrMsg[0]+'">',
							'</li>',
							 '<li class="list_two">',
								'<input type="text" name="unit" style="width:20px;padding:0;height:20px;border-radius:0"  value="'+arrMsg[1]+'">',
							'</li>',
							 '<li class="list_three">',
								'<span style="margin-right:25px">',
									'<b >20GP</b>',
									'<input type="text" name="gp20Num" style="width:30px;padding:0;height:20px;border-radius:0" value="'+arrMsg[2]+'">',
								'</span>',
								'<span style="margin-right:25px">',
									'<b>40GP</b>',
									'<input type="text" name="gp40Num" style="width:30px;padding:0;height:20px;border-radius:0" value="'+arrMsg[3]+'">',
								'</span>',
								'<span>',
									 '<b>40HQ</b>',
									 '<input type="text" name="hq40Num" style="width:30px;padding:0;height:20px;border-radius:0" value="'+arrMsg[4]+'">',
								'</span>',
							'</li>',
							'<li class="list_four">',
								'<input type="text" name="piecePrice" style="width:30px;padding:0;height:20px;border-radius:0"  value="'+arrMsg[5]+'">',	         
							'</li>',
							'<li class="list_five">',
								'<input type="text" name="currency" style="width:50px;padding:0;height:20px;border-radius:0"  value="'+arrMsg[6]+'" >',
							'</li>',
							'</ul>' 							  		
						].join("");				
				
					$(".main-content").append(listMsg);
					//$(".local_total").append(showLocalMsg);
					$(".main-content").find("input[name='unit'],input[name='extraCharge']").prop("disabled",true)
				
				}	 		
			}
		}else{
			$(".title_list").hide();
			var ec = new ExtraCharge({
					$ctn:$('.main-content')
			});


			}
	$("#save").click(function(){
		var localChargeArr =[];
		if($('input[name="extra"]').val()){		
			  
			   $(".local_list").each(function(){
			    var localListArr=[];
			    var extraChargeVal =$(this).find('input[name="extraCharge"]').val().trim();
			    var unitVal=$(this).find('input[name="unit"]').val().trim();
			    var gp20NumVal=$(this).find('input[name="gp20Num"]').val()?$(this).find('input[name="gp20Num"]').val().trim():'0';
			    var gp40NumVal=$(this).find('input[name="gp40Num"]').val()?$(this).find('input[name="gp40Num"]').val().trim():'0';
			    var hq40NumVal=$(this).find('input[name="hq40Num"]').val()?$(this).find('input[name="hq40Num"]').val().trim():'0';
			    var piecePriceVal=$(this).find('input[name="piecePrice"]').val()?$(this).find('input[name="piecePrice"]').val().trim():'0';
			    var currencyVal =$(this).find('input[name="currency"]').val();
			    localListArr.push(extraChargeVal,unitVal,gp20NumVal,gp40NumVal,hq40NumVal,piecePriceVal,currencyVal);	    
	    		 var localArr = $.map(localListArr,function(item){
	    					if(item==="票")  return "piece";
							if(item==="箱") return  "box";				
							return item ;					    
	    				})
	    		localListStr =localArr.join('-')				
	    		localChargeArr.push(localListStr);
	  
	 		 })
		}else{
			var extraChargeData = ec.getAllData();     	  	
      	  	if(extraChargeData.length > 0){
      			 for(var i=0;i<extraChargeData.length;i++){ 			
      				localChargeArr.push( extraChargeData[i]['value'])      			 
      			 }       		  
      	 	 }
  		}

					
		$(".extra").val(localChargeArr.join(';'));
		$('#dataForm').submit();
	
	})
		
			
	$("#transTypeSelect").change(function() {
		var value = $(this).val();
		$("tr[type='trans']").hide();
		$("tr[name='trans_" + value + "']").show();
	});
	$("#transTypeSelect").change();
})	
</script>
</body>
</html>