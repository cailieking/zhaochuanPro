<g:set var="springSecurityService" bean="springSecurityService" />
<g:set var="cityService" bean="cityService" />
<%@page import="com.cdd.base.enums.Status"%>
<%@page import="com.cdd.base.enums.OrderStatus"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<!DOCTYPE html>
<html>
<head>
<title>货盘审核</title>
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
				   	<span style="margin-left:55px;">货物：</span><input type="text" id="hw">
				   	<span style="margin-left:55px;">公司：</span><input type="text" id="company">
				   	<!--  运输类型：<select id="transType">
						   		<option value="">类型</option>
						   		<option value="Whole">整箱</option>
						   		<option value="Together">拼箱</option>
						   	</select>
						   	-->
					<span style="margin-left:41px;">始发港：</span><input type="text" id="start">
				 <div style="float:left;width:100%;margin-bottom:10px;">
				   	<span style="margin-left:42px;">目的港：</span><input type="text" id="end">			   
				   	<span style="margin-left:41px;">联系人：</span><input type="text" id="contact">				   
				   	<span style="margin-left:41px;">所在地：</span>
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
				  </div> 
				   	<div style="float: left;margin-bottom:10px;margin-left:0px">
				   	<span style="margin-left:0px;">报价截止日期：</span><input type="text" class="datepicker" id="orderstarttime">
				       <span style="margin-left:0px;"> 走货开始日期：</span><input type="text" class="datepicker" id="starttime">
				   	<span style="margin-left:0px;">走货结束日期：</span><input type="text" class="datepicker" id="endtime">
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
	var cityId=$("#cityId")
	var start=$("#start")
	var end=$("#end")
	var contact=$("#contact")
	var starttime=$("#starttime")
	var endtime=$("#endtime")
	var orderstarttime=$("#orderstarttime")
	var statusSelect = $([
   		'<select class="selectpicker" style="float:right; margin-left: 10px;">',
   		'<option value="" >审核状态</option>', 
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
		url : '${request.contextPath}/orderAudit/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '订单号/货物/公司/联系人';
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'number',
			title : '货盘编号',
			formatter : function (value, row, index) {<%--href="/orderAudit/view/'+row.id+'" target="_blank"--%>
				return [
						'<a class="datatable_operation view" href="javascript:void(0);" >',
						value, 
						'</a>' 
					].join('');
				},
				events : operateEvents
		},{
			field : 'companyName',
			title : '公司',
			sortable : true
		// formatter: priceFormatter,
		//sorter: priceSorter
		}, {
			field : 'cargoName',
			title : '货物',
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
			title : '始发港',
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
			formatter : function (value, row, index) {<%--href="/orderAudit/data/'+value+'" target="_blank"--%>
				return [
						'<a class="datatable_operation edit" href="javascript:;" >',
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
	        params.orderstatus=orderTypeSelect.val()
			params.transstatus=transTypeSelect.val()
			params.start=start.val()
			params.end=end.val()
			params.contact=contact.val()
			params.orderstarttime=orderstarttime.val()
			params.starttime=starttime.val()
			params.endtime=endtime.val()
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

	
	$(".datatable-search-btn").after(statusSelect);
	$(".datatable-search-btn").after(orderTypeSelect);
	$(".datatable-search-btn").after(transTypeSelect);
	statusSelect.change(function() {
		$(".datatable-search-btn").click()
	});
	transTypeSelect.change(function(){
		$(".datatable-search-btn").click();
	});
	orderTypeSelect.change(function(){
		$(".datatable-search-btn").click();
	});

	//不通过
	var nopassBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">不通过</a>')
	$(".datatable-search-btn").before(nopassBtn);
	nopassBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定不通过吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/orderAudit/nopass/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	})
		
	//通过
	var passBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">通过</a>')
	$(".datatable-search-btn").before(passBtn);
	passBtn.click(function() {
		 
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定通过吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/orderAudit/pass/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	})

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
		window.location.href = '${request.contextPath}/orderAudit/view/' + row.id;
	},
	'click .edit' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}/orderAudit/data/' + value;
	},

    'click .closed' : function(e, value, row, index) {
		alert(row.status)
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
							window.open('${request.contextPath}/orderAudit/close/' + value);
						}
	},
};

</script>
</body>
</html>
