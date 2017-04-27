<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta http-equiv="X-UA-Compatible" content="IE=edge" ></meta>
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>
<script src="../js/ajaxfileupload.js"></script>

</head>
<body>

<div class="w960">

  
<form method="post">
<div class="right batch">
<p class="headtitle"><span>批量发布货物</span></p>
<p class="p1"><a href="/order/downloadExample" class="btn btn-blue btn-sizem3">点击下载模版</a>&nbsp;&nbsp;批量发布货物excel模版下载</p>
<p class="p2">选择发布货物文件：<input type="file" class="file" name="xls" id="xls"></p>
<p class="p3" style="color:#333;">找船网批量发布货物规则说明：</p>
<p class="p3">1.仅支持 Excel 表格直接上传，建议使用97-2003版本；文件不能大于1M，发布货物条数不能多于200条。</p>
<p class="p3">2.excel文件必须填写起始港，目的港，走货日期，报价截至时间，运输种类才能上传成功。</p>
<p class="p3">3.当运输种类为整箱时，柜型和柜个数为必填。当运输种类为整箱时，数量/件数，毛重，体积为必填。</p>
<p class="p3">4.毛重，体积, 长度, 宽度, 体积将最多保留2位有效数字。</p>
<p><input class="Button" style="margin:20px 0 20px 35px;" type="button" value="提 交"></p>
</div>
</form>

<script>
$(function()
{

    //上传文件
    $(".Button").on("click",function()
    {
    	
    	var url=SITE_URL+"order/issueBatch";
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
            secureuri: false,
            fileElementId: "xls",
            dataType: 'json',
            success:function(rs)
            {
				$("#showdiv1").hide();
				$("#showdiv2").hide();
                if(rs.status==-100)
                {
                    show_dialog_login();
                }
                else if(rs.status<0)
                {
                    alert(rs.msg);
                }
                else
                {
                	alert(rs.msg);
                	location.reload();
                }
            }
        });
    });

});
</script>

</div>

<div class="" style="display: none; position: absolute;"><div class="aui_outer"><table class="aui_border"><tbody><tr><td class="aui_nw"></td><td class="aui_n"></td><td class="aui_ne"></td></tr><tr><td class="aui_w"></td><td class="aui_c"><div class="aui_inner"><table class="aui_dialog"><tbody><tr><td colspan="2" class="aui_header"><div class="aui_titleBar"><div class="aui_title" style="cursor: move;"></div><a class="aui_close" href="javascript:/*artDialog*/;">×</a></div></td></tr><tr><td class="aui_icon" style="display: none;"><div class="aui_iconBg" style="background: none;"></div></td><td class="aui_main" style="width: auto; height: auto;"><div class="aui_content" style="padding: 20px 25px;"></div></td></tr><tr><td colspan="2" class="aui_footer"><div class="aui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="aui_e"></td></tr><tr><td class="aui_sw"></td><td class="aui_s"></td><td class="aui_se" style="cursor: se-resize;"></td></tr></tbody></table></div></div>

<div class="backpage backbatchcargo needtop"></div>

</body></html>