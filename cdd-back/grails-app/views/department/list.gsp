<!DOCTYPE html>
<html>
<head>
<title>组织机构</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/manage_common.css" />
<asset:stylesheet src="c_css/zTreeStyle.css" />
<asset:stylesheet src="c_css/group.css" />
<asset:javascript src="c_js/common.js" />
<asset:javascript src="c_js/jquery.ztree.core.js" />
 <asset:javascript src="jquery.validate.min.js"/>
</head>   
<body> 
<div class="win_manage_bg">
	<!-- 左侧板块 -->
	<div class="win_manage_layout wm_left">
		<div class="wm_top">
			<div class="caption">组织机构</div>
			<div class="btnR btnMod1" onclick="addGroupDlgShow()">添加部门</div>
			<div class="btnR btnMod1" onclick="deleteGroup()">删除部门</div>
		</div>
		<div class="wm_content">
			<%--<ul class="groupRoot ztree">
				<li>
					<span class="button level0 switch noline_open"></span>
					<span>深圳市找船网络科技有限公司（42人）</span>
				</li>
			</ul>
			--%><ul id="group_tree" class="ztree">
			</ul>
		</div>
	</div>
	<!-- 左侧板块  end-->
	<!-- 右侧板块 -->
	<div class="win_manage_layout wm_right">
		<div class="wm_top">
			<div class="caption" id="topDpName">部门名</div>
			<div class="btnL btnMod1" onclick="editGroupDlgShow()" id="editNode">编辑部门</div>
			<div class="btnL btnMod1" onclick="addMemberDlgShow('add')">添加员工</div>
			<div class="btnR btnMod1"  id="search" >搜索</div>
			<input type="text" class="wm_top_searchbox" placeholder="输入员工姓名/帐号/手机号码" />
		</div>
		<div class="wm_content">
			<div class="r_caption" id="sortDpName">
				<!--<span class="blue" id="sortDpName"> </span>
			
				<span class="blue">深圳市找船网络科技有限公司</span>
				<span class="r_ar">></span>
				<span class="blue">交易中心</span>
				<span class="r_ar">></span>
				<span>交易一部</span>-->
			</div>
			<div class="r_content">
				<div class="r_controlLine">
					<div class="r_name">部门主管</div>
				</div>
				<div class="groupBoss" id="dpMgr">古远军</div>
				<div class="r_controlLine">
					<div class="r_name">下级部门</div>
				</div>
				<ul class="groupList" id="child_dp">
					<li>
						<span class="name">交易一部</span>
						<span class="num">16人</span>
					</li>
					<li>
						<span class="name">交易二部</span>
						<span class="num">9人</span>
					</li>
					<li>
						<span class="name">商务部</span>
						<span class="num">8人</span>
					</li>
				</ul>
				<div class="r_controlLine">
					<div class="r_name">部门员工</div>
					<div class="btnR btnMod1" onclick="addMemberDlgShow('add_dp')">添加员工</div>
				</div>
				<table class="wm_table" width="706" id="eps_tb">
					<tr>
	                	<th width="29"></th>
	                    <th width="69">姓名</th>
	                    <th width="119">账号</th>
	                    <th width="89">职位</th>
	                    <th width="99">手机号</th>
	                    <th width="109">角色</th>
	                    <th width="49">状态</th>
	                    <th width="118">操作</th>
	                </tr>
	                <tr>
	                	<td><input type="checkbox" /></td>
	                    <td><span class="blue">古远军</span></td>
	                    <td>guyuanjun</td>
	                    <td>VP</td>
	                    <td>13817878999</td>
	                    <td><span class="blue">VP</span></td>
	                    <td><span class="blue">启用</span></td>
	                    <td><a onclick="addMemberDlgShow('edit')">编辑</a><a>禁用</a><a class="red">删除</a></td>
	                </tr>
				</table>
				<div class="wm_profession_page" style="padding-top:330px;padding-left: 550px"></div>
			</div>
			
		</div>
	</div>
	<!-- 右侧板块  end-->
	
</div>

<script>
var nLevel = 0
var pageCount = 10
var users = []
var showId = "group_tree"	
var delDpTid
$(function(){
	var tag = "show"
	
	//initTreeData(tag,showId);//初始化左侧树结构
	initTreeData(showId)
	/*setCommonPage2Event($('.wm_profession_page'),pageTotal,function(num){
					paging(num)
	})*/
});

var nodes = {
		zNodes: [],
		roles:  [],
		jNodes: [],
		users:[]
	}


var dpObj = {
		name:"",
		pId:"",
		isParent:true,
		manager:"",
		description:""
	}

//删除部门
function deleteGroup(){
	var ztObj = $.fn.zTree.getZTreeObj("group_tree");
	var node = ztObj.getNodeByTId(delDpTid)
	

	zcConfirm('是否删除部门？',function(r){
		if(r){
			if(node.children != null){
				zcAlert('该部门下有其它部门，无法删除');
			}else if(node.users.length > 0){
				zcAlert('该部门下已有员工， 无法删除');
			}else{					
				$.post("/department/deleteDepartment?dpName="+node.name.substring(0,node.name.indexOf("(")),function(data){
						if(data == "true"){
							zcAlert('删除成功');
							initTreeData("group_tree")
						}else{
							zcAlert('删除失败');
						}

				})
			}
		}
	});
}

