<%@page import="com.cdd.base.enums.FrontUserType"%>
<!DOCTYPE html>
<html>
<head>
<title>员工数据统计</title>
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
	$('#list').bootstrapTable({
		url : '${request.contextPath}/statStaff/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '姓名';
		},
		columns : [ {
			field : 'firstname',
			title : '姓名'
		}, {
			field : 'importCargoUsers',
			title : '导入货主数',
			sortable : true
		//formatter: nameFormatter
		}, {
			field : 'importAgentUsers',
			title : '导入货代数',
			sortable : true
		//formatter: nameFormatter
		}, {
			field : 'importOrders',
			title : '导入订单数',
			sortable : true
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, {
			field : 'importShipInfos',
			title : '导入航线数',
			sortable : true
		//  events: operateEvents
		}, {
			field : 'orderPassed',
			title : '审核订单数',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'shipPassed',
			title : '审核航线数',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'tradeSuccess',
			title : '撮合成功数',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'certPassed',
			title : '审核凭证成功数',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}]
	});

});

</script>
</body>
</html>
