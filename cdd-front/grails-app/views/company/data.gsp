<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="layout" content="main" />
<title>港口 - 找船网</title>
<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
<meta name="description" content="港口 - 找船网">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/biz/biz.css">
<link rel="stylesheet" type="text/css" href="/css/index/index.css">
<link rel="stylesheet" type="text/css"
	href="/css/commodity_price_page/more.css">
<script src="/js/jquery.js"></script>
<script src="/js/js.js"></script>
<script src="/js/common.js"></script>
</head>
<body>
	<div class="agent-resource-ctn">
		<div class="nav">
			<a href="http://www.zhao-chuan.com/">首页</a> <span class="divider">
				></span> <a href="/company">所有公司</a> <span
				class="divider"> ></span>当前：${params.company.companyName }
		</div>
		<div class="main-content">
			<div class="company-info">
				<div class="company-logo">
					<a href="javascript:void(0)"> <img
						src="/images/company/commodity_price_page/zc.jpg" alt="深圳站第一点"
						title="深圳市大新建材市场" width="150px" height="150px">
					</a>
				</div>
				<div class="company-detail">
					<div class="company-title">
						<div class="title">
							${params.company.companyName }<span class="verified-icon"
								title="认证用户"><img
								src="/images/company/commodity_price_page/verfied.png"
								alt="认证企业" style="width: 16px; height: 16px;"></span>
						</div>
						<span> ${params.company.englishName }
						</span>
					</div>
					<div class="company-classification">
						<ul>
							<li><span class="details">优势航线&nbsp;&nbsp;:&nbsp;&nbsp;
									${params.company.advancedRoute}
							</span></li>
							<li><span class="details">公司地址&nbsp;&nbsp;:&nbsp;&nbsp;${params.company.address}</span></li>
							<li><span class="details">业务范围&nbsp;&nbsp;:&nbsp;&nbsp;${params.company.businessRange}</span><span
								style="margin-left: 50px" class="details">公司信誉&nbsp;&nbsp;:&nbsp;&nbsp;
                          <g:if test="${params.company.verified}">
								<img
									src="/images/company/heart.png">&nbsp;信誉  
								</g:if><g:else>
								<img
									src="/images/company/unheart.png">&nbsp;<a href="#">信誉认证</a> 
								</g:else>
</span></li>
						</ul>
					</div>
				</div>
				<div style="both: clear;"></div>
				<%--<div class="company-brief">
                 <div> 公司简介&nbsp;&nbsp;:&nbsp;&nbsp;</div>
                 <span class="brief">${params.company.introduce }</span>
             </div>
             <br/>
          
             --%>
				<div class="company_brief2">
					公司简介&nbsp;&nbsp;:&nbsp;&nbsp;<span class="brief"> ${params.company.introduce }
					</span>
				</div>
				<div class="company_brief2">
					成立时间&nbsp;&nbsp;:&nbsp;&nbsp;<span class="brief"> ${params.company.bulidTime}
					</span>
				</div>
				<div class="company_brief2">
					公司规模&nbsp;&nbsp;:&nbsp;&nbsp;<span class="brief"> ${params.company.workers}
					</span>
				</div>
				<div class="company_brief2">
					注册资本&nbsp;&nbsp;:&nbsp;&nbsp;<span class="brief"> ${params.company.regCapital}
					</span>
				</div>
				<div class="company_brief2">
					公司网址&nbsp;&nbsp;:&nbsp;&nbsp;<span class="brief"> <g:if
							test="${params.company.website}">
							${params.company.website}
						</g:if>
					</span>
				</div>


			</div>
			<div style="clear: both;"></div>
			<div class="first-header">
				<span>向他们咨询</span>
			</div>
			<!-- manager page begin -->
			<g:if test="${params.user}">
			 
		
			<g:each in="${params.user}" var="d" status="i">
				<div class="consult">
					<ul>
						<li class="last"><span class="member-image"> <a
								href="javascript:void(0);"> <img
									src="/images/company/commodity_price_page/default.jpg" alt="me">
							</a>
						</span> <span class="member-credit"> <span class="member-title">
									<span><a href="javascript:void(0);"> ${d.firstname.substring(0, 1) }先生
									</a></span> 
									
									<span class="vtruename" title="认证用户">
									<g:if test="${d.verified}">
								<img
									src="/images/company/verfied.png">&nbsp;认证用户
								</g:if><g:else>
								<img
									src="/images/company/unverfied.png">&nbsp;认证用户
								</g:else>
									</span>
									
								<span class="vtruename" title="诚信用户">
								<g:if test="${d.verified}">
								<img
									src="/images/company/honest.png">&nbsp;诚信用户
								</g:if><g:else>
								<img
									src="/images/company/unhonest.png">&nbsp;诚信用户
								</g:else>
									</span>
									
								<span class="vtruename" title="信誉用户">
								<g:if test="${d.verified}">
								<img
									src="/images/company/heart.png">&nbsp;信誉用户
								</g:if><g:else>
								<img
									src="/images/company/unheart.png">&nbsp;信誉用户
								</g:else>
							</span></span>
								<div class="callhim">
									<a href="/company/finduser?id=${d.id}"
										style="text-decoration: none;">联系他</a>
								</div>
						</span>
							<ul class="evaluate">
								<li><span>服务评价:<em class="cheng"> </em></span></li>
								<li><span>服务评价:<em class="cheng">暂无</em></span></li>
								<li><span>服务评价:<em class="cheng">暂无</em></span></li>
							</ul></li>
					</ul>
				</div>
			</g:each>
				</g:if><g:else>
				<br/>
					<br/>
			<span style="font-size:18px;color:orange; "> 暂无经理  </span>
				</g:else>
			<!-- manager page over -->
		</div>

	</div>

	<div class="helppage needtop needsearch"></div>
</body>
</html>