$("#search").on('click',function(){
		var s_val = $(this).next().val()
	var searchUsers = []
	if(s_val != null && s_val != ""){
		for(var i in nodes.users){
			
			if(nodes.users[i].firstname.indexOf(s_val) >= 0){
				 searchUsers.push(nodes.users[i])
				
			}if(nodes.users[i].username.indexOf(s_val) >= 0 ){
				 searchUsers.push(nodes.users[i])
			
			}if(nodes.users[i].mobile.indexOf(s_val) >= 0){
				searchUsers.push(nodes.users[i])
			}
		}
	}else{
		searchUsers = nodes.users
	}	
	
	$(".r_controlLine").hide()
	$("#dpMgr").hide()
	$("#child_dp").empty()
	$("#eps_tb").empty()
	
		var eps_tb_data = '<tr>'+
	                   '<th width="29"></th>'+
	                   '<th width="69">姓名</th>'+
	                   '<th width="119">账号</th>'+
	                   '<th width="89">职位</th>'+
	                   '<th width="99">手机号</th>'+
	                   '<th width="109">角色</th>'+
	                   '<th width="49">状态</th>'+
	                   '<th width="118">操作</th>'+
	                '</tr>'
	               
			if(searchUsers.length > 0){
					for(var i=0, l=pageCount; i<pageCount; i++){
					if(searchUsers[i] != undefined){
					   eps_tb_data +=  '<tr>'+
	                  	 '<td><input type="checkbox" /></td>'+
	                   	 '<td><span class="blue">'+searchUsers[i].firstname+'</span></td>'+
	                  	 '<td>'+searchUsers[i].username+'</td>'+
	                     '<td>'+searchUsers[i].jobTitle+'</td>'+
	                     '<td>'+searchUsers[i].mobile+'</td>'+
	                     '<td><span class="blue">'+searchUsers[i].roleName+'</span></td>'+
	                     '<td><span class="blue">'+(searchUsers[i].enabled?'启用':'禁用')+'</span></td>'+
	                 	 '<td><a onclick="addMemberDlgShow('+"'"+searchUsers[i].username+"'"+')">编辑</a>'+
	                 	 '<a onclick="enable('+"'"+searchUsers[i].id+"'"+','+"'"+searchUsers[i].enabled+"'"+')">'+(searchUsers[i].enabled?'禁用':'启用')+'</a>'+
	                 	 '<a  onclick="delUser('+"'"+searchUsers[i].id+"'"+')" class="red">删除</a></td>'+
	                 '</tr>'
				 }
				}
		
			}else{
				console.log(eps_tb_data)
				//eps_tb_data += '<td><span class="blue">无数据</span></td>'
			}
			
			$("#eps_tb").append(eps_tb_data)
			var pageTotal = searchUsers.length % pageCount> 0 ? Math.floor(searchUsers.length / pageCount) + 1 :  searchUsers.length / pageCount
			setCommonPage2Event($('.wm_profession_page'),pageTotal,function(num){
					paging(num)
	})
	
})



