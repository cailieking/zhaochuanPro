<g:set var="springSecurityService" bean="springSecurityService" />
<%@page import="com.cdd.base.enums.Status"%>
<%@page import="com.cdd.base.enums.OrderStatus"%>
<!DOCTYPE html>
<html>
<head>
<title>订单交易列表</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
</head>
<body>
	<%--<div class="row">
		--%><div class="col-lg-12">
			<div class="block">
				<table id="list"></table>
			</div>
		</div>
	<%--</div>
	
--%><script>

$(function() {
	var statusSelect = $([
   		'<select class="selectpicker" style="float:right; margin-left: 10px;">',
   		'<option value="">全部</option>', 
   		<g:each in="${OrderStatus.values()}" var="status">
   		'<option value="${status.name()}">${status.text}</option>', 
   		</g:each>
   		'</select>' 
   	].join(''))
	
	$('#list').bootstrapTable({
		url : '${request.contextPath}/orderTrade/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '订单号/货物/公司/联系人';
		},
		columns : [ {
			field : 'number',
			title : '订单号',
			sortable : true
		}, {
			field : 'cargoName',
			title : '货物',
			sortable : true
		//formatter: nameFormatter
		}, {
			field : 'companyName',
			title : '公司',
			sortable : true
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, {
			field : 'contactName',
			title : '联系人',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'city',
			title : '所在地',
			sortable : true,
			formatter: function(city, row, index) {
				if(city) {
					return city.name
				} else {
					return null
				}
			}
		//  events: operateEvents
		}, {
			field : 'startPort',
			title : '始发港',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'endPort',
			title : '目的港',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				if(row.orderStatus == '${OrderStatus.UnTrade.name()}') {
					if(row.owner) {
						return [
								'<a class="datatable_operation edit" href="javascript:void(0)">',
								'修改', 
								'</a>', 
								'<a class="datatable_operation recommend" href="javascript:void(0)">',
								'推送', 
								'</a>' 
						].join('');
					} else {
						return [
								'<a class="datatable_operation edit" href="javascript:void(0)">',
								'修改', 
								'</a>', 
								'<a class="datatable_operation recommend" href="javascript:void(0)">',
								'撮合', 
								'</a>' 
						].join('');
					}
				} else if(row.orderStatus == '${OrderStatus.TradeSuccess.name()}') {
					if(row.bookingFilePath) {
						return [
								'<a class="datatable_operation edit" href="javascript:void(0)">',
								'修改', 
								'</a>', 
								'<a class="datatable_operation checkDelegate" target="preview" href="${request.contextPath}/',
								row.bookingFilePath,
								'">',
								'查看委托单', 
								'</a>' 
						].join('');
					} else {
						return [
								'<a class="datatable_operation edit" href="javascript:void(0)">',
								'修改', 
								'</a>' 
						].join('');
					}
				} else if(row.orderStatus == '${OrderStatus.CertPassed.name()}') {
					return [
							'<a class="datatable_operation edit" href="javascript:void(0)">',
							'修改', 
							'</a>', 
							'<a class="datatable_operation checkDelegate" target="preview" href="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/',
							row.bookingFilePath,
							'">',
							'查看委托单', 
							'</a>',
							'<a class="datatable_operation checkDelegate" target="preview" href="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/',
							row.certFilePath,
							'">',
							'查看上传凭证', 
							'</a>'  
					].join('');
				} else {
					return [
							'<a class="datatable_operation edit" href="javascript:void(0)">',
							'修改', 
							'</a>'
					].join('');
				}
			},
			events : operateEvents
		} ],
		queryParams: function (params) {
			params.status = statusSelect.val()
			return params;
		}
	});

	
	$(".datatable-search-btn").before(statusSelect);
	statusSelect.change(function() {
		$(".datatable-search-btn").click()
	});

	var intervalId = window.setInterval(function() {
		var el = $(".bootstrap-select");
		if(el.size() > 0) {
			el.css("float", "right").css("marginLeft", "10px").css("marginTop", "-2px");
			window.clearInterval(intervalId);
		}
	}, 10);

});


window.operateEvents = {
	'click .edit' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}/orderTrade/data/' + row.id;
	},
	'click .recommend' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}/recommendAgent/list/' + row.id;
	},
};

</script>
</body>
</html>
