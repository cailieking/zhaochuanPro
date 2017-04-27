<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>委托单 - 找船网</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">

<style type="text/css">
.ui-datepicker-title {
	color: #555555;
}
.booking_form{
	margin: 0 auto;
	clear: both;
	overflow: hidden;
	width:1140px;
}
.booking_form label, .booking_form table th{
	font-weight:normal;
}
.booking_form .panel-heading{
	/* font-weight:bold; */
}
.booking_form .form-control{
	border:1px solid #999;
}
.booking_form .text-danger{
	color:#f00;
}
</style>
<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery-ui.js"></script>
<body>
	<div class="booking_form">
		<h1 style="text-align:center">委托单 BOOKING FORM</h1>
		<form id="booking-form">
			<table class="table">
				<tr>
					<td colspan="2" style="border-top: 2px solid #999;">
						<div class="col-md-3">
						<div class="form-group">
							<label><span class="text-danger">*</span> Service Contract No. (合约号)</label>
							<input type="text" placeholder="" name="serviceContractNo" class="form-control">
						</div>
						</div>
						<div class="col-md-3">
						<div class="form-group">
							<label>Export Licence No. (出口许可证)</label>
							<input type="text" placeholder="" name="exportLicenseNo" class="form-control">
						</div>
						</div>
						<div class="col-md-3">
						<div class="form-group">
							<label>Booking Date (订舱时间)</label>
							<input type="text" placeholder="" name="bookingDate" class="form-control datepicker">
						</div>
						</div>
						<div class="col-md-3">
						<div class="form-group">
							<label>Booking No. (订舱号)</label>
							<input type="text" placeholder="" name="bookingNo" class="form-control">
						</div>
						</div>
					</td>
				</tr>
				<tr class="form-horizontal">
					<td width="50%" style="border-top: 2px solid #999;">

						<div class="panel panel-default">
							<div class="panel-heading"><span class="text-danger">*</span> Booked By (订舱人) (complete name and address)</div>
							<div class="panel-body">
								<div class="form-group">
									<label  class="col-sm-2 control-label">Name</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="bookedByName" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">Contact</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="bookedByContact" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">Email</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="bookedByEmail" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">TEL</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="bookedByTel" class="form-control">
									</div>
								</div>
							</div>
						</div>

						<div class="panel panel-default">
							<div class="panel-heading">Shipper (托运人) (complete name and address)</div>
							<div class="panel-body">
								<div class="form-group">
									<label  class="col-sm-2 control-label">Name</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="shipperName" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">Contact</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="shipperContact" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">Email</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="shipperEmail" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">TEL</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="shipperTel" class="form-control">
									</div>
								</div>
							</div>
						</div>

						
						<div class="panel panel-default">
							<div class="panel-heading">Notify Party (到货通知人) (complete name and address)</div>
							<div class="panel-body">
								<div class="form-group">
									<label  class="col-sm-2 control-label">Name</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="notifyName" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">Contact</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="notifyContact" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">Email</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="notifyEmail" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">TEL</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="notifyTel" class="form-control">
									</div>
								</div>
							</div>
						</div>

						

						<div class="panel panel-default">
							<div class="panel-heading">Consignee (收货人) (complete name and address)</div>
							<div class="panel-body">
								<div class="form-group">
									<label  class="col-sm-2 control-label">Name</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="consigneeName" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">Contact</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="consigneeContact" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">Email</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="consigneeEmail" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">TEL</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="consigneeTel" class="form-control">
									</div>
								</div>
							</div>
						</div>


						
					</td>


					<td width="50%" style="border-top: 2px solid #999;">

						<div class="panel panel-default">
							<div class="panel-heading"><span class="text-danger">*</span> Contractual Customer (运输合同签约人) (complete name and address)</div>
							<div class="panel-body">
								<div class="form-group">
									<label  class="col-sm-2 control-label">Name</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="customerName" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">Contact</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="customerContact" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">Email</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="customerEmail" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">TEL</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="customerTel" class="form-control">
									</div>
								</div>
							</div>
						</div>

						<div class="panel panel-default">
							<div class="panel-heading">运费 (Rate)</div>
							<div class="panel-body">
								<div class="form-group">
									<label  class="col-sm-2 control-label">O/F</label>
									<div class="col-sm-10">
										<input type="text" placeholder="" name="of" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">THC/ORC</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="thc" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">EIR</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="eir" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">DOC</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="doc" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">EBS</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="ebs" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">ISPS</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="isps" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">CIC</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="cic" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">SEAL</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="seal" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">TLX</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="tlx" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label  class="col-sm-2 control-label">ENS/AMS</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="ens" class="form-control">
									</div>
									<label  class="col-sm-2 control-label">OTHERS</label>
									<div class="col-sm-4">
										<input type="text" placeholder="" name="others" class="form-control">
									</div>
								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="border-top: 2px solid #999;">
						<div class="col-md-3">
							<div class="form-group">
								<label><span class="text-danger">*</span> Place of Receipt(装货地)</label>
								<input type="text" placeholder="" name="receiptPlace" class="form-control">
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label>Port of Loading(装货港)</label>
								<input type="text" placeholder="" name="loadingPort" class="form-control">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label><span class="text-danger">*</span> Service Mode at Origin (起运港运输方式)</label>
								<div class="radio">
									<label>
										<input type="radio" name="radio_qygysfs" value="cy"> CY
										<div style="display:none;"><input type="text" name="originCY"></div>
									</label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label>
										<input type="radio" name="radio_qygysfs" value="cfs"> CFS
										<div style="display:none;"><input type="text" name="originCFS"></div>
									</label>

								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="col-md-3">
							<div class="form-group">
								<label>Port of Discharge(卸货港)</label>
								<input type="text" placeholder="" name="dischargePort" class="form-control">
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label><span class="text-danger">*</span> Place of Delivery(目的地)</label>
								<input type="text" placeholder="" name="deliveryPlace" class="form-control">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label><span class="text-danger">*</span> Service Mode at Destination (目的港运输方式)</label>
								<div class="radio">
									<label>
										<input type="radio" name="radio_mdfysfs" value="cy"> CY
										<div style="display:none;"><input type="text" name="destinationCY"></div>
									</label>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<label>
										<input type="radio" name="radio_mdfysfs" value="cfs"> CFS
										<div style="display:none;"><input type="text" name="destinationCFS"></div>
									</label>
								</div>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="col-md-3">
							<div class="form-group">
								<label>Ocean Vessel Name / Voyage No.(船名/航次)</label>
								<input type="text" placeholder="" name="voyageNo" class="form-control">
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label>Pre-Carriage By</label>
								<input type="text" placeholder="" name="precarriage" class="form-control">
							</div>
						</div>
						<div class="col-md-3">
							<div class="form-group">
								<label><span class="text-danger">*</span> ETD(Y/M/D) (预计装船时间)</label>
								<input type="text" placeholder="" name="etd" class="form-control datepicker">
							</div>
						</div>

						<div class="col-md-3">
							<div class="form-group">
								<label>Final Destination (for information only)</label>
								<input type="text" placeholder="" name="finalDestination" class="form-control">
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="border-top: 2px solid #999;">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th rowspan="2"><span class="text-danger">*</span> Contaier Type(集装箱型)</th>
									<th rowspan="2"><span class="text-danger">*</span> Quantity(集装箱数量)</th>
									<th rowspan="2"><span class="text-danger">*</span> Commodity(货品描述)</th>
									<th rowspan="2"><span class="text-danger">*</span> Total Weight(KGS)(毛重：公斤)</th>
									<th rowspan="2">Total Volume(CBM)(体积：立方米)</th>
									<th colspan="4" style="text-align:center;">Information for Reefer(冻柜信息)</th>
								</tr>
								<tr>
									<th>Temperature(温度)(Celsius)</th>
									<th>Humidity(湿度)(%)</th>
									<th>Probes Number</th>
									<th>Ventilation Volume(cbm/hr)</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th>20'</th>
									<td><input type="text" placeholder="" name="quantity20" class="form-control"></td>
									<td rowspan="6"><textarea rows="14" name="commodity" style="resize:none;" class="form-control"></textarea></td>
									<td><input type="text" placeholder="" name="weight20" class="form-control"></td>
									<td><input type="text" placeholder="" name="cbm20" class="form-control"></td>
									<td><input type="text" placeholder="" name="temperature20" class="form-control"></td>
									<td><input type="text" placeholder="" name="humidity20" class="form-control"></td>
									<td><input type="text" placeholder="" name="probes20" class="form-control"></td>
									<td><input type="text" placeholder="" name="volume20" class="form-control"></td>
								</tr>
								<tr>
									<th>40'</th>
									<td><input type="text" placeholder="" name="quantity40" class="form-control"></td>
									<td><input type="text" placeholder="" name="weight40" class="form-control"></td>
									<td><input type="text" placeholder="" name="cbm40" class="form-control"></td>
									<td><input type="text" placeholder="" name="temperature40" class="form-control"></td>
									<td><input type="text" placeholder="" name="humidity40" class="form-control"></td>
									<td><input type="text" placeholder="" name="probes40" class="form-control"></td>
									<td><input type="text" placeholder="" name="volume40" class="form-control"></td>
								</tr>
								<tr>
									<th>40' HQ</th>
									<td><input type="text" placeholder="" name="quantity40hq" class="form-control"></td>
									<td><input type="text" placeholder="" name="weight40hq" class="form-control"></td>
									<td><input type="text" placeholder="" name="cbm40hq" class="form-control"></td>
									<td><input type="text" placeholder="" name="temperature40hq" class="form-control"></td>
									<td><input type="text" placeholder="" name="humidity40hq" class="form-control"></td>
									<td><input type="text" placeholder="" name="probes40hq" class="form-control"></td>
									<td><input type="text" placeholder="" name="volume40hq" class="form-control"></td>
								</tr>
								<tr>
									<th>45'</th>
									<td><input type="text" placeholder="" name="quantity45" class="form-control"></td>
									<td><input type="text" placeholder="" name="weight45" class="form-control"></td>
									<td><input type="text" placeholder="" name="cbm45" class="form-control"></td>
									<td><input type="text" placeholder="" name="temperature45" class="form-control"></td>
									<td><input type="text" placeholder="" name="humidity45" class="form-control"></td>
									<td><input type="text" placeholder="" name="probes45" class="form-control"></td>
									<td><input type="text" placeholder="" name="volume45" class="form-control"></td>
								</tr>
								<tr>
									<th>40' HQ reefer</th>
									<td><input type="text" placeholder="" name="quantity40hqReefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="weight40hqReefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="cbm40hqReefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="temperature40hqReefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="humidity40hqReefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="probes40hqReefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="volume40hqReefer" class="form-control"></td>
								</tr>
								<tr>
									<th>20' reefer</th>
									<td><input type="text" placeholder="" name="quantity20Reefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="weight20Reefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="cbm20Reefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="temperature20Reefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="humidity20Reefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="probes20Reefer" class="form-control"></td>
									<td><input type="text" placeholder="" name="volume20Reefer" class="form-control"></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td style="border-top: 2px solid #999;">
						<div class="form-group">
							<label>Remarks(订舱人备注)</label>
							<textarea style="resize:none;" rows="5" name="remark" class="form-control"></textarea>
						</div>
					</td>
					<td style="border-top: 2px solid #999;">
						<div class="form-group">
							<label>Singnature & chop of booked by party: (订舱人签字盖章)</label>
							<input type="text" placeholder="" name="signature" class="form-control">
						</div>
						<div class="form-group form-horizontal" >
							<label>Person in charge: (经办人)</label>
							<div class="form-group">
								<label  class="col-sm-1 control-label">TEL</label>
								<div class="col-sm-5">
									<input type="text" placeholder="" name="chargeTel" class="form-control">
								</div>
								<label  class="col-sm-1 control-label">EMAIL</label>
								<div class="col-sm-5">
									<input type="text" placeholder="" name="chargeEmail" class="form-control">
								</div>
							</div>
						</div>
					</td>
				</tr>
			</table>
			<p style="text-align:center;">
				<button type="button" class="btn btn-primary btn-lg" id="submit-btn">提交</button>
				<button type="button" class="btn btn-default btn-lg" id="return-btn">返回</button>
			</p>
		</form>
	</div>
	<div class="backpage backtools needtop"></div>
