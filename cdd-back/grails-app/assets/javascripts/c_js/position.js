var pfMenu={
	rootDiv:{},
	treeData:[],
	createRoot:function(data){
		var type='';
		if(data.type){
			type=data.type;
		}
		var doHtml=
		'<div class="pfRow">'+
			'<div class="pfGrid" id="'+data.id+'">'+
				'<div class="bLine"></div>'+
				'<div class="pfTextBg"><div class="pfText '+type+'">'+data.name+'</div></div>'+
			'</div>'+
		'<div>';
		this.rootDiv.html(doHtml);
	},
	addChildNodes:function(pNode,data){
		var minW=90*data.length;
		var nodeEle=$('#'+pNode.id)
		nodeEle.css('min-width',minW+'px');
		var doHtml='<div class="pfRow">';
		for(var i=0;i<data.length;i++){
			//格子样式处理
			var type='';
			if(data[i].type){
				type=data[i].type;
			}
			//格子样式处理 end
			//顶部横线处理
			var hLine='';
			if(data.length>1){
				if(i==0){
					hLine='<div class="hLine_l"></div>';
				}else if(i==data.length-1){
					hLine='<div class="hLine_r"></div>';
				}else{
					hLine='<div class="hLine_m"></div>';
				}
			}
			//顶部横线处理 end
			//底部竖线处理
			var bLine='';
			if(this.getChildNodes(data[i].id).length>0){
				bLine='<div class="bLine"></div>';
			}
			//底部竖线处理end
			doHtml+=
				'<div class="pfGrid" id="'+data[i].id+'">'+
					'<div class="tLine"></div>'+
					hLine+
					bLine+
					'<div class="pfTextBg"><div class="pfText '+type+'">'+data[i].name+'</div></div>'+
				'</div>';
		}
		doHtml+='<div>'
		nodeEle.append($(doHtml));
	},
	getRootNode:function(){
		var root={};
		for(var i=0;i<this.treeData.length;i++){
			if(this.treeData[i].pId==''||this.treeData[i].pId==null||this.treeData[i].pId==0){
				root=this.treeData[i];
			}
		}
		return root;
	},
	getChildNodes:function(id){
		var childNodes=[];
		for(var i=0;i<this.treeData.length;i++){
			if(this.treeData[i].pId==id){
				childNodes.push(this.treeData[i]);
			}
		}
		return childNodes;
	},
	getAllChildNodes:function(data){
		var nodes=[];
		for(var i=0;i<data.length;i++){
			for(var j=0;j<this.treeData.length;j++){
				if(this.treeData[j].pId==data[i].id){
					nodes.push(this.treeData[j]);
				}
			}
		}
		return nodes;
	},
	initTree:function(root,data){
		this.rootDiv=root;
		this.treeData=data;
		this.createRoot(this.getRootNode());
		var lastNodes=[];
		lastNodes[0]=this.getRootNode();
		while(this.getAllChildNodes(lastNodes).length>0){
			var allChilds=[];
			for(var i=0;i<lastNodes.length;i++){
				var childNode=this.getChildNodes(lastNodes[i].id);
				if(childNode.length>0){
					this.addChildNodes(lastNodes[i],childNode);
					for(var j=0;j<childNode.length;j++){
						allChilds.push(childNode[j]);
					}
				}
			}
			lastNodes=allChilds;
		}
	}
};

var tree_node = []

