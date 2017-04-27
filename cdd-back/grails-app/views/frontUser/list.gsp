<%@page import="com.cdd.base.enums.FrontUserType"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<g:set var="cityService" bean="cityService" />
<!DOCTYPE html>
<html> 
<head>
<title>用户管理</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/user_manage.css" />
<asset:javascript src="c_js/common.js" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js" />
</head>
<body>
	<div class="manage_md_right">
		<!--右侧主体-->
		<form action="" method="post" id="export">
			<div class="rControlLine">
				<span class="label0">查询条件:</span> 
				<input class="box1" type="text"  id="searchKey" style="width:220px" placeholder="用户名/姓名/公司/创建者/邀请码"/>
				 
				<span class="label1" style="margin-left: 20px;">注册时间段:</span> 
				<input class="box1" style="width:100px" type="text" id="createDateStart" onClick="WdatePicker()" />
				<span class="txt1" style="margin-left:5px;margin-right:5px">—</span> 
				<input class="box1" style="width:100px" type="text" id="createDateEnd" onClick="WdatePicker()" />
				
				<span class="label1" style="margin-left: 20px;">登录时间段:</span> 
				<input class="box1" style="width:100px" type="text" id="startDate" onClick="WdatePicker()" />
				<span class="txt1" style="margin-left:5px;margin-right:5px">—</span> 
				<input class="box1" style="width:100px" type="text" id="endDate" onClick="WdatePicker()" />
				<div class="btnR btnMod1" id="search">查询</div>
			</div>
			
			<div class="rControlLine">
				<span class="label0">筛选条件:</span>
				<select class="select1" id="frontType">
				<option value="">类型</option>
				<g:each in="${FrontUserType.values()}" var="type">
				<option value="${type.name()}">${type.text}</option>
				</g:each>
				</select>
				
				<select class="select1" style="margin-left:40px" id="comefrom">
				<option value="">来源</option>
				<option value="Z">前台</option>
				<option value="HTZC">后台</option>
				</select>
				
				<select  class="select1" id="cityId" style="margin-left:40px">
				<option value="">所在地</option>
					<g:each in="${Provinces.values()}" var="province">
						<optgroup label="${province.desc}">
							<g:each in="${cityService.getCities(province.code).list}" var="city">
								<option value="${city.id}">${city.name}</option>
							</g:each>
						</optgroup>
					</g:each>
				</select>
				
				<select class="select1" style="margin-left:40px" id="selIsEnabled">
				<option value="">许可</option>
				<option value="false">禁用</option>
				<option value="true">启用</option>
				</select>
				
				<select class="select1" style="margin-left:40px" id="selIsOnline">
				<option value="">在线状态</option>
				<option value="true">在线</option>
				<option value="false">离线</option>
				</select>
				
				<div class="btnR btnMod1" id="helpRegister">注册</div>
			</div>
			<div class="rControlLine">
				<span class="txt1">查询结果：<span id="totalCount" style="color: #f00;">${map.totalCount}</span></span> 
				<span class="txt1" id='pageSize'> <a href="#">20</a> <a href="#">50</a> <a href="#">100</a> <a href="#">500</a> <a href="#">1000</a>
				</span>
				<div class="btnR btnMod1" id="exportData">导出</div>
			</div>
		</form>
		<div class="rGridTop" style="width:130%">
			<div class="w2" style="color: #2a9de9" >用户名</div>
			<div class="w3" style="color: #2a9de9">姓名</div>
			<div class="w4" style="color: #2a9de9">所在地</div>
			<div class="w5" style="color: #2a9de9">类型</div>
			<div class="w6" style="color: #2a9de9">注册时间</div>
			<div class="w7" style="color: #2a9de9">最后登录时间</div>
			<div class="w8" style="color: #2a9de9">创建者</div>
			<div class="w9" style="color: #2a9de9">邀请码</div>
			<div class="w10" style="color: #2a9de9">许可</div>
			<div class="w11" style="color: #2a9de9">状态</div>
			<div class="w12" style="color: #2a9de9">操作</div>
		</div>
		<ul class="search_log_list rGridList" style="width:130%">
			<g:each in="${map.rows}" var="row" status="m">
			<li style="width:100%">
			<div class="w2"><a onclick="showDetail('${row.id}')">${row.username}</a></div>
			<div class="w3">${row.firstname}</div>
			<div class="w4">${row.city?.name}</div>
			<g:if test="${row.type == 'Agent'}">
			<div class="w5">货代</div>
			</g:if>
			<g:else><div class="w5">货主</div></g:else>
			
			<div class="w6">${row.dateCreated}</div>
			<div class="w7">${row.loginOutTime?row.loginOutTime:'-'}</div>
			<div class="w8">${row.createBy}</div>
			<div class="w9">${row.invitationCode?row.invitationCode:'-'}</div>
			<div class="w10">${row.enabled?'可用':'禁用'}</div>
			<div class="w11">${row.isOnline?'在线':'离线'}</div>
			<div class="w12">
			<span style="width:50px;float:left"><a  onclick="enabledUser('${row.id}','${row.enabled}')" class="color:#0088DD">${row.enabled?'禁用':'启用'}</a></span>
			<%--<span style="width:70px;float:left"><a  onclick="hornestUser('${row.id}','${row.hornest}')" class="color:#0088DD">${row.hornest?'取消诚信':'诚信'}</a></span>
			<span style="width:70px;float:left"><a  onclick="safetyUser('${row.id}','${row.safety}')" class="color:#0088DD">${row.safety?'取消保障':'保障'}</a></span>
			--%><span style="width:70px;float:left"><a  onclick="verifiedUser('${row.id}','${row.verified}')" class="color:#0088DD">${row.verified?'取消认证':'认证'}</a></span>
			<span style="width:50px;float:left"><a  onclick="editUser('${row.id}')" class="color:#0088DD">编辑</a></span>
			<span style="width:50px;float:left"><a  onclick="delUser('${row.id}')" class="color:#0088DD">删除</a></span>
			
			</div>
			
			</li>
			</g:each>
		</ul>
		<div class="search_log_bottom"></div>
		<input type="hidden" value="${map.totalCount}" />
		<!--右侧主体-->
	</div>
