<!DOCTYPE html>
<html>
<head>
<title>搜索日志</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/search_logs.css" />
<asset:javascript src="c_js/common.js" />
<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js"/>
</head>
<body>
    <div class="manage_md_right">
        <!--右侧主体-->
           <form action="/searchLog/export" method="post" id="export">
            <div class="rControlLine">
            	<span class="label0">查询条件:</span>
            	<span class="label1" >起始港:</span>
            	<input class="box1" type="text" id='startPort' />
            	<span class="label1" >目的港:</span>
            	<input class="box1" type="text" id='endPort'/>
            	<span class="label1"  >船公司:</span>
            	<input class="box1" type="text" id='shipCompany'/>
            	<span class="label1"  >搜索人:</span>
            	<input class="box1" type="text" id='searchUser'/>
            </div>
            <div class="rControlLine">
            	<span class="label1" style="margin-left:90px;">开始时间:</span>
            	<input class="box1" type="text" id="startDate" onClick="WdatePicker()"/>
            	<span class="label1">结束时间:</span>
            	<input class="box1" type="text" id="endDate" onClick="WdatePicker()"/>
            	<span class="label1">来源:</span>
            	<select class="select1" id="searchSource">
            		<option value="">请选择</option>
            		<option value="前台">前台</option>
            		<option value="后台">后台</option>
            	</select>
            	<span class="label1" >结果数:</span>
            	<select class="select1" id="resultCount">
            		<option value="">请选择</option>
            		<option value="0">0</option>
            		<option value="1~10">1~10</option>
            		<option value="11~100">11~100</option>
            		<option value="101~500">101~500</option>
            		<option value="500以上">500以上</option>
            	</select>
            	<div class="btnR btnMod1" id="search">查询</div>
            </div>
            <div class="rControlLine">
            	<span class="txt1">查询结果：<span id="totalCount" style="color:#f00;">${map.totalCount}</span></span>
            	<span class="txt1" id='pageSize'>
            		<a href="#">10</a>
            		<a href="#">20</a>
            		<a href="#">50</a>
            		<a href="#">100</a>
            		<a href="#">200</a>
            	</span>
            	<div class="btnR btnMod1" id="exportData">导出</div>
            </div>
             </form>
            <div class="rGridTop">
            	<div class="w1">编号</div>
                <div class="w2" style="color:#2a9de9">起始港</div>
                <div class="w3" style="color:#2a9de9">目的港</div>
                <div class="w4" style="color:#2a9de9">船公司</div>
                <div class="w5" style="color:#2a9de9">结果数</div>
                <div class="w6" style="color:#2a9de9">耗时(秒)</div>
                <div class="w7" style="color:#2a9de9">搜索人</div>
                <div class="w8" style="color:#2a9de9">搜索时间</div>
                <div class="w9" style="color:#2a9de9">来源</div>
            </div>
            <ul class="search_log_list rGridList">
            	<g:each in="${map.rows}" var = "row" status = "m">
            		<li>
                		<div class="w1">${m+1}</div>
                   	    <div class="w2">${row.startPort?row.startPort:'-'}</div>
                        <div class="w3">${row.endPort?row.endPort:'-'}</div>
                        <div class="w4">${row.shipCompany?row.shipCompany:'-'}</div>
                        <div class="w5">${row.resultCount}</div>
                        <div class="w6">${row.consuming}</div>
                        <div class="w7">${row.searchUser}</div>
                        <div class="w8">${row.searchTime}</div>
                        <div class="w9">${row.searchSource}</div>
                    </li>
            	</g:each>
            </ul>
            <div class="search_log_bottom"></div><input  type="hidden" value="${map.totalCount}"/>
        <!--右侧主体-->
    </div>
