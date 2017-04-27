<%@page import="com.cdd.base.enums.OrderStatus"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/button.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap-table.css">
<link rel="stylesheet" type="text/css" href="../css/font-awesome/css/font-awesome.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<%-- some comment --%>
<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script src="../js/bootstrap-table.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/ajaxfileupload.js"></script>
<%-- some comment --%>
</head>
<body>
<div class="w960">


<div class="right my_buy">
<p class="headtitle"><span>我的订单</span></p>

<div class="row">
	<div class="col-lg-12">
		<div class="block">
			<table id="list"></table>
		</div>
	</div>
</div>

<script>
$(function() {
	
	var statusSelect = $([
  		'<span style="float:right;  margin: 0 10px;">状态：<select id="query_status" class="selectpicker" >',
  		'<option value="">全部</option>', 
   		<g:each in="${OrderStatus.values()}" var="status">
   		<g:if test="${status != OrderStatus.UnTrade && status != OrderStatus.InTrade}">
   		'<option value="${status.name()}">${status.text}</option>', 
   		</g:if>
   		</g:each>
  		'</select></span>' 
  	].join(''))
	                 	
	$('#list').bootstrapTable({
		url : SITE_URL+'ship/myOrders',
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '搜索 航线名称 | 起始港 | 目的港';
		},
		columns : [ 
		  //{
			//field : 'routeName',
			//title : '航线名称',
			//sortable : true,
			//formatter : function (value, row, index) {
				//return [
					//row.info.routeName?row.info.routeName:''
				//].join('');
			//}
		  //},
		{
			field : 'startPort',
			title : '起始港',
			sortable : true,
			formatter : function (value, row, index) {
				var startPort = row.info.startPort?row.info.startPort:'';
				var startPortCn = row.info.startPortCn?row.info.startPortCn:'';
				return [startPort+"<br />"+startPortCn];
			}
		}, {
			field : 'endPort',
			title : '目的港',
			sortable : true,
			formatter : function (value, row, index) {
				var endPort = row.info.endPort?row.info.endPort:'';
				var endPortCn = row.info.endPortCn?row.info.endPortCn:'';
				return [endPort+"<br />"+endPortCn];
			}
		}, {
			field : 'startDate',
			title : '有效期始',
			sortable : true,
			width: 110,
			formatter : function (value, row, index) {
				return [
					row.info.startDate?row.info.startDate:''
					//((row.info.startDate?row.info.startDate:'')+'至<br/>'+(row.info.endDate?row.info.endDate:''))
				].join('');
			}//,
		}, {
			field : 'id',
			title : '航运信息',
			formatter : function (value, row, index) {
				var startPort = row.info.startPort ? row.info.startPort : '';
				var endPort = row.info.endPort ? row.info.endPort : '';
				var shipCompany = row.info.shipCompany ? row.info.shipCompany : '';
				var middlePort = row.info.middlePort ? row.info.middlePort : '';
				var routeName = row.info.routeName ? row.info.routeName : '';
				var remark = row.info.remark ? row.info.remark : '';
				return [
						'<div class="dt_oper_view" href="javascript:void(0)" style="color:#6699FF;" onmouseover="viewDetail(this)" onmouseout="hideDetail(this)" > <span class="glyphicon glyphicon-eye fa fa-eye table-icon"></span>',
						'查看', 
						'<div class="dt_oper_view_div pos2" style="display: none;right:-319px;top:-120px;">',
						'<table>',
							'<tr><td class="td4">起始港:</td><td title='+startPort+'><a class="td1">'+startPort+'</a></td><td class="td0">目的港:</td><td title='+endPort+'><a class="td1">'+endPort+'</a></td><td class="td0">船公司:</td><td title='+shipCompany+'><a class="td1">'+shipCompany+'</a></td></tr>',
							'<tr><td class="td4">运输种类:</td><td><a class="td1">'+(row.info.transType?row.info.transType:'')+'</a></td><td class="td0">开船日:</td><td><a class="td1">'+(row.info.shippingDay?row.info.shippingDay:'')+'</a></td><td class="td0">中转港:</td><td title='+middlePort+'><a class="td1">'+middlePort+'</a></td></tr>',
							'<tr><td class="td4">航线名称:</td><td colspan="3" title='+routeName+'><a class="td2">'+routeName+'</a></td><td class="td0">航程:</td><td><a class="td1">'+(row.info.shippingDays?row.info.shippingDays:'')+'</a></td></tr>',
							'<tr><td class="td4">柜型运价:</td><td colspan="5"><a class="td3">'+((row.info.gp20?(row.info.gp20+"美元/20'GP   "):'')+(row.info.gp40?(row.info.gp40+"美元/40'GP   "):'')+(row.info.hq40?(row.info.hq40+"美元/40'HQ   "):'')+(row.info.hq45?(row.info.hq45+"美元/45'HQ"):''))+'</a></td></tr>',
							'<tr><td class="td4">附加费:</td><td><a class="td1">'+(row.info.extra?row.info.extra:'')+'</a></td><td class="td0">有效期:</td><td colspan="3"><a class="td2">'+((row.info.startDate?row.info.startDate:'')+' 至 '+(row.info.endDate?row.info.endDate:''))+'</a></td></tr>',
							'<tr><td class="td4">备注:</td><td colspan="5" title='+remark+'><a class="td3">'+remark+'</a></td></tr>',
						'</table>',
		             	'</div>' ,
						'</div>'

				].join('');
			}//,
			//events : operateEvents
		}, {
			field : 'info',
			title : '货主信息',
			width : 150,
			sortable : false,
			formatter : function (value, row, index) {
				if (row.info) {
					var startPort = row.startPort ? row.startPort : '';
					var endPort = row.endPort ? row.endPort : '';
					var cargoName = row.cargoName ? row.cargoName : '';
					var companyName = row.companyName ? row.companyName : '';
					var companyFullName = row.companyFullName  ? row.companyFullName : '';
					var cargoBoxType = row.cargoBoxType ? row.cargoBoxType : '';
					var cargoBoxNums = row.cargoBoxNums ? row.cargoBoxNums : '';
					var transType = row.transType ? row.transType : '';	
					var wholeStyle = transType == '整箱' ?  ""  : "display:none;";
					var togetherStyle = transType == '整箱' ? "display:none;" : "" ;

					return [
						'<div class="dt_oper_view" href="javascript:void(0)" style="color:#6699FF;" onmouseover="viewDetail(this)" onmouseout="hideDetail(this)" >',
						companyName,  
						'<div class="dt_oper_view_div pos2" style="display: none;right:-200px;top:-120px;">',
						'<table>',
							'<tr><td class="td4">货主公司:</td><td colspan="5" title='+companyFullName+'><a class="td3">'+companyFullName+'</a></td></tr>',
							'<tr><td class="td4">起始港:</td><td title='+startPort+'><a class="td1">'+startPort+'</a></td><td class="td0">目的港:</td><td title='+endPort+'><a class="td1">'+endPort+'</a></td><td class="td0">运输种类:</td><td><a class="td1">'+transType+'</a></td></tr>',
							'<tr><td class="td4">走货日期:</td><td colspan="3"><a class="td2">'+((row.startDate?row.startDate:'')+' 至 '+(row.endDate?row.endDate:''))+'</a></td><td class="td0">报价截至:</td><td><a class="td1">'+(row.biteEndDate?row.biteEndDate:'')+'</a></td></tr>',
							'<tr><td class="td4">货物名称:</td><td colspan="3" title='+cargoName+'><a class="td2">'+cargoName+'</a></td><td class="td0">货物类型:</td><td><a class="td1">'+(row.orderType?row.orderType:'')+'</a></td></tr>',
							'<tr style="'+togetherStyle+'"><td class="td4">件数:</td><td><a class="td1">'+(row.cargoNums?row.cargoNums:'')+'</a></td><td class="td0">毛重:</td><td><a class="td1">'+(row.cargoWeight?row.cargoWeight:'')+'</a></td><td class="td0">体积:</td><td><a class="td1">'+(row.cargoCube?row.cargoCube:'')+'</a></td></tr>',
							'<tr style="'+togetherStyle+'"><td class="td4">单位尺寸:</td><td colspan="5"><a class="td3">'+((row.cargoWidth?("宽"+row.cargoWidth+"CM   "):'')+(row.cargoHeight?("高"+row.cargoHeight+"CM   "):'')+(row.cargoLength?("长"+row.cargoLength+"CM   "):''))+'</a></td></tr>',
							'<tr style="'+wholeStyle+'"><td class="td4">柜型:</td><td colspan="5"><a class="td3">'+cargoBoxType+' * '+cargoBoxNums+'</a></td></tr>',
						'</table>',
		             	'</div>' ,
						'</div>',
					].join('');
				}
			}//,
		}, {
			field : 'id',
			title : '相关文件',
			formatter : function (value, row, index) {
				var htmlList = [];
				if(!!row.bookingFilePath){
					htmlList.push('<p><a style="color:#6699FF;text-decoration:underline;" href="'+row.bookingFilePath+'" target="_blank">委托单</a></p>');
				}
				if(!!row.isoFilePath || !!row.certFilePath){
					htmlList.push('<p>')
					if(!!row.isoFilePath){
						htmlList.push('<a style="color:#6699FF;text-decoration:underline;" href="'+row.isoFilePath+'" target="_blank">I/S</a>&nbsp;&nbsp;');
					}
					if(!!row.certFilePath){
						htmlList.push('<a style="color:#6699FF;text-decoration:underline;" href="'+row.certFilePath+'" target="_blank">凭证</a>');
					}
					htmlList.push('</p>')
				}
				if(htmlList.length == 0){
					htmlList.push('-');
				}
				return htmlList.join('');
			}
		}, {
			field : 'status',
			title : '状态',
			sortable : true
		}, {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				/*
				交易撮合成功 TradeSuccess
				交易关闭 CloseTrade
				凭证待上传 CertUnupload
				凭证待审核 CertUploaded
				凭证审核中 CertInVerify
				凭证审核不通过 CertFailed
				交易成功 CertPassed
				*/
				//row.statusKey.name='CertUnupload';
				var operationArr = [];
				if(row.statusKey.name=='CertUnupload' || row.statusKey.name=='CertUploaded' || row.statusKey.name=='CertInVerify' || row.statusKey.name=='CertFailed'){
					operationArr.push('<a href="javascript:;" style="padding:0 5px;margin-top:2px;" data-orderid="'+row.id+'" data-hasiso="'+(!!row.isoFilePath ? 1 : 0)+'" class="Button uploadISBtn">上传I/S</a>');
				}
				if(row.statusKey.name=='CertUnupload' || row.statusKey.name=='CertFailed'){
					operationArr.push('<a href="javascript:;" style="padding:0 5px;margin-left:5px;margin-top:2px;" data-orderid="'+row.id+'" class="Button uploadBLBtn">上传凭证</a>');
				}
				if(operationArr.length == 0){
					operationArr.push('-');
				}
				return operationArr.join('');
			}//,
			//events : operateEvents
		}],
		queryParams: function (params) {
			params.status = $("#query_status").val()
			return params;
		}
		
	});

	$(".datatable-search-btn").after(statusSelect);
		statusSelect.change(function() {
		$(".datatable-search-btn").click()
	});

	iePlaceHolder();

});

