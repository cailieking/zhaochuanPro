<g:set var="springSecurityService" bean="springSecurityService" />
<g:set var="cityService" bean="cityService" />
<%@page import="com.cdd.base.enums.Status"%>
<%@page import="com.cdd.base.enums.OrderStatus"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<!DOCTYPE html>
<html>
<head>
<title>货盘查询</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
<style>
.service_box{
width:100%;

}
.service_box input{
	display:inline-block;
	width:100px;
	padding: 2px 3px; 
	margin-right:40px;
}
.refer,.more{
 display:inline-block;
 padding:4px 25px;
  background:orange;
 color:white;
 border-radius:3px;
  text-decoration:none;
 
 
}

.service_area{
	float: left; 
	width:100%;	
	margin:10px 0 ;
}

#refer_pallet_01{
margin: 0 65px 0  80px;

}
#refer_pallet_02{
margin-left:77px;
}
.definite_area{
   display:none;
}
.display{
display:block
}
.definite_area>input{
	margin-bottom:20px;	
}

</style>
</head>
<body>
	<%--<div class="row">
		--%><div class="col-lg-12">
			<div class="block">
				<div class="service_box">
				   <div class="service_area">
						 <span style="margin-left:27px;">货盘编号：</span><input type="text" name="ordernumber"  id="ordernumber" />
						  <span style="margin-left:40px;">创建人：</span><input type="text" name="createman"  id="createman"/>
						<span style="margin-left:27px;">创建时间：</span><input name="createtime"   type="text" class="datepicker" id="createtime"/>
						 	<a href="javascript:;" class="refer " id="refer_pallet_01" >查询</a>
						 		<a href="javascript:;" class="more" id="more">更多查询条件</a>
				  </div>
			   
			   <div  class="definite_area">
			   		<span style="margin-left:41px;">起始港：</span><input type="text" id="start">
			   		<span style="margin-left:42px;">目的港：</span><input type="text" id="end">
				   	<span style="margin-left:55px;">货物名称：</span><input type="text" id="hw">
				   	<span style="margin-left:55px;">船公司：</span><input type="text" id="shipCompany">
				   	<!--  运输类型：<select id="transType">
						   		<option value="">类型</option>
						   		<option value="Whole">整箱</option>
						   		<option value="Together">拼箱</option>
						   	</select>
						   	-->
				 	<div style="float:left;width:100%;margin-bottom:10px;">
				 	 <span style="margin-left:0px;"> 预计出货日：</span><input type="text" class="datepicker" id="starttime">
				 	 <span style="margin-left:0px;">公司名称：</span><input type="text" id="company">
				   	<span style="margin-left:41px;">所在地：</span>
						<select name="cityId" class="selectautocomplete" id="cityId" style="width:96px; text-align:center">
							<option value="">请选择</option>
							<g:each in="${Provinces.values()}" var="province">
								<optgroup label="${province.desc}" style="text-align:center">
									<g:each in="${cityService.getCities(province.code).list}" var="city">
											<option value="${city.id}" style="text-align:center">${city.name}</option>
									</g:each>
								</optgroup>
							</g:each>
						</select>
					<span style="margin-left:41px;">联系人：</span><input type="text" id="contact">
					<a href="javascript:;" class=" refer" id="refer_pallet_02" >查询</a>
				</div>		
			 </div>
			</div>
			 
				<table id="list"></table>
			</div>
		</div>
	<%--</div>
	