<script>
$(function(){
	var  pageSize = 10;
	var searchArguments = {
			'searchKey' : '',
			'createDateStart' : '',
		    'createDateEnd' : '',
		    'startDate' : '',
			'endDate' : '',
			'frontType' : '',
			'comefrom' : '',
			'cityId' : '',
			'selIsEnabled' : '',
			'selIsOnline' : ''
	}

	
	var total = $('.search_log_bottom').next().val()
	var pageTotal = total % pageSize > 0 ? Math.floor(total / pageSize) + 1 :  total / pageSize
			
	initTotalPage(pageTotal)

function initTotalPage(pageTotal){
		
		setCommonPage2Event($('.search_log_bottom'),pageTotal,function(num){//初始化翻页控件 common.js中定义
			console.log(num);
			searchArguments.searchKey = $("#searchKey").val()
			searchArguments.createDateStart = $("#createDateStart").val()
			searchArguments.createDateEnd = $("#createDateEnd").val()
			searchArguments.startDate = $("#startDate").val()
			searchArguments.endDate = $("#endDate").val()
			searchArguments.frontType = $("#frontType option:selected").val()
			searchArguments.comefrom = $("#comefrom option:selected").val()
			searchArguments.cityId = $("#cityId option:selected").val()
			searchArguments.selIsEnabled = $("#selIsEnabled option:selected").val()
			searchArguments.selIsOnline = $("#selIsOnline option:selected").val()
			/*$.post("/shipInfo/list",{offset:num-1,limit:pageSize,searchArguments,state:true},function(data){
					init(data)
			})*/
			//zcAlert(num+'页');
			var currentPage = (num-1)*pageSize
			$.ajax({
				type:'post',
				url:'/frontUser/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
				dataType:'json',
		     	data:searchArguments,
				success:function(rs){
					init(rs,num,pageSize)
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					console.log(XMLHttpRequest)
					console.log(textStatus)
					console.log(errorThrown)
				}
			});
		})
	}
	
	$("#search").click(function(){
		initPageData()
	});
	
	$('#pageSize >a').click(function(){
			pageSize = $(this).text()
			initPageData();
	})


	var initPageData = function(){
		searchArguments.searchKey = $("#searchKey").val()
		searchArguments.createDateStart = $("#createDateStart").val()
		searchArguments.createDateEnd = $("#createDateEnd").val()
		searchArguments.startDate = $("#startDate").val()
		searchArguments.endDate = $("#endDate").val()
		searchArguments.frontType = $("#frontType option:selected").val()
		searchArguments.comefrom = $("#comefrom option:selected").val()
		searchArguments.cityId = $("#cityId option:selected").val()
		searchArguments.selIsEnabled = $("#selIsEnabled option:selected").val()
		searchArguments.selIsOnline = $("#selIsOnline option:selected").val()
		console.log(searchArguments)
			var currentPage = 0
				$.ajax({
						type:'post',
						url:'/frontUser/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
						dataType:'json',
						data:searchArguments,
						success:function(rs){
								init(rs,1,pageSize)
								var pageTotal = rs.totalCount % pageSize > 0 ? Math.floor(rs.totalCount / pageSize) + 1 :  rs.totalCount / pageSize
										console.log(pageTotal)
								initTotalPage(pageTotal)
							},
						error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
						}
	
			})
		
		}

	$("#helpRegister").on('click',function(){

		window.location.href = '${request.contextPath}/frontUser/addBackUser';

		})
	
   $("#exportData").on('click',function(){
	   	
	   searchArguments.searchKey = $("#searchKey").val()
		searchArguments.createDateStart = $("#createDateStart").val()
		searchArguments.createDateEnd = $("#createDateEnd").val()
		searchArguments.startDate = $("#startDate").val()
		searchArguments.endDate = $("#endDate").val()
		searchArguments.frontType = $("#frontType option:selected").val()
		searchArguments.comefrom = $("#comefrom option:selected").val()
		searchArguments.cityId = $("#cityId option:selected").val()
		searchArguments.selIsEnabled = $("#selIsEnabled option:selected").val()
		searchArguments.selIsOnline = $("#selIsOnline option:selected").val()
		 $("#export").attr("action","/frontUser/export?searchKey="+searchArguments.searchKey+"&createDateStart="+
					searchArguments.createDateStart+"&createDateEnd="+searchArguments.createDateEnd+"&startDate="+searchArguments.startDate+
					"&endDate="+searchArguments.endDate+"&frontType="+searchArguments.frontType+"&comefrom="+searchArguments.comefrom+
					"&cityId="+searchArguments.cityId+"&selIsEnabled="+searchArguments.selIsEnabled+"&selIsOnline="+searchArguments.selIsOnline)
					
		/*$("#export").attr("action","/searchLog/export?searchArguments="+searchArguments)		*/		
		$("#export").submit()
	   })
	
	
	

	function init(data,pageNum,pageSize){
		$("#totalCount").text(data.totalCount)
		$(".rGridList").empty()
		
		var rows = data.rows
			var body = ''
			for( i in rows){
					var username = rows[i].username
					var firstname = rows[i].firstname?rows[i].firstname:'-'
					var city = rows[i].city?rows[i].city:'-'
					var type = rows[i].type?rows[i].type:'-'
					var date = new Date(rows[i].dateCreated)
					var dateCreated = date.getFullYear()
	               			 + "-"
	               			 + ((date.getMonth() + 1) > 10 ? (date.getMonth() + 1) : "0"
	                       	 + (date.getMonth() + 1))
	               			 + "-"
	              	  		 + (date.getDate() < 10 ? "0" + date.getDate() : date.getDate())
	               			 + " "
	               			 + (date.getHours() < 10 ? "0" + date.getHours() : date.getHours())
	               			 + ":"
	                		 + (date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes())
	               			 + ":"
	              			 + (date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds());
					var loginOutTime = ''
							if(rows[i].loginOutTime){
	                		var date1 = new Date(rows[i].loginOutTime)
	     					 loginOutTime = date1.getFullYear()
	     	               			 + "-"
	     	               			 + ((date1.getMonth() + 1) > 10 ? (date1.getMonth() + 1) : "0"
	     	                       	 + (date1.getMonth() + 1))
	     	               			 + "-"
	     	              	  		 + (date1.getDate() < 10 ? "0" + date1.getDate() : date1.getDate())
	     	               			 + " "
	     	               			 + (date1.getHours() < 10 ? "0" + date1.getHours() : date1.getHours())
	     	               			 + ":"
	     	                		 + (date1.getMinutes() < 10 ? "0" + date1.getMinutes() : date1.getMinutes())
	     	               			 + ":"
	     	              			 + (date1.getSeconds() < 10 ? "0" + date1.getSeconds() : date1.getSeconds()); 

							}else{
								loginOutTime = '-'
								}
					var createBy = rows[i].createBy?rows[i].createBy:'-'
					var invitationCode = rows[i].invitationCode?rows[i].invitationCode:'-'
					var enabled = rows[i].enabled?'可用':'禁用'
					var isOnline = rows[i].isOnline?'在线':'离线'
					body += '<li style="width:100%">'+
               	    '<div class="w2"><a onClick="showDetail('+"'"+data.rows[i].id+"'"+')">'+username+'</a></div>'+
                    '<div class="w3">'+firstname+'</div>'+
                    '<div class="w4">'+city+'</div>'+
                    '<div class="w5">'+type+'</div>'+
                    '<div class="w6">'+dateCreated+'</div>'+
                    '<div class="w7">'+loginOutTime+'</div>'+
                    '<div class="w8">'+createBy+'</div>'+
                    '<div class="w9">'+invitationCode+'</div>'+
                    '<div class="w10">'+enabled+'</div>'+
                    '<div class="w11">'+isOnline+'</div>'+
                    '<div class="w12">'+
                    '<span style="width:50px;float:left"><a  onclick="enabledUser('+"'"+data.rows[i].id+"'"+','+"'"+data.rows[i].enabled+"'"+')" class="color:#0088DD">'+(data.rows[i].enabled?'禁用':'启用')+'</a></span>'+
        			'<span style="width:70px;float:left"><a  onclick="verifiedUser('+"'"+data.rows[i].id+"'"+','+"'"+data.rows[i].verified+"'"+')" class="color:#0088DD">'+(data.rows[i].verified?'取消认证':'认证')+'</a></span>'+
        			'<span style="width:50px;float:left"><a  onclick="editUser('+"'"+data.rows[i].id+"'"+')" class="color:#0088DD">编辑</a></span>'+
        			'<span style="width:50px;float:left"><a  onclick="delUser('+"'"+data.rows[i].id+"'"+')" class="color:#0088DD">删除</a></span>'+

                    '</div>'+
                    
                '</li>'
			}
		$('.rGridList').append(body)
	}
})
	