<script>
(function(){
	$(".datepicker").datepicker();
	var $bookingForm = $('#booking-form');
	$bookingForm.find('input[type=text]').val('');
	$bookingForm.find('textarea').val('');
	$bookingForm.find('input[type=radio]').each(function() {
		$(this)[0].checked = false;
	});
})();
(function(){
	var orderId = $.getUrlVar("id") || '';
	if(!orderId){
		alert('参数错误');
		location.href = '/member/cargolist';
	}
	$('input[name=radio_qygysfs]').click(function(){
		var val = $('input[name=radio_qygysfs]:checked').val();
		if(val == 'cy'){
			$('input[name=originCY]').val('true');
			$('input[name=originCFS]').val('');
		}else if(val == 'cfs'){
			$('input[name=originCY]').val('');
			$('input[name=originCFS]').val('true');
		}else{
			$('input[name=originCY]').val('');
			$('input[name=originCFS]').val('');
		}
	});

	$('input[name=radio_mdfysfs]').click(function(){
		var val = $('input[name=radio_mdfysfs]:checked').val();
		if(val == 'cy'){
			$('input[name=destinationCY]').val('true');
			$('input[name=destinationCFS]').val('');
		}else if(val == 'cfs'){
			$('input[name=destinationCY]').val('');
			$('input[name=destinationCFS]').val('true');
		}else{
			$('input[name=destinationCY]').val('');
			$('input[name=destinationCFS]').val('');
		}
	});

	var $submitBtn = $('#submit-btn');
	$submitBtn.on("click",function(){
        $.ajax({
            url:SITE_URL+"order/saveBooking/"+orderId,
            type:"post",
            data:$("#booking-form").serialize(),
            dataType:"json",
            beforeSend:function(){
                $submitBtn.prop("disabled",true);
            },
            success:function(rs){
                if(rs.status == 1){
                	alert('委托单提交成功');
                	location.href = '/member/cargolist';
                }else{
                    alert(rs.msg);
                }
            },
            error:function(rs){
                alert('系统忙，提交失败，请稍后重试');
            },
            complete:function(){
            	$submitBtn.prop("disabled",false);
            }
        });
    });
    $('#return-btn').click(function(){
    	location.href = '/member/cargolist';
    	return false;
    });
})();

/* for test */
// $('input[type=text],textarea').each(function(){
// 	$(this).val($(this).attr('name'));
// });
/* for test */
</script>
</body>
</html>