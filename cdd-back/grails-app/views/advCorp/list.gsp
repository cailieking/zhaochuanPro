<!DOCTYPE html>
<html>
<head>
<title>角色列表</title>
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
		url : '${request.contextPath}/advCorp/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '图片名';
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'image',
			title : '图片',
			formatter : function (value, row, index) {
				return '<img src="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/' + value + '" />';
			}
		}, {
			field : 'type',
			title : '类型'
		}, {
			field : 'order',
			title : '顺序'
		}, {
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

	
	var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">创建</a>')
	$(".datatable-search-btn").before(addBtn);
	addBtn.click(function() {
		window.location.href = '${request.contextPath}/advCorp/data/new';
	})
	
	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
	$(addBtn).before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/advCorp/delete/?ids=' + selectedDatas.join();
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
		window.location.href = '${request.contextPath}/advCorp/data/' + value
	}
};

</script>
</body>
</html>
