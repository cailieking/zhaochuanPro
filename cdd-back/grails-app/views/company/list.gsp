<%@page import="com.cdd.base.enums.AgentType"%>
<!DOCTYPE html>
<html>
<head>
<title>导入用户列表</title>
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
		url : '${request.contextPath}/company/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '用户名/姓名/公司';
		},
		columns : [{
			checkbox : true
		},  {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				return [
						'<a class="datatable_operation edit" href="javascript:void(0)">',
						'修改',
						'</a>',
						
						
				].join('');
			},
			events : operateEvents
		},{
			field : 'companyName',
			title : '公司名',
			sortable : true
		},{
			field : 'advancedRoute',
			title : '推荐航线',
			sortable : true
		},  {
			field : 'city',
			title : '城市',
			sortable : true
		// formatter: priceFormatter,
		//sorter: priceSorter
		},  {
			field : 'honest',
			title : '诚信',
			sortable : true,
			formatter : function (value, row, index) {
				var str = "",
				   result=[],
				   verified=row.honest;
                  if(verified){
                     str = "<h7 style='color:orange'>是</h7>";// alt='找船网-认证商家'
                     result.push(str);
                  }else{
                	  str = "否";// alt='找船网-认证商家'
                      result.push(str);
                      }
                 return result.join(''); 
			},
		
		//sorter: priceSorter
		},  {
			field : 'safety',
			title : '信誉',
			sortable : true,
			formatter : function (value, row, index) {
				var str = "",
				   result=[],
				   verified=row.safety;
                  if(verified){
                     str = "<h7 style='color:orange'>是</h7>";// alt='找船网-认证商家'
                     result.push(str);
                  }else{
                	  str = "否";// alt='找船网-认证商家'
                      result.push(str);
                      }
                 return result.join(''); 
			},
		// formatter: priceFormatter,
		//sorter: priceSorter
		},  {
			field : 'verified',
			title : '认证',
			sortable : true,
			formatter : function (value, row, index) {
				var str = "",
				   result=[],
				   verified=row.verified;
                  if(verified){
                	  str = "<h7 style='color:orange'>是</h7>";// alt='找船网-认证商家'
                      result.push(str);
                  }else{
                	  str = "否";// alt='找船网-认证商家'
                      result.push(str);
                      }
                 return result.join(''); 
			},
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, 
		//{
		//	field : 'introduce',
		//	title : '公司简介',
		//	sortable : true,
		//  events: operateEvents
		//}, 
		
		{
			field : 'scale',
			title : '公司规模（T）  ',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'website',
			title : '网站',
			sortable : true,
		//  events: operateEvents
		}, 
	
		
		{
			field : 'telephone',
			title : '联系电话',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'priceInfo',
			title : '运价信息',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'type',
			title : '客户类型',
			sortable : true,
		//  events: operateEvents
		}, 
		
		
		{
			field : 'regCapital',
			title : '注册资本',
			sortable : true,
		//  events: operateEvents
		},  {
			field : 'dateCreated',
			title : '记录时间',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'createBy',
			title : '来源',
			sortable : true
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

	 var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">添加公司</a>')
		$(".datatable-search-btn").before(addBtn);
		addBtn.click(function() {
			window.location.href = '${request.contextPath}/company/data?id=new'  ;
	});
	<!-- 导入开始  -->

	var uploadModalBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-royal table-btn">导入</a>')
	$(".datatable-search-btn").before(uploadModalBtn);
	uploadModalBtn.click(function() {
		BootstrapDialog.show({
            title: '导入公司信息',
            message: [
				'<iframe id="uploadFrame" name="uploadFrame" style="display: none;"></iframe>',
				'<form id="uploadForm" action="${request.contextPath}/company/importData" method="post" enctype="multipart/form-data" target="uploadFrame">', 
				'<input type="file" name="file" />', 
				'<a href="${request.contextPath}/company/downloadExample">下载模板</a>', 
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
	});
	<!-- 搜索按钮  -->
	$(".datatable-search-btn").before(typeSelect);
	typeSelect.change(function() {
		$(".datatable-search-btn").click();
	});
    <!---- 删除按钮   ----->
    var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
	$(".datatable-search-btn").before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/company/delete/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	})


	
	<!-- 导入结束   -->
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
			window.location.href = '${request.contextPath}/company/data/' + row.id;
		},
		
		'click .addmanager' : function(e, value, row, index) {
		 
			window.location.href = '${request.contextPath}/company/addmanager/' + row.id;
		},
		'click .certificate' : function(e, value, row, index) {
		 
			window.location.href = '${request.contextPath}/company/certificate/' + row.id;
		},
	};

</script>
</body>
</html>
