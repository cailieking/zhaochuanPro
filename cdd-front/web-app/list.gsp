<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>找船网</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="keywords" content="找船网">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<link rel="stylesheet" type="text/css" href="../css/shiplist.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">

<script src="../js/jquery.js"></script>
<script src="../js/jquery-ui.js"></script>
<script src="../js/js.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
</head>
<body>

	<div class="w960">
		<div class=" right release_single">
			<div class="head-title">
				<b></b> <span class="adds">咨询管理</span> <span class="model">（<b>*</b>为必填项）
				</span>
			</div>
			<form action="/inqueryPrice/list">
				<div class="search_area">
					<ul class="list">
						<li class="list-title">交易状态</li>
						<li class="list-select"><select name="status" id="status">
								<option value="">请选择交易状态</option>
								<option value="NotAccepted">未受理</option>
								<option value="Acceptance">受理中</option>
								<option value="Accepted">已完成</option>
								<option value="Revoked">已撤销</option>
						</select></li>
						<li class="list-title">关键字</li>
						<li class="list-import"><input type="text"
							placeholder="起始港/目的港" / name="serach" id="serach"></li>
					</ul>

					<a href="javascript:void(0)" class="search-btn" id="inquery">查询</a> <a
						href="javascript:void(0)" class="search-btn-more" id="more">更多查询条件</a>
					<ul class="list" id="list1" style="display: none">
						<li class="list-title">航程</li>
						<li class="list-import"><input type="text"
							placeholder="请输入航程" name="shippingDays" id="shippingDays" /></li>
						<li class="list-title">船公司</li>
						<li class="list-import"><input type="text"
							placeholder="请输入船公司" name="shipCompany" id="shipCompany" /></li>
					</ul>
					<ul class="list" id="list2" style="display: none">
						<li class="list-title">开船日</li>
						<li class="list-import"><input type="text"
							placeholder="年/月/日" name="endDate" id="endDate" /></li>
						</li>
						<li class="list-title">有效期</li>
						<li class="list-validity"><input type="text"
							placeholder="年/月/日" name="validityStratDate"
							id="validityStratDate" /> <b>-</b> <input type="text"
							placeholder="年/月/日" name="validityEndDate" id="validityEndDate" /></li>
					</ul>
				</div>
			</form>

			<div class="clear"></div>
			
				<ul class="title-list">
					<li class="port" style="line-height:30px">起始港/目的港/航程/船期</li>
					<li class="cost">运费</li>
					<li class="shipping-date">船期</li>
					<li class="state">交易状态</li>
					<li class="operation">操作</li>
				</ul>
			
			<div id="list"></div>
		</div>

		<div class=" enquiryList backpage backship needtop"></div>
		<script>
	$(document).ready(function(){
		$("#inquery").click(function() {
			var status = $("#status").val()
			var serach = $("#serach").val()
			var validityStratDate = $("#validityStratDate").val()
			var validityEndDate = $("#validityEndDate").val()
			var shipCompany = $("#shipCompany").val()
			var shippingDays = $("#shippingDays").val()
			var endDate = $("#endDate").val()
					$.ajax({
								url : "/InqueryPrice/list",
								type : "post",
								cache : true,
						        dataType : "json",
								data : {
									status : status,
									serach : serach,
									shippingDays : shippingDays,
									shipCompany : shipCompany,
									endDate : endDate,
									validityStratDate : validityStratDate,
									validityEndDate : validityEndDate
								},
								success : function(rs) {
									var result = rs.result
									var list = $("#list")
									//if (rs.statu == "0") {
									list.children().remove();
										var t = 0;
										for (i = 0; i <result.length; i++) {
											    var project=result[i]
											
											if (project.deleteStatus == "0") {
												++t
												var model = inquery(project.id,
														project.companyName,
														project.dateCreated,
														project.transType,
														project.startPort,
														project.startPortCn,
														project.endPort,
														project.endPortCn,
														project.middlePort,
														project.middlePortCn,
														project.shippingDay,
														project.shippingDays,
														project.gp20,
														project.gp40,
														project.hq40,
														project.startDate,
														project.status,
														project.endDate,
														project.infoid,
														project.number
														);
												
														//console.log('model---->',model);
												list.append(model)
												$(".status").each(function(){
								if($(this).html().trim()==="已撤销"){
									 var targetEl = $(this).parent().parent().children().find(".repeal");
									 targetEl.prop("href")=="javascript:void(0)";
									 targetEl.css({'color':'#b4b4b4'});
									}


								})
											}
										}
										if (t == 0) {
											list.children().remove();
											alert("你所选择的查询条件沒有数据")
										    }
									} 
								
								//error:function(rs){
									//console.log(rs);
								//}
							})
						})

				// $("#list").click(function(evt){
					//				  evt.stopPropagation();
					//		        	evt.preventDefault();
					//				  var $target = $(evt.target);
					//				  if($target.hasClass('repeal')){
					//					  confirm("确实是否需要修改")
					//				   }
							      
							        		 
					//		         })

						
			})

			
			
            
	           
			
	function inquery(id, companyName, dateCreated, transType, startPort,
			startPortCn, endPort, endPortCn, middlePort, middlePortCn,
			shippingDay, shippingDays, gp20, gp40, hq40, startDate, status,
			endDate, infoid,number) {
		var msgTpl = [


   ' <ul class="details">',
       ' <li class="fl  ">',
          '  <b>询价编号：</b>',
          //'<s><a href="javascript:void(0)">',number,'</a></s>',
          '<s><a href="InqueryPrice/view?number='+number+'">',number,'</a></s>',
        '</li>',
        '<li class="fl ">',
        '<b>运价编号：</b>',
        '<s>',infoid,'</s>',
   ' </li>',
        '<li class="fl ">',
            '<b>提交时间：</b>',
            '<s>',dateCreated,'</s>',
       ' </li>',
       ' <li class="fl">',
            '<b>运输类型：</b>',
            '<s>',transType,'</s>',
        '</li>',

    '</ul>',
    '<ul class="details-info">',
      '  <li class="port fl" >',
            '<div  class="list-01">',
             '   <div class="start-port">',startPort,'</div>',
                '<div style="height:20px;"> <b class="arrow"></b>	</div>',
                '<div class="end-port">',endPort,'</div>',
           ' </div>',
            '<div class="list-02">',
                '<span>航程</span>',
               ' <b>',shippingDays,'天</b>',
                '<span>船期</span>',
                '<b>',shippingDay,'</b>',
            '</div>',
        '</li>',
        '<li class="cost fl price-area" >',
            '<ul>',
                '<li>',
               '     <div class="box">20GP</div>',
                   ' <div class="price">$',gp20,'</div>',
                '</li>',
                '<li>',
                    '<div class="box">40GP</div>',
                    '<div class="price">$',gp40,'</div>',
                '</li>',
                '<li>',
                    '<div class="box">40HQ</div>',
                    '<div class="price">$',hq40,'</div>',
               ' </li>',

            '</ul>',
       ' </li>',
        '<li class="shipping-date fl">',
            '<span class="hanggao">',startDate,'</span>',
       ' </li>',
        '<li class="state fl">',
         ' <span class="hanggao status">',status,'</span>',
        '</li>',
       ' <li class="fl operation">',
            '<a href="/InqueryPrice/cargo?id='+id+'" class="hanggao amend">修改</a>',
           ' <a href="/InqueryPrice/updateStatus?infoid='+infoid+'" class="hanggao repeal">撤销</a>',
          ' <a href="/InqueryPrice/deletecargo?infoid='+id+'" class="hanggao delete">删除</a>',
        '</li>',
   ' </ul>'
].join('');
		return msgTpl;
                //var list=$("#list");
               //this.$("#dateCreated").html(dateCreated)
               //list.append($(msgTpl));
               // return msgTpl
	}

	
		var status = $("#status").val()
		var serach = $("#serach").val()
		var validityStratDate = $("#validityStratDate")
				.val()
		var validityEndDate = $("#validityEndDate").val()
		var shipCompany = $("#shipCompany").val()
		var shippingDays = $("#shippingDays").val()
		var endDate = $("#endDate").val()

		$.ajax({
			url : "/InqueryPrice/list",
			type : "post",
			cache : true,
	        dataType : "json",
			data : {
				status : status,
				serach : serach,
				shippingDays : shippingDays,
				shipCompany : shipCompany,
				endDate : endDate,
				validityStratDate : validityStratDate,
				validityEndDate : validityEndDate
			},
			success : function(rs) {
				var result = rs.result
				//if (rs.statu == "0") {
					
					for (i = 0; i <result.length; i++) {
						    var project=result[i]
						var list = $("#list")
						if (project.deleteStatus == "0") {
							
							var model = inquery(project.id,
									project.companyName,
									project.dateCreated,
									project.transType,
									project.startPort,
									project.startPortCn,
									project.endPort,
									project.endPortCn,
									project.middlePort,
									project.middlePortCn,
									project.shippingDay,
									project.shippingDays,
									project.gp20,
									project.gp40,
									project.hq40,
									project.startDate,
									project.status,
									project.endDate,
									project.infoid,
									project.number
									);
							
									//console.log('model---->',model);
							list.append(model);
							$(".status").each(function(){
								if($(this).html().trim()==="已撤销"){
									 var targetEl = $(this).parent().parent().children().find(".repeal");
									 targetEl.attr("href","javascript:void(0)");
									 targetEl.css({'color':'#b4b4b4'});
								}


							})
								
								
								  
				 
									


								 
								
						}
						
					}
				
				} 
			
			//error:function(rs){
				//console.log(rs);
			//}
			})
		
		$("#more").click(function(){
            $("#list1").is(':hidden') === true ? $("#list1").show():$("#list1").hide();
            $("#list2").is(':hidden') === true ? $("#list2").show():$("#list2").hide();
           

         })
         
        $("#list").click(function(evt){
									//  evt.stopPropagation();
							        //	evt.preventDefault();
									 var $target = $(evt.target);
									  if($target.hasClass('repeal')){
										  confirm("确实是否需要修改")
									   }
							      		if($target.hasClass('delete')){
							      			confirm("确实是否需要删除")
								      		}
							        		 
							     })
	
		$("#endDate").datepicker();
		$("#validityStratDate").datepicker();
		$("#validityEndDate").datepicker();
		
		
	
</script>
</body>
</html>