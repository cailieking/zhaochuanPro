$(function(){
	topTabClick();//顶部tab按钮点击
	manageHtmlChange(0);//管理子页面切换
})

//顶部tab按钮点击
function topTabClick(){
	$('.rightNav1 li').click(function(){
		var thisLi=$(this);
		var lis=$('.rightNav1 li');
		var index=lis.index(thisLi);
		lis.removeClass('sel');
		thisLi.addClass('sel');
		manageHtmlChange(index);
	})
}
//管理子页面切换
function manageHtmlChange(index){
	var html_label=
'<div class="rControlLine" style="position:relative;">'+
	'<div class="txt1">标签列表：</div>'+
	'<div class="btnR btnMod1" onClick="addLabelShow()">添加</div>'+
'</div>'+
'<table class="im_table" style="width:1000px;">'+
'</table>'+
'<div class="rControlLine" style="position:relative;padding-top:10px;">'+
	'<div class="modTishiBg labelTishi">'+
		'<div class="modTishiTxt">当有用户设定为某标签，该标签不能被删除</div>'+
	'</div>'+
	'<div class="im_pageBg"></div>'+
'</div>';

	var html_need=
'<div class="rControlLine" style="position:relative;">'+
	'<div class="txt1">需求列表：</div>'+
	'<div class="btnR btnMod1" onClick="addNeedShow()">添加</div>'+
'</div>'+
'<table class="im_table" style="width:1000px;">'+
'</table>'+
'<div class="rControlLine" style="position:relative;padding-top:10px;">'+
	'<div class="modTishiBg labelTishi">'+
		'<div class="modTishiTxt">当有用户设定为某需求，该需求不能被删除</div>'+
	'</div>'+
	'<div class="im_pageBg"></div>'+
'</div>';

	var html_type=
'<div class="rControlLine" style="position:relative;">'+
	'<div class="txt1">类型列表：</div>'+
	'<div class="btnR btnMod1" onClick="addTypeShow()">添加</div>'+
'</div>'+
'<table class="im_table" style="width:1000px;">'+
'</table>'+
'<div class="rControlLine" style="position:relative;padding-top:10px;">'+
	'<div class="modTishiBg labelTishi">'+
		'<div class="modTishiTxt">当有用户设定为某类型，该类型不能被删除</div>'+
	'</div>'+
	'<div class="im_pageBg"></div>'+
'</div>';

	var html_group=
'<div class="rControlLine" style="position:relative;">'+
	'<div class="txt1">群组列表：</div>'+
	'<div class="btnR btnMod1" onClick="addGroupShow()">添加</div>'+
'</div>'+
'<table class="im_table" style="width:1000px;">'+
	'<thead>'+
		'<tr>'+
			'<th width="60">序号</th>'+
			'<th width="120">群组名称</th>'+
			'<th width="120">客户数</th>'+
			'<th width="540">描述</th>'+
			'<th width="160">操作</th>'+
		'</tr>'+
	'</thead>'+
	'<tr style="height:10px;border:0;"></tr>'+
	'<tbody>'+
		'<tr>'+
			'<td>1</td>'+
			'<td>拼箱客户</td>'+
			'<td>20</td>'+
			'<td>有拼箱需求的用户</td>'+
			'<td>'+
				'<div class="operBtn edit" onClick="editGroupShow()"></div>'+
				'<div class="operBtn delete"></div>'+
			'</td>'+
		'</tr>'+
		'<tr>'+
			'<td>2</td>'+
			'<td>工厂直客</td>'+
			'<td>20</td>'+
			'<td>华南区域的工厂</td>'+
			'<td>'+
				'<div class="operBtn edit" onClick="editGroupShow()"></div>'+
				'<div class="operBtn delete"></div>'+
			'</td>'+
		'</tr>'+
	'</tbody>'+
'</table>'+
'<div class="rControlLine" style="position:relative;padding-top:10px;">'+
	'<div class="modTishiBg labelTishi">'+
		'<div class="modTishiTxt">当有用户设定为某群组，该群组不能被删除</div>'+
	'</div>'+
	'<div class="im_pageBg"></div>'+
'</div>';
	
	switch(parseInt(index)){
		case 0:{//标签
			$('.inpuiry_manage').html(html_label);
			var total;
			var pageNum = 1
			$.post("/clientAttrManager/getTags",{offset:0,limit:10},function(data){
				console.log(data)
				total = data.total % 10 > 0 ? Math.floor(data.total / 10) + 1 :  data.total / 10
				$(".im_table").empty()
				var tb = '<thead>'+
					'<tr>'+
					'<th width="60">序号<input type="hidden" value=0 /></th>'+
					'<th width="120">标签</th>'+
					'<th width="120">客户数</th>'+
					'<th width="540">描述</th>'+
					'<th width="160">操作</th>'+
					'</tr>'+
					'</thead>'+
					'<tr style="height:10px;border:0;"></tr>'
				for(var i in data.rows){
					var sequence = 10*(pageNum-1)+(parseInt(i)+parseInt(1))
					tb += '<tbody><tr>'+
							'<td>'+sequence+'</td>'+
							'<td><div class="labelDiv" style="background:'+data.rows[i].tagName+';"></div></td>'+
					        '<td>'+data.rows[i].customerCount+'</td>'+
					        '<td>'+data.rows[i].description+'</td>'+
					   '<td>'+
						   '<div class="operBtn edit" onClick="editLabelShow('+data.rows[i].id+',event)"></div>'+
						   '<div class="operBtn delete" onClick="deleteTag('+data.rows[i].id+',event)"></div>'+
					   '</td>'+
				    '</tr>'
				}
				tb+='</tbody>'
				$(".im_table").append(tb)
				//init(data)
				setCommonPage2Event($('.im_pageBg'),11,function(num){//初始化翻页控件 common.js中定义
				var currentPage = (num-1)*total
				$.post("/clientAttrManager/getTags",{offset:currentPage,limit:10},function(data){
					//init(data)
					})
				//zcAlert(num+'页');
				})
			})
			
		}
		break;
		case 1:{//需求
			$('.inpuiry_manage').html(html_need);
			var total;
			var pageNum = 1
			$.post("/clientAttrManager/getDemands",{offset:0,limit:10},function(data){
				console.log(data)
				total = data.total % 10 > 0 ? Math.floor(data.total / 10) + 1 :  data.total / 10
				$(".im_table").empty()
				var tb = '<thead>'+
				'<tr>'+
					'<th width="60">序号<input type="hidden" value=1 /></th>'+
					'<th width="460">需求</th>'+
					'<th width="260">客户数</th>'+
					'<th width="220">操作</th>'+
				'</tr>'+
				'</thead>'+
				'<tr style="height:10px;border:0;"></tr>'
				for(var i in data.rows){
					var sequence = 10*(pageNum-1)+(parseInt(i)+parseInt(1))
					tb += '<tbody><tr>'+
							'<td>'+sequence+'</td>'+
							'<td>'+data.rows[i].demandName+'</td>'+
					        '<td>'+data.rows[i].customerCount+'</td>'+
					   '<td>'+
						   '<div class="operBtn edit" onClick="editNeedShow('+data.rows[i].id+',event)"></div>'+
						   '<div class="operBtn delete" onClick="deleteDemand('+data.rows[i].id+',event)"></div>'+
					   '</td>'+
				    '</tr>'
				}
				tb+='</tbody>'
				$(".im_table").append(tb)
				//init(data)
				setCommonPage2Event($('.im_pageBg'),total,function(num){//初始化翻页控件 common.js中定义
				var currentPage = (num-1)*total
				$.post("/clientAttrManager/getDemands",{offset:currentPage,limit:10},function(data){
					//init(data)
					})
				//zcAlert(num+'页');
				})
			})
			
//			setCommonPage2Event($('.im_pageBg'),11,function(num){//初始化翻页控件 common.js中定义
//				zcAlert(num+'页');
//			})
		}
		break;
		case 2:{//类型
			$('.inpuiry_manage').html(html_type);
			var total;
			var pageNum = 1
			$.post("/clientAttrManager/getClientTypes",{offset:0,limit:10},function(data){
				total = data.total % 10 > 0 ? Math.floor(data.total / 10) + 1 :  data.total / 10
				$(".im_table").empty()
				var tb = '<thead>'+
				'<tr>'+
					'<th width="60">序号<input type="hidden" value=2 /></th>'+
					'<th width="460">类型</th>'+
					'<th width="260">客户数</th>'+
					'<th width="220">操作</th>'+
				'</tr>'+
				'</thead>'+
				'<tr style="height:10px;border:0;"></tr>'
				for(var i in data.rows){
					var sequence = 10*(pageNum-1)+(parseInt(i)+parseInt(1))
					tb += '<tbody><tr>'+
							'<td>'+sequence+'</td>'+
							'<td>'+data.rows[i].typeName+'</td>'+
					        '<td>'+data.rows[i].customerCount+'</td>'+
					   '<td>'+
						   '<div class="operBtn edit" onClick="editTypeShow('+data.rows[i].id+',event)"></div>'+
						   '<div class="operBtn delete" onClick="deleteType('+data.rows[i].id+',event)"></div>'+
					   '</td>'+
				    '</tr>'
				}
				tb+='</tbody>'
				$(".im_table").append(tb)
				//init(data)
				setCommonPage2Event($('.im_pageBg'),total,function(num){//初始化翻页控件 common.js中定义
					var currentPage = (num-1)*total
					$.post("/clientAttrManager/getClientTypes",{offset:currentPage,limit:10},function(data){
					//init(data)
						})
				//zcAlert(num+'页');
					})
				})
			
//			setCommonPage2Event($('.im_pageBg'),11,function(num){//初始化翻页控件 common.js中定义
//				zcAlert(num+'页');
//			})
		}
		break;
		case 3:{//群组
			$('.inpuiry_manage').html(html_group);
			var total;
			var pageNum = 1
			$.post("/clientAttrManager/getGroups",{offset:0,limit:10},function(data){
				total = data.total % 10 > 0 ? Math.floor(data.total / 10) + 1 :  data.total / 10
				$(".im_table").empty()
				var tb = '<thead>'+
				'<tr>'+
					'<th width="60">序号<input type="hidden" value=3 /></th>'+
					'<th width="120">群组名称</th>'+
					'<th width="120">客户数</th>'+
					'<th width="540">描述</th>'+
					'<th width="160">操作</th>'+
				'</tr>'+
				'</thead>'+
				'<tr style="height:10px;border:0;"></tr>'
				for(var i in data.rows){
					var sequence = 10*(pageNum-1)+(parseInt(i)+parseInt(1))
					tb += '<tbody><tr>'+
							'<td>'+sequence+'</td>'+
							'<td>'+data.rows[i].groupName+'</td>'+
					        '<td>'+data.rows[i].customerCount+'</td>'+
					        '<td>'+data.rows[i].description+'</td>'+
					   '<td>'+
						   '<div class="operBtn edit" onClick="editGroupShow('+data.rows[i].id+',event)"></div>'+
						   '<div class="operBtn delete" onClick="deleteGroup('+data.rows[i].id+',event)"></div>'+
					   '</td>'+
				    '</tr>'
				}
				tb+='</tbody>'
				$(".im_table").append(tb)
				//init(data)
				setCommonPage2Event($('.im_pageBg'),total,function(num){//初始化翻页控件 common.js中定义
					var currentPage = (num-1)*total
					$.post("/clientAttrManager/getGroups",{offset:currentPage,limit:10},function(data){
					//init(data)
						})
				//zcAlert(num+'页');
					})
				})
//			setCommonPage2Event($('.im_pageBg'),11,function(num){//初始化翻页控件 common.js中定义
//				zcAlert(num+'页');
//			})
		}
		break;
		default:{
			console.log(index)
		}
		break;
	}
}
function deleteTag(id,e){
	var index = $("input[type=hidden]").val()
	zcConfirm('是否删除该标签',function(r){
		if(r){
			if($(e.target).parents("tr").find("td").eq(2).text() == 0){
				$.post("/clientAttrManager/delTag?id="+id,function(data){
					if(data == "true"){
						manageHtmlChange(index)
						zcAlert('删除成功');
					}else{
						zcAlert('删除失败');
					}
				})
			}else{
				zcAlert('该标签下已有客户，不可删除');
				
			}
		}
	});
}

