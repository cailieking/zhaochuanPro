//	$('.web_banner_editDlg1').css("width",image.width)
//	$('.web_banner_editDlg1').css("height",image.height)
//	
//		modDlgEvent($('.web_banner_editDlg1'))
//	})
var $_this
var btn
$(function(){
//	$(".blueBtnU").click(function(){
//		$('#createImageUpFile').trigger('click');
//	})
	
	$("body").on('click','.blueBtn',function(){
		//var img = $(this).parents("from").find("img").attr("src")
		//console.log("img")
		var img = $(".imageShow").attr("src")
		var image = new Image();
		image.src = img
		$("body").append('<div class="winModBg0" >'+
		'<div class="winModBg wEditMod web_banner_editDlg1" >'+
		'<div class="titleBg">'+
	    '<div class="closeBtn">X</div>'+
	    '</div>'+
		'<img src="'+img+'"/>'+
		'</div></div>')
		
		$('.web_banner_editDlg1').css("width",image.width)
		$('.web_banner_editDlg1').css("height",image.height)
	
		modDlgEvent($('.web_banner_editDlg1'))
	})
	
	$("#preview").on("click",function(){
		var title = $("input[name=title]").val()
		var comes = $("input[name=comes]").val()
		var tags =  $("input[name=pageTag]")
		content = CKEDITOR.instances['articleContent'].getData()
//		$("body").append('<div class="msgsBg">'+
//					'<div class="title">title</div>'+
//					'<div class="from">'+
//					'<span>来源：<span class="link"></span></span>'+
//					'<span>日期：<span>2015-12-20</span></span>'+
//					'</div>'+
//					'<img class="image" />'+
//					'<div class="msgContent">'+content+
//					'</div></div>')
            	$("body").append('<div class="winModBg0" >'+
        				'<div class="winModBg wEditMod web_banner_editDlg" >'+
        				'<div class="titleBg">'+
        			    '<div class="closeBtn">X</div>'+
        			    '</div>'+
        			    '<div class="msgsBg">'+
        				'<div class="title">'+(title||'xxxxxxxxxx')+'</div>'+
        				'<div class="from">'+
        				'<span>来源：<span class="link">'+(comes||'xxxxxxx')+'</span></span>'+
        				'<span>日期：<span>xxxxxxxx</span></span>'+
        				'</div>'+
        				'<img class="image" />'+
        				'<div class="msgContent">'+content+
        				'</div>'+
        				'<ul class="tag_li"><label style="color:orange">标签：</label>'+
        				'</ul>'+
        				'</div>'+
        				
        				'</div></div>')
        		for(var i = 0;i<tags.length;i++){
        			if(tags.eq(i).val() != null && tags.eq(i).val() != "" ){
        				$(".tag_li").append('<li >'+
    	        				'<a class="nofocus" href="javascript:;">'+tags.eq(i).val()+'</a>'+
    	        				'</li>')
        				}
        			}
        		modDlgEvent($('.web_banner_editDlg'));
            
		
//		var left = $(".content-detail").css("padding-left")
//		var index = left.indexOf('p')
//		var substr = left.substr(0,index)
//		console.log(substr)
	//	$('.web_banner_editDlg').css("width",$(".content-detail").width()+2 * parseInt(substr)+1)
	  //  $('.web_banner_editDlg').css("height","")

				
	   
		
	})
	
	
	$("input[type='file']").bind("change",function(){
		$_this = $(this)
		var formData = new FormData($(this).parents("form")[0])
		uploadFile($_this,formData)
		//var formData = new FormData($("input[type='file']").parents("form")[0]);
	})
	
	$("body").on("click","div[name=insert_img]",function(){
		insertImg($(this))
	})
	
	$("body").on('click','.blueBtnD',function(){
		    var btnD_ele = $(this)
		    var article_id = $("input[name=id]").val() 
		    var content = CKEDITOR.instances['articleContent'].getData(0)
			if($(this).parents(".imageUpBg").attr("name") == "first_row"){
				 var img_el = $(this).parent().parent().parent().find("img")
				 var img_name = $(this).parent().parent().find("input[type=hidden]").val()
				 $.post("/article/delImg",{imgName:img_name,id:article_id,content:content},function(rs){
					 if(rs.state == true){
						 zcAlert("删除成功")
						 $("#image").val("")
						 changeImgHtml(img_el,btnD_ele,rs)
						 
					 }else {
						 zcAlert("删除失败,该图已不存在")
						 $("#image").val("")
						 changeImgHtml(img_el,btnD_ele,rs)
//						 img_el.attr('src',"")
//						 img_el.hide();
//						 if(btnD_ele.parents(".form-group").find(".imageUpBg").length == 1){
//							 //$(this).parent().parent().parent().find(".btnMod2").show()
//							 if(btnD_ele.parents(".imageUpBg").find("input[type=file]").attr("name") == "titleImg"){
//								 $("#createImageUpBtn").show()
//							 }else{
//								 $("#createImageBodyBtn").show()
//								 btnD_ele.parents(".form-group").parent().next().hide()
//							 }
//						 }
//						// $("#createImageUpBtn").show()
//						 btnD_ele.parent().parent().hide()
//						 CKEDITOR.instances['articleContent'].setData(rs.content)
//						  var a = CKEDITOR.instances['articleContent'].getData()
//						 var b="/<IMG src=\"([^\"]*?)\">/gi"
//						 var s = a.match(b)
//						 for(var i= 0;i<s.length;i++)
//						 {
//							 	console.log(s[i]);
//							 	console.log(RegExp.$1)
//						 }
					 }
				 })
				
			}else{
				var img_name = $(this).parent().parent().find("input[type=hidden]").val()
				 $.post("/article/delImg",{imgName:img_name,id:article_id,content:content},function(rs){
					 if(rs.state == true){
						zcAlert("删除成功")
						btnD_ele.parents(".imageUpBg").parent().prev().remove()
						btnD_ele.parents(".imageUpBg").parent().remove()
						 var img_html = $("#imageDataBgId").parents(".form-group").find(".imageUpBg")
						 if(img_html.length == 1 && img_html.find(".imageShow").css("display") == "none"){
								  $("#createImageBodyBtn").show()
								  $("#createImageBodyBtn").parents(".form-group").parent().next().hide()
							 }
						if(rs.content != null && rs.content != ""){
							 CKEDITOR.instances['articleContent'].setData(rs.content)
						 }else{
						 }
//						 var a = CKEDITOR.instances['articleContent'].getData()
//						 var b = /<IMG src=\"([^\"]*?)\">/gi
//						 var s = a.match(b)
//						 for(var i= 0;i<s.length;i++)
//						 {
//							 	console.log(s[i]);
//							 	console.log(RegExp.$1)
//						 }
					 }else {
						 zcAlert("删除失败,该图已不存在")
						 btnD_ele.parents(".imageUpBg").parent().prev().remove()
							btnD_ele.parents(".imageUpBg").parent().remove()
							 var img_html = $("#imageDataBgId").parents(".form-group").find(".imageUpBg")
							 if(img_html.length == 1 && img_html.find(".imageShow").css("display") == "none"){
									  $("#createImageBodyBtn").show()
									  $("#createImageBodyBtn").parents(".form-group").parent().next().hide()
							 }
						 if(rs.content != null && rs.content != ""){
							 CKEDITOR.instances['articleContent'].setData(rs.content)
						 }else{
						 }
//						 var a = CKEDITOR.instances['articleContent'].getData()
//						 var b="/<IMG src=\"([^\"]*?)\">/gi"
//						 var s = a.match(b)
//						 for(var i= 0;i<s.length;i++)
//						 {
//							 	console.log(s[i]);
//							 	console.log(RegExp.$1)
//						 }
					 }
				 })
			}
//		var imgName = $(this).next().val()
//		var fieldName = $(this).next().attr("name")
//		var id = $(this).parents("form").find("input[name=pageId]").val()
//		$.post("/page/deleteImg",{imgName:imgName,fieldName:fieldName,id:id},function(rs){
//			//window.location.href = "/page/list"
//			$_img.parent().find("input[type=file]").val();
//			console.log($_img.parent().children().last())
//			$_img.parent().children().last().html();
//			$_img.parents("form").find('img[name=imageFile]').attr('src','');//默认微信图片
//			$('#weixinShow').hide();
//		})
		
	})
	
	$('#bannerYesBtn').click(function(){
		$("#dataForm").submit();
		$('.web_banner_editDlg .closeBtn').trigger('click');
	})
	
	
	//取消
	$('#bannerNoBtn').click(function(){
		$('.web_banner_editDlg .closeBtn').trigger('click');
	})
	//重置
	$('#bannerResetBtn').click(function(){
		$('.web_banner_editDlg .closeBtn').trigger('click');
		createBannerShow();
	})
	//上传图片事件
	$('#createImageUpBtn').click(function(){
		btn = 0
		$('#createImageUpFile').trigger('click');
	})
	
	$('#createImageBodyBtn').click(function(){
		btn = 1
		$('#createImageBodyFile').trigger('click');
	})
	$('#createImageUpFile').change(function(){
		//$('.imageUpBg').hide();
		//$('.imageDataBg').show();
		$(this).parent().children().last("div").show();
		//$(".blueBtnU").show()
		$("#createImageUpBtn").hide()
		$(".modTishiBg").hide();
		//$(".blueBtn").show();
		var fileRoad=$(this).val().split('\\');
		var fileName=fileRoad[fileRoad.length-1];
		$('.imageDataBg .fileName').html(fileName);
	})
	
	$('#createImageBodyFile').change(function(){
		$(this).parent().children().last("div").show();
		$("#createImageBodyBtn").hide()
		$(".modTishiBg").hide();
		var fileRoad=$(this).val().split('\\');
		var fileName=fileRoad[fileRoad.length-1];
		$('.imageDataBg .fileName').html(fileName);
	})
	
	var valadator = $("#article_form").validate({
	debug: false,
  	rules: {
  		title:{
  			required: true,
  		},
  		tweetTitle:{
  			required: true,
  		},
  		articleSummary:{
  			required: true,
  		},
  		articleType:{
  			required: true,
  		},
  		image:{
  			required: true,
  		}
  	},
	messages: {
		title:{
			required: "* 请输入文章标题",
		},
		tweetTitle:{
			required: "* 请输入特推标题",
		},
		articleSummary:{
			required:   "* 请输入文章概要",
		},
		articleType:{
			required:  "* 请选择文章类型",
		},
		image:{
			required:  "* 标题图片不能为空",
  		}
	},
	errorPlacement:function(error, element){
			if(element.attr("type") == "radio"){
				error.insertAfter(element.parent().parent().after());
				element.parent().parent().next().css("color","red")
				element.parent().parent().next().css("font-weight", "400")
				element.parent().parent().next().addClass("	col-sm-2 control-label col-lg-2")
			}else{
				error.insertAfter(element.parent().after());
				element.parent().next().css("color","red")
				element.parent().next().css("font-weight", "400")
			}
		
			//chengeImage();
	},
	submitHandler: function(form){ 
	//	alert(window.event.target)
		
		if($("#article_form").valid()){
			var state = $(document.activeElement).next().val()
			console.log($("#image").val())
			if($("#image").val() == "" || $("#image").val() == null){
			    if($("#image").parent().parent().parent().next()[0].tagName != "LABLE"){
			    	$("#image").parent().parent().parent().after("<lable style='color:red;font-width:400' >* 标题图片不能为空</lable>")
			    }
			    return 
			}
			//alert(element)
//			var articleCategory = ""
//				$("input[name='article_category']:checkbox:checked").each(function(){
//					articleCategory += $(this).val()+',';
//			    });
//				
//			var articletype = $("input[name='articletype']:checked").val();
			//console.log(element.next().val())
			//var state = element.next().val()
		    for(instance in CKEDITOR.instances){
				CKEDITOR.instances[instance].updateElement();
			}
		    $.ajax({
		 	     url:'/article/save?articleState='+state,
		 	     data:$('#article_form').serialize(),
		 	   //  secureuri:true,
		 	     cache: true,
		 	     async: false,
		 	     type: "POST",
//		         cache: true,  
//		         contentType: false,  
//		         processData: false,
		         error: function(request) {
		      		// alert("Connection error");
		 	  	 },
		     	 success: function(data) {
			   		if(data == "true"){
			   			zcAlert("成功")
			   			window.history.back()
			   		}else{
			   			zcAlert("失败")
			   		}
		  	 }
			 });
		}else{
			chengeImage();
		}
     },
     chengeImage: function(){
    } 
  });
	
})	

