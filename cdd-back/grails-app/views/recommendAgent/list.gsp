<g:set var="springSecurityService" bean="springSecurityService" />
<%@page import="com.cdd.base.enums.Status"%>
<%@page import="com.cdd.base.enums.OrderStatus"%>
<% msg = data.owner ? '推送' : '撮合' %>
<!DOCTYPE html>
<html>
<head>
<title><%=msg %>列表</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
</head>
<body>
	<div class="row">
		<div class="col-lg-12">
			<div class="block">
				<table id="list"></table>
			</div>
		</div>
	</div>
	
<script>
var selectedDatas = []
$(function() {
	$('#list').bootstrapTable({
		url : '${request.contextPath}/recommendAgent/list?dataType=json&id=${params.id}&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '公司/联系人';
		},
		columns : [ {
			checkbox : true
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
			field : 'phone',
			title : '联系方式',
			sortable : true
		}, {
			field : 'city',
			title : '所在地',
			sortable : true,
			formatter: function(city, row, index) {
				if(city) {
					return city.name;
				}
				return null;
			}
		//  events: operateEvents
		}, {
			field : 'shipCompany',
			title : '船公司',
			sortable : true
			
		}, {
			field : 'shippingDay',
			title : '船期',
			sortable : true
			
		}, {
			field : 'shippingDays',
			title : '航程',
			sortable : true
		}, {
			field : 'transType',
			title : '运输类别(整箱/拼箱)',
			sortable : true
		}, {
			field : 'startDate',
			title : '有效期开始日期',
			sortable : true
		}, {
			field : 'endDate',
			title : '有效期结束日期',
			sortable : true
		}, {
			field : "gp20",
			title : 'USD/20GP',
			sortable : true
		}, {
			field : "gp40",
			title : 'USD/40GP',
			sortable : true
		}, {
			field : "hq40",
			title : 'USD/40HQ',
			sortable : true
		}, {
			field : "hq45",
			title : 'USD/45HQ',
			sortable : true
		}, {
			field : "extra",
			title : '附加费',
			width : '500',
			sortable : true
		}, {
			field : "weightLimit",
			title : '限重（整箱时填写，单位吨）',
			sortable : true
		}, {
			field : "lowestCost",
			title : 'USD/rt',
			sortable : true
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, {
			field : 'remark',
			title : '备注',
			sortable : true
		}, {
			field : 'routeName',
			title : '航线',
			sortable : true
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
			field : 'middlePort',
			title : '中转港',
			sortable : true
		}]
	}).on('check.bs.table', function (e, row) {
		triggerRowSelection();
    }).on('uncheck.bs.table', function (e, row) {
    	triggerRowSelection();
    }).on('check-all.bs.table', function (e) {
    	triggerRowSelection();
    }).on('uncheck-all.bs.table', function (e) {
    	selectedDatas.length = 0;
    }).css("width", "500%").css("max-width", "500%");

	var recommendBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn"><%=msg %></a>')
	$(".datatable-search-btn").before(recommendBtn);
	recommendBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定<%=msg %>吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/recommendAgent/send/${params.id}?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	});
	
});


</script>
</body>
</html>
