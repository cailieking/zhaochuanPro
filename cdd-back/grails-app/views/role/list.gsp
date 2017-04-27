<!DOCTYPE html>
<html>
<head>
<title>角色管理 </title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/manage_common.css" />
<asset:stylesheet src="c_css/zTreeStyle.css" />
<asset:stylesheet src="c_css/role.css" />
<asset:javascript src="c_js/common.js" />
<asset:javascript src="c_js/jquery.ztree.core-3.5.js" />
<asset:javascript src="c_js/jquery.ztree.excheck-3.5.js" />
 
</head>  
<body>

<g:set var="menuService" bean="menuService" />
<input id="rootMenuIds" type="hidden" value="${menuService.menus.id}" />
<input id="rootMenuNames" type="hidden" value="${menuService.menus.name}" />
<input id="chilidMenuIds" type="hidden" value="${menuService.menus.children.id}" />
<input id="chilidMenuNames" type="hidden" value="${menuService.menus.children.name}" />
<div class="win_manage_bg">
	<!-- 左侧板块 -->
	
	<div class="win_manage_layout wm_left">
		<div class="wm_top">
			<div class="caption">角色管理</div>
			<div class="btnR btnMod1" onclick="addRoleDlgShow()">添加角色</div>
			<div class="btnR btnMod1" onclick="deleteRole()">删除角色</div>
		</div>
		<div class="wm_content">
			<table id="roleList" class="wm_table" width="338">
				<tr>
                	<th width="29"></th>
                    <th width="204">名称</th>
                    <th width="103">人数</th>
                </tr>
                <g:each in="${map}" var="data">
                <tr>
                	<td><input type="checkbox"  data-id="${data.id}" data-num="${data.num}"/></td>
                    <td><span class="rolename" data-title="${data.des}" data-id="${data.id}" onclick="roleGetRequestMap(${data.id})">${data.name}</span></td>
                    <td>${data.num}</td>
                </tr>
               </g:each>
			</table>
			<%--分页控件（先注释掉）<div class="wm_role_page"></div>
		--%></div>
	</div>
	<!-- 左侧板块  end-->
	<!-- 右侧板块 -->
	<div class="win_manage_layout wm_right">
		<div class="wm_top">
			<div id="wm_top_userName" class="caption">未选择角色</div>
			<div class="btnL btnMod1" onclick="editRoleDlgShow()">编辑角色</div>
			<div class="btnR btnMod1" onclick="roleRquestmapSave()">保存</div>
		</div>
		<div class="wm_content">
			<div class="r_caption">角色权限</div>
			<div class="r_content">
				<ul id="role_tree" class="ztree"></ul>
			</div>
		</div>
	</div>
	<!-- 右侧板块  end-->
	
</div>
<div class="roleTipsBg"></div>
<script>
$(function(){
	setCommonPage2Event($('.wm_role_page'),10,function(num){//初始化翻页控件 common.js中定义
		zcAlert(num+'页');
	})
	initTreeData();//初始化左侧树结构
	$('#roleList .rolename').hover(function(){
		roleTipsShow($(this));
	},function(){
		roleTipsHide();
	})
	$('#roleList .rolename').click(function(){
		$('#wm_top_userName').html($(this).html());
		$('#wm_top_userName').attr('data-id',$(this).attr('data-id'));
		$('#wm_top_userName').attr('data-title',$(this).attr('data-title'));
	})
});

