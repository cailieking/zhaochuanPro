

	<!--4f start-->
	<div id="new_fourf" class="mar_t20 floor_flag">
		<div class="new_fourf_content">
			<div class="new_f_title clearfix" style="width: 920px;">
				<div class="" style="float: right; font-size: 16px;padding-top:10px;cursor:pointer;">
					<a href="/cargo/cargo.html" target="_blank"><span class="fcolor_1">&lt;&lt;查看更多</span></a>
				</div>
				<div class="f_title_bg lt">
					<span class="fcolor_1">4F</span><span class="f_title_text"></span>拼箱
				</div>
			</div>
			<div class="new_f_content">
				<div class="f_content_top">

					<div class="content_top_jydt">
						<h4 class="public_title">
							<span class="fcolor_1">交易动态</span>
						</h4>
						<div class="mj_content">
							<table class="mj_table">
								<tbody>
									<tr class="tr_34 fcolor_6">
										<td class="td_w84">货主</td>
										<td class="td_w84">交易状态</td>
										<td class="td_w84">时间</td>
									</tr>
									<tr class="loading">
										<td colspan="9" align="center">
											<img src="/images/ajax-loader.gif" />
										</td>
									</tr>
								</tbody>
							</table>
							<div class="mj_message_table purchase_scroll4">
								<table id="floorScrollTable4">
									<tbody>
									</tbody>
								</table>
							</div>
						</div>

					</div>

					<div class="content_top_xhzy">
						<div class="content_public_list">
							<table  id="floorTable4" class="public_list_message">
								<tbody>
									<tr class="tr_38  fcolor_6 ">
										<th class="td_w140">起始港</th>
										<th class="td_w140">目的港</th>
										<th class="td_w120">品名</th>
										<th class="td_w200">货量</th>
										<th class="td_w120">走货日期</th>
										<th class="td_w105">运输种类</th>
										<th class="td_w105"></th>
									</tr>
									<tr class="loading">
										<td colspan="9" align="center">
											<img src="/images/ajax-loader.gif" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>


				</div>
				<div class="f_content_bot">
					<img class="gys_tj" src="/images/index/adv1.jpg" alt="" width="64"
						height="52">
				</div>
			</div>
		</div>
	</div>
	<!--4f end-->



	<!--资讯动态 satr-->
	
	<div class="zixundt floor_flag">
		<h2 class="lt">
			<img src="./images/index/zxdt.png">
		</h2>
		<div>
			<div class="box1">
			</div>
			<div class="box2 current zixun_box">
				<h5>
					<a target="_blank" href="javascript:void(0);">外贸资讯</a>
					 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <a  href="/news/articleList1?type=ftlist"  >更多></a> 
				</h5>
				<div class="p1">
					<ul class="zixun_box_ul">
					</ul>
				</div>
			</div>
			<div class="box3 zixun_box">
				<h5>
					<a target="_blank" href="javascript:void(0);">运输资讯</a>
								  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <a  href="/news/articleList1?type=tplist"  >更多></a> 
				</h5>
				<div class="p1">
					<ul class="zixun_box_ul">
					</ul>
				</div>
			</div>
			<div class="box4 zixun_box">
				<h5>
					<a target="_blank" href="javascript:void(0);">公司资讯</a>
								  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 <a  href="/news/articleList1?type=comlist"  >更多></a> 
				</h5>
				<div class="p1">
					<ul class="zixun_box_ul">
					</ul>
				</div>
			</div>
			<div class="line"></div>
		</div>
	</div>
	
	<!--资讯动态 end-->



	<!--电梯-开始-->
	<div class="lift">
		<ul class="floor">
			<li class="f1">航运</li>
			<li class="f2">家具</li>
			<li class="f3">建材</li>
			<li class="f4">服装</li>
			<li class="f5">拼箱</li>
			<!--  <li class="f6">资讯</li> -->
		</ul>
		<div class="go_top">
			<a href="javascript:void(0);"></a>
		</div>
		<div class="arrow"></div>
	</div>
	<!--电梯-结束-->

	<!--移入提示层 end-->
	<div id="tip_message"></div>

	<!--发布成功弹出框start-->
	<div class="Dwt" style="display: none;">
		<p class="title">
			<a href="javascript:void(0)" id="close_purchase"> <!--关闭-->
			</a>&nbsp;&nbsp;&nbsp;&nbsp;采购单：<span id="purchase_sn"></span>&nbsp;成功发布
		</p>
		<div class="d">
			<p class="p1">&nbsp;&nbsp;您的委托采购内容：</p>
			<p class="p2" id="issue_content"></p>
			<p>
				<i></i>您的以下委托已成功发布，请等待交易员为您审核采购内容，您的委托通过审核后将开始接受报价并由交易员为您找货。
			</p>
			<p style="padding-left: 36px; margin-top: 10px;">您可以从会员中心“我的采购”中了解您的委托进度
			</p>
			<p style="padding-left: 36px;">
				&gt;&gt; 点击查看"<a
					href="/?app=member&act=purchase"
					style="color: #08d;">我的采购</a>"
			</p>
		</div>
	</div>
	<!--发布成功弹出end框-->

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
	<div class="indexpage needtop needsearch"></div>
