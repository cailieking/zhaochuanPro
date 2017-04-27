<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>找船网后台管理_运价信息底部</title>
   
    <asset:javascript src="common.js" />
    <meta name="layout" content="main">
	<asset:javascript src="shipBottom.js" />
	<asset:stylesheet src="common.css" />
	<asset:stylesheet src="shipBottom.css" />
</head>
<body>
<div class="child_content">
	<div class="child_top">
    	<div class="link blue">广告管理></div>
        <div class="link blue">一级页面></div>
        <div class="cur">运价信息底部</div>
    </div>
    <ul class="child_nav">
    	<li><a href="/imageInfo/list/">首页Banner</a></li>
        <li>运价信息左侧</li>
        <li class="sel">运价信息底部</li>
        <li>货盘信息左侧</li>
        <li>货盘信息底部</li>
        <li>合作伙伴</li>
    </ul>
    <div class="child_oper">
    	<div class="left">
        	<div class="clabel">广告栏设置：</div>
            <div class="turn on">
            	<div class="turnTxt">ON</div>
                <div class="turnBtn"></div>
            </div>
        </div>
        <div class="right">
        	<button onClick="shipBottomCreateShow()">创建</button>
        </div>
    </div>
    <!--表格-->
    <div class="child_table">
    	<div class="th">
            <div class="td1 td">顺序</div>
            <div class="td2 td">图片</div>
            <div class="td3 td">属性</div>
            <div class="td4 td">操作</div>
        </div>
        <!--表格_行-->
        <g:each in="${list}" var="row" status="m">
        <div class="tr">
            <div class="td1 td"><span class="vertMidBg">1</span></div>
            <div class="td2 td">
            	<img class="image" src="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/${row.image}" data-oss="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/"/>
            </div>
            <div class="td3 td">
            	<ul class="infoList">
                	<li class="w50">
                    	<div class="clabel" >状态：</div>
                        <div name="shipBottomState" class="txt red" data-status="${row.state}" >${row.state}</div>
                    </li>
                    <li class="w50">
                    	<div class="clabel">创建人：</div>
                        <div class="txt">${row.createBy}</div>
                    </li>
                    <li class="w50">
                    	<div class="clabel">创建时间：</div>
                        <div class="txt">${row.dateCreated}</div>
                    </li>
                    <li class="w50">
                    	<div class="clabel">到期时间：</div>
                        <div data-order="${row.order}" class="txt red">${row.endDate}</div>
                    </li>
                    <li class="w100">
                    	<div class="clabel">Title：</div>
                        <div class="txt">${row.title}</div>
                    </li>
                    <li class="w100">
                    	<div class="clabel">Alt：</div>
                        <div class="txt">${row.alt}</div>
                    </li>
                    <li class="w100" style="border-bottom:1px #797979 solid;">
                    	<div class="clabel">链接：</div>
                        <div class="txt blue">${row.href}</div>
                    </li>
                    <li class="w100">
                    	<div class="clabel">客户名称：</div>
                        <div class="txt">${row.customName}</div>
                    </li>
                    <li class="w50">
                    	<div class="clabel">合同编号：</div>
                        <div class="txt">${row.contractNumber}</div>
                    </li>
                    <li class="w50">
                    	<div class="clabel">业务员：</div>
                        <div class="txt">${row.sales}</div>
                    </li>
                </ul>
            </div>
            <div class="td4 td">
            	<span class="vertMidBg">
                	<span onClick="adEditShow($(this))" data-id="${row.id}" class="operBtn">修改</span><br/>
                    <span class="operBtn" onClick="shipBottomDelete(${row.id})">删除</span>
                </span>
            </div>
        </div>
        <!--表格_行 end-->
        </g:each>
    </div>
    <!--表格 end-->
</div>

<!--banner创建弹出框-->

<div class="alertBg0" id="shipBottomCreate" style="display:none;">
	<div class="adEdit">
	<form action="${request.contextPath}/advManage/saveShipBottom" method="post" id="dataFormCreate" enctype="multipart/form-data">
    	<div class="caption">ShipBottom创建<div onClick="shipBottomCreateHide()" class="close"></div></div>
        <ul class="editList">
        	<li>
            	<div class="clabel">Title：</div>
                <input id="createTitle" name="title" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">Alt：</div>
                <input id="createAlt" name="alt" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">链接：</div>
                <input id="createHref" name="href" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">到期时间</div>
                <div class="timesBg">
                    <input  id="createEndDate" name="endDate" class="box box83 datepicker" type="text" value="" />
                </div>
                
                <span class="red">到期时间必填！</span>
            </li>   	
            <li>
            	<div class="clabel"> 客户名称：</div>
                <input id="createCustom" name="customName" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">合同编号：</div>
                <input id="createContractNumber" name="contractNumber" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">业务员：</div>
                <input id="createSales" name="sales" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">顺序<span class="must red">*</span></div>
                <input id="createOrder" name="order" class="box box21" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">图片<span class="must red">*</span></div>
                <div class="right">
                	<%--<img id="createImage" name="image" class="image" src="" />
                	--%><input id="createFile" name="file" type="file" />
                </div>
            </li>
        </ul>
        </form>
        <div class="btmBtnsBg">
        	<div class="editBtn" onclick="createSubmit();">提交</div>
            <div class="editBtn" onClick="shipBottomCreateHide();">取消</div>
            <div class="editBtn" onClick="shipBottomCreateClear();">清空</div>
        </div>
    </div>
</div>


<!--banner创建弹出框 end-->




<!--广告修改弹出框-->

<div class="alertBg0" id="adEdit" style="display:none;">
	<div class="adEdit">
	<form action="${request.contextPath}/advManage/saveShipBottom" method="post" id="dataFormEdit" enctype="multipart/form-data">
    	<div class="caption">广告修改<div onClick="adEditHide()" class="close"></div></div>
        <ul class="editList">
        <input type="hidden" id="editId" name="id" value="" />
        	<li>
            	<div class="clabel">Title：</div>
                <input id="title" name="title" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">Alt：</div>
                <input id="alt" name="alt" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">链接：</div>
                <input id="href" name="href" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">到期时间</div>
                <div class="timesBg">
                    <input id="endDate" name="endDate" class="box box83 datepicker" type="text" value="" />
                </div>
                
                <span class="red">到期时间必填！</span>
            </li>   	
            <li>
            	<div class="clabel"> 客户名称：</div>
                <input id="customName" name="customName" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">合同编号：</div>
                <input id="contractNumber" name="contractNumber" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">业务员：</div>
                <input id="sales" name="sales" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">顺序<span class="must red">*</span></div>
                <input id="order" name="order" class="box box21" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">图片<span class="must red">*</span></div>
                <div class="right">
                	<img id="image" name="image" class="image" src="" />
                	<input id="file" name="file" type="file" />
                    <div class="imageOper">
                    	<span class="blue">删除</span>
                    </div>
                </div>
            </li>
        </ul>
        </form>
        <div class="btmBtnsBg">
        	<div class="editBtn" onclick="editSubmit();">提交</div>
            <div class="editBtn" onClick="adEditHide();">取消</div>
            <div class="editBtn" onClick="adEditClear();">清空</div>
        </div>
    </div>
</div>
<!--广告修改弹出框 end-->
</body>
</html>