function uploadFile(ele,formData){
	
	var imgName = ele.attr("name")
	$.ajax({
		url:'/article/execute?imgName='+imgName,
		type:'post',
		secureuri:false,
		data:formData,
        cache: false,  
        async: false,
        contentType: false,  
        processData: false, 
		success:function(rs){
			if(btn==2){
				$("#imageDataBgId").before('<label class="col-sm-2 control-label col-lg-2" for="inputSuccess"></label>'+
						'<div class="row"><div class="imageUpBg" style="height:auto">'+
						'<img src="'+ossDomain+"/"+rs+'" class="imageShow" />'+
						'<div style="clear:both" >'+
							'<div class="row" style="padding-left: 10px">'+
							'<div class="blueBtn" >查看原图</div><div class="blueBtnD">删除</div></div>'+
							'<div class="row" style="width: 200%">'+
								'<span  style="margin:5px 0px 0px 14px;float:left;">连接： </span><a href="'+ossDomain+"/"+rs+'" class="blueBtn" >'+ossDomain+"/"+rs+'</a><input type="hidden" value="'+rs+'" /><div class="blueBtnU"  onclick="Copy(event)">复制连接</div>'+
								'<div style="margin:5px;float:left;color:#0088dd;cursor: pointer" name="insert_img" >插入文章</div>'+
							'</div>'+
						'</div></div></div>'
				)
			}else{
				//$_this.parents("form").find("img").attr("src",rs)
				$_this.parent().find("img").attr("src",ossDomain+"/"+rs)
				$_this.parent().find("img").show()
//				if($_this.parent().next()[0].tagName == "LABLE"){
//					$_this.parent().next().remove()
//				}
				var a_tag = $_this.next().find("a")
				a_tag.attr("href",ossDomain+"/"+rs)
				a_tag.text(ossDomain+"/"+rs)
				//if(imgName == "titleImg"){
					a_tag.next().val(rs)
				//}
				$_this.parents(".form-group").parent().next().show()
				
			}
			

//			var imgHtml = '<div class="row" style="width: 200%">'+
//			'<span  style="margin:5px 0px 0px 14px;float:left;">连接： </span><a href="" class="blueBtn" >'+
//			'</a><input type="hidden" value="" /><div class="blueBtnU"  onclick="Copy(event)">复制连接</div>'+
//			'<div class="blueBtn" >查看原图</div><div class="blueBtnD">删除</div>'+
//		    '<div style="margin:5px;float:left;color:#0088dd;cursor: pointer" name="insert_img" >插入文章</div>'+
//			'</div>'
//	       $(eve.target).parent().parent().find(".row").last().after(imgHtml)
			//$_this.parents("form").find("img").show();
		//	$(".blueBtnD").after("<input type='hidden' value='"+rs+"' name='logo'/>")
			//$('#logoShowImage').attr("src",rs)
		}
	})
	
}