function enabledUser(id,enabled){
	console.log(enabled)
	if(enabled=="true"){
		zcConfirm('是否禁用该用户？',function(r){
			if(r){
				window.location.href ='${request.contextPath}/frontUser/enable/' + id + "?enabled="+false;
				}
			})
	}else{
		zcConfirm('是启用该用户？',function(r){
			if(r){
				window.location.href ='${request.contextPath}/frontUser/enable/' + id + "?enabled="+true;
				}
			})
		}
	
}

function hornestUser(id,hornest){
	if(hornest=="true"){
		zcConfirm('是否取消设置该用户为诚信？',function(r){
			if(r){
				window.location.href ='${request.contextPath}/frontUser/hornest/' + id + "?hornest="+false;
				}
			})
	}else{
		zcConfirm('是设置该用户为诚信？',function(r){
			if(r){
				window.location.href ='${request.contextPath}/frontUser/hornest/' + id + "?hornest="+true;
				}
			})
		}
}

function safetyUser(id,safety){
	if(safety=="true"){
		zcConfirm('是否取消设置该用户为保障？',function(r){
			if(r){
				window.location.href ='${request.contextPath}/frontUser/safety/' + id + "?safety="+false;
				}
			})
	}else{
		zcConfirm('是设置该用户为保障？',function(r){
			if(r){
				window.location.href ='${request.contextPath}/frontUser/safety/' + id + "?safety="+true;
				}
			})
		}
}
function verifiedUser(id,verified){
	if(verified=="true"){
		zcConfirm('是否取消设置该用户为认证？',function(r){
			if(r){
				window.location.href ='${request.contextPath}/frontUser/verified/' + id + "?verified="+false;
				}
			})
	}else{
		zcConfirm('是设置该用户为认证？',function(r){
			if(r){
				window.location.href ='${request.contextPath}/frontUser/verified/' + id + "?verified="+true;
				}
			})
		}
}
function showDetail(id){
	$.ajax({
		type:'post',
		url:'/frontUser/data',
		dataType:'json',
		data:{id:id},
		success:function(rs){
			console.log(rs.user)
			var data = rs.user
			var date = new Date(data.dateCreated)
			var dateCreated = date.getFullYear()
           			 + "-"
           			 + ((date.getMonth() + 1) > 10 ? (date.getMonth() + 1) : "0"
                   	 + (date.getMonth() + 1))
           			 + "-"
          	  		 + (date.getDate() < 10 ? "0" + date.getDate() : date.getDate())
           			 + " "
           			 + (date.getHours() < 10 ? "0" + date.getHours() : date.getHours())
           			 + ":"
            		 + (date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes())
           			 + ":"
          			 + (date.getSeconds() < 10 ? "0" + date.getSeconds() : date.getSeconds());
			var loginOutTime = ''
				if(data.loginOutTime){
        		var date1 = new Date(data.loginOutTime)
					 loginOutTime = date1.getFullYear()
	               			 + "-"
	               			 + ((date1.getMonth() + 1) > 10 ? (date1.getMonth() + 1) : "0"
	                       	 + (date1.getMonth() + 1))
	               			 + "-"
	              	  		 + (date1.getDate() < 10 ? "0" + date1.getDate() : date1.getDate())
	               			 + " "
	               			 + (date1.getHours() < 10 ? "0" + date1.getHours() : date1.getHours())
	               			 + ":"
	                		 + (date1.getMinutes() < 10 ? "0" + date1.getMinutes() : date1.getMinutes())
	               			 + ":"
	              			 + (date1.getSeconds() < 10 ? "0" + date1.getSeconds() : date1.getSeconds()); 

				}else{
					loginOutTime = '-'
					}
		var qq = data.qq?data.qq:"-"
		var email = data.email?data.email:"-"
			
			var doHtml=
				'<div class="winModBg0">'+
				'<div class="winModBg wEditMod addLabelDlg" style="width:500px">'+
			    	'<div class="titleBg">'+
			        	'<div class="caption">用户编辑</div>'+
			            '<div class="closeBtn">X</div>'+
			        '</div>'+
			        '<ul class="editList">'+
			        '<li>'+
	            	'<div class="wLabel">用户名：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+data.username+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">姓名：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+data.firstname+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">公司名：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+data.companyName+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">QQ：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+qq+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">email：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+email+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">所在地：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+data.city+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">类型：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+data.type+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">邀请码：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+(data.invitationCode?data.invitationCode:'-')+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">创建人：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+data.createBy+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">注册时间：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+dateCreated+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">最后登录：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+loginOutTime+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">许可状态：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+(data.enabled?'可用':'禁用')+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="wLabel">在线状态：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+(data.isOnline?'在线':'离线')+'</div>'+
	            	'</li>'+
	            	
	            	'<li>'+
	            	'<div class="wLabel">认证状态：<div class="imp"></div></div>'+
	            	'<div class="txt1" >'+(data.verified?'YES':'NO')+'</div>'+
	            	'</li>'+
	            	'<li>'+
	            	'<div class="bottomBtns">'+
                    '<div id="addLabelNoBtn" class="btnMod1">关闭</div>'+
               		'</div>'+
               		'</li>'+
                    '</ul>'+
    			    '</div>'+
    				'</div>';
    				$('body').append($(doHtml));
    				modDlgEvent($('.addLabelDlg'));//自制弹出框公用事件 居中_拖拽_关闭
    				initGuestLabel($('#addLabel'),guest_label_color,'transparent');//初始化用户颜色标签控
    				//取消
    				$('#addLabelNoBtn').on('click',function(){
    					$('.addLabelDlg .closeBtn').trigger('click')
    				});
    		},
    		error:function(XMLHttpRequest, textStatus, errorThrown){
    					console.log(XMLHttpRequest)
    					console.log(textStatus)
    					console.log(errorThrown)
    		}

    	})
}
function delUser(id){
	zcConfirm('确认删除该用户？',function(r){
		if(r){
			window.location.href = '${request.contextPath}/frontUser/delete/?ids='+id
			}
		})
	
}