function viewDetail(target) {
	$(".Dwt").show();
	$(target).find('.dt_oper_view_div').show();
}
function hideDetail(target) {
	$(target).find('.dt_oper_view_div').hide();
}
</script>



</div>
</div>
<div class="aui_state_focus" style="position: absolute; left: -9999em; top: 305px; width: auto; z-index: 1987;"><div class="aui_outer"><table class="aui_border"><tbody><tr><td class="aui_nw"></td><td class="aui_n"></td><td class="aui_ne"></td></tr><tr><td class="aui_w"></td><td class="aui_c"><div class="aui_inner"><table class="aui_dialog"><tbody><tr><td colspan="2" class="aui_header"><div class="aui_titleBar"><div class="aui_title" style="cursor: move;">消息</div><a class="aui_close" href="javascript:/*artDialog*/;">×</a></div></td></tr><tr><td class="aui_icon" style="display: none;"><div class="aui_iconBg" style="background: none;"></div></td><td class="aui_main" style="width: auto; height: auto;"><div class="aui_content" style="padding: 20px 25px;"><div class="aui_loading"><span>loading..</span></div></div></td></tr><tr><td colspan="2" class="aui_footer"><div class="aui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="aui_e"></td></tr><tr><td class="aui_sw"></td><td class="aui_s"></td><td class="aui_se" style="cursor: se-resize;"></td></tr></tbody></table></div></div>


