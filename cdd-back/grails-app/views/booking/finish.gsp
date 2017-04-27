
<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE html>
<html>

<head lang="en">
<meta charset="UTF-8">
<meta name="layout" content="main">
<title>订舱结单</title>
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
<asset:stylesheet src="book_view.css" />
<style>
        .so_information{

            width: 100%;

        }
        .so_information .color{
            color: red;
            text-align: right;
            font-weight: normal;

        }
        .so_information .input_box{
            display: inline-block;
            *display: inline;
            *zoom: 1;
            width:150px;
            height: 25px;
            margin-left: 10px;
           
            text-align: center;

        }
        .so_information .num_box{
            display: inline-block;
            *display: inline;
            *zoom: 1;
            width:50px;
            height: 18px;
            float: left;
            margin:2px  5px; ;
            text-align: center;

        }
        .so_information .input_box>li{
            float: left;

        }
        .so_information .input_box>.name{
            width:40px;
            font-size: 12px;
            line-height: 25px;


        }
        .so_information .minus,.so_information .addition{
            width: 15px;
            height: 15px;
            float: left;
            margin: 4px 0;
            cursor: pointer;
        }
        .so_information .minus{
            background: url("../../images/minus.png") no-repeat;

        }
        .so_information .addition{
            background: url("../../images/addition.png") no-repeat;

        }



        .so_information .title{
            margin-left: 10px;
            font-size: 12px;
            text-align: right;
        }
    </style>
