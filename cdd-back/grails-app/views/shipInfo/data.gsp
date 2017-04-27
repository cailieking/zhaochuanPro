<%@page import="com.cdd.base.enums.TransportationType"%>
<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE>
<html>
<head>
<title>订单信息</title>
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
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">合作厂商信息</div>
		<form  id="dataForm">
			<formTable:table>
				<formTable:tr title='航线'>
					<input type="text" readonly="readonly" value="${data.routeName}" />
				</formTable:tr>
				<formTable:tr title='审核状态'>
					<input type="text" readonly="readonly" value="${data.status?.text}" />
				</formTable:tr>
				<formTable:tr title='负责客服'>
					<input type="text" readonly="readonly" value="${data.service?.firstname}" />
				</formTable:tr>
				<formTable:tr title='航线'>
					<input type="text" readonly="readonly" value="${data.routeName}" />
				</formTable:tr>
				<formTable:tr title='公司'>
					<input type="text" readonly="readonly" value="${data.companyName}" />
				</formTable:tr>
				<formTable:tr title='所在地'>
					<input type="text" readonly="readonly" value="${data.city?.name}" />
				</formTable:tr>
				<formTable:tr title='地址'>
					<input type="text" readonly="readonly" value="${data.address}" />
				</formTable:tr>
				<formTable:tr title='联系人'>
					<input type="text" readonly="readonly" value="${data.contactName}" />
				</formTable:tr>
				<formTable:tr title='联系方式'>
					<input type="text" readonly="readonly" value="${data.phone}" />
				</formTable:tr>
				<formTable:tr title='始发港'>
					<input type="text" readonly="readonly" value="${data.startPort}" />
				</formTable:tr>
				
				<formTable:tr title='目的港'>
					<input type="text" readonly="readonly" value="${data.endPort}" />
				</formTable:tr>
				
				<formTable:tr title='中转港'>
					<input type="text" readonly="readonly" value="${data.middlePort}" />
				</formTable:tr>
				
				<formTable:tr title='船公司'>
					<input type="text" readonly="readonly" value="${data.shipCompany}" />
				</formTable:tr>
				<formTable:tr title='船期'>
					<input type="text" readonly="readonly" value="${data.shippingDay}" />
				</formTable:tr>
				<formTable:tr title='航程'>
					<input type="text" readonly="readonly" value="${data.shippingDays}" />
				</formTable:tr>
				<formTable:tr title='开始日期'>
					<input type="text" readonly="readonly" value="${data.startDate ? dateFormat.format(data.startDate): ''}" />
				</formTable:tr>
				<formTable:tr title='结束日期'>
					<input type="text" readonly="readonly" value="${data.endDate ? dateFormat.format(data.endDate): ''}" />
				</formTable:tr>
				<formTable:tr title='运输类型'>
					<input type="text" readonly="readonly" value="${data.transType?.text}" />
				</formTable:tr>
				<g:if test="${data.transType == TransportationType.Whole}">
					<formTable:tr title='USD/20GP'>
						<input type="text" readonly="readonly" value="${data.prices?.gp20}" />
					</formTable:tr>
					<formTable:tr title='USD/20GPVIP'>
						<input type="text" readonly="readonly" value="${data.prices?.gp20Vip}" />
					</formTable:tr>
					<formTable:tr title='USD/40GP'>
						<input type="text" readonly="readonly" value="${data.prices?.gp40}" />
					</formTable:tr>
					<formTable:tr title='USD/40GPVIP'>
						<input type="text" readonly="readonly" value="${data.prices?.gp40Vip}" />
					</formTable:tr>
					<formTable:tr title='USD/40HQ'>
						<input type="text" readonly="readonly" value="${data.prices?.hq40}" />
					</formTable:tr>
					<formTable:tr title='USD/40HQVIP'>
						<input type="text" readonly="readonly" value="${data.prices?.hq40Vip}" />
					</formTable:tr>
				</g:if>
				<g:else>
					<formTable:tr title='USD/cbm'>
						<input type="text" readonly="readonly" value="${data.prices?.cbm}" />
					</formTable:tr>
					<formTable:tr title='最低消费'>
						<textarea  readonly="readonly">${data.prices?.lowestCost}</textarea>
					</formTable:tr>
					<formTable:tr title='服务类型'>
						<input type="text" readonly="readonly" value="${data.pinServiceType}" />
					</formTable:tr>
				</g:else>
				<formTable:tr title='附加费'>
				<input type="hidden" value=${data.prices?.extra} class="extra">
					
					
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
				<formTable:tr title='限重'>
					<textarea readonly="readonly">${data.weightLimit}</textarea>
				</formTable:tr>
				<formTable:tr title='货主备注'>
					<textarea readonly="readonly">${data.remark}</textarea>
				</formTable:tr>
				<formTable:tr title='员工备注'>
					<textarea readonly="readonly">${data.memo}</textarea>
				</formTable:tr>
			</formTable:table>
			</form>
				<div class="buttons">
				<a href="javascript:void(0);" onclick="window.history.back()" class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 1080px;">返回</a>
        		
        		<div class="clearfix"></div>
		</div>
		</div>
	</div>
	
<script>
		$(function(){
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
					$(".additional").find("input").prop("disabled",true)
				
				}	 		
			}


			})

</script>
</body>
<>
</html>