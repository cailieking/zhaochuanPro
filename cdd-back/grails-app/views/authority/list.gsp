<!DOCTYPE html>
<html>
<head>
<title>权限列表</title>
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
	$('#list').bootstrapTable({
		url : '${request.contextPath}/authority/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '名称/权限值/链接';
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'description',
			title : '名称',
			sortable : true
		},{
			field : 'url',
			title : '链接',
			sortable : true
		},  
		{
			field : 'authority',
			title : '权限值',
			sortable : true
		},  {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				return [
						'<a class="datatable_operation edit" href="javascript:void(0)" title="修改">',
						'修改', 
						'</a>' 
				].join('');
			},
			events : operateEvents
		} ]
	}).on('check.bs.table', function (e, row) {
		triggerRowSelection();
    }).on('uncheck.bs.table', function (e, row) {
    	triggerRowSelection();
    }).on('check-all.bs.table', function (e) {
    	triggerRowSelection();
    }).on('uncheck-all.bs.table', function (e) {
    	selectedDatas.length = 0;
    });

	
	var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">创建权限</a>')
	$(".datatable-search-btn").before(addBtn);
	addBtn.click(function() {
		window.location.href = '${request.contextPath}/authority/data/new';
	})
	
	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除权限</a>')
	$(addBtn).before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定权限吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/authority/delete/?ids=' + selectedDatas.join();
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
		window.location.href = '${request.contextPath}/authority/data/' + value
	}
};

</script>
</body>
</html>
