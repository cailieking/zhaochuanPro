
	<!--公告 start-->
	<div id="new_banner" class="clearfix">
		<div class="new_banner_content bootstrap-frm">


		<div class="indexPlatformInfo">
		    <ul>
		      	<li class="list-01">
				      <ul class="datebox">
				         <li  class="l1">
				        	<i class="year" id="year"></i>
				        	<b class="week" id="week"></b>	        
				          </li>
				         <li class="l2" id="datetime"></li>
				      </ul>
		      		<div style="clear:both"></div>	
		    	 </li>
		    	 <li  class="list-02">
		        	<i>美元兑人民币</i>
		        	<b id="curRate"></b>
		     	  </li>
		     	 
		     <li>
		       <div id="bdi-container"></div>
		     </li>
		      
		     
		     <%--
		      <li style="text-align:center;line-height:25px;">
		       <span style="background-color:#ff540c;display:inline-block;height:25px;margin-right:2px;margin-left:5px;width:40%">896</span>
		       <span style="background-color:#ff540c;display:inline-block;height:25px;width:58%">-2.98%</span>
		      </li>
		    --%></ul>
			<%--<div class="dateBox">
				<div class="month" id="curMonth"></div>
				<h2 class="date" id="curDay"></h2>
			</div>
			<div class="exchangeRate">
				<ul class="businessNum">
					<li style='height:30px; color: #c1974f;font-size: 14px;'>今日汇率（$ 兑 ￥）</li>
					<li style='height:35px; font-size: 28px;' id="curRate"></li>
				</ul>
			</div>
			<ul class="platformFunction">
				<li style="width:200px;padding: 0; padding-bottom: 3px;">新增货主&nbsp;<em id="shipNewAdded" style="color:red;"></em>&nbsp;家</li>
				<li style="width:200px;padding: 0; padding-bottom: 3px;">新增货盘&nbsp;<em id="cargoNewAdded" style="color:red;"></em>&nbsp;条</li>
				<li><a href="javascript:void(0)" target="_blank">
						<dl class="credit">
							<dt></dt>
							<dd class="tit">诚信档案</dd>
							<dd>信誉累积  更多货盘！</dd>
						</dl>
				</a></li>
				<li><a href="javascript:void(0)" target="_blank">
						<dl class="position">
							<dt></dt>
							<dd class="tit">服务保障</dd>
							<dd>服务有保障 交易更顺心！</dd>
						</dl>
				</a></li>
				<li>
					<dl class="brand">
						<dt></dt>
						<dd class="tit">物流商认证</dd>
						<dd>信息真实可靠 交易安全放心！</dd>
					</dl>
				</li>
			</ul>
		--%></div>


			<div class="banner_img">
				<ul class="img_list"></ul>
				<p class="banner_focus"></p>
			</div>

			<div class="free_message" id="index_login_box">
				<p class="free_title">会员登录<span class="title_icon"></span></p>
				<div class="free_div_bottom login_box">
				<form id="form_login" method="post" action="/j_spring_security_check">
					<div id="login_error"></div>
					<ul>
					    <li>
					        <span class="s">账&nbsp;号：</span><input type="text" class="text" id="j_username" name="j_username">
					    </li>
					    <li>
					        <span class="s">密&nbsp;码：</span><input type="password" class="text" id="j_password" name="j_password">
					    </li>
					</ul>
					<div class="b">
					    <p>
					    	<input type="button" value="登录" id="submit_login" class="btn btn-blue btn-sizem4">
					    	<a href="/register/step1" target="_blank" style="color:#06c;text-decoration:underline;">免费注册</a>
					    </p>
					    <p class="login_other"><a href="/forgetpass/step1" target="_blank" class="a">忘记密码？</a><input type="checkbox" style="vertical-align:middle;" value="1" name="_spring_security_remember_me" >&nbsp;2周自动登录</p>
					</div>
				</form>
				</div>
			</div>



	</div>
	</div>
	<!--公告 end-->



