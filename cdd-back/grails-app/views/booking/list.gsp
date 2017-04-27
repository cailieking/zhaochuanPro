<%@page import="com.cdd.base.enums.AgentType"%>
<!DOCTYPE html>
<html>
<head>
<title>Booking列表</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
<style>
.service_box {
	width: 100%;
}

.service_box input {
	display: inline-block;
	width: 150px;
	padding: 2px 3px;
	margin-right: 10px;
}

.refer, .more {
	display: inline-block;
	padding: 4px 25px;
	background: orange;
	color: white;
	border-radius: 3px;
	text-decoration: none;
}

.service_area {
	float: left;
	width: 100%;
	margin: 10px 0;
}

#refer-01 {
	margin: 0 10px 0 80px;
}

.definite_area {
	display: none;
}

.display {
	display: block
}

.definite_area>input {
	margin-bottom: 20px;
}
</style>
</head>
<body>

	<%--<div class="row">
		--%>
	<div class="col-lg-12">
		<div class="block">
			<div class="service_box">
				<div class="service_area">

					订单编号： <input type="text" name="yjnumber" id="yjnumber" /> 起始港： <input
						type="text" name="startPort" id="startPort"
						style="margin-right: 23px;" /> 目的港：<input name="endPort"
						type="text" id="endPort" /> <a href="javascript:;" class="refer "
						id="refer-01">查询</a> <a href="javascript:;" class="more"
						id="more">更多查询条件</a> <span id="uncheckStats"></span> <span
						id="inBookingNum"></span>
				</div>
				<div class="definite_area">

					<span style="margin-left: 3px;">下单时间：</span><input type="text"
						id="dateCreated" class="route"> <span
						style="margin-left: 5px;">审核人：</span><input type="text"
						id="operateBy" class="company">
					<%--
						   <span >审核时间：</span><input type="text" id="chuancompany" class="chuancompany"><br>
							--%>
					<%--<span style="margin-left:5px;">结单时间：</span><input type="text" id="start" class="start_port">
						   	--%>
					<span style="margin-left: 17px;">结单人：</span><input type="text"
						id="finishedBy" class="middle_port">

				</div>
			</div>
			<table id="list"></table>
		</div>
	</div>
	<script>
var statusSelect = $([
                  	'<select style="float:right; margin-left: 40px;width:150px;height:32px;">',
                  	'<option value="">状态</option>', 
                  	'<option value="UnCheck">未审核</option>',
                  	'<option value="InBooking">审核中</option>',
                  	'<option value="NoPass">不通过</option>',
                  	'<option value="ShippingSpaced">已放舱</option>', 
                  	'<option value="FailBooking">订舱失败</option>', 
                  	'</select>' 
                  ].join(''))