function deleteDemand(id,e){
	var index = $("input[type=hidden]").val()
	zcConfirm('是否删除该标签',function(r){
		if(r){
			if($(e.target).parents("tr").find("td").eq(2).text() == 0){
				$.post("/clientAttrManager/delDemand?id="+id,function(data){
					if(data == "true"){
						manageHtmlChange(index)
						zcAlert('删除成功');
					}else{
						zcAlert('删除失败');
					}
				})
			}else{
				zcAlert('该标业务需求已有客户，不可删除');
				
			}
		}
	});
}

function deleteType(id,e){
	var index = $("input[type=hidden]").val()
	zcConfirm('是否删除该标签',function(r){
		if(r){
			if($(e.target).parents("tr").find("td").eq(2).text() == 0){
				$.post("/clientAttrManager/delClientType?id="+id,function(data){
					if(data == "true"){
						manageHtmlChange(index)
						zcAlert('删除成功');
					}else{
						zcAlert('删除失败');
					}
				})
			}else{
				zcAlert('该客户类型下已有客户，不可删除');
				
			}
		}
	});
}

function deleteGroup(id,e){
	var index = $("input[type=hidden]").val()
	zcConfirm('是否删除该标签',function(r){
		if(r){
			if($(e.target).parents("tr").find("td").eq(2).text() == 0){
				$.post("/clientAttrManager/delGroup?id="+id,function(data){
					if(data == "true"){
						manageHtmlChange(index)
						zcAlert('删除成功');
					}else{
						zcAlert('删除失败');
					}
				})
			}else{
				zcAlert('该群组下已有客户，不可删除');
				
			}
		}
	});
}


