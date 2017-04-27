<%@page import="com.cdd.base.enums.FrontUserType"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<g:set var="cityService" bean="cityService" />
<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE html>
<html>
<head>
<title>用户列表</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:javascript src="list-table.js" />
<asset:stylesheet src="form-table.css" />
<asset:javascript src="dialog.js" />
<link rel="stylesheet" href="/assets/ui-dialog.css">
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
			   
			   <div>&nbsp;</div>
			   <div>
			   <span>注册时间起：</span><input   id="registerStratDate" class="datepicker" type="text"  />
			   <span>注册时间止：</span><input id="registerEndDate" class="datepicker" type="text"  />
			   <span>创建者:</span><input type="text"   name="createBy"   id="createBy"/>
			   <%--<span>核实者:</span><input type="text"   name="checkBy"   id="checkBy"/>--%>
			   <span>邀请码:</span><input type="text"   name="invitationCode"   id="invitationCode"/>
			   <div>&nbsp</div>
				<table id="list"></table>
			</div>
		</div>
	</div>
<script>

var typeSelect = $([
	'<select class="selectpicker" style="float:right; margin:0 5px;">',
	'<option value="">类型</option>', 
	<g:each in="${FrontUserType.values()}" var="type">
	'<option value="${type.name()}">${type.text}</option>', 
	</g:each>
	'</select>' 
].join(''))

var comeFromSelect = $([
	'<select class="selectpicker" style="float:right; margin:0 5px;">',
	'<option value="">来源</option>', 
	'<option value="Z">注册</option>', 
	//'<option value="D">导入</option>', 
	'<option value="HTZC">后台注册</option>', 
	'</select>' 
].join(''))

var selectedDatas = []

$(function() {
	var cityId =$("#cityId")
	var createBy=$("#createBy")
	var checkBy = $("#checkBy")
	var registerStratDate = $("#registerStratDate")
	var registerEndDate = $("#registerEndDate")
	var invitationCode  =  $("#invitationCode")
	$('#list').bootstrapTable({
		url : '${request.contextPath}/frontUser/list?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '用户名/姓名/公司';
		},
		columns : [{
			checkbox : true
		}, {
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
				if(city) {
					return city.name;
				}
				return null;
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
			title : '注册时间',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},
		{
			field : 'createBy',
			title : '创建者',
			sortable : true
		// formatter: operateFormatter,
		//  events: operateEvents
		},
		{
		    field : 'loginTime',
			title : '最后登录时间',
			sortable : true
		},
		 {
			field : 'comeFrom',
			title : '来源',
			sortable : true,
			formatter: function(value, row, index) {
				if(value=="Z") {
					return "注册";
				} 
				if(value=="D"){
					return "导入";
					}else {
					return "后台注册";
				}
			}
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
			}
		//  events: operateEvents invitationCode
		},
		{
		    field : 'invitationCode',
			title : '邀请码',
			sortable : true
		}, {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				var enableText = '禁用'
				if(!row.enabled) {
					enableText = '启用'
				}

				var hornestText = '取消诚信'
				if(!row.hornest) {
					hornestText = '诚信'
				}

				var safetyText = '取消保障'
				if(!row.safety) {
					safetyText = '保障'
				}

				var verifiedText = '取消认证'
				if(!row.verified) {
					verifiedText = '认证'
				}

				return [
						'<a class="datatable_operation stop" href="javascript:void(0)">',
						enableText,
						'</a>',
						'<a class="datatable_operation hornest" href="javascript:void(0)">',
						hornestText,
						'</a>',
						'<a class="datatable_operation safety" href="javascript:void(0)">',
						safetyText,
						'</a>',
						'<a class="datatable_operation verified" href="javascript:void(0)">',
						verifiedText,
						'</a>'
				].join('');
			},
			events : operateEvents
		} ],
		queryParams: function (params) {
			params.type = typeSelect.val();
			params.cityId = cityId.val();
			params.comeFrom=comeFromSelect.val();
			params.registerStratDate=registerStratDate.val();
			params.registerEndDate=registerEndDate.val();
			params.createBy=createBy.val();
			params.checkBy=checkBy.val();
			params.invitationCode = invitationCode.val();
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
	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
	$(".datatable-search-btn").before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/frontUser/delete/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
			
		}
	})
	var sendSms = $('<a href="javascript:;" style="background-color:#2E92EC;" class="button button-glow button-rounded button-caution-flat table-btn">发送短信</a>')
	$(".datatable-search-btn").before(sendSms);
	sendSms.click(function() {
		if(selectedDatas.length > 0) {
		var mobile = '';
		var userData=$('#list').bootstrapTable('getSelections');
		for(i=0;i<userData.length;i++){
			mobile+=userData[i].username+';';
		}
		var d = dialog({
			id : 'id-demo',
		    title: '发送短信',
		    content: '<form action="${request.contextPath}/frontUser/sendSms" method="post" id="dataForm" >' 
		    	+'<div style="padding:8px 0;"><input type="radio" checked="checked" name="sendMsg" value="ship"/>运价推送<input style="margin-left:8px;" type="radio" name="sendMsg" value="order"/>货盘推送</div>'
		    	+'<div><span style="color:red">*</span>收信人<textarea style="width:400;height:50;"  name="mobile" >'+mobile+'</textarea></div>'
		    	
			    +'<div ><span style="color:red">*</span>内容（不用编辑）<textarea  style="width:400;height:200;" name="content" >"尊敬的【变量】，您在找船网关注的【变量】，有新的【变量】发布，请登录找船网【变量】查看：www.zhao-chuan.com。"</textarea>'
			    +'</form>',
			    
		    ok: function () {
		    	$('#dataForm').submit();
		    },
	    	cancel: function(){
				//this.close();
		    }
		}).width(500).height(400);		

		d.show();
		}
		else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
			
		}
	})
	
	
	var addUserBtn = $('<a href="javascript:;" style="background-color:#2E92EC;" class="button button-glow button-rounded button-caution-flat table-btn">后台注册用户</a>')
	    $(".datatable-search-btn").before(addUserBtn);
	    addUserBtn.click(function() {
			window.location.href = '${request.contextPath}/frontUser/addBackUser';
				
		});
		
	$(".datatable-search-btn").after(typeSelect);
	typeSelect.change(function() {
		$(".datatable-search-btn").click();
	});
	$(".datatable-search-btn").after(comeFromSelect);
	comeFromSelect.change(function() {
		$(".datatable-search-btn").click();
	});

	var intervalId = window.setInterval(function() {
		var el = $(".bootstrap-select");
		if(el.size() > 0) {
			el.css("float", "right").css("marginRight", "10px").css("marginTop", "0px").css("width", "140px");
			window.clearInterval(intervalId);
		}
	}, 10);
	
});

