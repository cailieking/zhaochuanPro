<!DOCTYPE html>
<html>
<head>
<title>找船网后台管理_首页banner</title>
<meta name="layout" content="main">
<asset:javascript src="common.js" />
<asset:javascript src="index_banner.js" />
<asset:stylesheet src="common.css" />
<asset:stylesheet src="index_banner.css" />
</head>
<body>
<div class="child_content">
	<div class="child_top">
    	<div class="link blue">广告管理></div>
        <div class="link blue">一级页面></div>
        <div class="cur">首页banner</div>
    </div>
    <ul class="child_nav">
    	<li class="sel">首页Banner</li>
        <li>运价信息左侧</li>
        <li><a href="/advManage/shipBottom">运价信息底部</a></li>
        <li>货盘信息左侧</li>
        <li>货盘信息底部</li>
        <li>合作伙伴</li>
    </ul>
    <div class="child_oper">
    	<div class="left">
        	<button onClick="bannerMultDelete()">批量删除</button>
        </div>
        <div class="right">
        	<button onClick="bannerCreateShow()">创建</button>
        </div>
    </div>
    <!--表格-->
    <div class="child_table">
    	<div class="th">
        	<div class="td1 td"><span class="vertMidBg"><input class="checksAll" type="checkbox" /></span></div>
            <div class="td2 td">顺序</div>
            <div class="td3 td">图片</div>
            <div class="td4 td">属性</div>
            <div class="td5 td">操作</div>
        </div>
        <g:each in="${rows}" var="row" status="m">
        <!--表格_行-->
        <div class="tr">
        	<div class="td1 td"><span class="vertMidBg"><input data-id="${row.id}" class="check" type="checkbox" /></span></div>
            <div class="td2 td"><span class="vertMidBg">${row.order}</span></div>
            <div class="td3 td">
            	<img class="image" src="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/${row.image}" />
                <div class="image_look"><span onClick="imageLookClick($(this))" data-src="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/${row.image}" class="blue">查看原图</span></div>
            </div>
            <div class="td4 td">
            	<ul class="infoList">
                	<li class="w50">
                    	<div class="clabel">状态：</div>
                        <div class="txt" data-status="${row.state}">启用</div>
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
                        <div class="txt">${row.endDate}</div>
                    </li>
                    <li class="w100">
                    	<div class="clabel">Title：</div>
                        <div class="txt">${row.title}</div>
                    </li>
                    <li class="w100">
                    	<div class="clabel">Alt：</div>
                        <div class="txt">${row.alt}</div>
                    </li>
                    <li class="w100">
                    	<div class="clabel">链接：</div>
                        <div class="txt blue">${row.href}</div>
                    </li>
                </ul>
            </div>
            <div class="td5 td">
            	<span class="vertMidBg">
                	<span  onClick="bannerEditShow(${row.id})" class="operBtn">修改</span><br/>
                	<g:if test="${row.state==0}">
                    <span class="operBtn" onClick="bannerState(${row.id},1)">关闭</span><br/>
                    </g:if>
                    <g:else >
                    <span class="operBtn" onClick="bannerState(${row.id},2)">启动</span><br/>
                    </g:else>
                    <span class="operBtn" onClick="bannerDelete(${row.id})">删除</span>
                </span>
            </div>
        </div>
        <!--表格_行 end-->
        </g:each>
    </div>
    <!--表格 end-->
</div>

