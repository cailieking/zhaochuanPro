<%@page import="com.cdd.base.enums.AgentType"%>
<!DOCTYPE html>
<html>
<head>
<title>起始港列表</title>
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
	</div>
<script>

var typeSelect = $([
	'<select class="selectpicker" style="float:right; margin-left: 10px;">',
	'<option value="">全部</option>', 
	<g:each in="${AgentType.values()}" var="type">
	'<option value="${type.name()}">${type.text}</option>', 
	</g:each>
	'</select>' 
].join(''))



var selectedDatas = []

$(function() {
	$('#list').bootstrapTable({
		url : '${request.contextPath}/startPort/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '港口名/港口英文/国家中文/国家英文';
		},
		columns : [{
			checkbox : true
		},  {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				return [
						'<a class="datatable_operation edit" href="javascript:void(0)">',
						'查看',
						'</a>',
						
						'<a class="datatable_operation certificate" href="javascript:void(0)">',
						'修改',
						'</a>'
				].join('');
			},
			events : operateEvents
		},{
			field : 'portName',
			title : '港口名',
			sortable : true
		},{
			field : 'portEnglishName',
			title : '英文名称',
			sortable : true
		},  {
			field : 'countryCh',
			title : '国家中文名',
			sortable : true
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, 
		{
			field : 'countryEn',
			title : '国家英文名',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'code',
			title : '编码',
			sortable : true,
		//  events: operateEvents
		}, 
	
		
		{
			field : 'codeSimple',
			title : '编码简称',
			sortable : true,
		//  events: operateEvents
		}, 
		
		
		 {
			field : 'dateCreated',
			title : '添加时间',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},  {
			field : 'createBy',
			title : '创建人',
			sortable : true
		//  events: operateEvents
		},
		{
			field : 'remark',
			title : '备注',
			sortable : true,
		//  events: operateEvents
		}],
		queryParams: function (params) {
			 params.type = typeSelect.val();
			//params.registered = registeredSelect.val();
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

	var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">新建港口</a>')
	$(".datatable-search-btn").before(addBtn);
	addBtn.click(function() {
		window.location.href = '${request.contextPath}/startPort/edit/new';
	})


	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除港口</a>')
	$(addBtn).before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/startPort/delete/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	})
	
	});

window.operateEvents = {
		'click .edit' : function(e, value, row, index) {
			window.location.href = '${request.contextPath}/startPort/data/' + row.id;
		},
		'click .certificate' : function(e, value, row, index) {
		 
			window.location.href = '${request.contextPath}/startPort/edit/' + row.id;
		},
	};

</script>
</body>
</html>
