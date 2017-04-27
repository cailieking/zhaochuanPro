data.id = info.<%@page import="com.cdd.base.enums.TransportationType"%>
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
<style>
.title_list,.local_list{
  width:100%;
  height:25px;
  line-height:25px;	
  float:left; 
  margin-bottom:10px;
}      
.title_list>li,.local_list>li{
    float:left;
    text-align: center;
      }
 .local_list>li input{
 	display:inline-block;
 	*display:inline;
 	*zoom:1;
 	width:45px;
 	height:20px;
 	border:1px solid #b4b4b4;
 	text-align:center;
 }     
.list_one {
    width:75px;
      }
.list_two {
    width:45px;
      }
.list_three {
    width:400px;
 }
 .list_three b{
  font-weight:normal;
  font-size:13px;
 }
.list_four {
   width:50px;
      }
.list_five {
   width:60px;
}
.local_total{
width:100%;


}
.local_total_list{
 margin:3px;
 width:200px;
 float:left;

}
</style>
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
			<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">货代审核信息</div>
			<form action="${request.contextPath}/shipAudit/update" method="post" id="dataForm">
			<input type="hidden" name="id" value="${data.id}" />
			<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<div class="clearfix"></div>
			</div>
				 <formTable:table>
					<formTable:tr title='审核状态:'>
						<select name="status" id="statusSelect" class="selectpicker">
							<g:each in="${Status.values()}" var="status">
								<g:if test="${data.status == status}">
									<option selected="selected" value="${status.name()}">${status.text}</option>
								</g:if>
								<g:else>
									<option value="${status.name()}">${status.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					
					<formTable:tr title='航线:'>
						<input type="text" name="routeName"  value="${data.routeName}" placeholder="航线"/>
					</formTable:tr>
					<formTable:tr title='公司:'>
						<input type="text" name="companyName"  value="${data.companyName}" placeholder="公司"/>
					</formTable:tr>
					<formTable:tr title='所在地:'>
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
					<formTable:tr title='联系人:'>
						<input type="text" name="contactName"  value="${data.contactName}"  placeholder="联系人"/>
					</formTable:tr>
					<formTable:tr title='联系方式:'>
						<input type="text" name="phone"  value="${data.phone}" placeholder="联系方式"/>
					</formTable:tr>
					<<formTable:tr title='始发港:'>
						<input type="text" name="startPort"  value="${data.startPort}" placeholder="始发港"/>
					</formTable:tr>
					<formTable:tr title='目的港:'>
						<input type="text" name="endPort"  value="${data.endPort}" placeholder="目的港"/>
					</formTable:tr>
					<formTable:tr title='中转港:'>
						<input type="text" name="middlePort"  value="${data.middlePort}" placeholder="中转港"/>
					</formTable:tr>
					<formTable:tr title='船公司:'>
						<input type="text" name="shipCompany"  value="${data.shipCompany}" placeholder="船公司"/>
					</formTable:tr>
					<formTable:tr title='船期:'>
						<input type="text" name="shippingDay"  value="${data.shippingDay}" placeholder="船期"/>
					</formTable:tr>
					<formTable:tr title='航程:'>
						<input type="text" name="shippingDays"  value="${data.shippingDays}" placeholder="航程"/>
					</formTable:tr>
					<formTable:tr title='开始日期:'>
						<input name="startDate" class="datepicker" type="text" value="${data.startDate ? dateFormat.format(data.startDate): ''}" placeholder="开始日期"/>
					</formTable:tr>
					<formTable:tr title='结束日期:'>
						<input name="endDate" class="datepicker" type="text" value="${data.endDate ? dateFormat.format(data.endDate): ''}" placeholder="结束日期"/>
					</formTable:tr>
					<formTable:tr title='运输类型:'>
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
					<formTable:tr type="trans" name="trans_Whole" title='USD/20GP:'>
						<input type="text" name="gp20"  value="${data.prices?.gp20}" placeholder="USD/20GP"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/20GPVIP:'>
						<input type="text" name="gp20Vip"  value="${data.prices?.gp20Vip}" placeholder="USD/20GP"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/40GP:'>
						<input type="text" name="gp40"  value="${data.prices?.gp40}" placeholder="USD/40GP"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/40GPVIP:'>
						<input type="text" name="gp40Vip"  value="${data.prices?.gp40Vip}" placeholder="USD/40GP"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/40HQ:'>
						<input type="text" name="hq40"  value="${data.prices?.hq40}" placeholder="USD/40HQ"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Whole" title='USD/40HQVIP:'>
						<input type="text" name="hq40Vip"  value="${data.prices?.hq40Vip}" placeholder="USD/40HQ"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='USD/cbm:'>
						<input type="text" name="cbm"  value="${data.prices?.cbm}" placeholder="USD/cbm"/>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='最低消费:'>
						<textarea class="transData" name="lowestCost" placeholder="最低消费">${data.prices?.lowestCost}</textarea>
					</formTable:tr>
					<formTable:tr type="trans" name="trans_Together" title='服务类型:'>
						<input type="text" name="pinServiceType"  value="${data.pinServiceType}" placeholder="服务类型"/>
					</formTable:tr>
					<formTable:tr title='附加费'>
					<input type="hidden" value=${data.prices?.extra} class="extra" name="extra">
					
					
					<div style="width: 800px; border:1px solid #ddd" class="additional">
								
									<ul class="title_list">
							         <li class="list_one">名称</li>
							         <li class="list_two">单位</li>
							         <li class="list_three">柜型</li>
							         <li class="list_four">单票</li>
							         <li class="list_five">币种</li>
   							  		</ul>
   							  		
   					</div>		  		
					</formTable:tr>
					<formTable:tr title='限重:'>
						<textarea name="weightLimit" placeholder="限重">${data.weightLimit}</textarea>
					</formTable:tr>
					<formTable:tr title='货主备注:'>
						<textarea name="remark" placeholder="货主备注">${data.remark}</textarea>
					</formTable:tr>
					<formTable:tr title='员工备注:'>
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
	<script>
	$(function(){
		String.prototype.trim= function(){
  			 return this.replace(/^\s+|\s+$/img,'');
		};
			var locaLTotal  =$(".extra").val().trim();		    
			var Arr =locaLTotal.split(";")
			if(Arr.length>0){
			 $(".additional").css({'height':35*(Arr.length+1)+"px"});
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
				
					$(".additional").append(listMsg);
					//$(".local_total").append(showLocalMsg);
					$(".additional").find("input[name='unit'],input[name='extraCharge']").prop("disabled",true)
				
				}	 		
			}
	$("#save").click(function(){
	  var localChargeArr =[];
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
