<%@page import="com.cdd.base.enums.FrontUserType"%>
<%@page import="com.cdd.base.enums.Provinces"%>
<g:set var="cityService" bean="cityService" />
<!DOCTYPE html>
<html>
<head>
<title>访问日志</title> 
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" /> 
<asset:stylesheet src="c_css/login_log.css" />
<asset:javascript src="c_js/common.js" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js" />
</head> 

<body>
	<div class="manage_md_right">
		<!--右侧主体--> 
		<form action="/accessLog/export" method="post" id="export">
			<div class="rControlLine">
				<span class="label0">查询条件:</span> 
				<input class="box1" type="text" id='searchKey' placeholder="访问者/栏目标题/IP"/> <span
					class="label1" style="margin-left: 90px;">登录时间段:</span> <input
					class="box1" type="text" id="startDate" onClick="WdatePicker()" />
				<span class="txt1" style="margin-left:15px;">—</span> <input class="box1" style="margin-right:1px;" type="text"
					id="endDate" onClick="WdatePicker()" />
				<div class="btnR btnMod1" id="search">查询</div>
			</div>
			<div><span>&nbsp;&nbsp;</span></div>
			<div class="rControlLine">
				<span class="txt1">查询结果：<span id="totalCount"
					style="color: #f00;">
						${map.totalCount}
				</span></span> <span class="txt1" id='pageSize'> <a href="#">10</a> <a
					href="#">20</a> <a href="#">50</a> <a href="#">100</a> <a href="#">200</a>
				</span>
				
				<select class="select1" style="margin-left:300px" id="type">
				<option value="">访问类型</option>
				<option value="游客">游客</option>
				<option value="搜索引擎">搜索引擎</option>
				<option value="登录用户">登录用户</option>
				</select>
				
				<select  class="select1" id="cityId" style="margin-left:20px">
				<option value="">所在地</option>
					<g:each in="${Provinces.values()}" var="province">
						<optgroup label="${province.desc}">
							<g:each in="${cityService.getCities(province.code).list}" var="city">
								<option value="${city.id}">${city.name}</option>
							</g:each>
						</optgroup>
					</g:each>
				</select>
				<div class="btnR btnMod1" id="exportData">导出</div>
			</div>
		</form>
		<div class="rGridTop">
			<div class="w1">编号</div>
			<div class="w2" style="color: #2a9de9">访问者</div>
			<div class="w3" style="color: #2a9de9">访问类型</div>
			<div class="w4" style="color: #2a9de9">栏目/标题</div>
			<div class="w5" style="color: #2a9de9">访问时间</div>
			<div class="w6" style="color: #2a9de9">IP</div>
			<div class="w7" style="color: #2a9de9">城市</div>
		</div>
		<ul class="search_log_list rGridList">
			<g:each in="${map.rows}" var="row" status="m">
				<li >
					<div class="w1">
						${m+1}
					</div>
					<div class="w2">
						${row.visitor}
					</div>
					<div class="w3">
						${row.type}
					</div>
					<div class="w4" title="${row.url}" style="overflow:hidden;text-overflow: ellipsis;white-space: nowrap;">
						${row.url}
					</div>
					<div class="w5">
						${row.time}
					</div>
					<div class="w6">
						${row.ip?row.ip:'-'}
					</div>
					<div class="w7">
						${row.city?row.city:'-'}
					</div>
				</li>
			</g:each>
		</ul>
		<div class="search_log_bottom"></div>
		<input type="hidden" value="${map.totalCount}" />
		<!--右侧主体-->
	</div>
	<script>
	var searchArguments = {
			'searchKey' : '',
			'startDate' : '',
			'endDate' : '',
			'type' : '',
			'cityId' : '',
		}
	
	$("#search").click(function(){
		initPageData()
	});

	$('#pageSize >a').click(function(){
		pageSize = $(this).text()
		initPageData();
	})
	
	$("#exportData").on('click',function(){
		searchArguments.searchKey=$("#searchKey").val()
		searchArguments.startDate=$("#startDate").val()
		searchArguments.endDate=$("#endDate").val()
		searchArguments.type = $("#type option:selected").val()
		searchArguments.cityId = $("#cityId option:selected").val()
		 $("#export").attr("action","/accessLog/export?searchKey="+searchArguments.searchKey+"&startDate="+
					searchArguments.startDate+"&endDate="+searchArguments.endDate+"&type="+searchArguments.type+"&cityId="+searchArguments.cityId)
					
		/*$("#export").attr("action","/searchLog/export?searchArguments="+searchArguments)*/		
		$("#export").submit()
	})
	var  pageSize = 10;
	var total = $('.search_log_bottom').next().val()
	var pageTotal = total % pageSize > 0 ? Math.floor(total / pageSize) + 1 :  total / pageSize
			
	initTotalPage(pageTotal)

function initTotalPage(pageTotal){
		searchArguments.searchKey=$("#searchKey").val()
		searchArguments.startDate=$("#startDate").val()
		searchArguments.endDate=$("#endDate").val()
		searchArguments.type = $("#type option:selected").val()
		searchArguments.cityId = $("#cityId option:selected").val()
		console.log(pageTotal);
		setCommonPage2Event($('.search_log_bottom'),pageTotal,function(num){//初始化翻页控件 common.js中定义

			
			var currentPage = (num-1)*pageSize
			console.log(searchArguments)
			$.ajax({
				type:'post',
				url:'/accessLog/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
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

	function init(data,pageNum,pageSize){
		$("#totalCount").text(data.totalCount)
		$(".rGridList").empty()
		
		var rows = data.rows
			var body = ''
			for( i in rows){
				var sequence = pageSize*(pageNum-1)+(parseInt(i)+parseInt(1))	
				var visitor = rows[i].visitor
				var type = rows[i].type
				var url = rows[i].url
				var date = new Date(rows[i].time)
				var time = date.getFullYear()
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
				
				var ip = rows[i].ip
				var city = rows[i].city?rows[i].city:'-'
					body += '<li>'+
            		'<div class="w1">'+sequence+'</div>'+
               	    '<div class="w2">'+visitor+'</div>'+
               	 	'<div class="w3">'+type+'</div>'+
            	    '<div class="w4" title='+url+' style="overflow:hidden;text-overflow: ellipsis;white-space: nowrap;">'+url+'</div>'+
            	    '<div class="w5">'+time+'</div>'+
               	    '<div class="w6">'+ip+'</div>'+
               	 	'<div class="w7">'+city+'</div>'+
                '</li>'
			}
		$('.rGridList').append(body)
	

	}
	var initPageData = function(){
		searchArguments.searchKey=$("#searchKey").val()
		searchArguments.startDate=$("#startDate").val()
		searchArguments.endDate=$("#endDate").val()
		searchArguments.type = $("#type option:selected").val()
		searchArguments.cityId = $("#cityId option:selected").val()
			var currentPage = 0
				$.ajax({
						type:'post',
						url:'/accessLog/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
						dataType:'json',
						data:searchArguments,
						success:function(rs){
							console.log(rs);
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
</script>
</body>
</html>