var selectedDatas = []
$(function() {
	var unCheckNum = "";
	var inBookingNum = "";
	setTimeout(function(){
		
	},10)
	var booknumber = $("#yjnumber");
	var startPort =$("#startPort");
	var endPort =$("#endPort");
	var dateCreated =$("#dateCreated");
	var operateBy =$("#operateBy");
	var finishedBy =$("#finishedBy")	
	$('#list').bootstrapTable({
		url : '${request.contextPath}/booking/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '订舱人';
		},
		columns : [{
			checkbox : true
		}, 
		{
			field : 'id',
			title : '订舱编号',
			formatter : function (value, row, index) {<%--href="/booking/data/'+row.id+'" target="_blank"--%>
				return [
						'<a class="datatable_operation view"  href="javascript:;">',
						'5000000'+value, 
						'</a>' 
					].join('');
				},
				events : operateEvents
		}, {
			field : 'infoId',
			title : '关联运价编号',
			sortable : true,
			formatter: function(value, row, index) {<%--href="/shipInfo/data/'+value+'" target="_blank"--%>
				return [
						'<a class="datatable_operation yview" href="javascript:void(0)">',
						value, 
						'</a>' 
					].join('');
			},
		}, 
		{
			field : 'bookingName',
			title : '订舱人',
			sortable : true
		},
		{
			field : 'startPort',
			title : '起始港',
			sortable : true
			//formatter: function(info.startPort, row, index) {
				//return info.startPort;
		//	}
		},
		{
			field : 'endPort',
			title : '目的港',
			sortable : true
			//formatter: function(info.startPort, row, index) {
				//return info.startPort;
		//	}
		},{
			field : 'dateCreated',
			title : '下单时间',
			sortable : true
		},
		{
			field : 'operateBy',
			title : '审核人',
			sortable : true
		},
		{
			field : 'finishedBy',
			title : '结单人',
			sortable : true
		},{
			field : 'status',
			title : '受理状态',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},
		{
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {<%--target="_blank"--%>
				return [
						'<a class="datatable_operation operate" href="javascript:void(0)" >',
						'审核', 
						'</a>' ,
						'<a class="datatable_operation finish" href="javascript:void(0)" >',
						'结单', 
						'</a>'  
				].join('');
			},
			events : operateEvents
		} ],
		responseHandler:function(res){
			 unCheckNum = res.unCheckNum;
			 unCheckNum = unCheckNum ? unCheckNum : 0;
			 inBookingNum = res.inBookingNum;
			 inBookingNum = inBookingNum ? inBookingNum : 0;
			 $('#uncheckStats').html('未审核（<b style="color:red;font-weight:normal;">'+unCheckNum+'</b>）');
			 $('#inBookingNum').html('订舱中（<b style="color:red;font-weight:normal;">'+inBookingNum+'</b>）');
			return res;
		},
		queryParams: function (params) {
			params.status = statusSelect.val()
			params.booknumber = booknumber.val().trim().substring(7)
			params.startPort= startPort.val()
			params.endPort= endPort.val()
			params.dateCreated= dateCreated.val()
			params.operateBy= operateBy.val()
			params.finishedBy= finishedBy.val()			
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
	$(".button-highlight").css({'marginLeft':'15px'}); 
	$("#more").click(function(){$(".definite_area").toggleClass("display")})  
	$(".refer").click(function(){$(".button-highlight").click()}) 
	$("#dateCreated").datepicker();
	
		 <!---- 删除按钮   ----->
		    var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
			$(".datatable-search-btn").before(deleteBtn);
			deleteBtn.click(function() {
				if(selectedDatas.length > 0) {
					BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
						if(result) {
							window.location.href = '${request.contextPath}/booking/delete/?ids=' + selectedDatas.join();
						}
					});
				} else {
					BootstrapDialog.show({
						message: '请选择至少一条记录'
					});
				}
			})
	
			var uploadModalBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-royal table-btn">导入</a>')
			//$(".datatable-search-btn").before(uploadModalBtn);
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
			'click .view' : function(e, value, row, index){
				window.location.href = '${request.contextPath}/booking/data/' + row.id
	
			},     
			'click .operate' : function(e, value, row, index) {
				if(row.status=="订舱中"||row.status=="不通过"||row.status=="已放舱"||row.status=="订舱失败"){
					BootstrapDialog.show({
						message: '已审核，不能重复审核'
					});
						return false;
					}
					else{
						window.location.href = '${request.contextPath}/booking/operate/' + value;
					}
				<%--window.location.href = '${request.contextPath}/shipInfo/data/' + value;--%>
			},
			'click .finish' : function(e, value, row, index) {
				if(row.status=="未审核"){
					BootstrapDialog.show({
						message: '请先审核，再进行结单'
					});
						//alert("请先受理");
						return false;
					}else if(row.status=="订舱中"){
						window.open('${request.contextPath}/booking/finish/'+ value);

				} else if (row.status == "已放舱" || row.status == "订舱失败"
						|| row.status == "不通过") {
					BootstrapDialog.show({
						message : '已结单或未通过审核，不能进行结单操作'
					});
					//alert("已结单");
					return false;
				}
			},
			'click .yview' : function(e, value, row, index){
				window.location.href = '${request.contextPath}/shipInfo/data/' + value
	
			},
		};
	</script>
</body>
</html>
