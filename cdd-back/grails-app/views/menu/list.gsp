<%@page import="com.cdd.base.constant.SpringSecurityConstant"%>
<%@page import="com.cdd.base.domain.Requestmap"%>
<!DOCTYPE html>
<html>
<head>
<title>菜单管理</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/manage_common.css" />
<asset:stylesheet src="c_css/zTreeStyle.css" />
<asset:stylesheet src="c_css/menu.css" />
<asset:javascript src="c_js/common.js" />
<asset:javascript src="c_js/jquery.ztree.core-3.5.js" />
</head>   
<body>
<g:set var="menuService" bean="menuService" />
<input id="rootMenuIds" type="hidden" value="${menuService.menus.id}" />
<input id="rootMenuNames" type="hidden" value="${menuService.menus.name}" />
<input id="chilidMenuIds" type="hidden" value="${menuService.menus.children.id}" />
<input id="chilidMenuNames" type="hidden" value="${menuService.menus.children.name}" />
<input id="contextPath" type="hidden" value="${request.contextPath}" />
	<%--<g:each in="${menuService.menus}" var="rootMenu" status="m">
		<g:if test="${rootMenu.children}">
				<div><span>+${rootMenu.name}</span></div>
            	     
		    		<g:each in="${rootMenu.children}" var="childrenMenu" status="c">
		    			<div><span>${childrenMenu.name}</span><span>${childrenMenu.id}</span></div>
		    		</g:each>
		</g:if>
	</g:each>
	
--%>
<div class="win_manage_bg">
	<!-- 左侧板块 -->
	<div class="win_manage_layout wm_left">
		<div class="wm_top">
			<div class="caption">菜单管理</div>
			<div class="btnR btnMod1" onclick="addMenuDlgShow()">添加菜单</div>
			<div class="btnR btnMod1" onclick="deleteMenu()">删除菜单</div>
		</div>
		<div class="wm_content">
			<ul id="menu_tree" class="ztree">
			</ul>
		</div>
	</div>
	<!-- 左侧板块  end-->
	<!-- 右侧板块 -->
	
	<div class="win_manage_layout wm_right">
		<div class="wm_top">
			<div class="caption" id="wm_top_menuName">未选择菜单</div>
			<div class="btnL btnMod1" onclick="editThisMenuDlgShow()">编辑菜单</div>
		</div>
		<g:if test="${map}">
		<div class="wm_content">
			<div class="r_caption">菜单配置</div>
			<div class="r_content">
				<div class="r_controlLine">
					<div class="r_name">本菜单</div>
					<g:if test="${map?.childrenMenu}">
					<div class="btnR btnMod1" onclick="addMenuDlgShow()">添加菜单</div>
					</g:if>
				</div>
				<table class="wm_table" width="706">
					<tr>
	                	<th width="29"></th>
	                    <th width="119">名称</th>
	                    <th width="119">父节点</th>
	                    <th width="219">链接</th>
	                    <th width="39">图标</th>
	                    <th width="39">顺序</th>
	                    <th width="59">状态</th>
	                    <th width="78">操作</th>
	                </tr>
	               
	                <tr>
	                	<td><input type="hidden" id="clickedId" value="${map?.clickedMenu?.id}"></input></td>
	                	
	                    <td><span class="blue" id="clickedName" >${map?.clickedMenu?.name}</span></td>
	                    <td id="clickedPname" data-clickedPid="${map?.clickedMenu?.parent?.id}">${map?.clickedMenu?.parent?.name}</td>
	                    <td id="clickedUrl" data-clickedMapId="${map?.clickedMenu?.map?.id}">${map?.clickedMenu?.map?.url}</td>
	                    <td id="clickedIcon" data-clickenIcon="${map?.clickedMenu?.icon}" ><i class="fa fa-${map?.clickedMenu?.icon}"></i></td>
	                    <td id="clickedOrders">${map?.clickedMenu?.orders}</td>
	                    
	                    <g:if test="${map?.clickedMenu.isHide}">
	                    <td>隐藏</td>
	                    <td>
	                    <a onclick="toShow(1,${map?.clickedMenu?.id})">显示</a>
	                    <a onclick="editThisMenuDlgShow()">编辑</a></td>
	                    </g:if>
	                    <g:else>
	                    <td>显示</td>
	                    <td>
	                    <a onclick="toShow(0,${map?.clickedMenu?.id})">隐藏</a>
	                    <a onclick="editThisMenuDlgShow()">编辑</a></td>
	                    </g:else>
	                    
	                   
	                </tr>
				</table>
				<g:if test="${map?.childrenMenu}">
				
				<div class="r_controlLine">
					<div class="r_name">下级菜单</div>
					<div class="btnR btnMod1" onclick="deleteChildrenMenu()">删除菜单</div>
				</div>
				<table id="childrenTable" class="wm_table" width="706">
					<tr>
	                	<th width="29"></th>
	                    <th width="119">名称</th>
	                    <th width="119">父节点</th>
	                    <th width="219">链接</th>
	                    <th width="39">图标</th>
	                    <th width="39">顺序</th>
	                    <th width="59">状态</th>
	                    <th width="78">操作</th>
	                </tr>
	                <g:each in="${map?.childrenMenu}" var="children">
	                <tr>
	                	<td><input type="checkbox"  data-children="${children.id}"/></td>
	                    <td><span class="blue">${children.name}</span></td>
	                    <td>${children.parent.name}</td>
	                    <td>${children.map?.url}</td>
	                    <td><i class="fa fa-${children.icon}"></i></td>
	                    <td>${children.orders}</td>
	                    
	                    
	                    <g:if test="${children?.isHide}">
	                    <td>隐藏</td>
	                     <td data-id="${children.id}" data-name="${children.name}" data-pname="${children.parent.id}" data-url="${children.map?.id}" data-icon="${children.icon}" data-orders="${children.orders}">
	                     <a onclick="toShow(1,${children.id})">显示</a><a onclick="tableEditMenuDlgShow($(this))">编辑</a></td>
	                    </g:if>
	                    <g:else>
	                    <td>显示</td>
	                     <td data-id="${children.id}" data-name="${children.name}" data-pname="${children.parent.id}" data-url="${children.map?.id}" data-icon="${children.icon}" data-orders="${children.orders}">
	                     <a onclick="toShow(0,${children.id})">隐藏</a><a onclick="tableEditMenuDlgShow($(this))">编辑</a></td>
	                    </g:else>
	                   
	                </tr>
	                </g:each>
				</table>
				
				</g:if>
			</div>
		</div>
		</g:if>
	</div>
	<!-- 右侧板块  end-->
	
