<%@page import="com.cdd.base.enums.RouteCategory"%>
<%@page import="com.cdd.base.enums.RouteType"%>
<!DOCTYPE html>
<html>
<head>
<title>航线分类列表</title>
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
	var categorySelect = $([
   		'<select class="selectpicker" style="float:right; margin-left: 10px;">',
   		'<option value="">全部</option>', 
   		<g:each in="${RouteCategory.values()}" var="category">
   		'<option value="${category.name()}">${category.text}</option>', 
   		</g:each>
   		'</select>' 
   	].join(''))
   	
	var typeSelect = $([
   		'<select class="selectpicker" style="float:right; margin-left: 10px;">',
   		'<option value="">全部</option>', 
   		<g:each in="${RouteType.values()}" var="type">
   		'<option value="${type.name()}">${type.text}</option>', 
   		</g:each>
   		'</select>' 
   	].join(''))
	
	$('#list').bootstrapTable({
		url : '${request.contextPath}/route/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '港口';
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'port',
			title : '港口'
		}, {
			field : 'category',
			title : '类别'
		}, {
			field : 'type',
			title : '类型'
		}, {
			field : 'shortName',
			title : '简写'
		}, {
			field : 'city',
			title : '城市'
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
		} ],
		queryParams: function (params) {
			params.category = categorySelect.val()
			params.type = typeSelect.val()
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

	
	var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">创建</a>')
	$(".datatable-search-btn").before(addBtn);
	addBtn.click(function() {
		window.location.href = '${request.contextPath}/route/data/new';
	})
	
	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
	$(addBtn).before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/route/delete/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	})

	var uploadModalBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-royal table-btn">导入</a>')
	$(".datatable-search-btn").before(uploadModalBtn);
	uploadModalBtn.click(function() {
		BootstrapDialog.show({
            title: '导入货代信息',
            message: [
				'<iframe id="uploadFrame" name="uploadFrame" style="display: none;"></iframe>',
				'<form id="uploadForm" action="${request.contextPath}/route/importData" method="post" enctype="multipart/form-data" target="uploadFrame">', 
				'<input type="file" name="file" />', 
				'<a href="${request.contextPath}/route/downloadExample">下载模板</a>', 
				'</form>'
			].join(''),
            buttons: [{
                label: '确定',
                action: function(dialog) {
                	currentDialog = dialog;
                	$("#uploadForm").submit();
                }
            }]
        });
	})

	$(".datatable-search-btn").before(categorySelect);
	categorySelect.change(function() {
		$(".datatable-search-btn").click();
	});

	$(".datatable-search-btn").before(typeSelect);
	typeSelect.change(function() {
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
	'click .edit' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}/route/data/' + value
	}
};

</script>
</body>
</html>
