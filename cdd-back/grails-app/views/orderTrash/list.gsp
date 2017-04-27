<g:set var="springSecurityService" bean="springSecurityService" />
<%@page import="com.cdd.base.enums.Status"%>
<%@page import="com.cdd.base.enums.OrderStatus"%>
<!DOCTYPE html>
<html>
<head>
<title>订单列表</title>
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
var selectedDatas = []
$(function() {
	var statusSelect = $([
   		'<select class="selectpicker" style="float:right; margin-left: 10px;">',
   		'<option value="">全部</option>', 
   		<g:each in="${Status.values()}" var="status">
   		'<option value="${status.name()}">${status.text}</option>', 
   		</g:each>
   		<g:each in="${OrderStatus.values()}" var="status">
   		'<option value="${status.name()}">${status.text}</option>', 
   		</g:each>
   		'</select>' 
   	].join(''))
	
	$('#list').bootstrapTable({
		url : '${request.contextPath}/orderTrash/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '订单号/货物/公司/联系人';
		},
		columns : [ {
			checkbox : true
		}, {
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
			field : 'service',
			title : '客服',
		// formatter: operateFormatter,
		//  events: operateEvents
			formatter : function (value, row, index) {
				if(value) {
					return value.firstname;
				} else {
					return null
				}
			}
		}, {
			field : 'sales',
			title : '业务员',
		// formatter: operateFormatter,
		//  events: operateEvents
			formatter : function (value, row, index) {
				if(value) {
					return value.firstname;
				} else {
					return null
				}
			}
		}, {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				return [
						'<a class="datatable_operation view" href="javascript:void(0)">',
						'查看', 
						'</a>'
				].join('');
			},
			events : operateEvents
		} ],
		queryParams: function (params) {
			params.status = statusSelect.val()
			return params;
		}
	}).on('check.bs.table', function (e, row) {
		triggerRowSelection();
    }).on('uncheck.bs.table', function (e, row) {
    	triggerRowSelection();
    }).on('check-all.bs.table', function (e) {
    	triggerRowSelection();
    }).on('uncheck-all.bs.table', function (e) {
    	selectedDatas.length = 0;
    });

	var revertBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">还原</a>')
	$(".datatable-search-btn").before(revertBtn);
	revertBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要还原选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/orderTrash/revert/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	});
	
	$(".datatable-search-btn").before(statusSelect);
	statusSelect.change(function() {
		$(".datatable-search-btn").click();
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
	'click .view' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}/orderTrash/data/' + value;
	},
};

</script>
</body>
</html>
