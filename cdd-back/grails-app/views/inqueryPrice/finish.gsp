<%@page import="com.cdd.base.enums.TransportationType"%>
<%
	def dateFormat = new java.text.SimpleDateFormat('yyyy-MM-dd')
%>
<!DOCTYPE>
<html>
<head>
<title>询价信息</title>
<meta name="layout" content="main">
<asset:stylesheet src="form-table.css" />
</head>
<body>
<%--<div class="row">
	--%><div class="col-lg-12">
		<div class="block">
			<form action="${request.contextPath }/inqueryPrice/finished" method="post" id="dataForm">
			<input type="hidden" name="id" value="${data.data.id}" />
			<table>
			 	<tr class="only-tr">
					<td>运价编号</td><td   title='运价编号'>
						<input type="text" readonly="readonly" value="${data.data.info.id}" />
					</td >
				</tr>
				<tr class="only-tr">
					${data.data.info.startPort }--------->${data.data.info.endPort }
				</tr>
				<tr class="only-tr">
				<td>20GP</td><td   title='运费'>
					<input name="gp20" type="text" readonly="readonly" value="${data.data.info.prices?.gp20}" />
				</td >
				<td>40GP</td><td   title='运费'>
					<input name="gp40" type="text" readonly="readonly" value="${data.data.info.prices?.gp40}" />
				</td >
				<td>40HQ</td><td   title='运费'>
					<input name="HQ40" type="text" readonly="readonly" value="${data.data.info.prices?.hq40}" />
				</td >
				</tr>
				<tr class="only-tr">
					<td>开船日</td>
					<td title="开船日"><input type="text" readonly="readonly" name="startDate" value="${data.data.info.startDate ? dateFormat.format(data.data.info.startDate): ''}"/></td>
					<td>船期</td>
					<td title="船期"><input type="text" readonly="readonly" name="shippingDay" value="${data.data.info.shippingDay }"/></td>
				</tr>
				<tr class="only-tr">
					<td>起始港</td>
					<td title="起始港"><input type="text" readonly="readonly" name="startPort" value="${data.data.info.startPort }"/></td>
					<td>中转港</td>
					<td title="中转港"><input type="text" readonly="readonly" name="middlePort" value="${data.data.info.middlePort }"/></td>
					<td>目的港</td>
					<td title="目的港"><input type="text" readonly="readonly" name="endPort" value="${data.data.info.endPort }"/></td>
				</tr>
				<tr class="only-tr">
					<%-- <td>有效期</td>
					<td title="有效期"><input type="text" value="${data.info.shippingDays }"/></td>--%>
					<td>航程</td>
					<td title="航程"><input type="text" readonly="readonly" name="shippingDays" value="${data.data.info.shippingDays }"/></td>
					<td>船公司</td>
					<td title="船公司"><input type="text" readonly="readonly" name="shipCompany" value="${data.data.info.shipCompany }"/></td>
				</tr>
				<tr class="only-tr">
					<td>限重</td>
					<td title="限重"><input type="text" readonly="readonly" name="weightLimit" value="${data.data.info.weightLimit }"/></td>
					<td>运输类型</td>
					<td title="运输类型"><input type="text" readonly="readonly" name="transType" value="${data.data.info.transType?.text }"/></td>
				</tr>
				<tr class="only-tr">
					<td>附加费</td>
					<td title="附加费"><textarea readonly="readonly">${data.data.info.prices?.extra}</textarea></td>
				</tr>
				<tr class="only-tr">
					<td>备注</td>
					<td title="备注">
					<textarea readonly="readonly">${data.data.info.remark }</textarea>
					</td>
				</tr>
				<g:if test="${data.order==null }">
					<tr class="only-tr">
						<td>询价编号</td>
						<td title="询价编号"><input type="text" readonly="readonly" name="number" value="${data.data.number}"/></td>
					</tr>
					<tr class="only-tr">
						<td>公司名称</td>
						<td title="公司名称"><input type="text" name="companyName" value="${data.data.companyName}" id="companyName"/></td>
						<td>联系人</td>
						<td title="联系人"><input type="text" name="contactMan" value="${data.data.contactMan}"/></td>
					</tr>
					<tr class="only-tr">
						<td>手机号码</td>
						<td title="手机号码"><input type="text" name="mobile" value="${data.data.mobile}" id="mobile"/></td>
						<td>QQ号码</td>
						<td title="QQ号码"><input type="text" name="qq" value="${data.data.qq}"/></td>
					</tr>
					<tr class="only-tr">
						<td>处理意见</td>
						<td><textarea name="operateOpinion" id="operateOpinion">${data.data.operateOpinion }</textarea></td>
					</tr>
					
					<tr class="only-tr">
						<td>备注</td>
						<td><textarea name="remark">${data.data.remark }</textarea></td>
					</tr>
				</g:if>
				<g:if test="${data.order!=null }">
					<tr class="only-tr">
						<td>询价编号</td>
						<td title="询价编号"><input type="text" readonly="readonly" name="number" value="${data.data.number}"/></td>
					</tr>
					<tr class="only-tr">
						<td>公司名称</td>
						<td title="公司名称"><input type="text" name="companyName" value="${data.data.companyName}" id="companyName"/></td>
						<td>联系人</td>
						<td title="联系人"><input type="text" name="contactMan" value="${data.data.contactMan}"/></td>
					</tr>
					<tr class="only-tr">
						<td>手机号码</td>
						<td title="手机号码"><input type="text" name="mobile" value="${data.data.mobile}" id="mobile"/></td>
						<td>QQ号码</td>
						<td title="QQ号码"><input type="text" name="qq" value="${data.data.qq}"/></td>
					</tr>
					<tr class="only-tr">
						<td>起始港</td>
						<td title="起始港"><input type="text" readonly="readonly" name="startPort" value="${data.order.startPort}"/></td>
						<td>目的港</td>
						<td title="目的港"><input type="text" readonly="readonly" name="endPort" value="${data.order.endPort}"/></td>
					</tr>
					<tr class="only-tr">
						<td>货物名称</td>
						<td title="货物名称"><input type="text" readonly="readonly" name="cargoName" value="${data.order.cargoName}"/></td>
						<td>货物类型</td>
						<td title="货物类型"><input type="text" readonly="readonly" name="orderType" value="${data.order.orderType}"/></td>
						<td>运输类别</td>
						<td title="运输类别"><input type="text" readonly="readonly" name="transType" value="${data.order.transType?.text}"/></td>
					</tr>
					<tr class="only-tr">
						<td>毛重</td>
						<td title="毛重">
							<input type="text" name="cargoWeight" readonly="readonly" value="${data.order.cargoWeight }"/>
						</td>
						<td>体积</td>
						<td title="体积">
							<input type="text" name="cargoCube" readonly="readonly" value="${data.order.cargoCube }"/>
						</td>
						<td>预计出货日</td>
						<td title="预计出货日">
							<input type="text" name="startDate" readonly="readonly" value="${data.order.startDate ? dateFormat.format(data.order.startDate): ''}"/>
						</td>
						<%-- 
						<td>预计出货日</td>
						<td title="预计出货日">
							<input type="text" name="cargoCube" value="${data.order.cargoCube }"/>
						</td>--%>
					</tr>
					<g:if test="${data.str!=null }">
						<tr class="only-tr">
							<td>箱型</td>
							<td title="GP20">
											<span>${data.GP20 }：</span>
											<span style="margin-left: 15px;color: orange;">${data.GP20CargoBoxNums }</span>
											<span style="margin-left: 15px;">TEU</span>
							</td>
							<td title="GP40">
											<span>${data.GP40}：</span>
											<span style="margin-left: 15px;color: orange;">${data.GP40CargoBoxNums }</span>
											<span style="margin-left: 15px;">TEU</span>
							</td>
							<td title="HQ40">
											<span>${data.HQ40}：</span>
											<span style="margin-left: 15px;color: orange;">${data.HQ40CargoBoxNums }</span>
											<span style="margin-left: 15px;">TEU</span>
							</td>
						</tr>
					</g:if>
					<g:if test="${data.str==null }">
						<tr class="only-tr">
							<td>箱型</td>
							<td>
								<span>${data.order.cargoBoxType}：</span>
								<span style="margin-left: 15px;color: orange;">${data.order.cargoBoxNums }</span>
								<span style="margin-left: 15px;">TEU</span>
							</td>
							
						</tr>
					</g:if>
					<tr class="only-tr">
						<td>备注</td>
						<td title="备注"><input type="text" readonly="readonly" name="orderDescript" value="${data.data.orderDescript}"/></td>
					</tr>
					<tr class="only-tr">
						<td>处理意见</td>
						<td><textarea name="operateOpinion" id="operateOpinion">${data.data.operateOpinion }</textarea></td>
					</tr>
					<tr class="only-tr">
						<td>备注</td>
						<td><textarea name="remark">${data.data.remark }</textarea></td>
					</tr>
				
				</g:if>
				
			</table>
			</form>
			<div class="buttons">
				<a href="javascript:;" onclick="finish()" class="button button-glow button-rounded button-raised button-primary" style="margin-left: 500px;">结单</a>
				<a href="javascript:;" class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 80px;">返回</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>
--%><script>
	$("#back").click(function(){
		
			window.close()

		})
		
		function finish(){
			if($("#companyName").val()==""){
					BootstrapDialog.show({
					message: '公司名不能为空'
					});
					return false;
				}
			if($("#mobile").val()==""){
					BootstrapDialog.show({
					message: '联系方式不能为空'
					});
					return false;
				}
			if($("#operateOpinion").val()==""){
					BootstrapDialog.show({
					message: '处理意见不能为空'
					});
					return false;
			}
			$('#dataForm').submit();
		}

</script>
</body>
</html>