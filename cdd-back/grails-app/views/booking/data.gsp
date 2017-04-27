<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="layout" content="main">
    <title>订舱查看</title>
    <asset:stylesheet src="table.css" />
	<asset:javascript src="list-table.js" />
    <asset:stylesheet src="book_view.css" />
</head>
<body>
<%--<div class="row">
		--%><div class="col-lg-12">
			<div class="lump">
    <div class="content">
        <div class="shipping_price_info" style="height:230px"><%--
            <div class="header">
            <input type="hidden" name="bookingId" id = "bookingId" value="${data.data.id}" />
                <span class="title">运价编号</span>
                <span class="info">${data.data.info.id}</span>
            </div>
            --%><div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">运价编号&nbsp;&nbsp;${data.data.info.id}</div>
            
         <div class="price_msg">
                <table cellspacing="1">
                    <tr>
                        <td rowspan="3" colspan="2">
                            <ul class="port_info">
                                <li>
                                    <b class="com_title">起始港：</b>

                                  <input type="text" class="title_msg" disabled value="${data.data.info.startPort}">
                                </li>
                                <li>
                                    <b class="com_title">目的港：</b>
                                    <input type="text" class="title_msg" disabled value="${data.data.info.endPort}">
                                </li>
                                <li>
                                    <b class="com_title">中站港：</b>
                                    <input type="text" class="title_msg" disabled >
                                </li>

                            </ul>
                        </td>
                        <td rowspan="3">
                            <ul class="box_price">
                                <li class="box_common" style="text-align: left">
                                    <div class="title" style="text-align: left">运&nbsp;费:</div>
                                    <div class="title"></div>
                                </li>
                                <li class="box_common">
                                    <div class="title">20GP</div>
                                    <div class="title price" id="price_20gp">${data.data.info.prices?.gp20}</div>
                                	<div class="title price" id="price_20gpVip" style="color:red;">${data.data.info.prices?.gp20Vip}</div>
                                </li>
                                <li class="box_common">
                                    <div class="title">40GP</div>
                                    <div class="title price" id="price_40gp">${data.data.info.prices?.gp40}</div>
                                	<div class="title price" id="price_40gpVip" style="color:red;">${data.data.info.prices?.gp40Vip}</div>
                                </li>
                                <li class="box_common">
                                    <div class="title">40HP</div>
                                    <div class="title price" id="price_40hq">${data.data.info.prices?.hq40}</div>
                                	<div class="title price" id="price_40hqVip" style="color:red;">${data.data.info.prices?.hq40Vip}</div>
                                </li>

                            </ul>
                            <div></div>
                        </td>
                        <td>
                            <b class="com_title_pop" style="text-align: left;width: 60px">有效期：</b>
                            <input type="text" class="title_msg" disabled >
                        </td>
                        <td  rowspan="5">
                            <div class="remark">
                                <b class="remark_title">附加费：</b>
                                <div class="remark_info local_total">
							
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="" rowspan="4">
                            <div class="additional">
                                <b class="additional_title">备注：</b>
                                <div class="additional_info">
                                  
                                    
                                    ${data.data.info.remark }
                                </div>
                            </div>

                        </td>
                    </tr>
                    <tr>
                        
                    </tr>
                    <tr>
                        <td style="width: 150px;">
                            <b class="com_title">船公司：</b>
                        </td>
                        <td>
                            <b class="com_title_pop">航程：</b>
                            <input type="text" class="show_style" readonly="readonly" name="shippingDays" value="${data.data.info.shippingDays }" />
                        </td>
                        <td rowspan="2">
                            <b class="com_title_pop">船&nbsp;期：</b>
                            <div class="show_msg">
								${data.data.info.shippingDay }
                            </div>

                        </td>
                    </tr>
                    <tr>
                        <td style="width: 150px;">
                            <b class="com_title">运输类型：</b>
                            <input type="text" class="show_style" readonly="readonly" name="transType" value="${data.data.info.transType?.text }" />
                        </td>
                        <td>
                            <b class="com_title_pop">限重：</b>
                            <input type="text" class="show_style" readonly="readonly" name="weightLimit" value="${data.data.info.weightLimit }" />
                        </td>
                    </tr>
                </table>

            </div>
        </div>
	<form id = "bookingForm" action="" >
        <div class="booking_info">
            <div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">booking</div>
            <div class="content">
                <div class="list_one">
                    <div class="party_msg">
                       <div class="title">Booking By (订舱人)</div>
                       <ul class="info">
                           <li class="list">
                            <span class="name">Name</span>
                            <span class="details">${data.data.bookingName }</span>
			    <input type="hidden" name="bookingName" value="${data.data.bookingName }">
                           </li>
                            <li class="list">
                                <span class="name">E-mail</span>
                                <span class="details">${data.data.bookingEmail }</span>
				 <input type="hidden" name="bookingEmail" value="${data.data.bookingEmail }">
                            </li>
                            <li class="list">
                                <span class="name">Contact</span>
                                <span class="details">${data.data.bookingContact }</span>
				<input type="hidden" name="bookingContact" value="${data.data.bookingContact }">
                            </li>
                            <li class="list">
                                <span class="name">TEL</span>
                                <span class="details">${data.data.bookingPhone}</span>
				<input type="hidden" name="bookingPhone" value="${data.data.bookingPhone }">
                            </li>
                         </ul>
                   </div>
                    <div class="party_msg">
                        <div class="title">Shipper(托运人)</div>
                        <ul class="info">
                            <li class="list">
                                <span class="name">Name</span>
                                <span class="details">${data.data.shipperName }</span>
				<input type="hidden" name="shipperName" value="${data.data.shipperName }">
                            </li>
                            <li class="list">
                                <span class="name">E-mail</span>
                                <span class="details">${data.data.shipperEmail }</span>
				<input type="hidden" name="shipperEmail" value="${data.data.shipperEmail }">
                            </li>
                            <li class="list">
                                <span class="name">Contact</span>
                                <span class="details">${data.data.shipperContact }</span>
				<input type="hidden" name="shipperContact" value="${data.data.shipperContact }">
                            </li>
                            <li class="list">
                                <span class="name">TEL</span>
                                <span class="details">${data.data.shipperPhone }</span>
				<input type="hidden" name="shipperPhone" value="${data.data.shipperPhone }">
                            </li>
                        </ul>
                    </div>
                    <div class="party_msg">
                        <div class="title">Consignee(收货人)</div>
                        <ul class="info">
                            <li class="list">
                                <span class="name">Name</span>
                                <span class="details">${data.data.consigneeName }</span>
				<input type="hidden" name="consigneeName" value="${data.data.consigneeName }">

                            </li>
                            <li class="list">
                                <span class="name">E-mail</span>
                                <span class="details">${data.data.consigneeEmail }</span>
				<input type="hidden" name="consigneeEmail" value="${data.data.consigneeEmail }">
                            </li>
                            <li class="list">
                                <span class="name">Contact</span>
                                <span class="details">${data.data.consigneeContact }</span>
				<input type="hidden" name="consigneeContact" value="${data.data.consigneeContact }">
                            </li>
                            <li class="list">
                                <span class="name">TEL</span>
                                <span class="details">${data.data.consigneePhone }</span>
				<input type="hidden" name="consigneePhone" value="${data.data.consigneePhone }">
                            </li>
                        </ul>
                    </div>
                    <div class="party_msg" style="margin-top:25px;">
                        <div class="title">Notify(订舱人)</div>
                        <ul class="info">
                            <li class="list">
                                <span class="name">Name</span>
                                <span class="details">${data.data.notifyPartyName }</span>
				<input type="hidden" name="notifyPartyName" value="${data.data.notifyPartyName }">
                            </li>
                            <li class="list">
                                <span class="name">E-mail</span>
                                <span class="details">${data.data.notifyPartyEmail }</span>
				<input type="hidden" name="notifyPartyEmail" value="${data.data.notifyPartyEmail }">
                            </li>
                            <li class="list">
                                <span class="name">Contact</span>
                                <span class="details">${data.data.notifyPartyContact}</span>
				<input type="hidden" name="notifyPartyContact" value="${data.data.notifyPartyContact }">
                            </li>
                            <li class="list">
                                <span class="name">TEL</span>
                                <span class="details">${data.data.notifyPartyPhone}</span>
				<input type="hidden" name="notifyPartyPhone" value="${data.data.notifyPartyPhone }">
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="list_two">
                        <ul class="port">
                            <li class="port_list">
                                <div class="port_name">Place of Receipt（装货地）</div>
                                <div class="port_city">${data.data.placeReceipt}</div>
				<input type="hidden" name="placeReceipt" value="${data.data.placeReceipt }">
                            </li>
                            <li class="port_list">
                                <div class="port_name">Port of Loading（装货港）</div>
                                <div class="port_city">${data.data.portLoading}</div>
				<input type="hidden" name="portLoading" value="${data.data.portLoading }">
                            </li>
                            <li class="port_list">
                                <div class="port_name">Port of Discharge（卸货港）</div>
                                <div class="port_city">${data.data.portDischarge }</div>
				<input type="hidden" name="portLoading" value="${data.data.portLoading }">
                            </li>
                            <li class="port_list">
                                <div class="port_name">Place of Delivery(目的地)</div>
                                <div class="port_city">${data.data.placeDelivery}</div>
				<input type="hidden" name="placeDelivery" value="${data.data.placeDelivery }">
                            </li>
                            <li class="port_list">
                                <div class="port_name">Vessel Name / Voyage No.(船名/航次)</div>
                                <div class="port_city">${data.data.voyageNo}</div>
				<input type="hidden" name="voyageNo" value="${data.data.voyageNo }">
                            </li>
                            <li class="port_list">
                                <div class="port_name">Pre-Carriage By（前段运输）</div>
                                <div class="port_city">${data.data.preCarriageBy}</div>
				<input type="hidden" name="preCarriageBy" value="${data.data.preCarriageBy }">
                            </li>

                        </ul>
                        <div  class="local_charges">
                             <div class="title">本地费（Local）</div>
                             <input type="hidden" class="local_all" value= ${data.data.info.prices?.extra}>
                             <div class="info local_total" style="color:#3399EE">
                             
                             </div>               
                         </div>
                </div>
                <div class="list_three">
                    <ul class="transportation">
                        <li>
                            <span class="trans_common">Service Mode at Origin (起始港运输方式)</span>
                            <span class="data">${data.data.serviceOrigin }</span>
			    <input type="hidden" name="serviceOrigin" value="${data.data.serviceOrigin }">
                        </li>
                        <li>
                            <span class="trans_common">Service Mode at Destination (目的港运输方式)</span>
                            <span class="data">${data.data.serviceDestination }</span>
			      <input type="hidden" name="serviceDestination" value="${data.data.serviceDestination }">
                        </li>
                        <li>
                            <span class="trans_common">ETD(Y/M/D) (开船时间)</span>
                            <span class="data">${data.data.etd ? dateFormat.format(data.data.etd): ''}</span>
			      <input type="hidden" name="etd" value="${data.data.etd }">
                        </li>
                        <li>
                            <span class="trans_common">Final Destination (for information only)</span>
                            <span class="data">${data.data.finalDestination}</span>
			     <input type="hidden" name="finalDestination" value="${data.data.finalDestination }">
                        </li>
                    </ul>
                    <div class="container_box">
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="type">
                                        <div class="EN">Container Type</div>
                                        <div class="CN">(集装箱型)</div>
                                    </td>
                                    <td  class="packages">
                                        <div class="EN">Quantity</div>
                                        <div class="CN">（集装箱数量）</div>

                                    </td>
                                    <td class="quantity">
                                        <div class="EN">Number of packages</div>
                                        <div class="CN">(包装/件数)</div>

                                    </td>
                                    <td class="weight">
                                        <div class="EN">Total Weight(KGS)</div>
                                        <div class="CN">(毛重：公斤)</div>

                                    </td>
                                    <td class="weight">
                                        <div class="EN">Total Volume(CBM)   </div>
                                        <div class="CN">(体积：立方米)</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="common" >20GP</td>
                                    <td class="common">
				    ${data.data.gp20Num }
				     <input type="hidden" name="gp20Num" id="gp20Quantity" value="${data.data.gp20Num }">
				    </td>
                                    <td class="common"  >${data.data.gp20Quantity }
				    <input type="hidden" name="gp20Quantity"  value="${data.data.gp20Quantity }">
				    </td>
                                    <td class="common">${data.data.gp20Weight }
					<input type="hidden" name="gp20Weight" value="${data.data.gp20Weight }">
				    
				    </td>
                                    <td class="common">${data.data.gp20Volume }
					<input type="hidden" name="gp20Volume" value="${data.data.gp20Volume }">
				    </td>
                                </tr>
                                <tr>
                                    <td class="common" >40GP</td>
                                    <td class="common">${data.data.gp40Num }
					<input type="hidden" name="gp40Num" id="gp40Quantity" value="${data.data.gp40Num }">
				    </td>
                                    <td class="common">${data.data.gp40Quantity }
					<input type="hidden" name="gp40Quantity"   value="${data.data.gp40Quantity }">
				    </td>
                                    <td class="common">${data.data.gp40Weight }
					<input type="hidden" name="gp40Weight" value="${data.data.gp40Weight }">
				    </td>
                                    <td class="common">${data.data.gp40Volume }
				    <input type="hidden" name="gp40Volume" value="${data.data.gp40Volume }">
				    </td>
                                </tr>
                                <tr>
                                    <td class="common" 	>40HQ</td>
                                    <td class="common">${data.data.hq40Num }
				    <input type="hidden" name="hq40Num" id="hq40Quantity" value="${data.data.hq40Num }">
				    
				    </td>
                                    <td class="common">${data.data.hq40Quantity }
				    <input type="hidden" name="hq40Quantity"  value="${data.data.hq40Quantity }">
				    </td>
                                    <td class="common">${data.data.hq40Weight }
				    <input type="hidden" name="hq40Weight" value="${data.data.hq40Weight }">
				    </td>
                                    <td class="common">${data.data.hq40Volume }
				    <input type="hidden" name="hq40Volume" value="${data.data.hq40Volume }">
				    </td>
                                </tr>
                            </table>
                    </div>

                </div>
                <div class="list_four">
                    <div class="commodity ">
                        <div class="title">Commodity (货品描述)</div>
                        <div class="msg">${data.data.commodity }</div>
			  <input type="hidden" name="commodity" value="${data.data.commodity }">
                    </div>
                    <div class="remark">
                        <div class="title">Remarks（订舱人备注）</div>
                        <div class="msg">${data.data.bookingRemark }</div>
			 <input type="hidden" name="bookingRemark" value="${data.data.bookingRemark }">
                    </div>
                </div>
                <div class="list_five">
                    <div class="rate">
                        <div class="title" style="font-weight: bold">Rate（运费）</div>
                        <div class="msg">
                            <div class="OF">
                                <span class="name">O/F：</span>
                                <span class="price"  id="">${data.data.ofMoney }</span>
                            </div>
                            <div class="OF">
                                <span class="name">Local：</span>
                                <span class="price"  id="">${data.data.localMoney }</span>
                            </div>
                           </div>
                    </div>
                    <div class="charge_msg">
                        <div class="title" style="font-weight: bold">Person in charge（(经办人）</div>
                        <div class="msg">
                            <div class="OF">
                                <span class="name">name：</span>
                                <span class="price">${data.data.personInCharge }</span>
				 <input type="hidden" name="personInCharge" value="${data.data.personInCharge }">
                            </div>
                            <div class="local">
                                <span class="name">TEL：</span>
                                <span class="price">${data.data.chargeTel }</span>
				<input type="hidden" name="personInCharge" value="${data.data.personInCharge }">
                            </div>
                            <div class="total">
                                <span class="name">E-mail：</span>
                                <span class="price">${data.data.chargeEmail }
				<input type="hidden" name="chargeEmail" value="${data.data.chargeEmail }">
				
				</span>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
	
    </div>
    </form>
    <g:if test="${data.data.so}">
        <div class="SO_info">
        
            <%--<div class="header">
                --%>
                <!--<span class="info">9301058888</span>--><%--
            </div>
            --%><div class="content">
            <div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">S/O详情</div>
                <ul class="basic_info">
                    <li>
                        <span class="name">S/O编号</span>
                        <span class="data_info">${data.data.so.id }</span>
                    </li>
                    <li>
                        <span class="name">船名</span>
                        <span class="data_info">${data.data.so.shipName }</span>
                    </li>
                    <li>
                        <span class="name">航次</span>
                        <span class="data_info">${data.data.so.voyageNo }</span>
                    </li>
                    <li>
                        <span class="name">船公司</span>
                        <span class="data_info">${data.data.so.shipCompany }</span>
                    </li>
                    <li style="width: 350px;">
                        <span class="name">箱型</span>
                        <span class="data_info" style="width: 170px;">${data.data.so.gp20Num }*20GP   ${data.data.so.gp40Num }*40GP   ${data.data.so.hq40Num }*40HQ</span>
                    </li>
                </ul>
                <ul class="port_info_so">
                    <li>
                        <span class="name">${data.data.so.shipCompany }</span>
                        <span class="data_info">${data.data.so.shipCompany }</span>
                    </li>
                    <li>
                        <span class="name">目的港</span>
                        <span class="data_info">北京</span>
                    </li>
                    <li>
                        <span class="name">截关日</span>
                        <span class="data_info">${data.data.so.endDate ? dateFormat.format(data.data.so.endDate): ''}</span>
                    </li>
                    <li>
                        <span class="name">开船日</span>
                        <span class="data_info">${data.data.so.startShipDate ? dateFormat.format(data.data.so.startShipDate): ''}</span>
                    </li>
                    <li >
                        <span class="name">附件</span>
                        <span class="data_info" >${data.data.so.soFilePath}</span>
                    </li>
                </ul>

            </div>
        </div>
        </g:if>
        <div class="reason_info">
            <div class="commodity ">
                <div class="title">不通过原因</div>
                <div class="msg">${data.data.failReason }</div>
            </div>
            <div class="remark">
                <div class="title">备注</div>
                <div class="msg">${data.data.remark }</div>
            </div>
        </div>
        <div class="btn_area">
            <div class="box">
                <%--<a href="javascript:void(0)" class="booking_btn" id ="booking_btn">导出Booking</a>
                <a href="javascript:void(0)" class="so_btn">导出S/O</a>
                --%><a href="javascript:void(0)" class="back" style="margin-left:100px">返回</a>
            </div>
        </div>
    </div>
   </div>
   </div>
   
   
<%--</div>

   
    --%><script>
    $(function(){
    	String.prototype.trim = function(){
    		return this.replace(/^\s*|\s*$/g,'');
    	}
		
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
             					'<input type="text" style="color:red;width:80px;border:none;text-align:center;"  class="total" value="',showNum,'">',
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
		var $backBtn  =$(".back");
		var $host =location.host;
		
		$backBtn.click(function(){
			location.href ="http://"+ $host+"/booking/list";

			})

        })
    
    <%--
    $(function(){
    var bookingId = $('#bookingId').val();
     var $submitBtn = $('#booking_btn');
	$submitBtn.on("click",function(){
        $.ajax({
            url:"../../booking/importBooking/"+bookingId,
            type:"post",
            data:$("#bookingForm").serialize(),
            dataType:"json",
            success:function(rs){
                if(rs.status == 1){
                	alert('委托单提交成功');
                }else{
                    alert(rs.msg);
                }
            },
            error:function(rs){
                alert('系统忙，提交失败，请稍后重试');
            }
        });
    });
    })
    --%></script>
</body>
</html>