<div class="modal fade" id="is-upload-modal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">上传I/S</div>
			<div class="modal-body">
				<form method="post">
					<div class="form-group">
						<label>选择I/S文件</label>
						<input type="file" id="is-upload-modal-file-input" name="file" style="border:1px solid #ddd;padding:10px;">
					</div>
					<button type="button" class="btn btn-primary" id="is-upload-modal-submit-btn">提 交</button>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>
<div class="modal fade" id="bl-upload-modal" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">上传凭证</div>
			<div class="modal-body">
				<form method="post">
					<div class="form-group">
						<label>选择凭证文件</label>
						<input type="file" id="bl-upload-modal-file-input" name="file" style="border:1px solid #ddd;padding:10px;">
					</div>
					<button type="button" class="btn btn-primary" id="bl-upload-modal-submit-btn">提 交</button>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			</div>
		</div>
	</div>
</div>


<div class="backpage backshipcargolist needtop"></div>

<script>
jQuery.extend({  
	handleError: function( s, xhr, status, e )      {  
		// If a local callback was specified, fire it  
		if ( s.error ) {  
			s.error.call( s.context || s, xhr, status, e );  
		}

		// Fire the global callback  
		if ( s.global ) {  
			(s.context ? jQuery(s.context) : jQuery.event).trigger( "ajaxError", [xhr, s, e] );  
		}  
	},
	uploadHttpData: function( r, type ) {  
        var data = !type;  
        data = type == "xml" || data ? r.responseXML : r.responseText;  
        // If the type is "script", eval it in global context  
        if ( type == "script" )  
            jQuery.globalEval( data );  
        // Get the JavaScript object, if JSON is used.  
        if ( type == "json" )  
            data = jQuery.parseJSON(data); //eval( "data = " + data );  
        // evaluate scripts within html  
        if ( type == "html" )  
            jQuery("<div>").html(data).evalScripts();  
            //alert($('param', data).each(function(){alert($(this).attr('value'));}));  
        return data;  
    }
});
(function(){
	function uploadHandler(uploadBtnClass, $uploadModal, $uploadModalSubmitBtn, fileElementId, interfacex){
		$('#list').on('click', '.'+uploadBtnClass, function(){
			if(uploadBtnClass == 'uploadISBtn'){
				var hasIso = $(this).data('hasiso');
				if(hasIso == 1){
					if(!confirm('重新上传I/S将覆盖原来的文件，确定重新上传吗？')){
						return false;
					}
				}
			}
			var orderId = $(this).data('orderid');
			$uploadModalSubmitBtn.data('orderid', orderId);
			$uploadModal.modal('show');
			return false;
		});
		$uploadModalSubmitBtn.click(function(){
			var file=$.trim($('#'+fileElementId).val());
			if(!file){
				alert('请选择文件');
				return false;
			}
			var orderId = $uploadModalSubmitBtn.data('orderid');
			$uploadModalSubmitBtn.html('上传中...').attr('disabled', true);
			$.ajaxFileUpload({
				url: SITE_URL+"order/"+interfacex+'/'+orderId,
				secureuri: false,
				fileElementId: fileElementId,
				//tag_id: orderId,
				dataType: 'json',
				success: function(rs){
					if(rs.status == 1){
						alert('上传成功');
						location.href = '/member/shipcargolist';
					}else{
						alert(rs.msg);
					}
				},
				error:function(){
					alert('上传失败，请重试');
				},
				complete: function(){
					$uploadModalSubmitBtn.html('提 交').attr('disabled', false);
				}
			});
			return false;
		});
	}

	uploadHandler('uploadISBtn', $('#is-upload-modal'), $('#is-upload-modal-submit-btn'), 'is-upload-modal-file-input', 'uploadIso');
	uploadHandler('uploadBLBtn', $('#bl-upload-modal'), $('#bl-upload-modal-submit-btn'), 'bl-upload-modal-file-input', 'uploadCert');
})();
</script>
</body></html>