<!DOCTYPE html>
<html>
<head>
<title>客户管理</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/inquiry_common.css" />
<asset:stylesheet src="c_css/inquiry_guestManage.css" />

<asset:javascript src="c_js/common.js" />
<asset:javascript src="c_js/inquiry_guestManage.js" />
 <asset:javascript src="c_js/ajaxfileupload.js"/>

</head>
<body>
   <div class="manage_md_right">
       <!-- 客户管理-->
       <div class="inpuiry_manage_guest">
       	<div class="rControlLine">
       		<div class="txt1">标签列表：</div>
       		<div id="guestLabel_top" class="guestLabel" >
                 <span>选择标签颜色</span>
                 <ul class="guestLabelList">
                     <li></li><li></li><li></li>
                     <li></li><li></li><li></li>
                     <li></li><li></li><li></li>
                 </ul>
             </div>
             <div class="txt1" style="margin-left:12px;" >需求：</div>
             <select class="select1" id="demand_select" onchange="searchChange()" >
             </select>
             <div class="txt1" style="margin-left:12px;"  >类型：</div>
             <select class="select1" id="type_select" onchange="searchChange()">
             </select>
             <div class="txt1" style="margin-left:12px;"  >群组：</div>
             <select class="select1" id="group_select" onchange="searchChange()">
             </select>
       	</div>
       	<div class="rControlLine">
       		 <input class="box1" type="text" placeholder="公司名称/联系人/手机号/邮箱" style="width:250px;" id="search_key" />
             <div class="btnL btnMod1" onClick="searchChange()">查询</div>
             <div class="btnR btnMod1" onClick="addGuestDlgShow()">添加</div>
             <form action="" id="exportData" method="post">
             <div class="btnR btnMod1" onClick="exportClients()" >导出</div>
             </form>
             <div class="btnR btnMod1" onClick="importGuestShow()">导入</div>
       	</div>
       	<table class="im_table" style="width:1000px;">
       	</table>
       	<div class="rControlLine" style="position:relative;padding-top:10px;">
       		<div class="txt1"><span>总数：</span><span class="orange">（135）</span></div>
       		<div class="txt1">
       			<span>每页显示：</span>
       			<span class="blue hand" name="search_count">20</span> 
       			<span class="blue hand" name="search_count">50</span> 
       			<span class="blue hand" name="search_count">100</span>
       		</div>
       		<div class="im_pageBg"></div>
       	</div>
       	
       </div>
       <!-- 客户管理 end -->
   </div>


<script>
$(function(){
	
})
</script>
</body>
</html>
