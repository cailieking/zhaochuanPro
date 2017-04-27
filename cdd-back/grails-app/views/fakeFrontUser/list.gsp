<%@page import="com.cdd.base.enums.FrontUserType"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<g:set var="cityService" bean="cityService" />
<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>

<!DOCTYPE html>
<html>
<head>
<title>导入用户列表</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
<asset:stylesheet src="form-table.css" />
</head>
<body>
	<%--<div class="row">
		--%><div class="col-lg-12">
			<div class="block">
			 <div>
			    <span>所在地：</span><formTable title='所在地'>
						<select name="cityId" class="selectautocomplete" id="cityId">
							<option value="">--请选择--</option>
							<g:each in="${Provinces.values()}" var="province">
								<optgroup label="${province.desc}">
									<g:each in="${cityService.getCities(province.code).list}" var="city">
											<option value="${city.id}">${city.name}</option>
									</g:each>
								</optgroup>
							</g:each>
						</select>
					</formTable>
			   </div>
			   <div>
			   <div>&nbsp</div>
			   <div>
			   <span>导入时间起：</span><input name="createStratDate"  id="createStratDate" class="datepicker" type="text"  />
			   <span>导入时间止：</span><input name="createEndDate" id="createEndDate" class="datepicker" type="text"  />
			   <span>导入者:</span><input type="text"   name="createBy"   id="createBy"/>
			   <span style="padding:10px 0;position:relative;top:-2px;margin: 0 0px 0 40px;">活跃用户</span>
			   <input type="checkbox" name="activeUser" id="activeUser" value="">
			   </div>
			   <div>&nbsp</div>
			   <%--<div>
			   <span>核实时间起：</span><input name="checkStartDate" id="checkStartDate" class="datepicker" type="text"  />
			   <span>核实时间止：</span><input name="checkEndDate" id="checkEndDate" class="datepicker" type="text"  />
			   <span>核实者:</span><input type="text"   name="checkBy"   id="checkBy"/>
			   </div>
			   </div>    --%>
				<table id="list"></table>
			</div>
		</div>
	</div>
	<script>
var typeSelect = $([
	'<select class="selectpicker" style="float:right; margin-left: 10px;">',
	'<option value="">类型</option>', 
	<g:each in="${FrontUserType.values()}" var="type">
	'<option value="${type.name()}">${type.text}</option>', 
	</g:each>
	'</select>' 
].join(''))

var registeredSelect = $([
	<%--'<select class="selectpicker" style="float:right; margin-left: 10px;">',
	'<option value="">客户状态</option>', 
	//'<option value="false">未核实</option>', 
	'<option value="true">活跃客户</option>', 
	'</select>' --%>
	
].join(''))

var selectedDatas = []

$(function() {
	var cityId =$("#cityId")
	var createBy=$("#createBy")
	var checkBy=$("#checkBy")
	var activeUser =$("#activeUser")
	var createStratDate = $("#createStratDate")
	var createEndDate = $("#createEndDate")
	var checkStartDate = $("#checkStartDate")
	var checkEndDate = $("#checkEndDate")
	
	$('#list').bootstrapTable({
		url : '${request.contextPath}/fakeFrontUser/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '用户名/姓名/公司';
		},
		columns : [{
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
			field : 'companyName',
			title : '公司',
			sortable : true
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, {
			field : 'city',
			title : '所在地',
			sortable : true,
			formatter: function(city, row, index) {
				return city.name;
			}
		//  events: operateEvents
		}, {
			field : 'type',
			title : '类型',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'dateCreated',
			title : '导入时间',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'createBy',
			title : '导入者',
			sortable : true
		//  events: operateEvents
		}, <%--{
			field : 'registered',
			title : '核实状态',
			sortable : true,
			formatter: function(value, row, index) {
				if(value) {
					return "已核实";
				} else {
					return "未核实";
				}
			}
		//  events: operateEvents
		}, {
			field : 'checkBy',
			title : '核实者',
			sortable : false
		//  events: operateEvents
		},--%>{
			field : 'remark',
			title : '备注',
			sortable : false
		//  events: operateEvents
		}, {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				return [
						'<a class="datatable_operation edit" href="javascript:void(0)">',
						'修改',
						'</a>'
				].join('');
			},
			events : operateEvents
		}],
		queryParams: function (params) {
			
			params.type = typeSelect.val();
			params.registered = activeUser.val();
			params.createBy = createBy.val();
			params.checkBy = checkBy.val();
			params.cityId = cityId.val();
			params.createStratDate = createStratDate.val();
			params.createEndDate = createEndDate.val();
			params.checkStartDate = checkStartDate.val();
			params.checkEndDate = checkEndDate.val();
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

	<%--
	var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">核实</a>')
	$(".datatable-search-btn").before(addBtn);
	addBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要注册选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/fakeFrontUser/transfer/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	})
	--%>

	var uploadModalBtn = $('<a href="javascript:;"  style="margin-left:600px" class="button button-glow button-rounded button-royal table-btn">导入</a>')
	$(".datatable-search-btn").before(uploadModalBtn);
	uploadModalBtn.click(function() {
		BootstrapDialog.show({
            title: '导入用户信息',
            message: [
				'<iframe id="uploadFrame" name="uploadFrame" style="display: none;"></iframe>',
				'<form id="uploadForm" action="${request.contextPath}/fakeFrontUser/importData" method="post" enctype="multipart/form-data" target="uploadFrame">', 
				'<input type="file" name="file" />', 
				'<a href="${request.contextPath}/fakeFrontUser/downloadExample">下载模板</a>', 
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
	
	<%--
	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
	$(uploadModalBtn).before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/fakeFrontUser/delete/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	})
	--%>

	
	activeUser.change(function() {
		if(activeUser.prop('checked')){
			activeUser.val("true")
		}else{
			activeUser.val("");
			}
		$(".datatable-search-btn").click();
	});


	$(".datatable-search-btn").before(typeSelect);
	typeSelect.change(function() {
		$(".datatable-search-btn").click();
	});
	
	$(".datatable-search-btn").before(registeredSelect);
	registeredSelect.change(function() {
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
			window.location.href = '${request.contextPath}/fakeFrontUser/data/' + row.id;
		},
	};

</script>
</body>
</html>
