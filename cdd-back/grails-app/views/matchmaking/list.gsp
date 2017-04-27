<%@page import="com.cdd.base.enums.AgentType"%>
<!DOCTYPE html>
<html>
<head>
<title>撮合交易列表</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
</head>
<body>
	<%--<div class="row">
		--%><div class="col-lg-12">
			<div class="block">
				<div>
			   <span>提交日期起：</span><input name="commitStratDate"  id="commitStratDate" class="datepicker" type="text"  />
			   <span>提交日期止：</span><input name="commitEndDate" id="commitEndDate" class="datepicker" type="text"  />
			   <span>航线:</span><input type="text"   name="route"   id="route"/>
			   <span>起始港:</span><input type="text"   name="startPort"   id="startPort"/>
			   
			   
			   </div>
			   <div><span>&nbsp</span></div>
			<div>
			<span>BookingNo.:</span><input type="text"   name="bookingNo"   id="bookingNo"/>
			<span>B/L No.:</span><input type="text"   name="blNo"   id="blNo"/>
			<span>船公司:</span><input type="text"   name="shipCompany"   id="shipCompany"/>
			<span>目的港:</span><input type="text"   name="endPort"   id="endPort"/>
			</div>
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
	var commitStratDate = $("#commitStratDate")
	var commitEndDate = $("#commitEndDate")
	var shipCompany = $("#shipCompany")
	var startPort = $("#startPort")
	var endPort = $("#endPort")
	var route = $("#route")
	var bookingNo = $("#bookingNo")
	var blNo = $("#blNo")
	$('#list').bootstrapTable({
		url : '${request.contextPath}/matchmaking/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '请输入要查询的业务员名称';
		},
		columns : [{
			checkbox : true
		}, {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				return [
						'<a class="datatable_operation edit" href="javascript:void(0)">',
						'查看',
						'</a>',
						
						
				].join('');
			},
			events : operateEvents
		},{
			field : 'saler',
			title : '业务员',
			sortable : true
		},{
			//var commitDate = dateFormat.formate(commitDate),
			field : 'commitDate',
			title : '提交日期',
			sortable : true,
			formatter:function(value, row, index){
				if(!value)return;
				return value.split(' ')[0];
			}	
		},  {
			field : 'startShipDate',
			title : '开船日期',
			sortable : true,
		 formatter: function(value, row, index){
				if(!value)return;
				return value.split(' ')[0];
			}	
		//sorter: priceSorter
		}, 
		{
			field : 'bookingNo',
			title : 'Booking No.',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'blNo',
			title : 'B/L No.',
			sortable : true,
		//  events: operateEvents
		}, 
		{
			field : 'shipCompany',
			title : '船公司',
			sortable : true,
		//  events: operateEvents
		}, 
		
		{
			field : 'gp20',
			title : '20GP',
			sortable : true,
			formatter: function(value){
				var result = value ? parseInt(value): value
				return result ;
			}
		
		//  events: operateEvents
		},
		{
			field : 'gp40',
			title : '40GP',
			sortable : true,
			formatter: function(value){
				var result = value ? parseInt(value): value
				return result ;
			}
		//  events: operateEvents
		},
		{
			field : 'hq40',
			title : '40HQ',
			sortable : true,
			formatter: function(value){
				var result = value ? parseInt(value): value
				return result ;
			}
		//  events: operateEvents
		},
		{
			field : 'productName',
			title : '品名',
			sortable : true,
		//  events: operateEvents
		},
		{
			field : 'startPort',
			title : '起始港',
			sortable : true,
		//  events: operateEvents
		},
		{
			field : 'endPort',
			title : '目的港',
			sortable : true,
		//  events: operateEvents
		},
		{
			field : 'route',
			title : '航线',
			sortable : true,
		//  events: operateEvents
		},{
			field : 'ofUsd',
			title : 'O/F(USD)',
			sortable : true,
		//  events: operateEvents
		},{
			field : 'ispsUsd',
			title : 'ISPS(USD)',
			sortable : true,
		//  events: operateEvents
		},{
			field : 'thcRmb',
			title : 'THC(RMB)',
			sortable : true,
		//  events: operateEvents
		},{
			field : 'docRmb',
			title : 'DOC(RMB)',
			sortable : true,
		//  events: operateEvents
		},{
			field : 'sealRmb',
			title : 'SEAL(RMB)',
			sortable : true,
		//  events: operateEvents
		},{
			field : 'eirRmb',
			title : 'EIR(RMB)',
			sortable : true,
		//  events: operateEvents
		},{
			field : 'otherRmb',
			title : 'other(RMB)',
			sortable : true,
		//  events: operateEvents
		},
		
		{
			field : 'remark',
			title : '备注',
			sortable : true,
		//  events: operateEvents
		}
		],
		queryParams: function (params) {
			 params.type = typeSelect.val();
			 params.commitStratDate = commitStratDate.val();
			 params.commitEndDate = commitEndDate.val();
			 params.shipCompany = shipCompany.val();
			 params.startPort = startPort.val();
			 params.endPort = endPort.val();
			 params.route = route.val();
			 params.bookingNo = bookingNo.val();
			 params.blNo = blNo.val();
			 
			 
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

	
	var uploadModalBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-royal table-btn">导入</a>')
	$(".datatable-search-btn").before(uploadModalBtn);
	uploadModalBtn.click(function() {
		BootstrapDialog.show({
            title: '导入用户信息',
            message: [
				'<iframe id="uploadFrame" name="uploadFrame" style="display: none;"></iframe>',
				'<form id="uploadForm" action="${request.contextPath}/matchmaking/importData" method="post" enctype="multipart/form-data" target="uploadFrame">', 
				'<input type="file" name="file" />', 
				'<a href="${request.contextPath}/matchmaking/downloadExample">下载模板</a>', 
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

window.operateEvents = {
		'click .edit' : function(e, value, row, index) {
			window.location.href = '${request.contextPath}/matchmaking/data/' + row.id;
		},
		
	};

</script>
</body>
</html>
