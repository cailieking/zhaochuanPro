<g:if test="${!menu.children}">
	<li name="menuchild" style="line-height:2.5">
		<a href="${request.contextPath}${menu.map.uri}" name="child"> 
			<%-- <g:if test="${menu.icon}"> --%>
              <i class="fa fa-angle-right" style="border-right: 1px solid rgba(255, 255, 255, 0.05);
float: left;
font-size: 14px;
line-height: 44px;
margin: -5px 10px -12px 0px;
overflow: hidden;
position: relative;
text-align: center;
width: 44px;"></i> 
          	<%-- </g:if> --%>
            <span>${menu.name}</span>
		</a>
	</li>
</g:if> 
<g:else>
	<li class="dropdown-submenu">
		<a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown">
			<%-- <g:if test="${menu.icon}">
              <i class="fa fa-${menu.icon}"></i> 
          	</g:if>--%>
          	 <i class="fa fa-angle-right" style="border-right: 1px solid rgba(255, 255, 255, 0.05);
						float: left;
						font-size: 14px;
						line-height: 44px;
						margin: -12px 10px -12px 0px;
						overflow: hidden;
						position: relative;
						text-align: center;
						width: 44px;"></i> 
            <span>${menu.name}</span>
		</a>
        <ul class="dropdown-menu">
            <g:render template="/templates/submenuTemplate" collection="${menu.children}" var="menu"/>
        </ul>
	</li>
</g:else>