function insertImg(ele){
	var aa = ele.parent().parent().parent().find("img").attr("src")
	//console.log(CKEDITOR.instances['aa'].insertHtml())
	CKEDITOR.instances['articleContent'].insertHtml('<img src="'+aa+'" />')
}

function createArticle(state){
//	var formData = new FormData($(this).parents("form")[0])
	//console.log(formData)
	
	
	var articleCategory = ""
		$("input[name='article_category']:checkbox:checked").each(function(){
			articleCategory += $(this).val()+',';
	    });
		
		var articletype = $("input[name='articletype']:checked").val();
    for(instance in CKEDITOR.instances){
		CKEDITOR.instances[instance].updateElement();
	}
    $.ajax({
 	     url:'/article/save?articleState='+state,
 	     type: "post",
 	     data:$('#article_form').serialize(),
 	   //  secureuri:true,
 	     async: false,
//         cache: true,  
//         contentType: false,  
//         processData: false,
         error: function(request) {
      		// alert("Connection error");
 	  	 },
     	 success: function(data) {
	   		if(data == "true"){
	   			zcAlert("成功")
	   			window.history.back()
	   		}else{
	   			zcAlert("失败")
	   		}
  	 }
	 });
	
	
	
//	console.log($('#article_form').serialize())
	//$('#article_form').attr("action",'/article/save')
	//$('#article_form').submit()
	//'articleContent'
	
				
	
}
function upBodyImg(id){
	$('#'+id).trigger('click');
		
}