var click_el
var pageCount = 10 
function initPosition(){
	$.post("/position/initPosition",function(data){
		
		
		
		var p_html = '<tr>'+
                	'<th width="29"></th>'+
                	'<th width="204">职位名称</th>'+
                    '<th width="103">人数</th>'+
                '</tr>'
        nodes = data
		tDatas = []
		
		
		for(var i in nodes){
			var treeData = new Object()
			var node = $.extend(true, {}, nodes[i]);
			initTreeData(node,treeData)
		}
		
		var pageTotal = data.length % pageCount> 0 ? Math.floor(data.length / pageCount) + 1 :  data.length / pageCount
		
		for(var i=0, l=pageCount; i<pageCount; i++){
					
					
					p_html +=  '<tr><td><input type="checkbox" value="'+nodes[i].id+'"/></td>'+
		            '<td><span class="professionname">'+nodes[i].name+'</span><input type="hidden" value="'+nodes[i].pId+'" /></td>'+
		            '<td>'+nodes[i].uLength+'</td></tr>'
					
		}		
		setCommonPage2Event($('.wm_profession_page'),pageTotal,function(num){//初始化翻页控件 common.js中定义
			//for(var i in data){
				//treeData.name = data[i].name
				//treeData.data = []
			 p_html = '<tr>'+
         		'<th width="29"></th>'+
         		'<th width="204">职位名称</th>'+
         		'<th width="103">人数</th>'+
         		'</tr>'
				for(var i=0+(num-1)*10, l=pageCount; i<pageCount+(num-1)*10; i++){
					var treeData = new Object()
					if(nodes[i] != undefined){
						//initTreeData(tree_node[i],treeData)
						p_html +=  '<tr><td><input type="checkbox" value="'+nodes[i].id+'"/></td>'+
			            '<td><span class="professionname">'+nodes[i].name+'</span><input type="hidden" value="'+nodes[i].pId+'" /></td>'+
			            '<td>'+nodes[i].uLength+'</td></tr>'
					}
					
				}
			 $("#professionList").empty()
			 $("#professionList").append(p_html);
			//}
		})
		$("#professionList").empty()
		$("#professionList").append(p_html);
		
		function initTreeData(node,treeData){
			if(treeData.name == null && treeData.data == null){
				treeData.name = node.name
				treeData.data = []
			}
			if(node.type == null){
					node.type = "cur"
				} 
				treeData.data.push(node)
					for(var j in nodes){
						if(nodes[j].id == node.pId){
							var pNode = $.extend(true, {}, nodes[j]);
							pNode.type = "last"
							initParentDate(pNode,treeData)
						}if(nodes[j].pId == node.id){
							var cNode = $.extend(true, {}, nodes[j]);
							initChildData(cNode,treeData)
						}
					}
					tDatas.push(treeData)
		}
		
		function initChildData(node,treeData){
				treeData.data.push(node)
				for(var k in nodes){
					if(nodes[k].pId == node.id){
						var cNode = $.extend(true, {}, nodes[k]);
						initChildData(cNode,treeData)
					
				}
			}
		}
		
		function initParentDate(node,treeData){
			treeData.data.push(node)
			for(var k in nodes){
				if(nodes[k].id == node.pId){
					var pNode = $.extend(true, {}, nodes[k]);
					pNode.type = "last"
					initParentDate(pNode,treeData)
				
			}
		}
	}
		
		
		$('body').on('click','.professionname',function(){
			var txt=$(this).html();
			$(".caption").text(txt)
			click_el = $(this)
			var data;
			for(var k in tDatas){
				if(tDatas[k].name == txt){
					pfMenu.initTree($('.pfTreeBg'),tDatas[k].data);
				}
			}
			
		})
		
		
			
//			switch(txt){
//				case "CEO":{
//					data=[
//						{id:'1',pId:'',name:"CEO",type:"cur"},
//						{id:'11',pId:'1',name:"VP"},
//						{id:'12',pId:'1',name:"副总经理"},
//						{id:'13',pId:'1',name:"产品总监"},
//						{id:'14',pId:'1',name:"运营总监"},
//						{id:'111',pId:'11',name:"商务总监"},
//						{id:'112',pId:'11',name:"交易总监"},
//						{id:'113',pId:'11',name:"客服主管"},
//						{id:'141',pId:'14',name:"运营主管"},
//						{id:'1111',pId:'111',name:"商务主管"},
//						{id:'1121',pId:'112',name:"交易专员"},
//						{id:'1131',pId:'113',name:"客服专员"},
//						{id:'1411',pId:'141',name:"运营专员"},
//						{id:'11111',pId:'1111',name:"商务专员"},
//					];
//				}
//				break;
//				case "VP":{
//					data=[
//						{id:'1',pId:'',name:"CEO",type:"last"},
//						{id:'11',pId:'1',name:"VP",type:"cur"},
//						{id:'111',pId:'11',name:"商务总监"},
//						{id:'112',pId:'11',name:"交易总监"},
//						{id:'113',pId:'11',name:"客服主管"},
//						{id:'1111',pId:'111',name:"商务主管"},
//						{id:'1121',pId:'112',name:"交易专员"},
//						{id:'1131',pId:'113',name:"客服专员"},
//						{id:'11111',pId:'1111',name:"商务专员"},
//					];
//				}
//				break;
//				case "运营总监":{
//					data=[
//						{id:'1',pId:'',name:"CEO",type:"last"},
//						{id:'14',pId:'1',name:"运营总监",type:"cur"},
//						{id:'141',pId:'14',name:"运营主管"},
//						{id:'1411',pId:'141',name:"运营专员"},
//					];
//				}
//				break;
//				case "运营主管":{
//					data=[
//						{id:'1',pId:'',name:"CEO",type:"last"},
//						{id:'14',pId:'1',name:"运营总监",type:"last"},
//						{id:'141',pId:'14',name:"运营主管",type:"cur"},
//						{id:'1411',pId:'141',name:"运营专员"},
//					];
//				}
//				break;
//				case "运营专员":{
//					data=[
//						{id:'1',pId:'',name:"CEO",type:"last"},
//						{id:'14',pId:'1',name:"运营总监",type:"last"},
//						{id:'141',pId:'14',name:"运营主管",type:"last"},
//						{id:'1411',pId:'141',name:"运营专员",type:"cur"},
//					];
//				}
//				break;
//				case "商务专员":{
//					data=[
//						{id:'1',pId:'',name:"CEO",type:"last"},
//						{id:'11',pId:'1',name:"VP",type:"last"},
//						{id:'111',pId:'11',name:"商务总监",type:"last"},
//						{id:'1111',pId:'111',name:"商务主管",type:"last"},
//						{id:'11111',pId:'1111',name:"商务专员",type:"cur"},
//					];
//				}
//				break;
//			}
			//pfMenu.initTree($('.pfTreeBg'),data);
//		$('.professionname').on('click',function(){
//			var txt=$(this).html();
//			$(".caption").text(txt)
//			click_el = $(this)
//			var data;
//			for(var k in tDatas){
//				if(tDatas[k].name == txt){
//					pfMenu.initTree($('.pfTreeBg'),tDatas[k].data);
//				}
//			}
//		})
		$('.professionname ').eq(0).trigger("click") 
	})
	
	
}
var nodes;
tDatas = []
//var treeData = {
//		name:"",
//		data:[]
//	}
$(function(){
	
	initPosition()
	
});
/*
<div class="pfRow">
	<div class="pfGrid">
		<div class="pfTextBg"><div class="pfText cur">CEO</div></div>
		<div class="pfRow">
			<div class="pfGrid" style="min-width:270px;">
				<div class="pfTextBg"><div class="pfText">VP</div></div>
				<div class="pfRow">
					<div class="pfGrid">
						<div class="pfTextBg"><div class="pfText">商务总监</div></div>
						<div class="pfRow">
							<div class="pfGrid" style="min-width:180px;">
								<div class="pfTextBg"><div class="pfText">商务主管</div></div>
								<div class="pfRow">
									<div class="pfGrid">
										<div class="pfTextBg"><div class="pfText">商务专员1</div></div>
									</div>
									<div class="pfGrid">
										<div class="pfTextBg"><div class="pfText">商务专员2</div></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="pfGrid">
						<div class="pfTextBg"><div class="pfText">交易总监</div></div>
					</div>
					<div class="pfGrid">
						<div class="pfTextBg"><div class="pfText">客服总监</div></div>
					</div>
				</div>
			</div>
			<div class="pfGrid">
				<div class="pfTextBg"><div class="pfText">副总经理</div></div>
			</div>
			<div class="pfGrid">
				<div class="pfTextBg"><div class="pfText">产品总监</div></div>
			</div>
			<div class="pfGrid">
				<div class="pfTextBg"><div class="pfText">运营总监</div></div>
				<div class="pfRow">
					<div class="pfGrid">
						<div class="pfTextBg"><div class="pfText">运营主管</div></div>
						<div class="pfRow">
							<div class="pfGrid">
								<div class="pfTextBg"><div class="pfText">运营专员</div></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div> 
 */