</div>

<script>
$(function(){
	
	initTreeData();//初始化左侧树结构
});

//初始化左侧选中
function initLeftSel(){
	var temAry=window.location.href.split('/');
	var nodeId=temAry[temAry.length-1];
	if(nodeId!=''&&nodeId!=null&&nodeId!='list'){
		var treeObj = $.fn.zTree.getZTreeObj("menu_tree");
		var nodes=treeObj.getNodes();
		var pNode=null;
		var selNode;
		for(var i=0;i<nodes.length;i++){
			if(nodes[i].id==nodeId){
				selNode=nodes[i];
				break;
			}
			for(var j=0;j<nodes[i].children.length;j++){
				if(nodes[i].children[j].id==nodeId){
					pNode=nodes[i];
					selNode=nodes[i].children[j];
				}
			}
		}
		treeObj.selectNode(selNode);
		$('#wm_top_menuName').html(selNode.name);
		if(pNode!=null){
			treeObj.expandNode(pNode, true, true, true);
		}
	}
}
//删除菜单
function deleteMenu(){
	var treeObj = $.fn.zTree.getZTreeObj("menu_tree");
	var selNode=treeObj.getSelectedNodes();
	if(selNode.length>0){
		if(!selNode[0].isParent){
			zcConfirm('是否删除菜单？',function(r){
				if(r){
					window.location.href = '${request.contextPath}/menu/delete/?ids=' + selNode[0].id;
				}
			});
		}else{
			zcAlert('不能删除一级菜单');
		}
	}else{
		zcAlert('请选择菜单');
	}
}

function toShow(status,id){

	window.location.href = '${request.contextPath}/menu/show/?id=' + id+'&status='+status;
}