--%><script>
var selectedDatas = []
$(function() {
	var ordernumber=$("#ordernumber")
	var createman=$("#createman")
	var createtime=$("#createtime")
	var hw=$("#hw")
	var company=$("#company")
	var shipCompany=$("#shipCompany")
	var cityId=$("#cityId")
	var start=$("#start")
	var end=$("#end")
	var contact=$("#contact")
	var starttime=$("#starttime")
	//var endtime=$("#endtime")
	//var orderstarttime=$("#orderstarttime")
	var statusSelect = $([
   		'<select class="selectpicker" style="float:right; margin-left: 10px;">',
   		'<option value="" style="width:120px">审核状态</option>', 
   		<g:each in="${Status.values()}" var="status">
   		'<option  style="width:120px" value="${status.name()}">${status.text}</option>', 
   		</g:each>
   		<g:each in="${OrderStatus.values()}" var="status">
   		'<option style="width:120px"  value="${status.name()}">${status.text}</option>', 
   		</g:each>
   		'</select>' 
   	].join(''))
   	var orderTypeSelect=$([
		'<select class="selectpicker" style="float:right;margin-left:10px;">',
		'<option value="">货盘类型</option>',
		'<option value="F">发布</option>',
		'<option value="D">导入</option>',
		'</select>'
    ].join(''))
    
	var transTypeSelect=$([
		'<select class="selectpicker" style="float:right;margin-left:10px;">',
		'<option value="">箱型</option>',
		'<option value="Whole">整箱</option>',
		'<option value="Together">拼箱</option>',
		'</select>'
    ].join(''))
	$('#list').bootstrapTable({
		cache: false,
		url : '${request.contextPath}/order/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '订单号/货物/公司/联系人';
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'number',
			title : '货盘编号',
			formatter : function (value, row, index) {<%--href="/order/data/'+row.id+'" target="_blank"--%>
				return [
						'<a class="datatable_operation view" href="javascript:void(0)" >',
						value, 
						'</a>' 
					].join('');
				},
				events : operateEvents
		}, {
			field : 'companyName',
			title : '公司名称',
			sortable : true
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, {
			field : 'cargoName',
			title : '货物名称',
			sortable : true
		//formatter: nameFormatter
		}, {
			field : 'contactName',
			title : '联系人',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'city',
			title : '所在地',
			sortable : true,
			formatter: function(city, row, index) {
				if(city) {
					return city.name
				} else {
					return null
				}
			}
		//  events: operateEvents
		}, {
			field : 'startPort',
			title : '起始港',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'endPort',
			title : '目的港',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'service',
			title : '客服',
		// formatter: operateFormatter,
		//  events: operateEvents
			formatter : function (value, row, index) {
				if(value) {
					return value.firstname;
				} else {
					return null
				}
			}
		}, {
			field : 'sales',
			title : '业务员',
		// formatter: operateFormatter,
		//  events: operateEvents
			formatter : function (value, row, index) {
				if(value) {
					return value.firstname;
				} else {
					return null
				}
			}
		}, {
			field : 'createBy',
			title : '创建人',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'dateCreated',
			title : '创建时间',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {<%--href="/order/edit/'+value+'" target="_blank"--%>
				return [
						'<a class="datatable_operation edit" href="javascript:void(0)" >',
						'修改', 
						'</a>',
						'<a class="datatable_operation closed" href="javascript:void(0)">',
						'关闭', 
						'</a>'
				].join('');
			},
			events : operateEvents
		} ],
		queryParams: function (params) {
			params.status = statusSelect.val()
			params.ordernumber=ordernumber.val()
			params.createman=createman.val()
			params.createtime=createtime.val()
			params.hw=hw.val()
			params.company=company.val()
			params.shipCompany=shipCompany.val()
	        params.orderstatus=orderTypeSelect.val()
			params.transstatus=transTypeSelect.val()
			params.start=start.val()
			params.end=end.val()
			params.contact=contact.val()
			//params.orderstarttime=orderstarttime.val()
			params.startTime=starttime.val()
			//params.endtime=endtime.val()
			params.cityId=cityId.val()
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
	$(".button-glow").css({'marginLeft':'10px'});
	$(".columns").hide();
	$("#more").click(function(){$(".definite_area").toggleClass("display")})  
	$(".refer").click(function(){$(".button-highlight").click()})

	var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">新建</a>')
	$(".datatable-search-btn").before(addBtn);
	addBtn.click(function() {
		<%--window.open('${request.contextPath}/order/edit/new');--%>
		window.location.href = '${request.contextPath}/order/edit/new';
	})
	
	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
	$(addBtn).before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/order/delete/?ids=' + selectedDatas.join();
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
            title: '导入订单信息',
            message: [
				'<iframe id="uploadFrame" name="uploadFrame" style="display: none;"></iframe>',
				'<form id="uploadForm" action="${request.contextPath}/order/importData" method="post" enctype="multipart/form-data" target="uploadFrame">', 
				//'用户手机号码: <input type="input" name="mobile"  style="background: none repeat scroll 0 0 white !important;color: #000000!important;"/>', 
				'<input type="file" name="file" />', 
				'<a href="${request.contextPath}/order/downloadExample">下载模板</a>', 
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
	
	$(".datatable-search-btn").after(statusSelect);
	$(".datatable-search-btn").after(orderTypeSelect);
	$(".datatable-search-btn").after(transTypeSelect);
	statusSelect.change(function() {
		$(".datatable-search-btn").click();
	});
	transTypeSelect.change(function(){
		$(".datatable-search-btn").click();
	});
	orderTypeSelect.change(function(){
		$(".datatable-search-btn").click();
	});

	var intervalId = window.setInterval(function() {
		var el = $(".bootstrap-select");
		if(el.size() > 0) {
			el.css("float", "right").css("marginLeft", "10px").css("marginTop", "-2px").css("width","120px");
			window.clearInterval(intervalId);
		}
	}, 10);

});

window.operateEvents = {
	'click .view' : function(e, value, row, index) {
		value=row.id;
		//alert(value);
		window.location.href = '${request.contextPath}/order/data/' + value;
	},
	'click .edit' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}/order/edit/' + value;
	},
	
	'click .closed' : function(e, value, row, index) {
		
		if(row.status == "未审核"){
				BootstrapDialog.show({
					message: '货盘正在审核中，不能被关闭'
				});
				return false;
			}
			else if(row.status == "审核中"){
				BootstrapDialog.show({
					message: '货盘正在审核中，不能被关闭'
				});
				return false;
				}else if(row.status == "已关闭"){
						BootstrapDialog.show({
							message: '货盘已关闭，不能再关闭'
						});
					}else{
							value=row.id;
							window.open('${request.contextPath}/order/close/' + value);
						}
	},
};

</script>
</body>
</html>
