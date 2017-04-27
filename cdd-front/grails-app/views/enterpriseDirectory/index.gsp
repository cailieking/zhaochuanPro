<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main" />
    <title>企业名录 - 找船网</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"></meta>
	<meta name="keywords" content="货代平台,国际货代,在线订舱,集装箱海运,特种柜海运,国际集装箱货运,海运货代,国际货运代理,深圳海运代理,深圳货代公司,海运费查询,平板柜海运,最新运价信息,船多多,找船网,深圳市找船网络科技有限公司">
    <meta name="description" content="找船网">
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <link rel="stylesheet" type="text/css" href="/css/dialog.css">
    <link rel="stylesheet" type="text/css" href="/css/tools.css">
    <link rel="stylesheet" type="text/css" href="/css/enterpriseDirectory/enterpriseDirectory_verify.css">
    <link rel="stylesheet" type="text/css" href="/css/enterpriseDirectory/kkpager_orange.css" />
    <script src="/js/jquery.js"></script>
    <script src="/js/js.js"></script>
    <script src="/js/common.js"></script>
    <script src="/js/dialog.js"></script>
    <script src="/js/enterprise/kkpager.js"></script>
<body>
<div class="company-area">
     <div class="header">
     
     
     <g:if test="${verified==true}">
         <h3>企业名录</h3>
         <div>
             <a href="javascript:void(0)"><img src="../images/enterprise/autherized.png"  ></a>
         </div>
     </div>
    <div class="company-show">
             <ul class="company-list">
             <% 
				int pagesize=map.pagesize ;
                int total=map.total;
				int curPages=map.curPage;
                int start=map.start;
                int end=map.end-1;
				int  pagesall=Math.ceil(total/pagesize);
                %>
            <g:each  in="${map.list[start..end]}" var="d" status="b">
                 <li class="company marginR">
                 
                     <div class="company-name">
                     <div style="background:#CCDBF0;height:40px;line-height:40px;">
                         <h3 class="name" style="width:455px">
                         	<span>公司名称: </span>
                         <span style="width:380px;display:inline-block;	*display:inline;*zoom:1;" class="companyName" title="${d.companyName}">${d.companyName}</span>
                         
                         </h3>
                         <span class="city">${d.city}</span>
                      </div> 
                         <div class="clear"></div>
                     <div class="company-info">
                         <table >
                         
                             <tr style="width:500px;">
                                 <td class='first'>
                                     <span>联系人:</span>
                                 </td>
                                 <td class="second">${d.contactName}</td>
                             </tr>
                             <%--<tr>
                                 <td  class='first'>电话:</td>
                                 <td class="second">${d.mobile}</td>
                             </tr>
                             
                             --%><tr>
                                 <td  class='first'>邮箱:</td>
                                 <td class="second">${d.email}</td>
                             </tr>
                             
                             <tr>
                                 <td  class='first'>地址:</td>
                                 <td class="second address" title="${d.address}">${d.address}</td>
                             </tr>

                         </table>
                        
                     </div>
                     </div>
                 </li>
               </g:each>
               </ul>
               <div class="clear"></div>
               
               <div style="width:400px;margin-right:42px;float:right;text-align:right;">
               <a href="/enterpriseDirectory/list?&curPage=<%=curPages-1>=0?curPages-1:curPages%>">上一页</a>&nbsp;&nbsp;
		当前页[${curPages+1}]&nbsp;&nbsp;&nbsp;<a
			 href="/enterpriseDirectory/list?curPage=<%=curPages+1>=pagesall?pagesall-1:curPages+1%>">下一页</a>
		&nbsp;&nbsp;&nbsp;go<input id="pagenum" type="text" 
			size="1" style="border: 1px solid green" />页 <input type="button"
			value="go" onclick="go()"/> &nbsp;&nbsp;&nbsp;共${pagesall}页
			</div>
			<script>
			$(function(){
				var $companyName =$(".companyName");
				var $companyAddress =$(".address");
				$companyName.each(function(){
						 $(this).html($(this).html().substring(0,40)+"...")
						 });
				$companyAddress.each(function(){
					 $(this).html($(this).html().substring(0,45)+"...")
					 })
					 

					});
			function go() {
				var page = $("#pagenum").val();
				window.location.href = "/enterpriseDirectory/list?curPage="
						+(page-1)
			}
		</script>
        <div style="width:800px;margin:0 auto;">
            <div id="kkpager"></div>
        </div>
           
            </div>
</g:if>
<g:else> 
 <h3>企业名录</h3>
         <div>
             <a href="/member/certificate"><img src="../images/enterprise/unautherized.png"  ></a>
         </div>
     </div>
    <div class="company-show-unautherized">
             <ul class="company-list">
             <% 
				int pagesize=map.pagesize ;
                int total=map.total;
				int curPages=map.curPage;
                int start=map.start;
                int end=map.end-1;
				int  pagesall=Math.ceil(total/pagesize);
                %>
            <g:each  in="${map.list[start..end]}" var="d" status="b">
                 <li class="company_unautherized marginR">
                 <div class="company-name">
                 <div style="background:#CCDBF0;width:100%;height:40px;line-height:40px">
                         <h3 class="name" style="width:455px">
                         	<span>公司名称: </span>
                         <span style="width:380px;display:inline-block;	*display:inline;*zoom:1;" class="companyName" title="${d.companyName}">${d.companyName}</span>
                         
                         </h3>
                 
                     
                         <span class="city">${d.city}</span>
                      </div>   
                         <div class="clear"></div>
                     <div class="company-info">
                         <table >
                          	<tr style="width:500px;">
                                 <td class='first'>
                                     <span>联系人:</span>
                                 </td>
                                 <td class="second">${d.contactName}</td>
                             </tr>
                             
                             <tr style="font-size:15px; width:500px">
                                 <td  class='first' style="height:40px;line-height:40px;font-size:13px;">地址:</td>
                                 <td class="second address" title="${d.address}" >${d.address}</td>
                             </tr>
							 <%--<tr style="font-size:15px;">
                                 <td  class='first'>邮箱:</td>
                                 <td class="second">${d.email}</td>
                             </tr>
                         --%></table>
                        
                     </div>
                     </div>
                 </li>
               </g:each>
               </ul>
               <div class="clear"></div>
               <div style="width:400px;margin-right:42px;float:right;text-align:right;">
               <a href="/enterpriseDirectory/list?&curPage=<%=curPages-1>=0?curPages-1:curPages%>">上一页</a>&nbsp;&nbsp;
		当前页[${curPages+1}]&nbsp;&nbsp;&nbsp;<a
			 href="/enterpriseDirectory/list?curPage=<%=curPages+1>=pagesall?pagesall-1:curPages+1%>">下一页</a>
		&nbsp;&nbsp;&nbsp;go<input id="pagenum" type="text" 
			size="1" style="border: 1px solid green" />页 <input type="button"
			value="go" onclick="go()"/> &nbsp;&nbsp;&nbsp;共${pagesall}页
			</div>
			<script>
			$(function(){
				var $companyName =$(".companyName");
				var $companyAddress =$(".address");
				$companyName.each(function(){
						 $(this).html($(this).html().substring(0,40)+"...")
						 });

					
			$companyAddress.each(function(){
				 $(this).html($(this).html().substring(0,40)+"...")
				 })

			});
			function go() {
				var page = $("#pagenum").val();
				window.location.href = "/enterpriseDirectory/list?curPage="
						+(page-1)
			}
			
				
			
				 

				
		</script>
        
           
            </div>

</g:else>
    </div>
</div>
<div class="enterpriselpage  helppage needtop needsearch"></div>
</body>
</html>