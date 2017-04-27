<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="layout" content="main" />
<title>货代平台,国际货代,找船网,zhaochuan.cn,免费帮您找好船</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta name="description" content="港口 - 找船网">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/biz/biz.css">
<link rel="stylesheet" type="text/css" href="/css/index/index.css">
<link rel="stylesheet" type="text/css"
	href="/css/commodity_price_page/port.css">
<script src="/js/jquery.js"></script>
<script src="/js/js.js"></script>
<script src="/js/common.js"></script>
</head>
<body>
	<div class="agent-resource-ctn">
		<div class="nav">
			<a href="http://www.zhao-chuan.com/">首页</a> <span class="divider">
				></span> <a href='javascript:history.go(-1)'>所属公司</a> <span
				class="divider"> ></span> 详情
		</div>
		<div class="main-content" >
		  
			<div class="consult" >
				<ul>
					<li class="last"><span class="member-image"> <a
							href="javascript:void(0);"> <img
								src="/images/company/commodity_price_page/default.jpg" alt="me">
						</a>
					</span> <span class="member-credit"> <span class="member-title">
								<span><a href="javascript:void(0);">
										${user.firstname.substring(0, 1)}先生
								</a></span> 
								<span class="vtruename" title="认证用户">
								<g:if test="${user.verified}">
								<img
									src="/images/company/verfied.png">&nbsp;认证用户
								</g:if><g:else>
								<img
									src="/images/company/unverfied.png">&nbsp;认证用户
								</g:else>
									</span>
									
								<span class="vtruename" title="诚信用户">
								<g:if test="${user.verified}">
								<img
									src="/images/company/honest.png">&nbsp;诚信用户
								</g:if><g:else>
								<img
									src="/images/company/unhonest.png">&nbsp;诚信用户
								</g:else>
									</span>
									
								<span class="vtruename" title="信誉用户">
								<g:if test="${user.verified}">
								<img
									src="/images/company/heart.png">&nbsp;信誉用户
								</g:if><g:else>
								<img
									src="/images/company/unheart.png">&nbsp;信誉用户
								</g:else>
									</span>
							 
						</span>
					</span>
						<div class="company-name">
							公司名称：${user.companyName }
						</div>
						<div class="company-name">
							联系电话:<span style="color: #3399EE"> ${user.mobile}
							</span>
						</div>
						<div class="company-name">
							推荐航线:<span style="color:#3399EE">
							<g:each in="${user.recommendedRoutes.category }" var="d">
							${d }、
							</g:each>
							
							</span>
						</div>
						<div class="company-name">
							地址:<span style="color: orange"> ${user.address}
							</span>
						</div>
						 <br/>
						<ul class="evaluate">
							<li><span>好评率:<em class="cheng">暂无</em></span></li>
							<li><span>服务评价:<em class="cheng">暂无</em></span></li>
							<li><span>发盘次数:<em class="cheng">0</em></span></li>
							<li><span>报价次数:<em class="cheng">0</em></span></li>
							<li><span>成交量:<em class="cheng">暂无</em></span></li>
						</ul></li>
				</ul>
			</div>
			<div class="profile-zone">
				<div class="profile">优势简介&nbsp;：&nbsp;...</div>
				<div class="profile">个人介绍&nbsp;：&nbsp;...</div>
			</div>
		</div>

	</div>

	<div class="helppage needtop needsearch"></div>
</body>
</html>