//添加标签
function addLabelShow(){
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addLabelDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">添加标签</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
			'<div class="tishi2 modTishiBg">'+
				'<div class="modTishiTxt">带“*”号为必填项；</div>'+
				'<div class="modTishiTxt">提供9种颜色供选择；</div>'+
				'<div class="modTishiTxt">描述最多支持20个汉字。</div>'+
			'</div>'+
        	'<li>'+
            	'<div class="wLabel">标签颜色：<div class="imp">*</div></div>'+
                '<div id="addLabel" class="guestLabel">'+
                    '<span>选择标签颜色</span>'+
                    '<ul class="guestLabelList">'+
                        '<li></li><li></li><li></li>'+
                        '<li></li><li></li><li></li>'+
                        '<li></li><li></li><li></li>'+
                    '</ul>'+
                '</div>'+
            '</li>'+
			'<li>'+
            	'<div class="wLabel">描述：<div class="imp">*</div></div>'+
                '<textarea class="area1" style="width:188px;" id="description" />'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div id="addLabelNoBtn" class="btnMod1">取消</div>'+
                    '<div id="addLabelYesBtn" class="btnMod1">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.addLabelDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	initGuestLabel($('#addLabel'),guest_label_color,'transparent');//初始化用户颜色标签控
	//取消
	$('#addLabelNoBtn').on('click',function(){
		$('.addLabelDlg .closeBtn').trigger('click')
	});
	//确定
	$('#addLabelYesBtn').click(function(){
		var index = $("input[type=hidden]").val()
		var tagName = $("#addLabel").css("background-color")
		var description = $(this).parents().find("textarea").val()
		
		$.post("/clientAttrManager/saveTag",{tagName:tagName,description,description},function(data){
			if(data == "true"){
				$('.addLabelDlg .closeBtn').trigger('click')
				zcAlert("保存成功");
				manageHtmlChange(index)
			}else{
				zcAlert("保存失败");
			}
		})
	})
}
//编辑标签
function editLabelShow(id,e){
	var pTr = $(e.target).parents("tr")
	var tag = pTr.find("td").eq(1).find("div").css("background-color")
	var description = pTr.find("td").eq(3).text()
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addLabelDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">编辑标签</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
			'<div class="tishi2 modTishiBg">'+
				'<div class="modTishiTxt">带“*”号为必填项；</div>'+
				'<div class="modTishiTxt">提供9种颜色供选择；</div>'+
				'<div class="modTishiTxt">描述最多支持20个汉字。</div>'+
			'</div>'+
        	'<li>'+
            	'<div class="wLabel">标签颜色：<div class="imp">*</div></div>'+
                '<div id="addLabel" class="guestLabel" style="background-color:'+tag+'">'+
                    '<span>选择标签颜色</span>'+
                    '<ul class="guestLabelList">'+
                        '<li></li><li></li><li></li>'+
                        '<li></li><li></li><li></li>'+
                        '<li></li><li></li><li></li>'+
                    '</ul>'+
                '</div>'+
            '</li>'+
			'<li>'+
            	'<div class="wLabel">描述：<div class="imp">*</div></div>'+
                '<textarea class="area1" style="width:188px;" >'+description+'</textarea>'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div id="addLabelNoBtn" class="btnMod1">取消</div>'+
                    '<div id="addLabelYesBtn" class="btnMod1">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.addLabelDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	initGuestLabel($('#addLabel'),guest_label_color,tag);//初始化用户颜色标签控
	//取消
	$('#addLabelNoBtn').on('click',function(){
		$('.addLabelDlg .closeBtn').trigger('click')
	});
	//确定
	$('#addLabelYesBtn').click(function(){
		var index = $("input[type=hidden]").val()
		var tagName = $("#addLabel").css("background-color")
		var description = $(this).parents().find("textarea").val()
		$.post("/clientAttrManager/saveTag",{id:id,tagName:tagName,description,description},function(data){
			if(data == "true"){
				$('.addLabelDlg .closeBtn').trigger('click')
				zcAlert("保存成功");
				manageHtmlChange(index)
			}else{
				zcAlert("保存失败");
			}
		})
	})
}

