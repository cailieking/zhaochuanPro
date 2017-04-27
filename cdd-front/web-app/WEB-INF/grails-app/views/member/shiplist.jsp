<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>船多多</title>
<meta name="keywords" content="船多多">
<meta name="description" content="船多多">
<link rel="stylesheet" type="text/css" href="../css/common.css">
<link rel="stylesheet" type="text/css" href="../css/dialog.css">
<link rel="stylesheet" type="text/css" href="../css/member/member.css">

<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script src="../js/common.js"></script>
<script src="../js/dialog.js"></script>

</head>
<body>
<div class="w960">

<div class="right my_buy">
<p class="title"><span>我的航线</span></p>
<form action="" method="get" id="myform">
<input type="hidden" name="app" value="member">
<input type="hidden" name="act" value="purchase">
<p class="s">状态：
<select name="status">
<option value="0" selected>未审核</option>
<option value="1">开始报价</option>
<option value="2">正在报价</option>
<option value="3">正在洽谈</option>
<option value="5">正在洽谈</option>
<option value="4">等待打款</option>
<option value="7">交易成功</option>
<option value="8">已审凭证</option>
<option value="-2">全部</option>
<option value="-5">审核不通过</option>
<option value="-9">交易终止</option>
</select>
&nbsp;&nbsp;&nbsp;<input class="Button" value="搜索" type="submit">&nbsp;&nbsp;&nbsp;
</p>
</form>
<table>
<tbody><tr>
<th class="w1">流水号</th>
<th class="w2">原发布内容</th>
<th>审核后的发布内容</th>
<th class="w1">货主信息</th>
<th class="w4">状态</th>
</tr>
<tr>
<td class="w1">0407027498</td>
<td class="w2">sadasd </td>
<td></td>
<td class="w1"></td>
<td class="w4  color">
未审核</td>
</tr>
<tr>
<td class="w1">0407027499</td>
<td class="w2">测试测试 </td>
<td></td>
<td class="w1"><div class="company">深圳市ABC家具有限公司
<div class="company_div" style="display: none;">
             	<p>深圳市ABC家具有限公司</p>
                 <p>张维凯 15820407690</p>
                 <p class="tip">联系我时，请说是在船多多上看到的，谢谢！</p>
             </div></div>
</td>
<td class="w4  color">交易成功</td>
</tr>
</tbody>
</table>
<div class="page_a02"><div class="page_box">
                            <span class="on">1</span>
                        <span class="total">共 1 页</span>
    <span class="to">转到第 <input type="text" value="1" class="n"> 页</span>
    <span class="go">GO</span>
</div>
</div>
</div>
</div>
<script>
$(function()
{
	
/***公司移入显示效果***/
$(".company").mouseover(function(){
$(this).find('.company_div').show();
}).mouseout(function(){
$(this).find('.company_div').hide();
});
	
//播放语音
$(".play_audio").on("click",function()
{
$(this).siblings("audio")[0].play();
});

//审核不通过消息
$(".nopass").on("click",function()
{
$.showmessage($(this).data("content"));
});
});
</script>
<div class="aui_state_focus" style="position: absolute; left: -9999em; top: 305px; width: auto; z-index: 1987;"><div class="aui_outer"><table class="aui_border"><tbody><tr><td class="aui_nw"></td><td class="aui_n"></td><td class="aui_ne"></td></tr><tr><td class="aui_w"></td><td class="aui_c"><div class="aui_inner"><table class="aui_dialog"><tbody><tr><td colspan="2" class="aui_header"><div class="aui_titleBar"><div class="aui_title" style="cursor: move;">消息</div><a class="aui_close" href="javascript:/*artDialog*/;">×</a></div></td></tr><tr><td class="aui_icon" style="display: none;"><div class="aui_iconBg" style="background: none;"></div></td><td class="aui_main" style="width: auto; height: auto;"><div class="aui_content" style="padding: 20px 25px;"><div class="aui_loading"><span>loading..</span></div></div></td></tr><tr><td colspan="2" class="aui_footer"><div class="aui_buttons" style="display: none;"></div></td></tr></tbody></table></div></td><td class="aui_e"></td></tr><tr><td class="aui_sw"></td><td class="aui_s"></td><td class="aui_se" style="cursor: se-resize;"></td></tr></tbody></table></div></div>

<div class="backpage backshiplist needtop"></div>

</body></html>