function editUser(id){

	$.ajax({
		type:'post',
		url:'/frontUser/data',
		dataType:'json',
		data:{id:id},
		success:function(rs){
			console.log(rs.user)
			var data = rs.user
			var doHtml=
				'<div class="winModBg0">'+
				'<div class="winModBg wEditMod addLabelDlg" style="width:580px">'+
			    	'<div class="titleBg">'+
			        	'<div class="caption">用户编辑</div>'+
			            '<div class="closeBtn">X</div>'+
			        '</div>'+
			        '<ul class="editList">'+
						
			        	'<li>'+
			            	'<div class="wLabel">用户名：</div>'+
			            	'<input type="hidden" id="id" name="id" class="box1" value="'+data.id+'"/>'+
			            	'<input type="text" id="username" name="username" class="box1" value="'+data.username+'"/>'+
			            '</li>'+
			            '<li>'+
		            	'<div class="wLabel">姓名：</div>'+
		            	'<input type="text" id="firstname" name="firstname" class="box1" value="'+data.firstname+'"/>'+
		            	'</li>'+
		            	'<li>'+
		            	'<div class="wLabel">公司名：</div>'+
		            	'<input type="text" id="companyName" name="companyName" class="box1" value="'+data.companyName+'"/>'+
		            	'</li>'+
		            	'<li>'+
		            	'<div class="wLabel">QQ：</div>'+
		            	'<input type="text" id="qq" name="qq" class="box1" value="'+data.qq+'"/>'+
		            	'</li>'+
		            	'<li>'+
		            	'<div class="wLabel">email：</div>'+
		            	'<input type="text" id="email" name="email" class="box1" value="'+data.email+'"/>'+
		            	'</li>'+
		            	'<li>'+
		        		'<div class="wLabel">所在地：</div>'+
		        		'<input type="text" id="city" name="city" class="box1" value="'+data.city+'"/>'+
		       		 	'</li>'+
		        		'<li>'+
		    			'<div class="wLabel">类型：</div>'+
		    			'<input type="text" id="type" name="type" class="box1" value="'+data.type+'"/>'+
		    			'</li>'+
		    			'<li>'+
		    			'<div class="wLabel">许可状态：</div>'+
		    				'<input type="radio" id="enabled" name="enabled" value="true" />可用'+
		    				'<input type="radio"  name="enabled" value="false" />禁用'+
		    			'</li>'+
		    			'<li>'+
		    			'<div class="wLabel">诚信状态：</div>'+
		    			'<input type="radio" id="hornest" name="hornest" value="true" />YES'+
		    			'<input type="radio"  name="hornest" value="false" />NO'+
		    			'</li>'+
		    			'<li>'+
		    			'<div class="wLabel">保障状态：</div>'+
		    			'<input type="radio" id="safety" name="safety" value="true" />YES'+
		    			'<input type="radio"  name="safety" value="false" />NO'+
		    			'</li>'+
		    			'<li>'+
		    			'<div class="wLabel">认证状态：</div>'+
		    			'<input type="radio" id="verified" name="verified" value="true" />YES'+
		    			'<input type="radio"  name="verified" value="false" />NO'+
		    			'</li>'+
		    			'<li>'+
		    			'<div class="wLabel">密码修改：</div>'+
		    			'<input type="password" id="password" name="password" class="box1" placeholder="新密码"/>'+
		    			'<input type="password" id="passwordRepeat" name="password" class="box1" placeholder="重复"/>'+
		    			'</li>'+
			            '<li>'+
			            	'<div class="bottomBtns">'+
			                    '<div id="addLabelNoBtn" class="btnMod1">取消</div>'+
			                    '<div id="addLabelYesBtn" class="btnMod1">确定</div>'+
			                '</div>'+
			            '</li>'+
			        '</ul>'+
			    '</div>'+
			'</div>';
				$('body').append($(doHtml));
				if(data.enabled){
					$("input[name=enabled]").parent().children().eq(1).attr("checked",true)
				}else{
					$("input[name=enabled]").parent().children().last().attr("checked",true)
				}
				if(data.hornest){
					$("input[name=hornest]").parent().children().eq(1).attr("checked",true)
				}else{
					$("input[name=hornest]").parent().children().last().attr("checked",true)
				}
				if(data.safety){
					$("input[name=safety]").parent().children().eq(1).attr("checked",true)
				}else{
					$("input[name=safety]").parent().children().last().attr("checked",true)
				}
				if(data.verified){
					$("input[name=verified]").parent().children().eq(1).attr("checked",true)
				}else{
					$("input[name=verified]").parent().children().last().attr("checked",true)
				}

				$('#addLabelYesBtn').on('click',function(){
					var data = {}
					data.id = $("#id").val();
					data.username = $("#username").val();
					data.firstname = $("#firstname").val();
					data.companyName = $("#companyName").val();
					data.qq = $("#qq").val();
					data.email = $("#email").val();
					data.city = $("#city").val();
					data.type = $("#type").val();
					data.enabled = $("input[name='enabled']:checked").val() 
					data.hornest = $("input[name='hornest']:checked").val() 
					data.safety = $("input[name='safety']:checked").val() 
					data.verified = $("input[name='verified']:checked").val() 
					data.password = $("#password").val();
					data.passwordRepeat = $("#passwordRepeat").val();
					console.log('data',data)
					if(data.username == ""){
						zcAlert("用户名不能空！");
						return;
					}
					if(data.firstname == ""){
						zcAlert("姓名不能空！");
						return;
					}
					if(data.qq == ""){
						zcAlert("qq不能空！");
						return;
					}
					if(data.email == ""){
						zcAlert("email不能空！");
						return;
					}else{
						 var myreg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/;
						  if(!myreg.test(data.email))
           					{
                  			 zcAlert('提示\n\n请输入有效的E_mail！');
                  			 return;
                  		 }
					}
					if(data.password!=data.passwordRepeat){
						zcAlert("两次密码输入不同！");
						return;
					}
					
					$.ajax({
						type:'post',
						url:'/frontUser/save',
						dataType:'json',
						data:data,
						success:function(rs){

							if(rs.status){
								 location.reload();
								}
							
							}
					});
	
				});
				
				modDlgEvent($('.addLabelDlg'));//自制弹出框公用事件 居中_拖拽_关闭
				initGuestLabel($('#addLabel'),guest_label_color,'transparent');//初始化用户颜色标签控
				//取消
				$('#addLabelNoBtn').on('click',function(){
					$('.addLabelDlg .closeBtn').trigger('click')
				});
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
					console.log(XMLHttpRequest)
					console.log(textStatus)
					console.log(errorThrown)
		}

	})

	
}
</script>