//显示提示
function roleTipsShow(ele){
	var tipBg=$('.roleTipsBg');
	var eLeft=ele.offset().left+ele.width();
	var eTop=ele.offset().top;

	var parents=tipBg.parents();
	var defX=0;
	var defY=0;
	for(var i=0;i<parents.length;i++){
		if(parents.eq(i).css('position')=='absolute'||parents.eq(i).css('position')=='relative'){
			defX=parents.eq(i).offset().left;
			defY=parents.eq(i).offset().top;
		}
	}

	var tipX=eLeft-defX;
	var tipY=eTop-defY;
	tipBg.css({
		left:tipX,
		top:tipY
	})
	tipBg.html(ele.attr('data-title'));
	tipBg.show();
}
//隐藏提示
function roleTipsHide(){
	$('.roleTipsBg').hide();
	$('.roleTipsBg').html('');
}
//删除菜单
function deleteRole(){
	var checks=$('#roleList input[type="checkbox"]:checked');
	if(checks.length>0){
	zcConfirm('是否删除角色？',function(r){
		if(r){
			var isAllZero=true;
			for(var i=0;i<checks.length;i++){
				if(checks.eq(i).attr('data-num')!="0"){
					isAllZero=false;
					break;
				}
			}
			if(!isAllZero){
				zcAlert('有员工属于该角色，不能删除！');
				return;
			}
			var ids ="";
			var ids="";
			for(var i=0;i<checks.length;i++){
				if(i!=checks.length-1){
					ids+=checks.eq(i).attr("data-id")+",";
				}else{
					ids+=checks.eq(i).attr("data-id");
				}
			}
			window.location.href = '${request.contextPath}/role/delete/?ids=' + ids;
			
			//zcAlert('删除完毕');
		}
	});
	}else{
		zcAlert('请选择角色！');

		}
}
//删除菜单end
//添加菜单弹出框
function addRoleDlgShow(){
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addRoleDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">添加角色</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
        '<input type="hidden" id="roleIdSave" value="" />'+
        	'<li>'+
            	'<div class="wLabel">名称：<div class="imp">*</div></div>'+
                '<input placeholder="输入角色名称" type="text"  id="roleNameSave" class="box1" />'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">说明：<div class="imp"></div></div>'+
                '<textarea placeholder="输入角色说明" class="area1" id="roleDesSave"></textarea>'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div class="btnMod1" onclick="roleSave()">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	
	modDlgEvent($('.addRoleDlg'));//自制弹出框公用事件 居中_拖拽_关闭
}
//添加菜单弹出框end
//编辑菜单弹出框
function editRoleDlgShow(){
	var r_nameDiv=$('#wm_top_userName');
	if(r_nameDiv.html()=='未选择角色'){
		zcAlert('请指定角色！');
		return;
	}
	var name=r_nameDiv.html();
	var id=r_nameDiv.attr('data-id');
	var title=r_nameDiv.attr('data-title');
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod editRoleDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">编辑角色</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
        	'<input type="hidden" id="roleIdSave" value="'+id+'" />'+
        	'<li>'+
            	'<div class="wLabel">名称：<div class="imp">*</div></div>'+
                '<input type="text" id="roleNameSave" class="box1" value="'+name+'" />'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">说明：<div class="imp">*</div></div>'+
                '<textarea class="area1" id="roleDesSave">'+title+'</textarea>'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div class="btnMod1" onclick="roleSave()">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	
	modDlgEvent($('.editRoleDlg'));//自制弹出框公用事件 居中_拖拽_关闭
}
//编辑菜单弹出框end
//初始化左侧树结构
function initTreeData(){
	var setting = {
		check: {
			enable: true
		},
		view: {
			showIcon:false,
			showLine:false
		},
		data: {
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClick,
			onClick: onClick,
			onCollapse : checkListShowhide,
			onExpand: checkListShowhide,
			onCheck: zTreeOnCheck
		}
	};

	var rootIds=$('#rootMenuIds').val();
	var rootNames=$('#rootMenuNames').val();
	var childIds=$('#chilidMenuIds').val();
	var childNames=$('#chilidMenuNames').val();
	
	var rootIdsAry=rootIds.replace('\[','').replace('\]','').split(', ');
	var rootNamesAry=rootNames.replace('\[','').replace('\]','').split(', ');
	var childIdsAry1=childIds.split('], [');
	var childIdsAry2=[];
	for(var i=0;i<childIdsAry1.length;i++){
		var temp=childIdsAry1[i].replace('\[','').replace('\[','').replace('\]','').replace('\]','').split(', ');
		childIdsAry2.push(temp);
	}
	var childNamesAry1=childNames.split('], [');
	var childNamesAry2=[];
	for(var i=0;i<childNamesAry1.length;i++){
		var temp=childNamesAry1[i].replace('\[','').replace('\[','').replace('\]','').replace('\]','').split(', ');
		childNamesAry2.push(temp);
	}
	var zNodes =[];
	for(var i=0;i<rootIdsAry.length;i++){
		var node={};
		node.id=rootIdsAry[i];
		node.pId=0;
		node.open=true;
		node.name=rootNamesAry[i];
		if(childIdsAry2[i].length==1){
			if(childIdsAry2[i][0]!=''){
				zNodes.push(node);
			}
		}else{
			zNodes.push(node);
		}
		for(var j=0;j<childIdsAry2[i].length;j++){
			if(childIdsAry2[i].length==1){
				if(childIdsAry2[i][0]!=''){
					var cNode={};
					cNode.id=childIdsAry2[i][j];
					cNode.pId=rootIdsAry[i];
					cNode.name=childNamesAry2[i][j];
					cNode.isParent=true;
					zNodes.push(cNode);
				}
			}else{
				var cNode={};
				cNode.id=childIdsAry2[i][j];
				cNode.pId=rootIdsAry[i];
				cNode.name=childNamesAry2[i][j];
				cNode.isParent=true;
				zNodes.push(cNode);
			}
		}
	}
	function beforeClick(treeId, treeNode, clickFlag) {return false;}
	function onClick(event, treeId, treeNode, clickFlag) {}
	function checkListShowhide(event, treeId, treeNode) {
		if(treeNode.pId!=null){
			var childNodes=$("#role_tree>li>ul>li");
			for(var i=0;i<childNodes.length;i++){
				var check=childNodes.eq(i).find('.switch');
				if(check.hasClass('noline_open')){
					childNodes.eq(i).next('.roleListBg').show();
				}else{
					childNodes.eq(i).next('.roleListBg').hide();
				}
			}
		}
	}
	function zTreeOnCheck(event, treeId, treeNode) {
		treeNode.halfCheck=false;
		if(treeNode.checked==true){
			$('#'+treeNode.tId).next().find('input[type="checkbox"]').prop('checked',true);
		}else{
			$('#'+treeNode.tId).next().find('input[type="checkbox"]').prop('checked',false);
		}
	};
	$.fn.zTree.init($("#role_tree"), setting, zNodes);
	loadChecksData();
	function loadChecksData(){
     $.post("/role/aa",function(data){
			var allRequestmap = data

			console.log('allRequestmap',allRequestmap)
    		var tresNodes=$("#role_tree>li>ul>li");
		
    		for(var i=0;i<tresNodes.length;i++){
    			var treeObj = $.fn.zTree.getZTreeObj("role_tree");
    			var thisNode=treeObj.getNodeByTId(tresNodes.eq(i).attr('id'));
    			var id=thisNode.id;
    			var doHtml=
    				'<div class="roleListBg">'+
    					'<ul class="roleList">'
    				if(allRequestmap){
							for(var j in allRequestmap){
								if(allRequestmap[j].menu!=null){
									if(allRequestmap[j].menu.id == id){
											doHtml += '<li>'+
			    							'<input type="checkbox" data-id='+allRequestmap[j].id+' data-url='+allRequestmap[j].url+'/>'+
			    							'<div class="ckLabel">'+allRequestmap[j].description+'</div>'+
			    						'</li>'	
									}
								}
								
						}
        			}
    					
    				doHtml +='</ul></div><div style="clear:both"></div>'
    				tresNodes.eq(i).after($(doHtml));
    	}
   		$('.roleList input[type="checkbox"]').change(function(){
       		var tId=$(this).parents('.roleListBg').prev().attr('id');
       		var thisNode=treeObj.getNodeByTId(tId);
       		var checks=$(this).parents('.roleList').find('input[type="checkbox"]').length;
       		var checkeds=$(this).parents('.roleList').find('input[type="checkbox"]:checked').length;
       		if(checkeds==0){//无选中
       			thisNode.halfCheck=false;
       			treeObj.checkNode(thisNode, false, true);
       		}else if(checkeds<checks){//部分选中
       			thisNode.halfCheck=true;
       			treeObj.checkNode(thisNode, true, true);
       		}else if(checkeds==checks){//全选
       			thisNode.halfCheck=false;
       			treeObj.checkNode(thisNode, true, true);
       		}
       	})
    		
	 });
    	var treeObj = $.fn.zTree.getZTreeObj("role_tree");
    	treeObj.expandAll(false);
    	
}
}