window.operateEvents = {
	'click .edit' : function(e, value, row, index) {
			window.location.href = '${request.contextPath}/frontUser/data/' + row.id;
		},
	'click .stop' : function(e, value, row, index) {
		if(row.enabled) {
			BootstrapDialog.confirm("确定要禁用 " + row.firstname + " 吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/frontUser/enable/' + row.id + "?enabled=false";
	            }
	        });
		} else {
			BootstrapDialog.confirm("确定要启用 " + row.firstname + " 吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/frontUser/enable/' + row.id + "?enabled=true";
	            }
	        });
		}
	},

	'click .hornest' : function(e, value, row, index) {
		if(row.hornest) {
			BootstrapDialog.confirm("确定要取消设置 " + row.firstname + " 为诚信用户吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/frontUser/hornest/' + row.id + "?hornest=false";
	            }
	        });
		} else {
			BootstrapDialog.confirm("确定要设置 " + row.firstname + " 为诚信用户吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/frontUser/hornest/' + row.id + "?hornest=true";
	            }
	        });
		}
	},

	'click .safety' : function(e, value, row, index) {
		if(row.safety) {
			BootstrapDialog.confirm("确定要取消设置 " + row.firstname + " 为保障用户吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/frontUser/safety/' + row.id + "?safety=false";
	            }
	        });
		} else {
			BootstrapDialog.confirm("确定要设置 " + row.firstname + " 为保障用户吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/frontUser/safety/' + row.id + "?safety=true";
	            }
	        });
		}
	},

	'click .verified' : function(e, value, row, index) {
		if(row.verified) {
			BootstrapDialog.confirm("确定要取消设置 " + row.firstname + " 为认证用户吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/frontUser/verified/' + row.id + "?verified=false";
	            }
	        });
		} else {
			BootstrapDialog.confirm("确定要设置 " + row.firstname + " 为认证用户吗？", function(result) {
	            if(result) {
					window.location.href = '${request.contextPath}/frontUser/verified/' + row.id + "?verified=true";
	            }
	        });
		}
	}
};

</script>
</body>
</html>
