<!DOCTYPE html>
<html>
<head>
<title>登录日志</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/login_log.css" />
<asset:javascript src="c_js/common.js" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js" />
</head>
<body>
	<div class="manage_md_right">
		<!--右侧主体-->
		<form action="/searchLog/export" method="post" id="export">
			<div class="rControlLine">
				<span class="label0">查询条件:</span> <span class="label1">用户名:</span>
				<input class="box1" type="text" id='username' /> <span
					class="label1" style="margin-left: 90px;">登录时间段:</span> <input
					class="box1" type="text" id="startDate" onClick="WdatePicker()" />
				<span class="txt1" style="margin-left:15px;">—</span> <input class="box1" style="margin-right:1px;" type="text"
					id="endDate" onClick="WdatePicker()" />
				<div class="btnR btnMod1" id="search">查询</div>
			</div>

			<div class="rControlLine">
				<span class="txt1">查询结果：<span id="totalCount"
					style="color: #f00;">
						${map.totalCount}
				</span></span> <span class="txt1" id='pageSize'> <a href="#">10</a> <a
					href="#">20</a> <a href="#">50</a> <a href="#">100</a> <a href="#">200</a>
				</span>
				<div class="btnR btnMod1" id="exportData">导出</div>
			</div>
		</form>
		<div class="rGridTop">
			<div class="w1">编号</div>
			<div class="w2" style="color: #2a9de9">用户名</div>
			<div class="w3" style="color: #2a9de9">登录时间</div>
			<div class="w4" style="color: #2a9de9">退出时间</div>
			<div class="w5" style="color: #2a9de9">在线时长(分钟)</div>
			<div class="w6" style="color: #2a9de9">登录IP</div>
			<div class="w7" style="color: #2a9de9">城市</div>
		</div>
		<ul class="search_log_list rGridList">
			<g:each in="${map.rows}" var="row" status="m">
				<li>
					<div class="w1">
						${m+1}
					</div>
					<div class="w2">
						${row.username}
					</div>
					<div class="w3">
						${row.loginTime?row.loginTime:'-'}
					</div>
					<div class="w4">
						${row.loginOutTime?row.loginOutTime:'-'}
					</div>
					<div class="w5">
						${row.onlineTime?row.onlineTime:'-'}
					</div>
					<div class="w6">
						${row.ip?row.ip:'-'}
					</div>
					<div class="w7">
						${row.city}
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
				'username' : '',
				'startDate' : '',
				'endDate' : ''
		}
		
	$("#search").click(function(){
		initPageData()
	});

	$('#pageSize >a').click(function(){
		pageSize = $(this).text()
		initPageData();
	})
	
	$("#exportData").on('click',function(){
		searchArguments.username=$("#username").val()
		searchArguments.startDate=$("#startDate").val()
		searchArguments.endDate=$("#endDate").val()
		 $("#export").attr("action","/loginLog/export?username="+searchArguments.username+"&startDate="+
					searchArguments.startDate+"&endDate="+searchArguments.endDate)
					
		/*$("#export").attr("action","/searchLog/export?searchArguments="+searchArguments)*/		
		$("#export").submit()
	})
	
	
	var  pageSize = 10;
	var total = $('.search_log_bottom').next().val()
	var pageTotal = total % pageSize > 0 ? Math.floor(total / pageSize) + 1 :  total / pageSize
			
	initTotalPage(pageTotal)
	
	function initTotalPage(pageTotal){
		
		console.log(pageTotal);
		setCommonPage2Event($('.search_log_bottom'),pageTotal,function(num){//初始化翻页控件 common.js中定义

			searchArguments.username=$("#username").val()
			searchArguments.startDate=$("#startDate").val()
			searchArguments.endDate=$("#endDate").val()
			var currentPage = (num-1)*pageSize
			console.log(searchArguments)
			$.ajax({
				type:'post',
				url:'/loginLog/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
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
					var username = rows[i].username?rows[i].username:'-'
					//var loginTime = rows[i].loginTime?rows[i].loginTime:'-'
					//var loginOutTime = rows[i].loginOutTime?rows[i].loginOutTime:'-'
					var onlineTime = rows[i].onlineTime?rows[i].onlineTime:'-'
					var ip = rows[i].ip?rows[i].ip:'-'
					var city = rows[i].city?rows[i].city:'-'
					var date = new Date(rows[i].loginTime)
					var loginTime = date.getFullYear()
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
							if(rows[i].loginOutTime){
	                		 var date2 = new Date(rows[i].loginOutTime)
	     					var loginOutTime = date2.getFullYear()
	     	               			 + "-"
	     	               			 + ((date2.getMonth() + 1) > 10 ? (date2.getMonth() + 1) : "0"
	     	                       	 + (date2.getMonth() + 1))
	     	               			 + "-"
	     	              	  		 + (date2.getDate() < 10 ? "0" + date2.getDate() : date2.getDate())
	     	               			 + " "
	     	               			 + (date2.getHours() < 10 ? "0" + date2.getHours() : date2.getHours())
	     	               			 + ":"
	     	                		 + (date2.getMinutes() < 10 ? "0" + date2.getMinutes() : date2.getMinutes())
	     	               			 + ":"
	     	              			 + (date2.getSeconds() < 10 ? "0" + date2.getSeconds() : date2.getSeconds());
							}else{
								var loginOutTime = '-'
								}
					body += '<li>'+
            		'<div class="w1">'+sequence+'</div>'+
               	    '<div class="w2">'+username+'</div>'+
               	 	'<div class="w3">'+loginTime+'</div>'+
            	    '<div class="w4">'+loginOutTime+'</div>'+
            	    '<div class="w5">'+onlineTime+'</div>'+
               	    '<div class="w6">'+ip+'</div>'+
               	 	'<div class="w7">'+city+'</div>'+
                '</li>'
			}
		$('.rGridList').append(body)
	}

	var initPageData = function(){
		searchArguments.username=$("#username").val()
		searchArguments.startDate=$("#startDate").val()
		searchArguments.endDate=$("#endDate").val()
			var currentPage = 0
				$.ajax({
						type:'post',
						url:'/loginLog/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
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



</script>
</body>
</html>
