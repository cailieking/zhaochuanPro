<%@page import="com.cdd.base.enums.AgentType"%>
<!DOCTYPE html>
<html>
<head>
<title>企业名录列表</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
</head>
<body>
	<%--<div class="row">
		--%><div class="col-lg-12">
			<div class="block">
				<div>
		
				<table id="list"></table>
			</div>
		</div>
	</div>
<script>
var statusSelect = $([
                  	'<select class="selectpicker" style="float:right; margin-left: 10px;">',
                  	'<option value="">状态</option>', 
                  	'<option value=true>未关闭</option>', 
                  	'<option value=false>关闭</option>', 
                  	'</select>' 
                  ].join(''))
var selectedDatas = []

$(function() {
	$('#list').bootstrapTable({
		url : '${request.contextPath}/enterpriseDirectory/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '公司/货主姓名/电话';
		},
		columns : [{
			checkbox : true
		}, 
		{
			field : 'contactName',
			title : '货主姓名',
			sortable : true,
		//  events: operateEvents
		}, {
			field : 'companyName',
			title : '公司名称',
			sortable : true
		},
		{
			field : 'mobile',
			title : '联系电话',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'city',
			title : '所属城市',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'createBy',
			title : '创建人',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'dateCreated',
			title : '创建时间',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'showOnIndex',
			title : '状态',
			sortable : true,
			formatter: function(value, row, index) {
				var str = "",
				   result=[],
				   showOnIndex=row.showOnIndex;
               if(showOnIndex){
             	  str = "<h7 style='color:orange'>未关闭</h7>";
                   result.push(str);
               }else{
             	  str = "<h7 style='color:orange'>关闭</h7>";
                   result.push(str);
                   }
              return result.join(''); 
			},
		//  events: operateEvents
		}, 
		{
			field : 'remark1',
			title : '备注',
			sortable : true,
		//  events: operateEvents
		},{
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				var showText = '关闭'
					if(!row.showOnIndex) {
						showText = '打开'
					}
				return [
						'<a class="datatable_operation edit" href="javascript:void(0)" >',
						'修改', 
						'</a>',
						'<a class="datatable_operation data" href="javascript:void(0)">',
						'查看', 
						'</a>' ,
						'<a class="datatable_operation operate" href="javascript:void(0)">',
						showText, 
						'</a>'  
				].join('');
			},
			events : operateEvents
		} 
		],
		queryParams: function (params) {
			params.status=statusSelect.val();
			
			 
			 
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
	 var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">新建</a>')
		$(".datatable-search-btn").before(addBtn);
		addBtn.click(function() {
			window.location.href = '${request.contextPath}/enterpriseDirectory/edit?id=new'  ;
	});
		 <!---- 删除按钮   ----->
		    var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
			$(".datatable-search-btn").before(deleteBtn);
			deleteBtn.click(function() {
				if(selectedDatas.length > 0) {
					BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
						if(result) {
							window.location.href = '${request.contextPath}/enterpriseDirectory/delete/?ids=' + selectedDatas.join();
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
            title: '导入企业名录',
            message: [
				'<iframe id="uploadFrame" name="uploadFrame" style="display: none;"></iframe>',
				'<form id="uploadForm" action="${request.contextPath}/enterpriseDirectory/importData" method="post" enctype="multipart/form-data" target="uploadFrame">', 
				'<input type="file" name="file" />', 
				'<a href="${request.contextPath}/enterpriseDirectory/downloadExample">下载模板</a>', 
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
	
	});
	setTimeout(function(){
		var anchor = $(".datatable-search-btn").parent().find('a')[0];
		$(anchor).before(statusSelect);
		statusSelect .change(function() {
			$(".datatable-search-btn").click();
		});
		
		},0)


window.operateEvents = {
		'click .operate' : function(e, value, row, index) {
			if(row.showOnIndex) {
				BootstrapDialog.confirm("确定要关闭 " + row.contactName + " 吗？", function(result) {
		            if(result) {
						window.location.href = '${request.contextPath}/enterpriseDirectory/showOnIndex/' + row.id + "?showOnIndex=false";
		            }
		        });
			} else {
				BootstrapDialog.confirm("确定要打开 " + row.contactName + " 吗？", function(result) {
		            if(result) {
						window.location.href = '${request.contextPath}/enterpriseDirectory/showOnIndex/' + row.id + "?showOnIndex=true";
		            }
		        });
			}
		},
			
		'click .data' : function(e, value, row, index) {
			window.location.href = '${request.contextPath}/enterpriseDirectory/data/' + row.id;
		},
		'click .edit' : function(e, value, row, index) {
			window.location.href = '${request.contextPath}/enterpriseDirectory/edit/' + row.id;
		},
		
	};

</script>
</body>
</html>
