<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<link rel="stylesheet" type="text/css" href="../css/shiplist.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/css/bookingOnline.css">

<script src="../js/jquery.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/js.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>

</head>
<div class="w960">
		<div class=" right release_single">
		<div class="head-title">
			<b></b> 
			<span class="adds">订单管理</span> <span class="model">(查看)</span>
		</div>

  <div class="booking-main-container">
   <div class="specification">
     <div>如果在订舱过程中您有任何疑问，请通过热线电话或QQ联系我们；</div>
     <div> 信息提交后，我们会马上联系您安排订舱事宜</div>
   </div>
   <hr>
   <form action="/booking/saveBooking" name="form_booking_online">
   <input type="hidden" name="infoId" value="475456">
      <div class="ui-left-subtitle">填写BOOKING</div>
      <div class="booking-main-content">
     <h1 style="margin:50px auto"> BOOKING FORM</h1>
     <hr>
       <div class="input-collection-zone">
           <div class="book-1">
             <h1>*Booking By (订舱人)(complete name)</h1>
             
            
             <ul class="common-info">
               <li>
                  <label title="公司名">Name&nbsp;</label><input type="text" name="bookingName" value="${data.bookingName}">
               </li>
               <li>
                   <label title="联系人名称">Contact&nbsp;</label><input type="text" name="bookingContact" value="${data.bookingContact}">
               </li>
               <li>
                   <label>E-mail&nbsp;</label><input type="text" name="bookingEmail" value="${data.bookingEmail}">
               </li>
               <li>
                   <label>TEL&nbsp;</label><input type="text" name="bookingPhone" value="${data.bookingPhone}">
               </li>
              </ul>
            </div>
           <div class="book-2">
           <h1>Shipper (托运人)(complete name )</h1>
           <ul class="common-info">
               <li>
                   <label title="公司名">Name&nbsp;</label><input type="text" name="shipperName" value="${data.shipperName}">
               </li>
               <li>
                   <label title="联系人名称">Contact&nbsp;</label><input type="text" name="shipperContact" value="${data.shipperContact}">
               </li>
               <li>
                   <label>E-mail&nbsp;</label><input type="text" name="shipperEmail" value="${data.shipperEmail}">
               </li>
               <li>
                   <label>TEL&nbsp;</label><input type="text" name="shipperPhone" value="${data.shipperPhone}">
               </li>
           </ul>
       </div>
           <div class="section-3">
             <div class="book-3">
               <h1>Consignee(收货人)</h1>
               <ul class="common-info">
                   <li>
                       <label title="公司名">Name&nbsp;</label><input type="text" name="consigneeName" value="${data.consigneeName}">
                   </li>
                   <li>
                       <label title="联系人名称">Contact&nbsp;</label><input type="text" name="consigneeContact" value="${data.consigneeContact}" >
                   </li>
                   <li>
                       <label>E-mail&nbsp;</label><input type="text" name="consigneeEmail" value="${data.consigneeEmail}">
                   </li>
                   <li>
                       <label>TEL&nbsp;</label><input type="text" name="consigneePhone" value="${data.consigneePhone}">
                   </li>
               </ul>
           </div>
               <div class="book-4">
                 <h1>Notify Party(到货通知人)</h1>
                 <ul class="common-info">
                   <li>
                       <label title="公司名">Name&nbsp;</label><input type="text" name="notifyPartyName" value="${data.notifyPartyName}" >
                   </li>
                   <li>
                       <label title="联系人名称">Contact&nbsp;</label><input type="text" name="notifyPartyContact" value="${data.notifyPartyContact}" >
                   </li>
                   <li>
                       <label>E-mail&nbsp;</label><input type="text" name="notifyPartyEmail" value="${data.notifyPartyEmail}">
                   </li>
                   <li>
                       <label>TEL&nbsp;</label><input type="text" name="notifyPartyPhone" value="${data.notifyPartyPhone}">
                   </li>
                  </ul>
               </div>
       </div>
           <div class="book-5 local-fee">

               <h1>本地费（Local）</h1>
                <input type="hidden" class="local_all" value=<g:if test="${cargoInfo.prices && cargoInfo.prices.extra}">${cargoInfo.prices.extra}</g:if>>
               <div style="width:99%;height:99%;margin-top:-20px;outline:none;" class="local_total" ></div>
               <!--<ul class="common-info">
                     <li>
                        <label>ACF&nbsp;</label><input type="text" name="local-acf"/>
                      </li>
                      <li>
                         <label>ORC&nbsp;</label><input type="text" name="local-orc"/>
                      </li>
                      <li>
                        <label>AMS&nbsp;</label><input type="text" name="local-ams"/>
                      </li>
                      <li>
                         <label>PSD&nbsp;</label><input type="text" name="local-psd"/>
                      </li>
                      <li>
                         <label>DOC&nbsp;</label><input type="text" name="local-doc"/>
                      </li>
                      <li>
                         <label>SEAL&nbsp;</label><input type="text" name="local-seal"/>
                      </li>
                      <li>
                         <label>EIR&nbsp;</label><input type="text" name="local-eir"/>
                      </li>
                      <li>
                        <label>TLX&nbsp;</label><input type="text" name="local-tlx"/>
                     </li>
                     <li>
                      <label>ISPS&nbsp;</label><input type="text" name="local-isps"/>
                    </li>
                    <li>
                        <label>OTHERS&nbsp;</label><input type="text" name="local-others"/>
                    </li>
                 </ul>-->
       </div>
           <hr>
           <table class="table-1" style="height:271px;">
               <tbody><tr class="row1">
                   <td>*Place of Receipt（装货地）</td>
                   <td class="td2">Port of Loading（装货港）</td>
                   <td class="td3">*Service Mode at Origin (起始港运输方式)</td>
               </tr>
               
               <tr class="row-even">
                  <td><input type="text" name="placeReceipt" value="${ data.placeReceipt}"></td>
                   <td class="td2"><input type="text" name="portLoading" value="${ data.portLoading}"></td>
                   <td class="td3">
                      <span> <input type="radio" name="serviceOrigin" checked>CY</span>
                      <span> <input type="radio" name="serviceOrigin">CFS</span>
                      <span> <input type="radio" name="serviceOrigin">DOOR</span>
                   </td>
               </tr>
               <tr>
                <td colspan="3">
                  <hr style="width:100%;"> 
               </td></tr>
               <tr>
                   <td>Port of Discharge（卸货港）</td>
                   <td class="td2">*Place of Delivery(目的地)</td>
                   <td class="td3">*Service Mode at Destination (目的港运输方式)</td>
               </tr>

               <tr class="row-even">
                   <td><input type="text" name="portDischarge" value="${ data."portDischarge"}"></td>
                   <td class="td2"><input type="text" name="placeDelivery" value="${ data.placeDelivery}"></td>
                   <td class="td3">
                      <span> <input type="radio" name="serviceDestination" checked="">CY</span>
                       <span><input type="radio" name="serviceDestination">CFS</span>
                       <span><input type="radio" name="serviceDestination">DOOR</span>
                   </td>
               </tr>
                <tr>
                <td colspan="3">
                  <hr style="width:100%;"> 
               </td></tr>
               <tr>
                   <td>VName / VNo.(船名/航次)</td>
                   <td class="td2">Pre-Carriage By（前段运输）</td>
                   <td class="td3"><span>*ETD(Y/M/D) (开船时间)</span><span>Final Destination (for information only)</span></td>

               </tr>
               <tr row-last="">
                   <td><input type="text" name="voyageNo" value="${data.voyageNo }"></td>
                   <td class="td2"><input type="text" name="preCarriageBy" value="${data.preCarriageBy }"></td>
                   <td class="td3">
                   		<input type="text" placeholder="yyyy/mm/dd" name="etd" style="width:150px;" id="dp1449575435944" class="hasDatepicker" value="${etd }">
                   		<input type="text" name="finalDestination" style="width:150px;margin-left:20px;" value="${data.finalDestination}">
                </td>

               </tr>
           </tbody></table>
           <hr>
           <table class="table-2">
               <thead>
               <tr>
                   <td>*CT(集装箱型)</td>
                   <td>*Quant(集装箱数量)</td>
                   <td>*NP（包装/件数)</td>
                   <td>TV(CBM)(体积
                       ：立方米)</td>
                   <td>TW(KGS)(毛重：公斤)</td>
                   <td>Commod(货品描述)</td>
               </tr>
               </thead>
               <tbody>
               <tr data-name="gp20">
                   <td class="tbody-td1">20GP</td>
                   <td><input type="text" name="gp20Num" value="${data.gp20Num}"></td>
                   <td><input type="text" name="gp20Quantity" value="${data.gp20Quantity}"></td>
                   <td><input type="text" name="gp20Volume" value="${data.gp20Volume}"></td>
                   <td><input type="text" name="gp20Weight" value="${data.gp20Weight}"></td>
                   <td rowspan="3"><textarea name="commodity" disabled>${data.commodity }</textarea></td>
               </tr>
               <tr data-name="gp40">
                   <td class="tbody-td1">40GP</td>
                   <td><input type="text" name="gp40Num" value="${data.gp40Num}"></td>
                   <td><input type="text" name="gp40Quantity" value="${data.gp40Quantity}"></td>
                   <td><input type="text" name="gp40Volume" value="${data.gp40Volume}"></td>
                   <td><input type="text" name="gp40Weight" value="${data.gp40Weight}"></td>
               </tr>
               <tr data-name="hq40">
                   <td class="tbody-td1">40HQ</td>
                   <td><input type="text" name="hq40Num" value="${data.hq40Num}"></td>
                   <td><input type="text" name="hq40Quantity" value="${data.hq40Quantity}"></td>
                   <td><input type="text" naem="hq40Volume" value="${data.hq40Volume}" ></td>
                   <td><input type="text" name="hq40Weight" value="${data.hq40Weight}"></td>
               </tr>
               </tbody><tbody>
           </tbody></table>
           <hr>
           <div class="shipping-price-zone">
               <div class="shipping-price">Rate（运费）</div>
               <div class="shipping-price-detail">
                   <div class="currency" style="float:left;height:90px;">
                       <div class="rate-row1">
                           <span style="float:left;padding-top:5px;margin-right:10px;width:35px;text-align:right">O/F</span>
                           	<div style="float:left;width:300px;">
                           	<input type="text"  readOnly style="width:100px;float:left;margin-left:20px;height:29px;color:red;"  name="of_money" id="of_money" value=${data.ofMoney}>
                              <span class="money" style="float:left;margin-left:0px;padding:6px;">USD</span>
                              
                        	</div>
                        </div>	
                        <div style="clear:both"></div>
                        <div class="rate-row1">
                           <span style="float:left;padding-top:5px;margin-right:10px;width:35px;text-align:right">Local</span>
                           <div style="float:left;width:300px;">
                              <input type="text"  readOnly style="width:140px;float:left;margin-left:20px;height:29px;color:red;" name="local_money" id="local_money"  value=${data.localMoney}>
                              
                           </div>
                      </div>
                   </div>
                   <div class="currency" style="margin-left:40px;float:right;height:82px;">
						<div style="width:65px;float:left">
                         <div class="totalPrice" style="margin-bottom:15px;">价格合计</div>
                         
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
                   <textarea style="width:438px;height:100px;resize:none" name="bookingRemark" disabled >${data.bookingRemark}</textarea>
                   <div class="booker-remark">
                       <div><input type="text" style="width:350px;" name="bookingRemarks"/></div>
                       <div>Person in charge: (经办人)<input type="text" name="personInCharge" value="${data.personInCharge}"/></div>
                       <div class="last-signature">
                           <span>TEL</span><input type="text" maxlength=20 style="margin-right:30px;" name="chargeTel" value="${data.chargeTel}"/>
                           <span>E-mail</span><input type="text" name="chargeEmail" value="${data.chargeEmail}"/>
                       </div>
                   </div>
               </div>
               <div class="agreement">
                   <input type="hidden" ></span>
               </div>
          </div>
           <div class="booking-footer">
               <a href="javascript:void(0)" id="back">返回</a>
           </div>
       </div>
    </form>
     
    <input type="hidden"  id="20gp_price" value="<g:if test="${data.info.prices && data.info.prices.gp20}">${data.info.prices.gp20}</g:if>">
    <input type="hidden"  id="40gp_price" value="<g:if test="${data.info.prices && data.info.prices.gp40}">${data.info.prices.gp40}</g:if>">
    <input type="hidden"  id="40hq_price" value="<g:if test="${data.info.prices && data.info.prices.hq40}">${data.info.prices.hq40}</g:if>">
    
    </div>
 </div>
