<%@page import="com.cdd.base.enums.AgentType"%>
<%@page import="com.cdd.base.domain.Role"%>
<!DOCTYPE>
<html>
<head>
<title>公司信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">公司认证列表</div>
			<form  action="${request.contextPath}/companyCertificate/save" method="post" id="dataForm">
				<input type="hidden" name="id" value="${data.id}" />
				<formTable:table>
					<formTable:tr title='公司名(必填):'>
						<input type="text" name="companyName" value="${data.companyName}" placeholder="公司名" />
					</formTable:tr>
					<formTable:tr title='地址（必填）:'>
						<input type="text" name="address" value="${data.address}" placeholder="地址"/>
					</formTable:tr>
					<formTable:tr title='城市（必填）:'>
						<input type="text" name="city" value="${data.city}" placeholder="城市"/>
					</formTable:tr>
						<formTable:tr title='成立时间（如：1991）:'>
					    <input type="text" name="bulidTime" value="${data.bulidTime}" placeholder="成立时间"/>
					</formTable:tr>
					<formTable:tr title='注册资本（万）:'>
					    <input type="text" name="regCapital" value="${data.regCapital}" placeholder="注册资本（"/>
					</formTable:tr>
					<formTable:tr title='诚信:'>
							<input type="hidden" id="honest" value="${data.honest}">
					     是<input type="radio" id="honest1" name="honest" class="numberTextbox"  value="true"  >
					     否<input type="radio" id="honest2" name="honest" class="numberTextbox" value="false">
					</formTable:tr>
					<formTable:tr title='信誉:'>
							<input type="hidden" id="safety" value="${data.safety}">
					        是<input type="radio" id="safety1" name="safety" class="numberTextbox" value="true"  >
					         否<input type="radio" id="safety2" name="safety" class="numberTextbox" value="false">
					</formTable:tr>
					<formTable:tr title='认证:'>
					<input type="hidden" id="verified" value="${data.verified}">
					      是<input type="radio"  id="verified1" name="verified" class="numberTextbox" value="true" >
					         否<input type="radio"  id="verified2"  name="verified" class="numberTextbox" value="false">
					</formTable:tr>
					<formTable:tr title='公司简介:'>
					    <input type="text" name="introduce" value="${data.introduce}" placeholder="公司简介"/>
					</formTable:tr>
					<formTable:tr title='公司规模（人）:'>
					    <input type="text" name="workers" value="${data.workers}" placeholder="公司规模"/>
					</formTable:tr>
					<formTable:tr title='业务规模(T):'>
					    <input type="text" name="scale" value="${data.scale}" placeholder="业务规模"/>
					</formTable:tr>
					<formTable:tr title='公司网址:'>
					    <input type="text" name="website" value="${data.website}" placeholder="公司网址"/>
					</formTable:tr>
					<formTable:tr title='邮箱:'>
					    <input type="text" name="mailbox" value="${data.mailbox}" placeholder="邮箱"/>
					</formTable:tr>
					<formTable:tr title='联系电话（必填）:'>
					    <input type="text" name="telephone" value="${data.telephone}" placeholder="联系电话"/>
					</formTable:tr>
					<formTable:tr title='业务范围 :'>
					    <input type="text" name="businessRange" value="${data.businessRange}" placeholder="业务范围 "/>
					</formTable:tr>
					<formTable:tr title='类型（船东、一级货代 、二级货代、中小货代）:'>
					   	<select name="type" class="selectpicker">
							<option value="">--请选择--</option>
							<g:each in="${AgentType.values()}" var="type">
								<g:if test="${data.type == type}">
									<option selected="selected" value="${type.name()}">${type.text}</option>
								</g:if>
								<g:else>
									<option value="${type.name()}">${type.text}</option>
								</g:else>
							</g:each>
						</select>
					</formTable:tr>
					<formTable:tr title='运价情况:'>
					    <input type="text" name="priceInfo" value="${data.priceInfo}" placeholder="运价情况"/>
					</formTable:tr>
					<formTable:tr title='备注:'>
					    <input type="text" name="remark" value="${data.remark}" placeholder="备注"/>
					</formTable:tr>
					<formTable:tr title='英文名称:'>
					    <input type="text" name="englishName" value="${data.englishName}" placeholder="英文名称"/>
					</formTable:tr>
					<formTable:tr title='推荐航线:'>
					    <input type="text" name="advancedRoute" value="${data.advancedRoute}" placeholder="推荐航线"/>
					</formTable:tr>
				
				</formTable:table>
			</form>
			<div class="buttons">
				<a href="javascript:;" onclick="$('#dataForm').submit();" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<a href="javascript:;" onclick="window.history.back()" class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 1080px;">返回</a>
				
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
</div>


</body>
</html> 