function Copy(eve)  {  
   $('#image_url').html('');
  var url = $(eve.target).prev().prev().text()
  var shippingText = url;
  $('#image_url').html(shippingText);
  $('#image_url').get(0).select();
  if(document.execCommand("Copy")){
		document.execCommand("Copy");
		zcConfirm3("复制成功");
	}else{
		zcConfirm3("复制失败");
	}
}  

function continueImg(id,eve){
	btn = 2
	$('#'+id).trigger('click');
	
}

function changeImgHtml(img_el,btnD_ele,data){
	 img_el.attr('src',"")
	 img_el.hide();
	 if(btnD_ele.parents(".form-group").find(".imageUpBg").length == 1){
		 //$(this).parent().parent().parent().find(".btnMod2").show()
		 if(btnD_ele.parents(".imageUpBg").find("input[type=file]").attr("name") == "titleImg"){
			 $("#createImageUpBtn").show()
		 }else{
			 $("#createImageBodyBtn").show()
			 btnD_ele.parents(".form-group").parent().next().hide()
		 }
	 }
	// $("#createImageUpBtn").show()
	 btnD_ele.parent().parent().hide()
	 if(data.content != null && data.content != ""){
		 CKEDITOR.instances['articleContent'].setData(data.content)
	 }else{
		// CKEDITOR.instances['articleContent'].setData(data.content)
	 }
	
//	 var a = CKEDITOR.instances['articleContent'].getData()
//	 var b="/<IMG src=\"([^\"]*?)\">/gi"
//	 var s = a.match(b)
//	 for(var i= 0;i<s.length;i++)
//	 {
//		 	console.log(s[i]);
//		 	console.log(RegExp.$1)
//	 }
}