function roleGetRequestMap(id){
	 $.post("/role/data/"+id,function(data){
				var usedMap = data
				console.log('usedMap',usedMap);
				if(usedMap){
					$('.roleList input[type="checkbox"]').prop('checked',false)
					for(var i in usedMap){

						$('#role_tree .roleList input[data-id="'+usedMap[i].id+'"]').prop('checked',true);
						}
					}
				setRoleTreeChecks();//设置权限树各节点选中状态
				
		 });
	
}
//设置权限树各节点选中状态
function setRoleTreeChecks(){
	var lists=$('.roleList');
	var treeObj = $.fn.zTree.getZTreeObj("role_tree");
	for(var i=0;i<lists.length;i++){
		var tId=lists.eq(i).parents('.roleListBg').prev().attr('id');
		var thisNode=treeObj.getNodeByTId(tId);
		var checks=lists.eq(i).find('input[type="checkbox"]').length;
		var checkeds=lists.eq(i).find('input[type="checkbox"]:checked').length;
		if(checkeds==0){//无选中
			thisNode.halfCheck=false;
			treeObj.checkNode(thisNode, false, true);
		}else if(checkeds<checks){//部分选中
			thisNode.halfCheck=true;
			treeObj.checkNode(thisNode, true, true);
		}else if(checkeds==checks){//全选
			thisNode.halfCheck=false;
			treeObj.checkNode(thisNode, true, true);
		}
	}
}


function roleSave(){
	var id = $("#roleIdSave").val();
	var name = $("#roleNameSave").val();
	var description = $("#roleDesSave").val();

	window.location.href = '${request.contextPath}/role/roleSave/?id=' + id+'&name='+name+'&description='+description;
}

function roleRquestmapSave(){
	var r_nameDiv=$('#wm_top_userName');
	var roleName = r_nameDiv.html();
	if(r_nameDiv.html()=='未选择角色'){
		zcAlert('未指定角色！');
		return;
	}else{
		var ids=[];
		var checks=$('#role_tree .roleList input:checked');
		for(var i=0;i<checks.length;i++){
			ids.push(checks.eq(i).attr('data-id'));
		}
		window.location.href = '${request.contextPath}/role/roleRquestmapSave/?mapIds=' + ids+'&roleName='+roleName;
	}
}
//初始化左侧树结构 end
</script>
</body>
</html>