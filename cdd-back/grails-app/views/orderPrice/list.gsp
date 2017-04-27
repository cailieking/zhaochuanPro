<g:set var="springSecurityService" bean="springSecurityService" />
<g:set var="cityService" bean="cityService" />
<%@page import="com.cdd.base.enums.Status"%>
<%@page import="com.cdd.base.enums.InqueryPriceStatus"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<!DOCTYPE html>
<html>
<head>
<title>货盘咨询</title>
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
	margin-right:10px;
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

#refer-01{
margin: 0 40px 0  325px;

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
						  询价编号： <input type="text" name="number"  id="number" />
						  联系人： <input type="text" name="contactman"  id="contactman"/>
						 提交时间：<input name="createtime"   type="text" class="datepicker" id="createtime"/>
						 		<a href="javascript:;" class="refer " id="refer-01" >查询</a>
						 		<a href="javascript:;" class="more" id="more">更多查询条件</a>
			  		</div>
				  	 <div  class="definite_area">
				  	   		
						<span style="margin-left:33px;">受理人：</span><input type="text" id="operateBy"  class="route">
						<span style="margin-left:15px;">受理时间：</span><input type="text" id="operateTime" class="datepicker">
						<span style="margin-left:18px;">结单人：</span><input type="text" id="finishBy" class="chuancompany">
						<span style="margin-left:15px;">结单时间：</span><input type="text" id="lastUpdated" class="datepicker">
					   	
						 <a href="javascript:;" class=" refer" id="refer-02" >查询</a>
				  		
				   	</div>
			 </div>
			   <table id="list"></table>
			
		
	</div>
</div>
<%--</div>	