</head>
<body>
	<%--<div class="row">
		--%><div class="col-lg-12">
			<div class="block">
    <div class="content">
        <div class="shipping_price_info" style="height:180px">
            <div class="header">
           
                <span class="title">运价编号</span>
                <span class="info">${data.data.info.id}</span>
            </div>
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
                                	 <div class="title price"  style="color:red">${data.data.info.prices?.gp20Vip}</div>
                                </li>
                                <li class="box_common">
                                    <div class="title">40GP</div>
                                    <div class="title price" id="price_40gp">${data.data.info.prices?.gp40}</div>
                                	 <div class="title price"  style="color:red">${data.data.info.prices?.gp40Vip}</div>
                                </li>
                                <li class="box_common">
                                    <div class="title">40HP</div>
                                    <div class="title price" id="price_40hq">${data.data.info.prices?.hq40}</div>
                                     <div class="title price"  style="color:red">${data.data.info.prices?.hq40Vip}</div>
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
                                   <%--  <ul class="list">
                                        <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                        <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                         <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                         <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                         <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                         <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                         <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                         <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                         <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                         <li class="list_style">
                                            <span class="name">ACF</span>
                                            <span class="price">$232323</span>
                                        </li>
                                    </ul>--%>
                                    
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
                            <input type="text" class="show_style" readonly="readonly" name="shippingDays" value="${data.data.info.shippingDays }"/>
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
                            <input type="text" class="show_style" readonly="readonly" name="transType" value="${data.data.info.transType?.text }"/>
                        </td>
                        <td>
                            <b class="com_title_pop">限重：</b>
                            <input type="text" class="show_style" readonly="readonly" name="weightLimit" value="${data.data.info.weightLimit }"/>
                        </td>
                    </tr>
                </table>

            </div>
        </div>

        <div class="booking_info">
            <div class="header">
                <span class="title">Booking</span>
            </div>
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
                    <div class="party_msg">
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
                             <input type="hidden" class="local_all" value=${data.data.info.prices?.extra}>
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
                                    <div class="EN">Number of packages</div>
                                        <div class="CN">（包装/件数） 	</div>
                                        

                                    </td>
                                    <td class="quantity">
                                        <div class="EN">Quantity</div>
                                        <div class="CN">(集装箱数量)</div>

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
				     <input type="hidden" name="gp20Num"  id="gp20num" value="${data.data.gp20Num }">
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
					<input type="hidden" name="gp40Num"  id="gp40num" value="${data.data.gp40Num }">
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
				    <input type="hidden" name="hq40Num"  id="hq40Num" value="${data.data.hq40Num }">
				    
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
                                <span class="price"> ${data.data.ofMoney }</span>
                            </div>
                            <div class="OF">
                                <span class="name"> local：</span>
                                <span class="price" > ${data.data.localMoney }</span>
                            </div>
                            <%--<div class="local">
                                <span class="name">Local：</span>
                                <span class="price">USD 1200</span>
                            </div>
                            <div class="total">
                                <span class="name">价格合计：</span>
                                <span class="price">USD 1200</span>
                            </div>
                        --%></div>
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
    
    <form  id = "soForm" name="soInput" method="post"  enctype="multipart/form-data" action="${request.contextPath }/booking/finishReasult">
    <input type="hidden" name="bookingId" id="bookingId"
								value="${data.data.id}" />
      <div class="SO_info">
            <div class="header">
                <span class="title" style="font-weight: bold">上传S/O</span>
            </div>
			<div  class="so_information">
                <table>
                    <tr>
                        <td style="width: 70px; text-align:right;height: 30px;">
                            <span class="title"><b class="color">*</b>S/O编号</span>
                        </td>
                        <td style="width:260px;" >
                            <input type="text" class="input_box" name="soNumber">
                        </td>
                        <td style="width:70px;text-align:right">
                            <span ><b class="color">*</b>船公司</span>
                        </td>
                        <td style="width:260px;">
                            <input type="text" class="input_box" name="shipCompany">
                        </td>
                        <td style="width:70px;text-align:right">
                            <span ><b class="color">*</b>船名</span>

                        </td>
                        <td style="width:240px;">
                            <input type="text" class="input_box" name="shipName">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 70px; text-align:right;height: 30px;">
                            <span class="title"><b class="color">*</b>航次</span>
                        </td>
                        <td style="width:260px;" >
                            <input type="text" class="input_box" name="voyageNo">
                        </td>
                        <td style="width:70px;text-align:right">
                            <span ><b class="color">*</b>起始港</span>
                        </td>
                        <td style="width:260px;">
                            <input type="text" class="input_box" name="startPort">
                        </td>
                        <td style="width:70px;text-align:right">
                            <span ><b class="color">*</b>目的港</span>

                        </td>
                        <td style="width:240px;">
                            <input type="text" class="input_box" name="endPort">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 70px; text-align:right;height: 30px;">
                            <span class="title"><b class="color"></b>箱型</span>
                        </td>
                        <td style="width:260px;" >
                            <ul class="input_box">
                               <li class="name">20GP</li>
                               <li style="width:100px">
                                   <b  class="minus"></b>
                                   <input type="text" class="num_box" name="gp20Num">
                                   <b class="addition"></b>
                               </li>
                            </ul>
                        </td>
                        <td style="width:70px;text-align:right">
                            <span ><b class="color"></b></span>

                        </td>
                        <td style="width:260px;">
                            <ul class="input_box">
                                <li class="name">40GP</li>
                                <li style="width:100px">
                                    <b  class="minus"></b>
                                    <input type="text" class="num_box" name="gp40Num">
                                    <b class="addition"></b>
                                </li>
                            </ul>
                        </td>
                        <td style="width:70px;text-align:right">
                            <span ><b class="color"></b></span>

                        </td>
                        <td style="width:240px;">
                            <ul class="input_box">
                                <li class="name">40HQ</li>
                                <li style="width:100px">
                                    <b  class="minus"></b>
                                    <input type="text" class="num_box" name="hq40Num">
                                    <b class="addition"></b>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 70px; text-align:right;height: 30px;">
                            <span class="title"><b class="color">*</b>截关日</span>
                        </td>
                        <td style="width:260px;" >
                            <input type="text" class="input_box" id="closingDate" name="endDate">
                        </td>
                        <td style="width:70px;text-align:right">
                            <span ><b class="color">*</b>开船日</span>
                        </td>
                        <td style="width:260px;">
                            <input type="text" class="input_box" id="startDate" name="startShipDate">
                        </td>
                        <td style="width:70px;text-align:right">
                            <span ><b class="color">*</b>上传附件</span>

                        </td>
                        <td style="width:240px;">
                            <input type="file" class="input_box" id = "file" name="file" >
                        </td>
                    </tr>


                </table>
			</div>
          
        <div class="reason_info">
            <div class="commodity " style="border:none">
                <div class="title" style="border:none">不通过原因</div>
                <textarea class="msg" id="failReason"></textarea>
                  <input type="hidden" name="failReason" id="fail_reason">
            </div>
            <div class="remark" style="border:none">
                <div class="title" style="border:none">备注</div>
                <textarea class="msg" id="remark"></textarea>
                <input type="hidden" name="remark" id="remarks">
                <input type="hidden" name="status" id="status">
            </div>
        </div>
        <div class="btn_area">
            <div class="box">
                <a href="javascript:void(0)" class="booking_btn" id ="pass_btn">结单通过</a>
                <a href="javascript:void(0)" class="so_btn"  id="refuse_btn">结单不通过</a>
                <a href="javascript:void(0)" class="back"  id="back">返回</a>
            </div>
        </div>

    </div>
   </div>
  </div>
  </div>
 </div>
 
 </form>
 
  
    <script>
        $(function(){
            String.prototype.trim =function(){
                return   this.replace(/(^\s*)|(\s*$)/g,"");
            };
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
    		
    		//SO页面删选
    		 
    		$(".SO_info input[type='text']").not(".num_box").not("input[name='startShipDate']").not("input[name='endDate']").not("input[type='file']").blur(function(){
    			if($(this)&&!$(this).val().trim()){
    				alert("数据不能为空")
    			}
    		})
    		$(".input_box  input").blur(function(){
    			if($(this).val().trim()&& !/^\d+$/g.test($(this).val().trim())){
    				alert("格式错误，请输入数字")
    			}
    		
    		})
    		
    		


            
            var minusBtn = $(".minus");
            $(".minus").click(function(){
                var siblingsEl =$(this).parent().find(".num_box");
                var siblingsElVal =siblingsEl.val().trim();
                if(siblingsElVal&&(/\d+/.test(siblingsElVal))){

                   var ParseIntVal = parseInt(siblingsElVal);
                    if(ParseIntVal>0) {
                        ParseIntVal--;
                        siblingsEl.val(ParseIntVal);
                    }
                }
            });
            $(".addition").click(function(){
                var siblingsEl =$(this).parent().find(".num_box");
                var siblingsElVal =siblingsEl.val().trim();
                if(!siblingsElVal){
                    siblingsEl.val("1");
                }
                else if(siblingsElVal&&(/\d+/.test(siblingsElVal))){
                    var ParseIntVal = parseInt(siblingsElVal);
                        ParseIntVal++;
                        siblingsEl.val(ParseIntVal);
                }
            })
            var passBtn =$("#pass_btn");
            var refuseBtn  =$("#refuse_btn");
            var back  =$("#back");
             var msg ='' ;
             var totalInputEl =$(".so_information input").not(".num_box");
            passBtn.click(function(){        	
            	msg = '';
            	totalInputEl.each(function(){
            		if(!($(this).val().trim())){            			
            			msg = $(this).prop('name') + '不能为空';
            			
            		} 
            		 
            	//	return msg;          		       		                      	
            		
            	})
           
           if(msg){
            		alert(msg);
            		return
           }else{    	            	            	
             $("#status").val("1");
              $("#remarks").val($("#remark").val().trim());
               $("#soForm").submit();
           } 
            });		
            
            refuseBtn.click(function(){
                if($("#failReason").val()){
                    $("#status").val("0");
                    $("#fail_reason").val($("#failReason").val().trim());
                    $("#remarks").val($("#remark").val().trim());
                    $("#soForm").submit();
                }
                else{
                    alert("审核意见不能为空！")
                }
            })
             back.click(function(){
						history.back()
					  });
            
                $("#closingDate").datepicker();
                $("#startDate").datepicker()
        })
		
    </script>
</body>
</html>