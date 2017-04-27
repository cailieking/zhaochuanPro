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
<script>
	$(function() {

		$('#member_submit').on(
				"click",
				function() {
					var oldPassword = $.trim($("#oldPassword").val());
					var password = $.trim($("#password").val());
					var confirmPassword = $.trim($("#confirmPassword").val());
					if (!oldPassword) {
						$("#valiResult").css({
							"color" : "red"
						}).html("<i></i>请输入旧密码");
						$("#oldPassword").focus();
						return false;
					} else {
						if (oldPassword.length > 16 || oldPassword.length < 6) {
							$("#valiResult").css({
								"color" : "red"
							}).html("<i></i>旧密码不能小于6位或大于16位");
							$("#oldPassword").focus();
							return false;
						} else {
							$("#valiResult").html("");
						}
					}

					if (!password) {
						$("#valiResult").css({
							"color" : "red"
						}).html("<i></i>请输入新密码");
						$("#password").focus();
						return false;
					} else {
						if (password.length > 16 || password.length < 6) {
							$("#valiResult").css({
								"color" : "red"
							}).html("<i></i>密码不能小于6位或大于16位");
							$("#password").focus();
							return false;
						} else {
							$("#valiResult").html("");
						}
					}

					if (!confirmPassword) {
						$("#valiResult").css({
							"color" : "red"
						}).html("<i></i>请输入确认密码");
						$("#confirmPassword").focus();
						return false;
					} else {
						if (confirmPassword.length > 16 || confirmPassword.length < 6) {
							$("#valiResult").css({
								"color" : "red"
							}).html("<i></i>确认密码不能小于6位或大于16位");
							$("#confirmPassword").focus();
							return false;
						} else {
							$("#valiResult").html("");
						}
					}

					if (password != confirmPassword) {
						$("#valiResult").css({
							"color" : "red"
						}).html("<i></i>确认密码与密码不一致");
						$("#confirmPassword").focus();
						return false;
					} else {
						$("#valiResult").html("");
					}

					$.post(SITE_URL + "user/updatePassword", $(
							"#form_password_edit").serialize(), function(rs) {
						if (rs.status < 0) {
							alert(rs.msg);
						} else {
							$(".Dwt").show();
							form_password_edit.reset();
						}
					}, "json");
		});
});
</script>
</head>
<body>


	<div class="w960">


		<form id="form_password_edit" method="post">
			<div class="right account">
				<p class="headtitle">
					<span>修改密码</span>
				</p>
				<p>
					<span class="s">旧密码：</span><input type="password" value=""
						class="text w3" name="oldPassword" id="oldPassword" maxlength="16">
				</p>
				<p>
					<span class="s">新密码：</span><input type="password" value=""
						class="text w3" name="password" id="password" maxlength="16">
				</p>
				<p>
					<span class="s">确认密码：</span><input type="password" value=""
						class="text w3" name="confirmPassword" id="confirmPassword"
						maxlength="16">
				</p>
				<p>
					<input type="button" class="Button" id="member_submit"
						style="margin: 20px 0 20px 110px;" value="保存">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="valiResult"></span>
				</p>

				<div class="Dwt" style="display: none;">
					<p class="title_login" style="padding-left: 20px; font-size: 20px;">修改成功</p>
					<div class="d" style="height: 130px;">
						<p style="font-size: 16px;">
							<i></i><span style="color: red;">修改密码成功!</span>
						</p>
						<p
							style="text-align: center; margin-right: 25px; margin-top: 45px;">
							<input type="button" class="Button" id="close_purchase"
								value="关闭">
						</p>
					</div>
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

	<div class="backpage backchangepass needtop"></div>

</body>
</html>