function deleteChildrenMenu(){
	var checks=$('#childrenTable input[type="checkbox"]:checked');
	if(checks.length>0){
		zcConfirm('是否删除菜单？',function(r){
		if(r){
			var ids="";
			for(var i=0;i<checks.length;i++){
				if(i!=checks.length-1){
					ids+=checks.eq(i).attr("data-children")+",";
				}else{
					ids+=checks.eq(i).attr("data-children");
				}
			}
			window.location.href = '${request.contextPath}/menu/delete/?ids=' + ids;
		}
		});
	}else{
		zcAlert('请选择菜单');
		}
}
//删除菜单end
//添加菜单弹出框
function addMenuDlgShow(){
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addMenuDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">添加菜单</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
        	'<li>'+
            	'<div class="wLabel">名称：<div class="imp">*</div></div>'+
                '<input type="text" class="box1" id="menuName"/>'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">父节点：<div class="imp">*</div></div>'+
                '<select class="select1" id="parent">'+
                '<option value="">--请选择--</option>'+
				'<g:each in="${menuService.menus}" var="parent">'+	
						'<option value="${parent.id}" >${parent.name}</option>'+
					
				'</g:each>'+
                '</select>'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">链接：<div class="imp">*</div></div>'+
            	'<select class="select1" id="menuHref">'+
				'<option value="">--请选择--</option>'+
				'<g:each in="${menuService.menus?.children}" var="children">	'+
				'<g:each in="${children.map}" var="map">	'+
						'<option value="${map.id}" >${map.description}&nbsp;&nbsp;(${map.uri})</option>'+
				'</g:each>'+
				'</g:each>'+
			'</select>'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">图标名称：<div class="imp"></div></div>'+
                '<input type="text" class="box1" id="menuIcon"/>'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">显示顺序：<div class="imp"></div></div>'+
                '<input type="text" class="box1" id="menuOrders"/>'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                	'<div id="addMenuDlgReset" class="btnMod1">重置</div>'+
                    '<div id="saveMenu1" class="btnMod1">保存</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	
	modDlgEvent($('.addMenuDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	//重置按钮
	$('#addMenuDlgReset').click(function(){
		winReset();
	})
	//重置
	function winReset(){
		$('.addMenuDlg').parent().remove();
		addMenuDlgShow();
	}
	//保存按钮
	$('#saveMenu1').click(function(){
		saveMenu();
	})
	//保存菜单   
	function saveMenu(){
		var name=$('#menuName').val();
		var parentId=$('#parent').val();
		var mapId=$('#menuHref').val();
		var icon=$('#menuIcon').val();
		var orders=$('#menuOrders').val();
		var path=$('#contextPath').val()+'/menu/save';
		$.ajax({
			url:path,
            type: "post",
            cache : true,
	        dataType : "json",
            data:{name:name,parentId:parentId,mapId:mapId,icon:icon,orders:orders},
            error: function(e,request,setting) {
                alert("Connection error");
            },
            success: function(rs) {
                if(rs.status==1){
                	window.location.href = '${request.contextPath}/menu/menuData/1'
                    }
            }
        });
		
		
	}

	
}
//添加菜单弹出框end
//顶部表格内弹出编辑框
function editThisMenuDlgShow(){
	var data={};
     
	data.id=$('#clickedId').val();
	data.name=$('#clickedName').html();
	data.pname=$('#clickedPname').attr('data-clickedPid');
	data.url=$('#clickedUrl').attr('data-clickedMapId');
	data.icon=$('#clickedIcon').attr('data-clickenIcon');
	data.orders=$('#clickedOrders').html();
	editMenuDlgShow(data);
}
//表格内弹出编辑框
function tableEditMenuDlgShow(ele){
	var data={};
	var td=ele.parent();
     
	data.id=td.attr('data-id');
	data.name=td.attr('data-name');
	data.pname=td.attr('data-pname');
	data.url=td.attr('data-url');
	data.icon=td.attr('data-icon');
	data.orders=td.attr('data-orders');
	editMenuDlgShow(data);
}
//编辑菜单弹出框
function editMenuDlgShow(data){
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod editMenuDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">编辑菜单</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
        	'<input type="hidden" id="dataId" class="box1" value="'+data.id+'" />'+
        	'<li>'+
            	'<div class="wLabel">名称：<div class="imp">*</div></div>'+
                '<input type="text" id="dataName" class="box1" value="'+data.name+'" />'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">父节点：<div class="imp">*</div></div>'+
                '<select class="select1" id="parentSelect">'+
                '<option value="">--请选择--</option>'+
				'<g:each in="${menuService.menus}" var="parent">'+	
				'<option value="${parent.id}" >${parent.name}</option>'+
				'</g:each>'+
                	
                '</select>'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">链接：<div class="imp">*</div></div>'+
            	'<select class="select1" id="hrefSelect">'+
				'<option value="">--请选择--</option>'+
				'<g:each in="${menuService.menus?.children}" var="children">	'+
				'<g:each in="${children.map}" var="map">	'+
						'<option value="${map.id}" >${map.description}&nbsp;&nbsp;(${map.uri})</option>'+
				'</g:each>'+
				'</g:each>'+
			'</select>'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">图标名称：<div class="imp"></div></div>'+
                '<input type="text" id="dataIcon" class="box1" value="'+data.icon+'" />'+
            '</li>'+
            '<li>'+
            	'<div class="wLabel">显示顺序：<div class="imp"></div></div>'+
                '<input type="text" id="dataOrders" class="box1" value="'+data.orders+'" />'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                	'<div id="editMenuDlgReset" class="btnMod1">重置</div>'+
                    '<div id="editMenuSave" class="btnMod1">保存</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	$('#parentSelect').val(data.pname);
	$('#hrefSelect').val(data.url);
	modDlgEvent($('.editMenuDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	//重置按钮
	$('#editMenuDlgReset').click(function(){
		winReset();
	})
	
	
	//保存编辑菜单按钮
	$('#editMenuSave').click(function(){
		saveEditMenu();
	})
	//重置
	function winReset(){
		$('.editMenuDlg').parent().remove();
		editMenuDlgShow();
	}


	//保存编辑菜单
	function saveEditMenu(){
		var id=$('#dataId').val();
		var name=$('#dataName').val();
		var pname=$('#parentSelect').val();
		var url=$('#hrefSelect').val();
		var icon=$('#dataIcon').val();
		var orders=$('#dataOrders').val();
		
		$.ajax({
			url:"/menu/save",
            type: "post",
            cache : true,
	        dataType : "json",
            data:{id:id,name:name,parentId:pname,mapId:url,icon:icon,orders:orders},
            error: function(e,request,setting) {
                alert("Connection error");
            },
            success: function(rs) {
                if(rs.status==1){
                	window.location.href = '${request.contextPath}/menu/menuData/'+id;
                    }
            }
        });
		
		
	}
}
//编辑菜单弹出框end
//初始化左侧树结构
function initTreeData(){
	var setting = {
		view: {
			showIcon:showIconForTree,
			showLine:false
		},
		data: {
			key: {
				title:"title"
			},
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: beforeClick,
			onClick: onClick
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
					zNodes.push(cNode);
				}
			}else{
				var cNode={};
				cNode.id=childIdsAry2[i][j];
				cNode.pId=rootIdsAry[i];
				cNode.name=childNamesAry2[i][j];
				zNodes.push(cNode);
			}
		}
	}

	function beforeClick(treeId, treeNode, clickFlag) {
		
	}
	function onClick(event, treeId, treeNode, clickFlag) {
		console.log('treeNode',treeNode)
		window.location.href = '${request.contextPath}/menu/menuData/' + treeNode.id
	}
	function showIconForTree(treeId, treeNode) {
		return false;
	};
	
	$.fn.zTree.init($("#menu_tree"), setting, zNodes);
	//var divHtml='<div style="min-height:40px;background:#f00;clear:both;"></div>';
	//$("#wm_left_tree_root>li>ul>li").after($(divHtml));
	//var treeObj = $.fn.zTree.getZTreeObj("menu_tree");
	//treeObj.expandAll(false);
	initLeftSel();//初始化左侧选中
}
//初始化左侧树结构 end
</script>
</body>
</html>