--%><script>
var selectedDatas = []
var currentDialog
$(function() {
	var number=$("#number")
	var contactman=$("#contactman")
	var createtime=$("#createtime")
	//var shstatus=$("#shstatus")
	var operateBy=$("#operateBy")
	var operateTime=$("#operateTime")
	var finishBy=$("#finishBy")
	var lastUpdated=$("#lastUpdated")
	//var box= $("input[name='box']")
     var statusSelect = $([
   		'<select class="selectpicker" style="float:right; margin-left: 30px;margin-right:30px;">',
   		'<option value="" style="width:120px">受理状态</option>', 
   		<g:each in="${InqueryPriceStatus.values()}" var="status">
   		'<option value="${status.name()}">${status.text}</option>', 
   		</g:each>
   		'</select>' 
   	].join(''))           
	$('#list').bootstrapTable({
		url : '${request.contextPath}/orderPrice/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '询盘编号/公司名称/电话号码';
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'number',
			title : '询盘编号',
			formatter : function (value, row, index) {<%--href="/orderPrice/view/'+row.id+'" target="_blank"--%>
				return [
						'<a class="datatable_operation view" href="javascript:;">',
						value, 
						'</a>' 
					].join('');
				},
				events : operateEvents
		},{
			field : 'order',
			title : '货盘编号',
			formatter : function (value, row, index) {<%-- href="/order/data/'+value.id+'" target="_blank" --%>
				return [
						'<a class="datatable_operation hpview" href="javascript:;">',
						value.number, 
						'</a>' 
					].join('');
				},
				events : operateEvents
		}, {
			field : 'companyName',
			title : '公司名称',
			sortable : true
		 //formatter: priceFormatter,
		 //sorter: priceSorter
		}, {
			field : 'contactMan',
			title : '联系人',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, 
	//	{
		//	field : 'city',
		//	title : '所在地',
		//	sortable : true,
		//	formatter: function(city, row, index) {
			//	if(city) {
		//			return city.name;
			//	}
			//	return null;
		//	}
		//  events: operateEvents
	//	},
		 {
			field : 'mobile',
			title : '手机号码',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'orderDescript',
			title : '备注',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'dateCreated',
			title : '提交时间',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},{
			field : 'operateBy',
			title : '受理人',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},{
			field : 'operateTime',
			title : '受理时间',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},{
			field : 'finishedBy',
			title : '结单人',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},{
			field : 'lastUpdate',
			title : '结单时间',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},{
			field : 'status',
			title : '受理状态',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		}, {
			field : 'deleteStatus',
			title : '删除状态',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},{
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {<%--href="/orderPrice/update/'+value+'" target="_blank"--%>
				return [
						'<a class="datatable_operation update" href="javascript:;">',
						'修改', 
						'</a>',
						'<a class="datatable_operation operate" href="javascript:void(0)">',
						'受理', 
						'</a>' ,
						'<a class="datatable_operation finish" href="javascript:void(0)">',
						'结单', 
						'</a>'  
				].join('');
			},
			events : operateEvents
		} ],
		queryParams: function (params) {
			params.number = number.val()
			params.contactman=contactman.val()
			params.createtime=createtime.val()
			params.status = statusSelect.val()
			params.operateBy=operateBy.val()
			params.operateTime=operateTime.val()
			params.finishBy=finishBy.val()
			params.lastUpdated=lastUpdated.val()
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
       
	<%--$("#staEnd").click(function() {
	     var url='${request.contextPath}/shipInfo/list'
	     if(!end){
		      if(!start){
                      alert("请填写起始港或目的港")
                      return
			      }
		     }
	     alert(start.val());
	    window.location.href=url;
	})--%>

	   
	<%--var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">新建</a>')
	$(".datatable-search-btn").before(addBtn);
	addBtn.click(function() {
		window.location.href = '${request.contextPath}/shipInfo/edit/new';
	})--%>
	
	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
	//$(addBtn).before(deleteBtn);
	$(".datatable-search-btn").before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/orderPrice/delete/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	})
	$(".columns").hide();

	<%--var uploadModalBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-royal table-btn">导入</a>')
	$(".datatable-search-btn").before(uploadModalBtn);
	uploadModalBtn.click(function() {
		BootstrapDialog.show({
            title: '导入货代信息',
            message: [
				'<iframe id="uploadFrame" name="uploadFrame" style="display: none;"></iframe>',
				'<form id="uploadForm" action="${request.contextPath}/shipInfo/importData" method="post" enctype="multipart/form-data" target="uploadFrame">', 
				'货代用户手机号码: <input type="input" name="mobile"  style="background: none repeat scroll 0 0 white !important;color: #000000!important;"/>', 
				'<input type="file" name="file" />', 
				'<a href="${request.contextPath}/shipInfo/downloadExample">下载模板</a>', 
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
	})--%>
	
	$(".datatable-search-btn").after(statusSelect);
	statusSelect.change(function() {
		$(".datatable-search-btn").click();
	});
 

	var intervalId = window.setInterval(function() {
		var el = $(".bootstrap-select");
		if(el.size() > 0) {
			el.css("float", "right").css("marginLeft", "10px").css("marginTop", "-2px").css("width","150px");
			window.clearInterval(intervalId);
		}
	}, 10);

});

window.operateEvents = {
	'click .operate' : function(e, value, row, index) {
		if(row.status=="已受理"){
			BootstrapDialog.show({
				message: '已结单，不能再进行操作'
			});
				return false;
			}else if(row.status=="受理中"){
				BootstrapDialog.show({
					message: '正在受理中'
				});
				return false;
			}else{
				window.location.href = '${request.contextPath}/orderPrice/operate/' + value;
			}
		<%--window.location.href = '${request.contextPath}/shipInfo/data/' + value;--%>
	},
	'click .finish' : function(e, value, row, index) {
		if(row.status=="未受理"){
			BootstrapDialog.show({
				message: '请先受理，再进行结单'
			});
				//alert("请先受理");
				return false;
			}else if(row.status=="受理中"){
				window.open('${request.contextPath}/orderPrice/finish/' + value);
				
			}else if(row.status=="已完成"){
				BootstrapDialog.show({
					message: '已结单，不能再进行操作'
				});
				//alert("已结单");
				return false;
			}
		<%--window.location.href = '${request.contextPath}/shipInfo/edit/' + value;--%>
	},
	'click .view' : function(e, value, row, index) {
		value=row.id;
		window.location.href = '${request.contextPath}/orderPrice/view/' + value;
	},
	'click .update' : function(e, value, row, index){
			
			window.location.href = '${request.contextPath}/inqueryPrice/update/' + value;
	},
	'click .hpview' : function(e,value,row,index){
			value = value.id
			window.location.href='${request.contextPath}/order/data/' +value;
	},
	
};

</script>
</body>
</html>
