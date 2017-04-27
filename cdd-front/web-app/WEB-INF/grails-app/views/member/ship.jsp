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

		<form id="myform" method="post">


			<div class="right release_single">
				<p class="title">
					<span>发布航运信息</span>
				</p>
				<div class="one">
					<p class="color1">&nbsp;</p>
					<p>
						&nbsp;&nbsp;<span style="color: red">*</span>起始港： <input
							type="text" name="name" id="name" value="" class="bd">
						&nbsp;&nbsp;&nbsp;<span style="color: red">*</span>目的港： <input
							type="text" name="manufacturer" id="manufacturer" value=""
							class="bd"> &nbsp;&nbsp;&nbsp; <span style="color: red">*</span>运输种类：
						<input type="text" name="name" id="name" value="" class="bd">
						&nbsp;&nbsp;&nbsp;<span style="color: red">*</span>船公司： <input
							type="text" name="manufacturer" id="manufacturer" value=""
							class="bd"> &nbsp;&nbsp;&nbsp;
					</p>
					<p>
						&nbsp;&nbsp;<span style="color: red">*</span>开船日： <input
							type="text" name="name" id="name" value="" class="bd">
						&nbsp;&nbsp;&nbsp;<span style="color: red">*</span>有效期： <input
							type="text" name="manufacturer" id="manufacturer" value=""
							class="bd">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						航程： <input type="text" name="name" id="name" value="" class="bd">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;中转港： <input type="text"
							name="manufacturer" id="manufacturer" value="" class="bd">
						&nbsp;&nbsp;&nbsp;
					</p>
					<div class="div1">其它说明：</div>
					<div class="div2">
						<textarea name="purchase_content" id="purchase_content"></textarea>
					</div>
					<p>
						<input type="button" class="Button"
							style="margin: 20px 0 20px 75px;" value="发布">
					</p>
				</div>
			</div>
		</form>
	</div>

	<div class="" style="display: none; position: absolute;">
		<div class="aui_outer">
			<table class="aui_border">
				<tbody>
					<tr>
						<td class="aui_nw"></td>
						<td class="aui_n"></td>
						<td class="aui_ne"></td>
					</tr>
					<tr>
						<td class="aui_w"></td>
						<td class="aui_c"><div class="aui_inner">
								<table class="aui_dialog">
									<tbody>
										<tr>
											<td colspan="2" class="aui_header"><div
													class="aui_titleBar">
													<div class="aui_title" style="cursor: move;"></div>
													<a class="aui_close" href="javascript:/*artDialog*/;">×</a>
												</div></td>
										</tr>
										<tr>
											<td class="aui_icon" style="display: none;"><div
													class="aui_iconBg" style="background: none;"></div></td>
											<td class="aui_main" style="width: auto; height: auto;"><div
													class="aui_content" style="padding: 20px 25px;"></div></td>
										</tr>
										<tr>
											<td colspan="2" class="aui_footer"><div
													class="aui_buttons" style="display: none;"></div></td>
										</tr>
									</tbody>
								</table>
							</div></td>
						<td class="aui_e"></td>
					</tr>
					<tr>
						<td class="aui_sw"></td>
						<td class="aui_s"></td>
						<td class="aui_se" style="cursor: se-resize;"></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="backpage backship needtop"></div>

</body>
</html>