//添加业务需求
function addNeedShow(){
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addNeedDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">添加业务需求</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
			'<div class="tishi2 modTishiBg">'+
				'<div class="modTishiTxt">带“*”号为必填项；</div>'+
				'<div class="modTishiTxt">名称最多支持10个汉字。</div>'+
			'</div>'+
        	'<li>'+
            	'<div class="wLabel">需求名称：<div class="imp">*</div></div>'+
                '<input type="text" class="box1" />'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div id="addNeedNoBtn" class="btnMod1">取消</div>'+
                    '<div id="addNeedYesBtn" class="btnMod1">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.addNeedDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	//取消
	$('#addNeedNoBtn').on('click',function(){
		$('.addNeedDlg .closeBtn').trigger('click')
	});
	//确定
	$('#addNeedYesBtn').click(function(){
		var index = $("input[type=hidden]").val()
		//var tagName = $("#addLabel").css("background-color")
		var demandName = $(this).parents("ul").find("input").val()
		
		$.post("/clientAttrManager/saveDemand",{demandName:demandName},function(data){
			if(data == "true"){
				$('.addNeedDlg .closeBtn').trigger('click')
				zcAlert("保存成功");
				manageHtmlChange(index)
			}else{
				zcAlert("保存失败");
			}
		})
	})
}
//编辑业务需求
function editNeedShow(id,e){
	var demandName = $(e.target).parents("tr").find("td").eq(1).text()
	
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addNeedDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">编辑业务需求</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
			'<div class="tishi2 modTishiBg">'+
				'<div class="modTishiTxt">带“*”号为必填项；</div>'+
				'<div class="modTishiTxt">名称最多支持10个汉字。</div>'+
			'</div>'+
        	'<li>'+
            	'<div class="wLabel">需求名称：<div class="imp">*</div></div>'+
                '<input type="text" class="box1" value="'+demandName+'"/>'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div id="addNeedNoBtn" class="btnMod1">取消</div>'+
                    '<div id="addNeedYesBtn" class="btnMod1">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.addNeedDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	//取消
	$('#addNeedNoBtn').on('click',function(){
		$('.addNeedDlg .closeBtn').trigger('click')
	});
	//确定
	$('#addNeedYesBtn').click(function(){
		var index = $("input[type=hidden]").val()
		var demandName = $(this).parents("ul").find("input").val()
		$.post("/clientAttrManager/saveDemand",{id:id,demandName:demandName},function(data){
			if(data == "true"){
				$('.addNeedDlg .closeBtn').trigger('click')
				zcAlert("保存成功");
				manageHtmlChange(index)
			}else{
				zcAlert("保存失败");
			}
		})
	})
}


