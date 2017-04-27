<!DOCTYPE html>
<html>
<head>
<title>角色列表</title>
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
$(function() {
	$('#list').bootstrapTable({
		url : '${request.contextPath}/shipScore/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '公司名称';
		},
		columns : [ {
			field : 'companyName',
			title : '公司名称'
		}, {
			field : 'shipInTime',
			title : '放舱效率'
		}, {
			field : 'docInTime',
			title : '单证及时率'
		}, {
			field : 'infoInTime',
			title : '性价比'
		}, {
			field : 'serviceQuality',
			title : '付款速度'
		}, {
			field : 'serviceContent',
			title : '服务内容'
		}, {
			field : 'hornest',
			title : '诚信',
			formatter : function (value, row, index) {
				if(value) {
					return '是'
				} else {
					return '否'
				}
			}
		}, {
			field : 'safety',
			title : '保障',
			formatter : function (value, row, index) {
				if(value) {
					return '是'
				} else {
					return '否'
				}
			}
		}, {
			field : 'verified',
			title : '认证',
			formatter : function (value, row, index) {
				if(value) {
					return '是'
				} else {
					return '否'
				}
			}
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
	});
	
});

window.operateEvents = {
	'click .edit' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}/shipScore/data/' + value
	}
};

</script>
</body>
</html>