<!--banner创建弹出框-->
<form action="${request.contextPath}/imageInfo/save" method="post" id="dataFormCreat" enctype="multipart/form-data">
<div class="alertBg0" id="bannerCreate" style="display:none;">
	<div class="bannerEdit">
    	<div class="caption">Banner创建<div onClick="bannerCreateHide()" class="close"></div></div>
        <ul class="editList">
        	<li>
            	<div class="clabel">Title：</div>
                <input class="box box295" name="title" type="text" />
            </li>
            <li>
            	<div class="clabel">Alt：</div>
                <input class="box box295" name="alt" type="text" />
            </li>
            <li>
            	<div class="clabel">链接：</div>
                <input class="box box295" name="href" type="text" />
            </li>
            <li>
            	<div class="clabel">到期时间<span class="must red">*</span></div>
                <input name="endDate"   type="text" class="datepicker" id="createEndDate"/>
                <span class="red">到期时间为必填项！！！</span>
            </li>
            <li>
            	<div class="clabel">顺序<span class="must red">*</span></div>
                <input id="createOrder" class="box box21" name = "order" type="text" />
            </li>
            <li>
            	<div class="clabel">图片<span class="must red">*</span></div>
                <div class="right">
                	<input id="createFile" type="file" name="file" />
                    <p class="red fileInfo">
						• 图片格式：JPG,PNG<br/>
						  图片像素：1900pix*460pix<br/>
						  图片大小：不要超过500KB
                    </p>
                </div>
                <div class="right"  style="display:none;">
                	<img class="image" src="images/index_banner/index_banner1.jpg" />
                    <div class="imageOper">
                    	<span class="blue">删除</span>
                        <span onClick="imageLookClick($(this))" data-src="images/index_banner/index_banner1.jpg" class="blue">查看原图</span>
                    </div>
                </div>
            </li>
        </ul>
        </form>
        <div class="btmBtnsBg">
        	<div class="editBtn" onclick="createSubmit()">提交</div>
        	<div class="editBtn" onClick="bannerCreateHide()">取消</div>
        </div>
    </div>
</div>
<!--banner创建弹出框 end-->

<!--banner修改弹出框-->
<form action="${request.contextPath}/imageInfo/save" method="post" id="dataFormEdit" enctype="multipart/form-data">
<div class="alertBg0" id="bannerEdit" style="display:none;">
	<div class="bannerEdit">
    	<div class="caption">Banner修改<div onClick="bannerEditHide()" class="close"></div></div>
    	<input type="hidden" id="editId" name="id" value="" />
        <ul class="editList">
        	<li>
            	<div class="clabel">Title:</div>
                <input id="editTitle" name="title" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">Alt：</div>
                <input id="editAlt" name="alt" class="box box295" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">链接：</div>
                <input id="editHref"  name="href" class="box box295" type="text" value="" />
            </li>
            <li>
            
            	<div class="clabel">到期时间<span class="must red">*</span></div>
            	<input name="endDate"  id="editEndDate" type="text" class="datepicker" />
                <%--<input id="editEndDate" name="endDate" class="box box83" type="text" value="" />
                --%><span class="red">到期时间必填</span>
            </li>
            <li>
            	<div class="clabel">顺序<span class="must red">*</span></div>
                <input id="editOrder" name="order" class="box box21" type="text" value="" />
            </li>
            <li>
            	<div class="clabel">图片<span class="must red">*</span></div>
                <div class="right">
                	<img id="editImage" name="image" class="image" data-oss="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/" src="" />
                	<input id="editImageFile" type="file" name="file" />
                	<div class="imageOper">
                    	<span class="blue"  onClick="deleteOssImage()">删除</span>
                        <span id="editLookImage" onClick="imageLookClick($(this))" data-src="" class="blue">查看原图</span>
                    </div>
                    
                </div>
                <%--<div class="right"  style="display:none;">
                	<img id="" class="image" src="images/index_banner/index_banner1.jpg" />
                    
                </div>
            --%></li>
        </ul>
        </form>
        <div class="btmBtnsBg">
        <div class="editBtn" onclick="editSubmit();">提交</div>
        <div class="editBtn" onClick="bannerEditHide()">取消</div>
        <div class="editBtn" onClick="bannerEditClear()">清空</div>
        </div>
    </div>
</div>

<!--banner修改弹出框 end-->
</body>
</html>