//添加类型
function addTypeShow(){
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addTypeDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">添加类型</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
			'<div class="tishi2 modTishiBg">'+
				'<div class="modTishiTxt">带“*”号为必填项；</div>'+
				'<div class="modTishiTxt">名称最多支持10个汉字。</div>'+
			'</div>'+
        	'<li>'+
            	'<div class="wLabel">类型名称：<div class="imp">*</div></div>'+
                '<input type="text" class="box1" />'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div id="addTypeNoBtn" class="btnMod1">取消</div>'+
                    '<div id="addTypeYesBtn" class="btnMod1">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.addTypeDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	//取消
	$('#addTypeNoBtn').on('click',function(){
		$('.addTypeDlg .closeBtn').trigger('click')
	});
	//确定
	$('#addTypeYesBtn').click(function(){
		var index = $("input[type=hidden]").val()
		//var tagName = $("#addLabel").css("background-color")
		var typeName = $(this).parents("ul").find("input").val()
		
		$.post("/clientAttrManager/saveClientType",{typeName:typeName},function(data){
			if(data == "true"){
				$('.addTypeDlg .closeBtn').trigger('click')
				zcAlert("保存成功");
				manageHtmlChange(index)
			}else{
				zcAlert("保存失败");
			}
		})
	})
}
//编辑类型
function editTypeShow(id,e){
	var typeName = $(e.target).parents("tr").find("td").eq(1).text()
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addTypeDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">编辑类型</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
			'<div class="tishi2 modTishiBg">'+
				'<div class="modTishiTxt">带“*”号为必填项；</div>'+
				'<div class="modTishiTxt">名称最多支持10个汉字。</div>'+
			'</div>'+
        	'<li>'+
            	'<div class="wLabel">类型名称：<div class="imp">*</div></div>'+
                '<input type="text" class="box1" value="'+typeName+'"/>'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div id="addTypeNoBtn" class="btnMod1">取消</div>'+
                    '<div id="addTypeYesBtn" class="btnMod1">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.addTypeDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	//取消
	$('#addTypeNoBtn').on('click',function(){
		$('.addTypeDlg .closeBtn').trigger('click')
	});
	//确定
	$('#addTypeYesBtn').click(function(){
		var index = $("input[type=hidden]").val()
		var typeName = $(this).parents("ul").find("input").val()
		$.post("/clientAttrManager/saveClientType",{id:id,typeName:typeName},function(data){
			if(data == "true"){
				$('.addTypeDlg .closeBtn').trigger('click')
				zcAlert("保存成功");
				manageHtmlChange(index)
			}else{
				zcAlert("保存失败");
			}
		})
	})
}



