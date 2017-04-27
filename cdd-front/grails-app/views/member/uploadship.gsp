<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>找船网</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="keywords" content="找船网">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">
<!--<link rel="stylesheet" type="text/css" href="../css/ui-dialog.css">-->
<link rel="stylesheet" type="text/css" href="../css/error.css">

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script src="../js/ajaxfileupload.js"></script>
<!--<script src="../js/error.js"></script>
<script src="../js/dialogUploading.js"></script>-->

</head>
<body>

<div class="w960">
<form method="post">
<div class="right batch">
<p class="headtitle"><span>批量发布航线</span></p>
<p class="p1"><a href="/ship/downloadExample" class="btn btn-blue btn-sizem3">点击下载模版</a>&nbsp;&nbsp;批量发布航线excel模版下载</p>
<p class="p2">选择发布航线文件：<input type="file" class="file" name="xls" id="xls"></p>
<p class="p3" style="color:#333;">找船网批量发布航线规则说明：</p>
<p class="p3">1.仅支持 Excel 表格直接上传，建议使用97-2003版本；文件不能大于1M，发布航线条数不能多于200条。</p>
<p class="p3">2.excel文件必须填写起始港，目的港，船公司，开船日，运输类别，有效期才能上传成功。</p>
<p class="p3">3.柜型运价(USD/20GP, USD/40GP, USD/40HQ, USD/45HQ)，附加费将最多保留2位有效数字。</p>
<p><input class="Button" style="margin:20px 0 20px 35px;" type="button" value="提 交"></p>
</div>
</form>
<script>
$(function()
{
    //上传文件
    $(".Button").on("click",function()
    {
    	var url=SITE_URL+"ship/issueBatch";
    	var file=$.trim($("[name='xls']").val());
    	var main_products=$.trim($("[name='main_products']").val());
    	if(!file)
    	{
    		alert('请选择文件');
    		return false;
    	}

        $.ajaxFileUpload(
        {
            url: url,
            secureuri: false,//是否启用安全提交
            fileElementId: "xls",
            dataType: 'JSON',
            success:function(data)
            {
            	var info = data.substring(1,data.length-1).split(",");
            	//console.log(data);
            	if(info.length > 0 && info[0] != null && info[0] != ""){

            		$(function(){
                		errorCreate();
                		for(var i in info){
							 var index1 = info[i].indexOf("'");
							 var index2 = info[i].indexOf("【")
                    		 var index3 = info[i].indexOf("【");
                    		 var index4 = info[i].indexOf("】")
                    		 var index5 = info[i].indexOf("】");
                    		 //var index6 = info[i].indexOf("%");
                			//addErrorTxt('<span>'+info[i].trim().trim().substring(0,4)+'</span>','<span>'+info[i].trim().substring(5,11)+'</span>','不能为空');
                			addErrorTxt('<span style="color:gray;">'+info[i].substring(index1+1,index2)+'</span>','<span>'+info[i].substring(index3,index4+1)+'</span>',info[i].substr(index5+1,info[i].length));
                		}
                	})
                }
            	function errorCreate(){
            		var errorHtml=
            		'<div class="errorBg0">'+
            	    	'<div class="errorBg">'+
            	        	'<div class="errorHead">'+
            	            	'<div class="title">错误信息提示</div>'+
            	                '<div class="close">X</div>'+
            	            '</div>'+
            	            '<div class="errorMid">'+
            	            	'<div class="e_table">'+
            	                	'<div class="e_th">'+
            	                    	'<div class="e_td w1">行数</div>'+
            	                        '<div class="e_td w2">字段信息</div>'+
            	                        '<div class="e_td w3">错误提示</div>'+
            	                    '</div>'+
            	                '</div>'+
            	                '<div class="e_tips">'+
            	                	'<div>■ 行数代表的是批量导入的Excel文件中的对应行数；</div>'+
            	                    '<div>■ 字段信息给出具体错误字段</div>'+
            	                    '<div>■ 错误提示给出错误原因</div>'+
            	                '</div>'+
            	            '</div>'+
            	            '<div class="errorFoot">'+
            	            	'<div class="ebtn">关闭</div>'+
            	            '</div>'+
            	        '</div>'+
            	    '</div>';
            		$('body').append($(errorHtml));
            		$('.errorBg0 .close,.errorBg0 .ebtn').click(function(){
            			$('.errorBg0').remove();
            		})
            	}
            	function addErrorTxt(txt1,txt2,txt3){
            		var rowTxt='<div class="e_tr">'+
            						'<div class="e_td w1">'+txt1+'</div>'+
            						'<div class="e_td w2">'+txt2+'</div>'+
            						'<div class="e_td w3">'+txt3+'</div>'+
            					'</div>';
            		$('.errorBg0 .e_table').append($(rowTxt));
            	}
			},
			
	      });
    });
});
</script>

</div>

<div class="" style="display: none; position: absolute;"><div class="aui_outer"><table class="aui_border"><tbody><tr><td class="aui_nw"></td><td class="aui_n"></td><td class="aui_ne"></td></tr><tr><td class="aui_w"></td><td class="aui_c"><div class="aui_inner"><table class="aui_dialog"><tbody><tr><td colspan="2" class="aui_header"><div class="aui_titleBar"><div class="aui_title" style="cursor: move;"></div><a class="aui_close" href="javascript:/*artDialog*/;">×</a></div></td></tr><tr><td class="aui_icon" style="display: none;"><div class="aui_iconBg" style="background: none;"></div></td><td class="aui_main" style="width: auto; height: auto;"><div class="aui_content" style="padding: 20px 25px;"></div></td></tr><tr><td colspan="2" class="aui_footer"><div class="aui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="aui_e"></td></tr><tr><td class="aui_sw"></td><td class="aui_s"></td><td class="aui_se" style="cursor: se-resize;"></td></tr></tbody></table></div></div>

<div class="backpage backbatchship needtop"></div>

</body></html>