<script>
$(function(){
	var  pageSize = 10;
	var searchArguments = {
			'startPort' : '',
			'endPort' : '',
		    'shipCompany' : '',
		    'searchUser' : '',
			'startDate' : '',
			'endDate' : '',
			'searchSource' : '',
			'resultCount' : ''
	}

	
	var total = $('.search_log_bottom').next().val()
	var pageTotal = total % pageSize > 0 ? Math.floor(total / pageSize) + 1 :  total / pageSize
			
	initTotalPage(pageTotal)

function initTotalPage(pageTotal){
		
		setCommonPage2Event($('.search_log_bottom'),pageTotal,function(num){//初始化翻页控件 common.js中定义
			
			searchArguments.startPort = $("#startPort").val()
			searchArguments.endPort = $("#endPort").val()
			searchArguments.shipCompany = $("#shipCompany").val()
			searchArguments.companyName = $("#searchUser").val()
			searchArguments.startDate = $("#startDate").val()
			searchArguments.endDate = $("#endDate").val()
			searchArguments.searchSource = $("#searchSource option:selected").val()
			searchArguments.resultCount = $("#resultCount option:selected").val()
			/*$.post("/shipInfo/list",{offset:num-1,limit:pageSize,searchArguments,state:true},function(data){
					init(data)
			})*/
			//zcAlert(num+'页');
			var currentPage = (num-1)*pageSize
			$.ajax({
				type:'post',
				url:'/searchLog/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
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
	
	var initPageData = function(){
		searchArguments.startPort = $("#startPort").val()
		searchArguments.endPort = $("#endPort").val()
		searchArguments.shipCompany = $("#shipCompany").val()
		searchArguments.searchUser = $("#searchUser").val()
		searchArguments.startDate = $("#startDate").val()
		searchArguments.endDate = $("#endDate").val()
		searchArguments.searchSource = $("#searchSource option:selected").val()
		searchArguments.resultCount = $("#resultCount option:selected").val()
		console.log(searchArguments.resultCount)
			var currentPage = 0
				$.ajax({
						type:'post',
						url:'/searchLog/list/?offset='+currentPage+'&limit='+pageSize+'&state=true',
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

   $("#exportData").on('click',function(){
	   	
	   /* var startPort = searchArguments.startPort
		var endPort = searchArguments.endPort
		var shipCompany = 
		var searchUser = searchArguments.searchUser
		searchArguments.startDate = $("#startDate").val()
		searchArguments.endDate = $("#endDate").val()
		searchArguments.searchSource = $("#searchSource option:selected").val()
		searchArguments.resultCount = $("#resultCount option:selected").val()*/
		 $("#export").attr("action","/searchLog/export?startPort="+searchArguments.startPort+"&endPort="+
					searchArguments.endPort+"&shipCompany="+searchArguments.shipCompany+"&searchUser="+searchArguments.searchUser+
					"&startDate="+searchArguments.startDate+"&endDate="+searchArguments.endDate+"&searchSource="+searchArguments.searchSource+
					"&resultCount="+searchArguments.resultCount)
					
		/*$("#export").attr("action","/searchLog/export?searchArguments="+searchArguments)		*/		
		$("#export").submit()
	   })
	
	$("#search").click(function(){
		initPageData()
	});
	
	$('#pageSize >a').click(function(){
			pageSize = $(this).text()
			initPageData();
	})
	

	function init(data,pageNum,pageSize){
		$("#totalCount").text(data.totalCount)
		$(".rGridList").empty()
		
		var rows = data.rows
			var body = ''
			for( i in rows){
					var sequence = pageSize*(pageNum-1)+(parseInt(i)+parseInt(1))
					var startPort = rows[i].startPort?rows[i].startPort:'-'
					var endPort = rows[i].endPort?rows[i].endPort:'-'
					var shipCompany = rows[i].shipCompany?rows[i].shipCompany:'-'
					var date = new Date(rows[i].searchTime)
					var dateTime = date.getFullYear()
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
	                        
					body += '<li>'+
            		'<div class="w1">'+sequence+'</div>'+
               	    '<div class="w2">'+startPort+'</div>'+
                    '<div class="w3">'+endPort+'</div>'+
                    '<div class="w4">'+shipCompany+'</div>'+
                    '<div class="w5">'+rows[i].resultCount+'</div>'+
                    '<div class="w6">'+rows[i].consuming+'</div>'+
                    '<div class="w7">'+rows[i].searchUser+'</div>'+
                    '<div class="w8">'+dateTime+'</div>'+
                    '<div class="w9">'+rows[i].searchSource+'</div>'+
                '</li>'
			}
		$('.rGridList').append(body)
	}
})


</script>
</body>
</html>
