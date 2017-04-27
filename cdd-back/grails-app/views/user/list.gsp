<g:set var="springSecurityService" bean="springSecurityService" />
<!DOCTYPE html>
<html>
<head>
<title>用户列表</title>
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
		</div><%--
	</div>
	
--%><g:if test="${springSecurityService.currentUser.admin}">	
<script>
var selectedDatas = []

$(function() {
	$('#list').bootstrapTable({
		url : '${request.contextPath}/user/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '用户名/姓名/手机/邮箱';
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'username',
			title : '用户名',
			sortable : true
		}, {
			field : 'firstname',
			title : '姓名',
			sortable : true
		//formatter: nameFormatter
		}, {
			field : 'positionName',
			title : '职位',
			sortable : true
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, {
			field : 'mobile',
			title : '手机号码',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'email',
			title : '电子邮箱',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'enabled',
			title : '状态',
			sortable : true,
			formatter: function(value, row, index) {
				if(value) {
					return "使用中";
				} else {
					return "已禁用";
				}
			},
		//  events: operateEvents
		}, {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				var enableText = '禁用'
				if(!row.enabled) {
					enableText = '启用'
				}
				return [
						'<a class="datatable_operation stop" href="javascript:void(0)">',
						enableText,
						'</a>',
						'<a class="datatable_operation edit" href="javascript:void(0)">',
						'修改', 
						'</a>', 
						'<a class="datatable_operation assign" href="javascript:void(0)">',
						'指派任务', 
						'</a>', 
						'<a class="datatable_operation resetPass" href="javascript:void(0)">',
						'重置密码', 
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


	var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">创建用户</a>')
	$(".datatable-search-btn").before(addBtn);
	addBtn.click(function() {
		window.location.href = '${request.contextPath}/user/data/new';
	})
	
	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除用户</a>')
	$(addBtn).before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定用户吗？", function(result) {
				if(result) {
					var url = "${request.contextPath}/user/delete";
					
					$.post(url,{"ids" : selectedDatas.join()},function(result){
						<%--if(result.status==1){
								
						}--%>
						BootstrapDialog.show({
							message: result.msg
						});
						window.location.href = 	'${request.contextPath}/user/list' 
					
					})
					
					 <%-- $.ajax({
           				 url:"../../booking/importBooking/"+bookingId,
           				 type:"post",
          	  			 data:$("#bookingForm").serialize(),
            			 dataType:"json",
            			 success:function(rs){
                		 if(rs.status == 1){
                				alert('委托单提交成功');
                	   	 }else{
                    		alert(rs.msg);
                         }
          				  	},
           				 error:function(rs){
               			 alert('系统忙，提交失败，请稍后重试');
           					 }
      			  });--%>
					<%--window.location.href = '${request.contextPath}/user/delete/?ids=' + selectedDatas.join();--%>
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
	'click .stop' : function(e, value, row, index) {
		if(row.enabled) {
			BootstrapDialog.confirm("确定要禁用 " + row.username + " 吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/user/enable/' + row.id + "?enabled=false";
	            }
	        });
		} else {
			BootstrapDialog.confirm("确定要启用 " + row.username + " 吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/user/enable/' + row.id + "?enabled=true";
	            }
	        });
		}
	},
	'click .edit' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}/user/data/' + row.id;
	},
	'click .assign' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}/user/assign/' + row.id;
	},
	'click .resetPass': function(e, value, row, index) {
		BootstrapDialog.confirm("确定要重置 " + row.username + " 的密码吗？", function(result) {
            if(result) {
				window.location.href = '${request.contextPath}/user/resetPassword/' + row.id;
            }
        });
	}
};

</script>
</g:if>
<g:else>
<script>

$(function() {
	$('#list').bootstrapTable({
		url : '${request.contextPath}/user/list?dataType=json',
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '用户名/姓名/手机/邮箱';
		},
		columns : [ {
			field : 'username',
			title : '用户名',
			sortable : true
		}, {
			field : 'firstname',
			title : '姓名',
			sortable : true
		//formatter: nameFormatter
		}, {
			field : 'positionName',
			title : '职位',
			sortable : false
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, {
			field : 'mobile',
			title : '手机号码',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'email',
			title : '电子邮箱',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'enabled',
			title : '状态',
			sortable : true,
			formatter: function(value, row, index) {
				if(value) {
					return "使用中";
				} else {
					return "已禁用";
				}
			},
		//  events: operateEvents
		}]
	});


});
</script>
</g:else>
</body>
</html>