//删除部门end
//添加部门弹出框
function addGroupDlgShow(){
	event_name = ""
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addGroupDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">添加部门</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
        	'<li>'+
            	'<div class="wLabel">部门名称：<div class="imp">*</div></div>'+
                '<input type="text" class="box1" id="departmentName"/>'+
            '</li>'+
            '<li>'+
	        	'<div class="wLabel">上级部门：<div class="imp">*</div></div>'+
	        	'<input id="dpData"  type="text" class="box1"  readonly value=""/><a name="selectDp" href="#">选择</a>'+
	        	'<div id="menuContent" class="menuContent" name="menuContent" style="display:none; position: absolute;">'+
	        		'<ul id="dp_tree" class="ztree" style="margin-top:0; width:200px;"></ul>'+
	        	'</div>'+
	        	
	        	/* '<ul id="dp_tree" class="ztree">'+
				
					'</ul>'+
	        		'<select class="select1">'+
	            	'<option>选择上级部门</option>'+
	                '<option>深圳总部</option>'+
	                '<option>深圳总部-交易中心</option>'+
	                '<option>深圳总部-交易中心-商务部 </option>'+
	                '<option>深圳总部-交易中心-交易部</option>'+
	                '<option>深圳总部-财政人事部</option>'+
	                '<option>深圳总部-财务部</option>'+
	                '<option>深圳总部-产品研发中心-产品部</option>'+
	                '<option>深圳总部-产品研发中心-研发部</option>'+
	                '<option>深圳总部-产品研发中心-运营部</option>'+
	                '<option>深圳总部-产品研发中心-运维部</option>'+
	            '</select>'+*/
	        '</li>'+
            '<li>'+
            	'<div class="wLabel">部门主管：<div class="imp"></div></div>'+
            	'<select class="select1" id="dpManager">'+
            	'</select>'+
            '</li>'+
            '<li>'+
	        	'<div class="wLabel">部门描述：<div class="imp"></div></div>'+
	            '<textarea class="area1" id="dpDescription"></textarea>'+
	        '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div class="btnMod1" id="save_dp">保存</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	var tag = "add"
	if(clk_node.getParentNode() != null){
		var	p_name = clk_node.getParentNode().name
		dpObj.pId = clk_node.getParentNode().id
		$("#dpData").val(p_name.substring(0,p_name.indexOf("(")))
	}

	$(".select1").empty()

	
	var sel_html = '<option value="">请选择</option>'
	for(var i in nodes.users){
		sel_html += '<option value="'+nodes.users[i].firstname+'">'+nodes.users[i].firstname+'</option>'
	}
	$(".select1").append(sel_html)
	
	
	$("a[name=selectDp]").on("click",function(){
		var dpId = "dp_tree"
		var dv_id = "dpData"
		//initTreeData(tag,showId)
		for(var i in tNodes){
			if(tNodes[i].name.indexOf("(") > 0){
				tNodes[i].name = tNodes[i].name.substring(0,tNodes[i].name.indexOf("("))
			}
		}
		initZtree(dpId,tNodes,dv_id)
	})
	modDlgEvent($('.addGroupDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	
	//$("a[name=selectDp]").unbind('mouseenter').unbind('mouseleave'); 
	//$("a[name=selectDp]").off('mouseenter').unbind('mouseleave');
	
	
	$("#save_dp").on('click',function(){
		dpObj.name = $("#departmentName").val()
		dpObj.description = $("#dpDescription").text()
		dpObj.manager = $("#dpManager").val()
		
		$.ajax({
				type:'post',
				url:'/department/saveDepartment',
				dataType:'json',
				data:dpObj,
				success:function(rs){
				        if(rs == true){
				       		 $(".addGroupDlg").parent().remove()
				        	zcAlert("保存成功");
				        	var tag = "show"
							var showId = "group_tree"
							$("#save_dp").parents(".winModBg0").remove()
							initTreeData(showId)
				        }else{
				        		console.log("222")
				        		$(".addGroupDlg").parent().remove()
				        		zcAlert("保存失败");
				        }
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
				}
	
			})
	})
}

function initDpManager(node,managers){
	if(node.users.length > 0){
		for(var i in node.users){
			managers.push(node.users[i].firstname)
		}
	}	
	if(node.children != null){
		var childs = node.children
		console.log(childs)
		for(var j in childs){
				initDpManager(childs[j],managers)
			}
		}
    
	return managers
}
var dpData;
//添加部门弹出框end
//编辑部门弹出框
function editGroupDlgShow(){
	event_name = ""
	var dpName = $("#topDpName").text()
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod editGroupDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">编辑部门</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
	    	'<li>'+
	        	'<div class="wLabel">部门名称：<div class="imp">*</div></div>'+
	            '<input type="text" class="box1" id="departmentName" value="'+dpName+'"/>'+
	        '</li>'+
	        '<li>'+
	        	'<div class="wLabel">上级部门：<div class="imp">*</div></div>'+
	        	'<input id="dpData"  type="text" class="box1"  readonly value=""/><a name="selectDp" href="#">选择</a>'+
	        	'<div id="menuContent" class="menuContent" name="menuContent" style="display:none; position: absolute;">'+
	        		'<ul id="dp_tree" class="ztree" style="margin-top:0; width:200px;"></ul>'+
	        	'</div>'+
	        	/* '<select class="select1">'+
	            	'<option>选择上级部门</option>'+
	                '<option>深圳总部</option>'+
	                '<option>深圳总部-交易中心</option>'+
	                '<option>深圳总部-交易中心-商务部 </option>'+
	                '<option>深圳总部-交易中心-交易部</option>'+
	                '<option>深圳总部-财政人事部</option>'+
	                '<option>深圳总部-财务部</option>'+
	                '<option>深圳总部-产品研发中心-产品部</option>'+
	                '<option>深圳总部-产品研发中心-研发部</option>'+
	                '<option>深圳总部-产品研发中心-运营部</option>'+
	                '<option>深圳总部-产品研发中心-运维部</option>'+
	            '</select>'+  */
	        '</li>'+
	        '<li>'+
	        	'<div class="wLabel">部门主管：<div class="imp"></div></div>'+
	         	'<select class="select1" id="dpManager">'+
            	'</select>'+
	        '</li>'+
	        '<li>'+
	        	'<div class="wLabel" >部门描述：<div class="imp"></div></div>'+
	            '<textarea class="area1" id="dpDescription"></textarea>'+
	        '</li>'+
	        '<li>'+
	        	'<div class="bottomBtns">'+
	                '<div class="btnMod1" id="save_dp">保存</div>'+
	            '</div>'+
	        '</li>'+
	    '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	
	if(clk_node.getParentNode() != null){
		var	p_name = clk_node.getParentNode().name
		$("#dpData").val(p_name.substring(0,p_name.indexOf("(")))
	}
	var d_users = []
	var p_manager = clk_node.manager
	d_users = initDpManager(clk_node,d_users)
	$(".select1").empty()
	var sel_html = ""
	for(var i in d_users){
		if(d_users[i] == p_manager){
			sel_html += '<option value='+d_users[i]+' selected>'+d_users[i]+'</option>'
		}
		sel_html += '<option value='+d_users[i]+'>'+d_users[i]+'</option>'
	}
	$(".select1").append(sel_html)
	
	var tag = "edit"
	$("a[name=selectDp]").on("click",function(){
		var dpId = "dp_tree"
		var dv_id = "dpData"
		//initTreeData(tag,showId)
		for(var i in tNodes){
			if(tNodes[i].name.indexOf("(") > 0){
				tNodes[i].name = tNodes[i].name.substring(0,tNodes[i].name.indexOf("("))
			}
			
		}
		initZtree(dpId,tNodes,dv_id)
	
	})
	
	
	$("#save_dp").on('click',function(){
		dpObj.name = $("#departmentName").val()
		dpObj.description = $("#dpDescription").text()
		dpObj.manager = $("#dpManager").val()
		$.ajax({
				type:'post',
				url:'/department/saveDepartment',
				dataType:'json',
				data:dpObj,
				success:function(rs){
				        if(rs == true){
				        	//var tag = "show"
				        	$(".editGroupDlg").parent().remove()
				        	zcAlert("保存成功");
							var showId = "group_tree"
							$("#save_dp").parents(".winModBg0").remove()
							initTreeData(showId)
							
				        }else{
				       		 $(".editGroupDlg").parent().remove()
				      		  zcAlert("保存失败");
				      		  console.log(":222")
				        }
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
							console.log(XMLHttpRequest)
							console.log(textStatus)
							console.log(errorThrown)
				}
	
			})
	})
	modDlgEvent($('.editGroupDlg'));//自制弹出框公用事件 居中_拖拽_关闭
}
//编辑部门弹出框end
//删除员工
function deleteMember(){
	zcConfirm('是否删除员工？',function(r){
		if(r){
			zcAlert('删除完毕');
		}
	});
}

function initZtree(tree_id,datas,dv_id){
		console.log(datas)
		datas.sort(function compareble(a,b){
			return a.name.localeCompare(b.name)
		})

		$.fn.zTree.init($("#"+tree_id), zNodeObj.setting, datas)
			var dpObj = $("#"+dv_id);
			//var dpOffset = $("#"+dv_id).offset().left
			var dpOffset = $("#"+dv_id).position()
			$("#"+tree_id).parent().css({left:dpOffset.left + "px", top:dpOffset.top +  dpObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);

}

function onBodyDown(event) {
			if (!(event.target.id == "menuBtn" || event.target.name == "menuContent" || $(event.target).parents("div[name=menuContent]").length>0)) {
				hideMenu();
			}
		}
function hideMenu() {
			$("div[name=menuContent]").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}

//删除员工end
//添加员工弹出框

var event_name;
function addMemberDlgShow(tag){
	event_name = "add_em"
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addMemberDlg" style="width:500px">'+
    	'<div class="titleBg">'+
        	'<div class="caption" id="tag_name">添加员工</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<form id="userForm" action="" >'+
        '<input type="hidden" name="id" value=""/>'+
        '<ul class="editList">'+
	    	'<li>'+
	        	'<div class="wLabel">姓名：<div class="imp">*</div></div>'+
	            '<input type="text" id="firstname" name="firstname" class="box1" />'+
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel">英文名：<div class="imp"></div></div>'+
	            '<input type="text" class="box1" id="enName" name="enName"/>'+
	        '</li>'+
	        '<li>'+
	        	'<div class="wLabel">操作账号：<div class="imp">*</div></div>'+
	            '<input type="text" class="box1" id="username" name="username"/>'+
	        '</li>'+
	        '<li>'+
	        	'<div class="wLabel">角色：<div class="imp">*</div></div>'+
	            '<select class="select1" id="roleSel" >'+
	            	'<option>选择角色</option>'+
	            '</select>'+
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel" id="dpDiv">所属部门：<div class="imp">*</div></div>'+
	        	'<input id="dpData"  type="text" class="box1"  readonly value="" name="dpData"><a name="selectDp" href="#">选择</a>'+
	        	'<div id="menuDpContent" class="menuContent" name="menuContent" style="display:none; position: absolute;">'+
	        		'<ul id="dp_tree" class="ztree" style="margin-top:0; width:200px;"></ul>'+
	        	'</div>'+
	            /*'<select class="select1" >'+
	            	'<option>选择部门</option>'+
	                '<option>部门1</option>'+
	                '<option>部门2</option>'+
	                '<option>部门3</option>'+
	                '<option>部门4</option>'+
	            '</select>'+*/
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel">邀请码：<div class="imp"></div></div>'+
	            '<input type="text" class="box1" id="invite_code" name="invite_code"/>'+
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel">手机号：<div class="imp">*</div></div>'+
	            '<input type="text" class="box1" id="mobile" name="mobile"/>'+
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel">邮箱：<div class="imp">*</div></div>'+
	            '<input type="text" class="box1" id="email" name="email"/>'+
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel" id="jtDiv">职位：<div class="imp">*</div></div>'+
	        	'<input id="jtData"  type="text" class="box1"  readonly value="" name="jtData"/><a name="selectJt" href="#">选择</a>'+
	        	'<div id="menuJtContent" class="menuContent" name="menuContent" style="display:none; position: absolute;">'+
	        		'<ul id="jt_tree" class="ztree" style="margin-top:0; width:200px;"></ul>'+
	        	'</div>'+
	            /*'<select class="select1">'+
	            	'<option>选择职位</option>'+
	                '<option>职位1</option>'+
	                '<option>职位2</option>'+
	                '<option>职位3</option>'+
	                '<option>职位4</option>'+
	            '</select>'+*/
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel">分机号：<div class="imp"></div></div>'+
	            '<input type="text" class="box1" id="ext_num" name="ext_num"/>'+
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel">工号：<div class="imp">*</div></div>'+
	            '<input type="text" class="box1" id="jobNum" name="jobNum"/>'+
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel">出生日期：<div class="imp"></div></div>'+
	            '<input type="text" class="box1" id="birth" name="birth"/>'+
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel">企业QQ：<div class="imp"></div></div>'+
	            '<input type="text" class="box1" id="qq" name="qq"/>'+
	        '</li>'+
			'<li>'+
	        	'<div class="wLabel">负责航线：<div class="imp"></div></div>'+
	            '<div class="shipLineBg">'+
					'<ul class="lineList" id="routeList" >'+
					'</ul>'+
					'<div id="shipLineAdd" class="b_btn">+</div>'+
	            '</div>'+
	        '</li>'+
	        '<li>'+
	        	'<div class="bottomBtns">'+
	        		/*'<input id="save_a_save" class="btnMod1" value="保存并继续添加" type="submit"/>'+*/
	            	/*'<div class="btnMod1" id="save_a_save">保存并继续添加</div>'+*/
	                '<input  class="btnMod1" value="保存" type="submit"/>'+
	            '</div>'+
	        '</li>'+
	        '<div class="shipLinesBg">'+
	        	'<ul class="linesList" id="hideLines">'+
        			'<li><input type="checkbox" /><span>中东印巴红海线</span><input type="hidden" value="中东印巴红海线"/></li>'+
        			'<li><input type="checkbox" /><span>中美加勒比海墨西哥线</span><input type="hidden" value="中美加勒比海墨西哥线"/></li>'+
        			'<li><input type="checkbox" /><span>欧洲线</span><input type="hidden" value="欧洲线"/></li>'+
        			'<li><input type="checkbox" /><span>非洲线</span><input type="hidden" value="非洲线"/></li>'+
        			'<li><input type="checkbox" /><span>南美线</span><input type="hidden" value="南美线"/></li>'+
        			'<li><input type="checkbox" /><span>澳新太平洋群岛线</span><input type="hidden" value="澳新太平洋群岛线"/></li>'+
        			'<li><input type="checkbox" /><span>北美线</span><input type="hidden" value="北美线"/></li>'+
        			'<li><input type="checkbox" /><span>中亚俄罗斯线</span><input type="hidden" value="中亚俄罗斯线"/></li>'+
        			'<li><input type="checkbox" /><span>地中海黑海线</span><input type="hidden" value="地中海黑海线"/></li>'+
        			'<li><input type="checkbox" /><span>东南亚日韩台湾线</span><input type="hidden" value="东南亚日韩台湾线"/></li>'+
        			'<li><input type="checkbox" /><span>其他</span><input type="hidden" value="其他"/></li>'+
        		'</ul>'+
		        '<div class="btnsBg" style="">'+
		        	'<div id="shipLinesAllCheck" class="btnMod1">全选</div>'+
		        	'<div id="shipLinesAllUnCheck" class="btnMod1">取消选择</div>'+
		        	'<div id="shipLinesAllOk" class="btnMod1">确定</div>'+
		        	'<div id="shipLinesAllClose" class="btnMod1">关闭</div>'+
		        '</div>'+
		    '</div>'+
	    '</ul>'+
	    '</form>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	var options = ""
	for(var i in nodes.roles){
			 options += '<option value="'+nodes.roles[i].name+'">'+nodes.roles[i].name+'</option>'
		
	}
	$(".addMemberDlg  select").append(options)
	
	
	if(tag == 'add'){
		
		
		var valadator = $("#userForm").validate({
		
		debug: false,
	  	rules: {
	  		firstname:{
	  			required: true,
	  		},
	  		username:{
	  			required: true,
	  			remote: {
					type: "post",
					async: false,
					url: "/user/isAccount",
					data: {username:function(){ console.log($("#username").val()); return $("#username").val()}},
				}
	  		},
	  		roleSel:{
	  			required: true,
	  			minlength: 1
	  		},
	  		dpData:{
	  			required: true,
	  			isDeparment: true
	  		},
	  		mobile:{
		  		required: true,
		  		isMobile: true
			},
			email: {
				required: true,
				email: true,
				remote: {
					type: "post",
					async: false,
					url: "/user/isAccountEmail",
					data: {email:function(){ console.log($("#email").val()); return $("#email").val()}},
				}
			},
			jtData: {
				required: true,
				isJobTitle:true
			},
			jobNum: {
				required: true,
				remote: {
					type: "post",
					async: false,
					url: "/user/isAccountEmail",
					data: {email:function(){ console.log($("#email").val()); return $("#email").val()}},
				}
			}
	  	},
		messages: {
			firstname:{
				required: "请输入中文名",
			},
			username:{
				required: "请输入账号",
				remote:   "该账号已存在"
			},
			roleSel:{
				required:    "请选择角色",
				minlength:   "请选择角色",
			},
			dpData:{
				required:  "请选择部门",
				isJobTitle: "无效职位"
			},
			mobile:{
				required: "请输入手机号",
				isMobile: "请输入有效的手机格式"
			},
			email:{
				required: "请输入邮箱",
				email:    "请输入有效的邮箱地址",
				remote:   "该邮箱已存在"	
			},
			jtData:{
				required:  "请选择职位",
				isJobTitle:"无效职位"
			},
			jobNum:{
				required:  "请输入工号",
				remote:    "该工号已存在"	
			},
		},
		errorPlacement:function(error, element){
				error.insertAfter(element.after());
				//chengeImage();
				
		},
		submitHandler: function(form){ 
		 	
			if($("#userForm").valid()){
			    var lis =  $("#routeList").children("li")
			    var routes = []
			    for(var i=0 , l=lis.length; i < l ; i++){
			    	routes.push(lis.eq(i).children().eq(0).text())
			    }
		        //$("#userForm").submit();
		        var user = {}
		       	var role = $("#roleSel").val()
		      	
		      	var addEpUrl;
		      	if(dpData){
		      		addEpUrl = "/department/addEmployee?routes="+routes+"&role="+role+"&dpData="+dpData
		      	}else{
		      		addEpUrl = "/department/addEmployee?routes="+routes+"&role="+role
		      	}
		       	
		       	$.ajax({
               		 cache: true,
              	     type: "POST",
                	 url:addEpUrl,
                	 data:$('#userForm').serialize(),// 你的formid
                     async: false,
                     error: function(request) {
                   		 alert("Connection error");
              	  	},
                	success: function(data) {
                		if(data == "true"){
                			$(".addMemberDlg").parent().remove()
                			if(tag == "add" || tag=="add_dp"){
                					zcAlert("添加成功");
                			}else{
                					zcAlert("修改成功");
                			}
                		}else{
                			$(".addMemberDlg").parent().remove()
                			if(tag == "add" || tag=="add_dp"){
                					zcAlert("添加失败");
                			}else{
                					zcAlert("修改失败");
                			}
                		}
                		
                		initTreeData("group_tree")
                   	 //$("#commonLayout_appcreshi").parent().html(data);
               	 }
           	 });
		       	
		       	
			}else{
				chengeImage();
			}
		   
	    },
	    chengeImage: function(){
			//$("#captchaimage").attr("src","/captcha/image?&#39; + Math.round(Math.random()*100000000)");
	    } 
	});
	}else if(tag == 'add_dp'){
		
		$("#dpDiv").parent().remove()
		dpData = $("#topDpName").text()
		
	}else{
		$(".titleBg").find("div").eq(0).text("编辑员工")
		var valadator = $("#userForm").validate({
		 
		debug: false,
	  	rules: {
	  		firstname:{
	  			required: true,
	  		},
	  		username:{
	  			required: true,
	  		},
	  		roleSel:{
	  			required: true,
	  			minlength: 1
	  		},
	  		dpData:{
	  			required: true,
	  			isDeparment: true
	  		},
	  		mobile:{
		  		required: true,
		  		isMobile: true
			},
			email: {
				required: true,
				email: true,
			},
			jtData: {
				required: true,
				isJobTitle:true
			},
			jobNum: {
				required: true,
			}
	  	},
		messages: {
			firstname:{
				required: "请输入中文名",
			},
			username:{
				required: "请输入账号",
			},
			roleSel:{
				required:    "请选择角色",
				minlength:   "请选择角色",
			},
			dpData:{
				required:  "请选择部门",
				isJobTitle: "无效职位"
			},
			mobile:{
				required: "请输入手机号",
				isMobile: "请输入有效的手机格式"
			},
			email:{
				required: "请输入邮箱",
				email:    "请输入有效的邮箱地址",
			},
			jtData:{
				required:  "请选择职位",
				isJobTitle:"无效职位"
			},
			jobNum:{
				required:  "请输入工号",
			},
		},
		errorPlacement:function(error, element){
				error.insertAfter(element.after());
				//chengeImage();
				
		},
		submitHandler: function(form){ 
		 	
			if($("#userForm").valid()){
			    var lis =  $("#routeList").children("li")
			    var routes = []
			    for(var i=0 , l=lis.length; i < l ; i++){
			    	routes.push(lis.eq(i).children().eq(0).text())
			    }
		        //$("#userForm").submit();
		        var user = {}
		       	var role = $("#roleSel").val()
		      	
		      	var addEpUrl;
		      	if(dpData){
		      		addEpUrl = "/department/addEmployee?routes="+routes+"&role="+role+"&dpData="+dpData
		      	}else{
		      		addEpUrl = "/department/addEmployee?routes="+routes+"&role="+role
		      	}
		       	
		       	$.ajax({
               		 cache: true,
              	     type: "POST",
                	 url:addEpUrl,
                	 data:$('#userForm').serialize(),// 你的formid
                     async: false,
                     error: function(request) {
                   		 alert("Connection error");
              	  	},
                	success: function(data) {
                		if(data == "true"){
                			$(".addMemberDlg").parent().remove()
                			if(tag == "add" || tag=="add_dp"){
                					zcAlert("添加成功");
                			}else{
                					zcAlert("修改成功");
                			}
                		}else{
                			$(".addMemberDlg").parent().remove()
                			if(tag == "add" || tag=="add_dp"){
                					zcAlert("添加失败"); 
                			}else{
                					zcAlert("修改失败");
                			}
                		}
                		
                		initTreeData("group_tree")
                   	 //$("#commonLayout_appcreshi").parent().html(data);
               	 }
           	 });
		       	
		       	
			}else{
				chengeImage();
			}
		   
	    },
	    chengeImage: function(){
			//$("#captchaimage").attr("src","/captcha/image?&#39; + Math.round(Math.random()*100000000)");
	    } 
	});
		
		for(var i in users){
			if(users[i].username == tag){
			        $("input[name=id]").val(users[i].id)
					$("#firstname").val(users[i].firstname)
					$("#username").val(users[i].username)
					$("#enName").val(users[i].enName)
					$("#mobile").val(users[i].mobile)
					$("#email").val(users[i].email)
					$("#invite_code").val(users[i].inviteCode||' -')
					$("#ext_num").val(users[i].extNum||' -')
					$("#jobNum").val(users[i].jobNum||" -")
					$("#birth").val(users[i].birth||" -")
					$("#qq").val(users[i].qq||" -")
					//console.log($("#roleSel option[value="+users[i].roleName+"]"))
					$("#roleSel").find("option[value="+users[i].roleName+"]").attr("selected",true);
					$("#roleSel option[text="+users[i].roleName+"]").attr("seleted",true)
					$("#jtData").val(users[i].jobTitle)
					$("#dpData").val(users[i].department)
					$("#routeList").append()
					//$("#firstname").val(users[i].firstname)
					//$("#firstname").val(users[i].firstname)
					var routeHtml=""
					for( var j=0,l=users[i].routes.length; j<l ; j++){
						
						routeHtml += '<li><div class="lineName">'+users[i].routes[j]+'</div><div class="b_btn">x</div></li>'
						//console.log($("#hideLines").find("span[text="+users[i].routes[j]+"]"))
						
						//console.log($("#hideLines").find("input[value="+users[i].routes[j]+"]").prev())
						$("#hideLines").find("input[value="+users[i].routes[j]+"]").prev().prev().prop("checked",true)
						
						var lis = $("#hideLines").children("li")
						
					}
					$(".lineList").html(routeHtml)
					$('.lineList .b_btn').click(function(){
						$(this).parent().remove();
					})
					//setLineList(users[i].routes)
			}
		}	
	}
	
	$("a[name=selectDp]").on("click",function(){
		var dpId = "dp_tree"
		var dp_input_id = "dpData"
		//initTreeData(tag,showId)
		for(var i in tNodes){
			if(tNodes[i].name.indexOf("(") > 0){
				tNodes[i].name = tNodes[i].name.substring(0,tNodes[i].name.indexOf("("))
			}
		}
		initZtree(dpId,tNodes,dp_input_id)
	})
	
	$("a[name=selectJt]").on("click",function(){
		var jtId = "jt_tree"
		var jt_input_id = "jtData"
		//initTreeData(tag,showId)
		initZtree(jtId,nodes.jNodes,jt_input_id)
	})
	
	initAccountForm();
	
	function initAccountForm(){
		$.validator.addMethod("isMobile", function(value, element) {    
			var length = value.length;    
			return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));    
		}, "请正确填写您的手机号码")
		
		$.validator.addMethod("isDeparment", function(value, element) {    
			return value != "深圳市找船网络科技有限公司";    
		}, "无效部门")
		
		$.validator.addMethod("isJobTitle", function(value, element) {    
			return value != "CEO";    
		}, "无效职位")
	
	
	
}
	
	
	$("#save_a_save").on("click",function(){
		
	})

	
	modDlgEvent($('.addMemberDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	shipLineEvent();//航线选择事件
}
//添加员工弹出框end


//航线选择事件
function shipLineEvent(){
	$('#shipLineAdd').click(function(){
		$('.shipLinesBg').show();
	});
	$('#shipLinesAllCheck').click(function(){
		$('.linesList input[type="checkbox"]').prop('checked',true);
	});
	$('#shipLinesAllUnCheck').click(function(){
		$('.linesList input[type="checkbox"]').prop('checked',false);
	});
	$('#shipLinesAllOk').click(function(){
		var checks=$('.linesList input[type="checkbox"]:checked');
		if(checks.length>0){
			var checkData=[];
			for(var i=0;i<checks.length;i++){
				var temp={};
				temp.name=checks.eq(i).next().html();
				checkData.push(temp);
			}
			setLineList(checkData)
		}else{
			$('.lineList').html('');
		}
		$('.shipLinesBg').hide();
	});
	$('#shipLinesAllClose').click(function(){
		$('.shipLinesBg').hide();
	});
	
	//设置负责航线
	function setLineList(data){
		var doHtml="";
		for(var i=0;i<data.length;i++){
			doHtml+='<li><div class="lineName">'+data[i].name+'</div><div class="b_btn">x</div></li>'
		}
		$('.lineList').html(doHtml);
		$('.lineList .b_btn').click(function(){
			$(this).parent().remove();
		})
	}
}

var zNodeObj = {
	setting : {
		view: {
			showIcon:showIconForTree,
			showLine:false
		},
		data: {
			key: {
				title:""
			},
			simpleData: {
				enable: true
			}
		},
		callback: {
			beforeClick: function(treeId, treeNode, clickFlag) {
					if(showId == "group_tree"){
						//console.log('treeId',treeId);
						//console.log(treeNode.name);
						//console.log('clickFlag',clickFlag);
						//return false
				}
		
			},
			onClick: function(event, treeId, treeNode, clickFlag) {
					onClick(event, treeId, treeNode, clickFlag)
					
		}
	}
}
}
var clk_node

function onClick(event, treeId, treeNode, clickFlag){
			 clk_node = treeNode
		      nLevel = treeNode.level
					if(treeId == "group_tree"){
						if(nLevel == 0){
							$("#editNode").attr("onClick","") 
							$("#editNode").css("background","#cccccc")
							$("#editNode").css("color","#fff")
						}else{
							$("#editNode").removeClass()
							$("#editNode").attr("style","")
							$("#editNode").addClass("btnL btnMod1")
							$("#editNode").attr("onClick","editGroupDlgShow()") 
						}
						$("#topDpName").text(treeNode.name.substring(0,treeNode.name.indexOf("(")))
						delDpTid = treeNode.tId
						var treeObj = $.fn.zTree.getZTreeObj("group_tree");
						var nodes = treeObj.getSelectedNodes()
						$("#child_dp").empty()
						$("#eps_tb").empty()
						$(".r_controlLine").show()
						$("#dpMgr").show()
						dpObj.pId = treeNode.pId
						if(nodes.length > 0){
							initChildDp(treeNode)
							initEmployees(treeNode)
							$("#dpMgr").text(treeNode.manager)
							var parentNodes = nodes[0].getPath()
							parentNodes.sort(function compare(a,b){
							return a.level-b.level
						});
							var sortNode = ""
						for(var k=0, l=parentNodes.length; k<l-1;k++){
							sortNode += '<span class="blue">'+parentNodes[k].name.substring(0,parentNodes[k].name.indexOf("("))+'</span><span class="r_ar">></span>'
						}
							sortNode += '<span>'+treeNode.name.substring(0,treeNode.name.indexOf("("))+'</span>'
							$("#sortDpName").html(sortNode)
					}else{
						$("#sortDpName").html('<span class="blue">'+treeNode.name.substring(0,treeNode.name.indexOf("("))+'</span>')
						$("#dpMgr").text(treeNode.manager)
						initChildDp(treeNode)
						initEmployees(treeNode)
					}
				}else{
					/*if(event_name == "add_em" && treeId == "dp_tree"){
						if(treeNode.children == null){
							$("#"+treeId).parent().parent().find("input").val(treeNode.name)
							dpObj.pId = treeNode.id
							hideMenu()
						}else{
							zcAlert("请选择下级部门")
						}
					}else{*/
							$("#"+treeId).parent().parent().find("input").val(treeNode.name)
							dpObj.pId = treeNode.id
							hideMenu()
					//}
					
			}
	}
	

//var dps=[];
var tNodes;

function initTreeData(showId){
	$.post("/department/initDepartmentData",function(data){
			nodes.zNodes = data.dps
			tNodes = data.dps
			nodes.roles = data.roles
			nodes.jNodes = data.jobTitles
			nodes.users = data.users
			
			var p_node_id 
			for(var i in data.dps){
				if(n_ids.indexOf(data.dps[i].id) < 0){
					data.dps[i].length = data.dps[i].users.length
					InfoEmployee(data.dps[i])
				}
			    if(data.dps[i].name == "深圳市找船网络科技有限公司"){
			    	p_node_id  = data.dps[i].pId 
			    }
			   //zNodes.push({id:data[i].id,pId:data[i].pId,name:data[i].name,isParent:data[i].isParent})
			}
			
			for(var k in nodes.zNodes){
				//nodes.zNodes[k].name += " ( " + nodes.zNodes[k].users.length + " ) "
				nodes.zNodes[k].name += " ( " + (nodes.zNodes[k].length||0) + " ) "
				
				if(nodes.zNodes[k].pId == p_node_id ){
					nodes.zNodes[k].open = true
				}
			}
			
			nodes.zNodes.sort(function compareble(a,b){
					return a.name.localeCompare(b.name);
			})
			$.fn.zTree.init($("#"+showId), zNodeObj.setting, nodes.zNodes);
			if(showId == "group_tree"){
				var tObj = $.fn.zTree.getZTreeObj("group_tree");
				var allNodes = tObj.getNodes()
				for(var i in allNodes){
					if(allNodes[i].level == 0){
						onClick(allNodes[i].click=true,showId,allNodes[i])
					}
				}
			}
	})

}
var n_ids = [];
function InfoEmployee(node){
	if(node.length > 0){
		var r;
		for(var j in nodes.zNodes){
			//console.log(nodes.zNodes[j])
			if(nodes.zNodes[j].id == node.id){
					nodes.zNodes[j].length = node.length
			}	
			if(nodes.zNodes[j].id == node.pId){
				if(nodes.zNodes[j].length != null){
					var count = nodes.zNodes[j].length + node.length
				}else{
					var count = nodes.zNodes[j].users.length + node.length
				}
				nodes.zNodes[j].length = count
				//var us = nodes.zNodes[j].users.concat(node.users)
				//nodes.zNodes[j].users = us
				//nodes.zNodes[j].users = $.merge(nodes.zNodes[j].users,node.users)
				
				if(nodes.zNodes[j].pId != null && nodes.zNodes[j].pId != 0){
					console.log(nodes.zNodes[j])
					n_ids.push(nodes.zNodes[j].id)
					InfoEmployee(nodes.zNodes[j])
				}
			}
		}
	}
}


var user;
function initChildDp(treeNode){
		if(treeNode.children != undefined && treeNode.children.length > 0  ){
				$("#child_dp").show()
				var childDps = treeNode.children
				for(var i in childDps){
					$("#child_dp").append('<li><input type="hidden" value='+'"'+childDps[i].tId+'"'+'/><span class="name" >'+childDps[i].name.substring(0,childDps[i].name.indexOf("("))+'</span><span class="num">'+childDps[i].users.length+'人</span></li>')
				}
				
				$("#child_dp li span").on("click",function(){
					var treeObj = $.fn.zTree.getZTreeObj("group_tree")
					var node = treeObj.getNodeByTId($(this).prev().val())
					 treeObj.selectNode(node)
					onClick(node.click=true,"group_tree",node)
				
				})
		}else{
			$("#child_dp").hide()
			$("#child_dp").prev().hide()
			//$("#child_dp").append('<li><span class="name">无数据</span></li>')
		}
	}
	
function initEmployees(treeNode){
			users = treeNode.users
			var eps_tb_data = '<tr>'+
	                   '<th width="29"></th>'+
	                   '<th width="69">姓名</th>'+
	                   '<th width="119">账号</th>'+
	                   '<th width="89">职位</th>'+
	                   '<th width="99">手机号</th>'+
	                   '<th width="109">角色</th>'+
	                   '<th width="49">状态</th>'+
	                   '<th width="118">操作</th>'+
	                '</tr>'
	               
			if(treeNode.users.length > 0){
					for(var i=0, l=pageCount; i<pageCount; i++){
					if(users[i] != undefined){
					   eps_tb_data +=  '<tr>'+
	                  	 '<td><input type="checkbox" /></td>'+
	                   	 '<td><span class="blue">'+users[i].firstname+'</span></td>'+
	                  	 '<td>'+users[i].username+'</td>'+
	                     '<td>'+users[i].jobTitle+'</td>'+
	                     '<td>'+users[i].mobile+'</td>'+
	                     '<td><span class="blue">'+users[i].roleName+'</span></td>'+
	                     '<td><span class="blue">'+(users[i].enabled?'启用':'禁用')+'</span></td>'+
	                 	 '<td><a onclick="addMemberDlgShow('+"'"+users[i].username+"'"+')">编辑</a>'+
	                 	 '<a onclick="enable('+"'"+users[i].id+"'"+','+"'"+users[i].enabled+"'"+')">'+(users[i].enabled?'禁用':'启用')+'</a>'+
	                 	 '<a  onclick="delUser('+"'"+users[i].id+"'"+')" class="red">删除</a></td>'+
	                 '</tr>'
				 }
				}
		
			}else{
				//eps_tb_data += '<td><span class="blue">'+无数据+'</span></td>'
			}
			
			$("#eps_tb").append(eps_tb_data)
			var pageTotal = users.length % pageCount> 0 ? Math.floor(users.length / pageCount) + 1 :  users.length / pageCount
			setCommonPage2Event($('.wm_profession_page'),pageTotal,function(num){
					paging(num)
	})
			
	}
	//分页
function paging(num){
	$("#eps_tb").empty()
	var eps_tb_data = '<tr>'+
	                   '<th width="29"></th>'+
	                   '<th width="69">姓名</th>'+
	                   '<th width="119">账号</th>'+
	                   '<th width="89">职位</th>'+
	                   '<th width="99">手机号</th>'+
	                   '<th width="109">角色</th>'+
	                   '<th width="49">状态</th>'+
	                   '<th width="118">操作</th>'+
	                '</tr>'
					for(var i=0+(num-1)*10, l=pageCount; i<pageCount+(num-1)*10; i++){
						if(users[i] != undefined){
							 eps_tb_data +=  '<tr>'+
	                  	 '<td><input type="checkbox" /></td>'+
	                   	 '<td><span class="blue">'+users[i].firstname+'</span></td>'+
	                  	 '<td>'+users[i].username+'</td>'+
	                     '<td>'+users[i].jobTitle+'</td>'+
	                     '<td>'+(users[i].mobile?users[i].mobile:'-')+'</td>'+
	                     '<td><span class="blue">'+users[i].roleName+'</span></td>'+
	                     '<td><span class="blue">'+(users[i].enabled?'启用':'禁用')+'</span></td>'+
	                 	 '<td><a onclick="addMemberDlgShow('+"'"+users[i].username+"'"+')">编辑</a>'+
	                 	 '<a onclick="enable('+"'"+users[i].id+"'"+','+"'"+users[i].enabled+"'"+')">'+(users[i].enabled?'禁用':'启用')+'</a>'+
	                 	 '<a class="red" onclick="delUser('+"'"+users[i].id+"'"+')">删除</a></td>'+
	                 '</tr>'
					}
				 }
		$("#eps_tb").append(eps_tb_data)

}
	
function showIconForTree(treeId, treeNode) {
		return false;
};
	
function enable(id,enable){
	$.post("/department/enable?id="+id+"&enabled="+enable,function(data){
		if(data){
			if(enable == true){
				zcAlert("禁用成功")
			}else{
				zcAlert("启用成功")
			}
			
			initTreeData("group_tree")
		}
		
	})	
}

function delUser(id){
zcConfirm('是否删除员工？',function(r){
		if(r){
		$.post("/department/delEmployee?id="+id,function(data){
			if(data=="true"){
				zcAlert("删除成功")
				initTreeData("group_tree")
			}else{
				zcAlert("删除失败")
			}
		
			})
		}
	});

}
//初始化左侧树结构 end
</script>
</body>
</html>