//添加群组
function addGroupShow(){
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addGroupDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">添加群组</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
			'<div class="tishi2 modTishiBg">'+
				'<div class="modTishiTxt">带“*”号为必填项；</div>'+
				'<div class="modTishiTxt">群组名称建议3~8个汉字，最多支持10个汉字；</div>'+
				'<div class="modTishiTxt">描述最多支持20个汉字。</div>'+
			'</div>'+
        	'<li>'+
            	'<div class="wLabel">群组名称：<div class="imp">*</div></div>'+
                '<input type="text" class="box1" />'+
            '</li>'+
			'<li>'+
            	'<div class="wLabel">描述：<div class="imp">*</div></div>'+
                '<textarea class="area1" style="width:200px;"></textarea>'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div id="addGroupNoBtn" class="btnMod1">取消</div>'+
                    '<div id="addGroupYesBtn" class="btnMod1">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.addGroupDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	//取消
	$('#addGroupNoBtn').on('click',function(){
		$('.addGroupDlg .closeBtn').trigger('click')
	});
	//确定
	$('#addGroupYesBtn').click(function(){
		var index = $("input[type=hidden]").val()
		//var tagName = $("#addLabel").css("background-color")
		var groupName = $(this).parents("ul").find("input").val()
		var description = $(this).parents().find("textarea").val()
		$.post("/clientAttrManager/saveGroup",{groupName:groupName,description:description},function(data){
			if(data == "true"){
				$('.addGroupDlg .closeBtn').trigger('click')
				zcAlert("保存成功");
				manageHtmlChange(index)
			}else{
				zcAlert("保存失败");
			}
		})
	})
}
//编辑群组
function editGroupShow(id,e){
	var groupName = $(e.target).parents("tr").find("td").eq(1).text()
	var description = $(e.target).parents("tr").find("td").eq(3).text()
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod addGroupDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">编辑群组</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
			'<div class="tishi2 modTishiBg">'+
				'<div class="modTishiTxt">带“*”号为必填项；</div>'+
				'<div class="modTishiTxt">群组名称建议3~8个汉字，最多支持10个汉字；</div>'+
				'<div class="modTishiTxt">描述最多支持20个汉字。</div>'+
			'</div>'+
        	'<li>'+
            	'<div class="wLabel">群组名称：<div class="imp">*</div></div>'+
                '<input type="text" class="box1" value="'+groupName+'"/>'+
            '</li>'+
			'<li>'+
            	'<div class="wLabel">描述：<div class="imp">*</div></div>'+
                '<textarea class="area1" style="width:200px;">'+description+'</textarea>'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div id="addGroupNoBtn" class="btnMod1">取消</div>'+
                    '<div id="addGroupYesBtn" class="btnMod1">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	modDlgEvent($('.addGroupDlg'));//自制弹出框公用事件 居中_拖拽_关闭
	//取消
	$('#addGroupNoBtn').on('click',function(){
		$('.addGroupDlg .closeBtn').trigger('click')
	});
	//确定
	$('#addGroupYesBtn').click(function(){
		var index = $("input[type=hidden]").val()
		var groupName = $(this).parents("ul").find("input").val()
		var description = $(this).parents().find("textarea").val()
		$.post("/clientAttrManager/saveGroup",{id:id,groupName:groupName,description:description},function(data){
			if(data == "true"){
				$('.addGroupDlg .closeBtn').trigger('click')
				zcAlert("保存成功");
				manageHtmlChange(index)
			}else{
				zcAlert("保存失败");
			}
		})
	})
}