//删除菜单
function deleteProfession(){
	//var cxs = $("input[type=checkbox]")
	
	var jt_names = []
//	for(var i in cxs){
//		if(cxs[i].checked){
//			
//		}
//		
//	}
	var cxs = $('input[type=checkbox]:checked')
	if(cxs.length == 0){
		zcAlert("请选择要删除的职位");
		return
	}
	var jt_id 
	for(var i=0, l=cxs.length; i<l;i++){
		jt_id = $(cxs[i]).val()
		for(var j in nodes){
			if(nodes[j].pId == jt_id ){
				zcAlert("请先删除该职位的下级职位")
				return
			}
			if(jt_id   == nodes[j].id && nodes[j].uLength > 0){
				zcAlert("该职位下已分配员工，不可删除")
				return
			}
		}
		jt_names.push(jt_id)
	}
	zcConfirm('是否删除选定职位？',function(r){
		if(r){
			$.post("/position/deleteJobTilte?names="+jt_names,function(data){
				if(data == "true"){
					zcAlert('删除成功');
					initPosition()
				}else{
					zcAlert('删除失败');
				}
				
			})
			
		}
	});
}
//删除菜单end
//添加菜单弹出框
function addProfessionDlgShow(tag){
	var doHtml=
		'<div class="winModBg0">'+
			'<div class="winModBg wEditMod addProfessionDlg">'+
		    	'<div class="titleBg">'+
		        	'<div class="caption">添加职位</div>'+
		            '<div class="closeBtn">X</div>'+
		        '</div>'+
		        '<form id="jt_form" action="">'+
		        '<ul class="editList">'+
		        	'<li>'+  
		            	'<div class="wLabel">名称：<div class="imp">*</div></div>'+
		                '<input placeholder="输入职位名称" type="text" class="box1" id="jt_name" name="jt_name" /><span></span>'+
		            '</li>'+
		            '<li>'+
			        	'<div class="wLabel" >上级职位：<div class="imp">*</div></div>'+
		            	'<input id="jtData"  type="text" class="box1"  readonly value="" name="jtData" /><a name="selectDp" href="#">选择</a>'+
			        	'<div id="menuContent" class="menuContent" name="menuContent" style="display:none; position: absolute;">'+
		        			'<ul id="jt_tree" class="ztree" style="margin-top:0; width:200px;"></ul>'+
		        		'</div>'+
			        '</li>'+
		            '<li>'+
		            	'<div class="wLabel">说明：<div class="imp"></div></div>'+
		                '<textarea placeholder="输入职位说明" class="area1" ></textarea>'+
		            '</li>'+
		            '<li>'+
		            	'<div class="bottomBtns">'+
		            		'<input id="save_a_save" class="btnMod1" value="确定" type="submit"/>'+
		                '</div>'+
		            '</li>'+
		        '</ul>'+
		        '</form>'+
		    '</div>'+
		'</div>';
	
	if(tag == "edit"){
		var cxs = $('input[type=checkbox]:checked')
//		if(cxs.length==0){
			//zcAlert("请选取要编辑的部门")
		//}else {
			 
			$('body').append($(doHtml));
			$(".titleBg").find("div").eq(0).text("编辑职位")
			//var ck_obj = $(cxs[0])
			//console.log(ck_obj.parent().next().find(".professionname"))
			//$("#jt_name").val(ck_obj.parent().next().find(".professionname").text())
			$("#jt_name").val($(click_el ).text())
			//var pId = ck_obj.parent().next().find("input").val()
			var pId =  $(click_el ).next().val()
			for(var i in nodes){
				if(nodes[i].id == pId){
					$("#jtData").val(nodes[i].name)
					$(".area1").text(nodes[i].description||'')
				}
				
			}
			
			
			var valadator = $("#jt_form").validate({
				
				debug: false,
			  	rules: {
			  		jt_name:{
			  			required: true
			  		},
			  		jtData:{
			  			required: true
			  		},
			  	},
				messages: {
					jt_name:{
						required: "请输入职位名称",
					},
					jtData:{
						required: "请选择上级职位",
					}
				},
				errorPlacement:function(error, element){
						error.insertAfter(element.next().after());
						//chengeImage();
						
				},
				submitHandler: function(form){ 
				 	
					if($("#jt_form").valid()){
				      
				      	var savePUrl = "/position/saveJobTitle";
//				      	if(dpData){
//				      		addEpUrl = "/department/addEmployee?routes="+routes+"&role="+role+"&dpData="+dpData
//				      	}else{
//				      		addEpUrl = "/department/addEmployee?routes="+routes+"&role="+role
//				      	}
				       	
				       	$.ajax({
		               		 cache: true,
		              	     type: "POST",
		                	 url:savePUrl,
		                	 data:{name:$("#jt_name").val(),jtData:$("#jtData").val(),description:$(".area1").text()},// 你的formid
		                     async: false,
		                     error: function(request) {
		                   		 alert("Connection error");
		              	  	},
		                	success: function(data) {
		                		if(data == "true"){
		                			$('.addProfessionDlg').parent().remove()
		                			if(tag == "add"){
		                					zcAlert("添加成功");
		                			}else{
		                					zcAlert("修改成功");
		                			}
		                		}else{
		                			$('.addProfessionDlg').parent().remove()
		                			if(tag == "add"){
		                					zcAlert("添加失败");
		                			}else{
		                					zcAlert("修改失败");
		                			}
		                		}
		                		
		                		initPosition();
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
		//}
		//$("#jt_name").val(click_el.html())
//		var ztObj = $.fn.zTree.getZTreeObj("jt_tree");
//		console.log(ztObj)
		//$("#jtData")
		
	}else{
		$('body').append($(doHtml));
	}
	
	$("a[name=selectDp]").on("click",function(){
		var dpId = "jt_tree"
		var dv_id = "jtData"
		//initTreeData(tag,showId)
	
		initZtree(dpId,nodes,dv_id)
	})
	
	var valadator = $("#jt_form").validate({
		
		debug: false,
	  	rules: {
	  		jt_name:{
	  			required: true,
	  			remote: {
					type: "post",
					async: false,
					url: "/position/isExists",
					data: {jt_name:function(){ console.log($("#jt_name").val()); return $("#jt_name").val()}},
				}
	  		},
	  		jtData:{
	  			required: true,
	  		},
	  	},
		messages: {
			jt_name:{
				required: "请输入职位名称",
				remote:   "该职位已存在"
			},
			jtData:{
				required: "请选择上级职位",
			}
		},
		errorPlacement:function(error, element){
				error.insertAfter(element.next().after());
				//chengeImage();
				
		},
		submitHandler: function(form){ 
		 	
			if($("#jt_form").valid()){
		      
		      	var savePUrl = "/position/saveJobTitle";
//		      	if(dpData){
//		      		addEpUrl = "/department/addEmployee?routes="+routes+"&role="+role+"&dpData="+dpData
//		      	}else{
//		      		addEpUrl = "/department/addEmployee?routes="+routes+"&role="+role
//		      	}
		       	
		       	$.ajax({
               		 cache: true,
              	     type: "POST",
                	 url:savePUrl,
                	 data:{name:$("#jt_name").val(),jtData:$("#jtData").val(),description:$(".area1").text()},// 你的formid
                     async: false,
                     error: function(request) {
                   		 alert("Connection error");
              	  	},
                	success: function(data) {
                		if(data == "true"){
                			$('.addProfessionDlg').parent().remove()
                			if(tag == "add"){
                					zcAlert("添加成功");
                			}else{
                					zcAlert("修改成功");
                			}
                		}else{
                			$('.addProfessionDlg').parent().remove()
                			if(tag == "add"){
                					zcAlert("添加失败");
                			}else{
                					zcAlert("修改失败");
                			}
                		}
                		
                		initPosition();
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
	
	modDlgEvent($('.addProfessionDlg'));//自制弹出框公用事件 居中_拖拽_关闭
}

var zNodeObj = {
		setting : {
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
				beforeClick: function(treeId, treeNode, clickFlag) {
						//if(showId == "group_tree"){
							//console.log('treeId',treeId);
							//console.log(treeNode.name);
							//console.log('clickFlag',clickFlag);
							//return false
					//}
			
				},
				onClick: function(event, treeId, treeNode, clickFlag) {
						onClick(event, treeId, treeNode, clickFlag)
						
			}
		}
	}
}
function showIconForTree(treeId, treeNode) {
	return false;
};

function onClick(event, treeId, treeNode, clickFlag){
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
				//console.log(treeId +"~~~~~~~~~~~~"+event_name)
				//if(event_name == "add_em" && treeId == "dp_tree"){
					//if(treeNode.children == null){
						//$("#"+treeId).parent().parent().find("input").val(treeNode.name)
						//pObj.pId = treeNode.id
					//}else{
						//zcAlert("请选择下级部门")
					//}
				//}else{
						$("#"+treeId).parent().parent().find("input").val(treeNode.name)
						hideMenu();
						//pObj.pId = treeNode.id
				//}
				
		}
}


function initZtree(tree_id,datas,dv_id){
	$.fn.zTree.init($("#"+tree_id), zNodeObj.setting, datas)
		var dpObj = $("#"+dv_id);
		//var dpOffset = $("#"+dv_id).offset().left
		var dpOffset = $("#"+dv_id).position()
		$("#"+tree_id).parent().css({left:dpOffset.left + "px", top:dpOffset.top +  dpObj.outerHeight() + "px" }).slideDown("fast");
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

//添加菜单弹出框end
//编辑菜单弹出框
function editProfessionDlgShow(){
	var doHtml=
'<div class="winModBg0">'+
	'<div class="winModBg wEditMod editProfessionDlg">'+
    	'<div class="titleBg">'+
        	'<div class="caption">编辑职位</div>'+
            '<div class="closeBtn">X</div>'+
        '</div>'+
        '<ul class="editList">'+
        	'<li>'+
            	'<div class="wLabel">名称：<div class="imp">*</div></div>'+
                '<input type="text" class="box1" />'+
            '</li>'+
            '<li>'+
	        	'<div class="wLabel">上级职位：<div class="imp">*</div></div>'+
	        	'<select class="select1">'+
	            	'<option>选择职位</option>'+
	                '<option>职位1</option>'+
	                '<option>职位2</option>'+
	                '<option>职位3</option>'+
	                '<option>职位4</option>'+
	            '</select>'+
	        '</li>'+
            '<li>'+
            	'<div class="wLabel">说明：<div class="imp">*</div></div>'+
                '<textarea class="area1"></textarea>'+
            '</li>'+
            '<li>'+
            	'<div class="bottomBtns">'+
                    '<div class="btnMod1">确定</div>'+
                '</div>'+
            '</li>'+
        '</ul>'+
    '</div>'+
'</div>';
	$('body').append($(doHtml));
	
	modDlgEvent($('.editProfessionDlg'));//自制弹出框公用事件 居中_拖拽_关闭
}