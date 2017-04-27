<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    
    <title></title>
    <meta name="layout" content="main">
    <asset:stylesheet src="form-table.css" />

    
</head>
<body>
        <%--<div class="row">
	--%><div class="col-lg-12">
		<div class="lump">
		<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">撮合交易信息</div>
			<from id="dataform">
			<formTable:table>
				<formTable:tr title='业务员'>
					<input type="text" readonly="readonly" value="${data.saler}" />
				</formTable:tr>
				<formTable:tr title='提交日期'>
					<input type="text" readonly="readonly" value="${data.commitDate}" />
				</formTable:tr>
				<formTable:tr title='开船日期'>
					<input type="text" readonly="readonly" value="${data.startShipDate}" />
				</formTable:tr>
				<formTable:tr title='BookingNo'>
					<input type="text" readonly="readonly" value="${data.bookingNo}" />
				</formTable:tr>
				<formTable:tr title='B/L-No'>
					<input type="text" readonly="readonly" value="${data.blNo}" />
				</formTable:tr>
				<formTable:tr title='船公司'>
					<input type="text" readonly="readonly" value="${data.shipCompany}" />
				</formTable:tr>
				<formTable:tr title='货代名称'>
					<input type="text" readonly="readonly" value="${data.cargoName}" />
				</formTable:tr>
				<formTable:tr title='供应商'>
					<input type="text" readonly="readonly" value="${data.offerName}" />
				</formTable:tr>
				<formTable:tr title='区域'>
					<input type="text" readonly="readonly" value="${data.area}" />
				</formTable:tr>
				<formTable:tr title='公式规模'>
					<input type="text" readonly="readonly" value="${data.companyScale}" />
				</formTable:tr>
				<formTable:tr title='20GP'>
					<input type="text" readonly="readonly" value="${data.gp20}" />
				</formTable:tr>
				<formTable:tr title='40GP'>
					<input type="text" readonly="readonly" value="${data.gp40}" />
				</formTable:tr>
				<formTable:tr title='40HQ'>
					<input type="text" readonly="readonly" value="${data.hq40}" />
				</formTable:tr>
				<formTable:tr title='品名'>
					<input type="text" readonly="readonly" value="${data.productName}" />
				</formTable:tr>
				<formTable:tr title='起始港'>
					<input type="text" readonly="readonly" value="${data.startPort}" />
				</formTable:tr>
				<formTable:tr title='目的港'>
					<input type="text" readonly="readonly" value="${data.endPort}" />
				</formTable:tr>
				<formTable:tr title='航线'>
					<input type="text" readonly="readonly" value="${data.route}" />
				</formTable:tr>
				<formTable:tr title='OF(USD)'>
					<input type="text" readonly="readonly" value="${data.ofUsd}" />
				</formTable:tr>
				<formTable:tr title='ISPS(USD)'>
					<input type="text" readonly="readonly" value="${data.ispsUsd}" />
				</formTable:tr>
				<formTable:tr title='THC(RMB)'>
					<input type="text" readonly="readonly" value="${data.thcRmb}" />
				</formTable:tr>
				<formTable:tr title='DOC(RMB)'>
					<input type="text" readonly="readonly" value="${data.docRmb}" />
				</formTable:tr>
				<formTable:tr title='SEAL(RMB)'>
					<input type="text" readonly="readonly" value="${data.sealRmb}" />
				</formTable:tr>
				<formTable:tr title='EIR(RMB)'>
					<input type="text" readonly="readonly" value="${data.eirRmb}" />
				</formTable:tr>
				<formTable:tr title='其他(RMB)'>
					<input type="text" readonly="readonly" value="${data.otherRmb}" />
				</formTable:tr>
				<formTable:tr title='备注'>
					<input type="text" readonly="readonly" value="${data.remark}" />
				</formTable:tr>
				
				
				
			</formTable:table>
			</from>
			<div class="buttons">
				<a href="javascript:;" onclick="window.history.back()" class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 1080px;">返回</a>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
<%--</div>
--%></body>
</html>