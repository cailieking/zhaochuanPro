<!DOCTYPE html>
<html>
<head>
<title>职位管理</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/manage_common.css" />
<asset:stylesheet src="c_css/zTreeStyle.css" />
<asset:stylesheet src="c_css/profession.css" />
<asset:javascript src="c_js/common.js" />
<asset:javascript src="c_js/position.js" />
<asset:javascript src="c_js/jquery.ztree.core-3.5.js" />
<asset:javascript src="c_js/jquery.ztree.excheck-3.5.js" />
 <asset:javascript src="jquery.validate.min.js"/>
</head>    
<body>
<div class="win_manage_bg">
	<!-- 左侧板块 -->
	<div class="win_manage_layout wm_left">
		<div class="wm_top">
			<div class="caption">职位管理</div>
			<div class="btnR btnMod1" onclick="addProfessionDlgShow('add')">添加职位</div>
			<div class="btnR btnMod1" onclick="deleteProfession()">删除职位</div>
		</div>
		<div class="wm_content">
			<table id="professionList" class="wm_table" width="338">
				<tr>
                	<th width="29"></th>
                    <th width="204">职位名称</th>
                    <th width="103">人数</th>
                </tr>
                <g:each in="${rows}" var="jt" status="m" >
                <tr>
                	<td><input type="checkbox" value="${jt.name}"/></td>
                    <td><span class="professionname">${jt.name}</span></td>
                    <td>${jt.users.size()}</td>
                </tr>
                </g:each>
			</table>
			 <div class="wm_profession_page"></div>
		</div>
	</div>
	<!-- 左侧板块  end-->
	<!-- 右侧板块 -->
	<div class="win_manage_layout wm_right">
		<div class="wm_top">
			<div class="caption">职位名</div>
			<div class="btnL btnMod1" onclick="addProfessionDlgShow('edit')">编辑职位</div>
		</div>
		<div class="wm_content">
			<div class="r_caption">组织结构</div>
			<div class="r_content">
				<div class="pfTreeBg">
					
				</div>
			</div>
		</div>
	</div>
	<!-- 右侧板块  end-->
	
</div>
<script>

//编辑菜单弹出框end
</script>
</body>
</html>