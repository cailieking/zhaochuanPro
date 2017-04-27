<%@page import="com.cdd.base.enums.FrontUserType"%>
<!DOCTYPE html>
<html>
<head>
<title>新增率数据统计</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
</head>
<body>
	<%--<div class="row">--%>
		<div class="col-lg-12">
			<div class="block">
				<table id="list"></table>
			</div>
		</div>
	<%--</div>
--%><script>

$(function() {
	$('#list').bootstrapTable({
		url : '${request.contextPath}/statIncrement/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		search: false,
		columns : [ {
			field : 'newCargoRate',
			title : '货主新增率',
			sortable : true,
			formatter: function(value, row, index) {
				return value + "%"
			}
		}, {
			field : 'newAgentRate',
			title : '货代新增率',
			sortable : true,
			formatter: function(value, row, index) {
				return value + "%"
			}
		},{
			field : 'newTotalUserRate',
			title : '用户新增率',
			sortable : true,
			formatter: function(value, row, index) {
				return value + "%"
			}
		}, 
		//{
		//	field : 'newOrderRate',
		//	title : '货盘新增率',
		//	sortable : true,
		//	formatter: function(value, row, index) {
		//		return value + "%"
		//	}
		//}, 
		{
			field : 'startDate',
			title : '开始日期',
			sortable : true
		}, {
			field : 'endDate',
			title : '截止日期',
			sortable : true
		}]
	});

});

</script>
</body>
</html>