</div>
 
 <div class="backpage  needtop bookingManage"></div>
<script>
    $(function(){
    	String.prototype.trim = function() {   
    	    return this.replace(/(^\s*)|(\s*$)/g, "");   
    	}  
        $("#back").click(function(){
			history.back();
	
            })
         $('input[type="text"]').prop('disabled',true);   
         $('input[type="radio"]').prop('disabled',true);
         
         //附加费
          if($(".local_all").val()){
          var $gp20Num =$('input[name="gp20Num"]').val()?parseInt($('input[name="gp20Num"]').val()):0;
           var $gp40Num =$('input[name="gp40Num"]').val()?parseInt($('input[name="gp40Num"]').val()):0;
            var $hq40Num =$('input[name="hq40Num"]').val()?parseInt($('input[name="hq40Num"]').val()):0;
           	 	var localAll  =$(".local_all").val().trim();
            	var localAllArr = localAll.split(';');
          		if(localAllArr.length>0){
          			for(var i =0;i<localAllArr.length;i++){	
						var arrListMsg =localAllArr[i].split("-");
						var valMsg =arrListMsg[1];
						var showNum =0;
						if(valMsg==='box'){
						 showNum = $gp20Num*parseInt(arrListMsg[2])+$gp40Num*parseInt(arrListMsg[3])+$hq40Num*parseInt(arrListMsg[4]);
						}else{
						showNum =parseInt(arrListMsg[5]);
						
						}
	 	 				var showLocalMsg =[
							'<li class="local_total_list">',		
           					'<span class="title_name"  style="display:inline-block;*display:inline;*zoom:1;width:32px;text-align:center">',arrListMsg[0],'</span>',
           					'<input type="text" style="color:red;"  class="total" value="',showNum,'">',
           					'<span class="local_charge_unit">',arrListMsg[6],'</span>',
           					'</li>' 	
						].join("");	
					$(".local_total").append(showLocalMsg);
					$(".local_total").find('input').prop('disabled',true);	
					}
					
					
          		}else{
          		$(".local_total").html('无');
          		
          		}
          }
          //总价
            var  localMoneyVal =$("#local_money").val();
            var  ofMoneyVal =$("#of_money").val();
           if(localMoneyVal){
           		if(!(/USD/img.test(localMoneyVal.trim()))){
              		$('#money').html(localMoneyVal+(ofMoneyVal+'USD'));
          		 }else{
            		var Arr =localMoneyVal.replace(/USD/img,'').split(',')
             		for(var i=0;i<Arr.length;i++){
             	 		if(/^\d+$/img.test(Arr[i])){
              	 			 Arr[i]=parseInt(Arr[i])+ parseInt(ofMoneyVal);
              	 			 Arr[i]+="USD";
             			 }           
            		 }
            		  $('#money').html(Arr.join(','))         
           	}
           
           };
         
          
          
    })

</script>
</body>
</html>