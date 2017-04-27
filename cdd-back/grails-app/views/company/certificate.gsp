<g:set var="ossRoot" value="http://${grailsApplication.config.oss.endpointDomain}/${grailsApplication.config.oss.publicbucket}/"></g:set>
<!DOCTYPE html>
<html>
<head>
<title>角色列表</title>
<meta name="layout" content="main">
<asset:stylesheet src="table.css" />
<asset:stylesheet src="upload_license.css" />
<asset:stylesheet src="jquery.typeahead.css" />
<asset:javascript src="list-table.js" />
<asset:javascript src="upload_license.js" />
<asset:javascript src="jquery.typeahead.js" />
<asset:stylesheet src="form-table.css" />

</head>

<body>
<div class="col-lg-12">
<div class="lump" ><%--style="background-color:#2C5C82" --%>
	<div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">认证</div>
       <!-- 左半部分显示区-->
       <div style="clear:both"></div>
       <%--<div class="company-list-left" style="background-color:#234968; margin-top:10px;">
         --%><%--<h4>认证</h4>
        --%><%--<div id="request-list" >
        --%><table  width="500">
        
        	<tr>
                <td><input type="hidden" id="companyCertificateId" value="${data.id}"/></td>
            </tr>
            <tr>
                <td  class="company-info-list">公司名称:</td>
                <td><input type="text" name="companyName"  readonly="readonly" id="companyName" class="text w3" maxlength="20" value="${data.companyName}"/></td>
            </tr>
            <tr>
                <td class="company-info-list">营业执照编号:</td>
                <td><input type="text"/ id="businessLicenseNum" readonly="readonly" class="text w3"name="businessLicenseNum" maxlength="30" value="${data.businessLicenseNum}"/></td>
            </tr>
            <tr>
                <td class="company-info-list">公司类型:</td>
                <td><input type="text" name="type"  readonly="readonly" id="type" class="text w3" maxlength="20" value="${data.type}"/></td>
            </tr>
            <tr>
                <td class="company-info-list">公司规模:</td>
                <td><input type="text"/ id="workers" class="text w3"name="workers" readonly="readonly" maxlength="20" value="${data.workers}"/>(人)<br/></td>
            </tr>
            <tr>
                <td class="company-info-list">公司资本:</td>
                <td><input type="text"/  id="regCapital" class="text w3"name="regCapital" readonly="readonly" maxlength="20" value="${data.regCapital}"/>(万)<br/></td>
            </tr>
            
            <tr>
                <td class="company-info-list">所在地址:</td>
                <td><input type="text"/  id="address" class="text w3" name="address" readonly="readonly" maxlength="20" value="${data.address}"/></td>
            </tr>
            <tr>
                <td class="company-info-list">关注航线:</td>
                <td><input type="text"/  id="advancedRoute" class="text w3" name="advancedRoute" readonly="readonly" maxlength="20" value="${data.advancedRoute}"/></td>
            </tr>
        </table>

         <ul class="img-list" id="img-list-left">
            <li class="corp_license">
                  <img data-corplicense="yes" src="${ossRoot + data.businessLicenseImg}">
             </li>
             <li class="tax_license">
                 <img  data-taxlicense="yes" src="${ossRoot + data.taxImg}" >
             </li>
             <li class="license">
                 <img data-orgnizelicense="yes" src="${ossRoot + data.companyCodeImg}" >
             </li>
     </ul>
     </div>
       </div>
       <div class="zoom-up-image-left">
           <img src="" alt="公司三证" >
       </div>
       <!-- 右半部分显示区-->
       <div class="company-list-right" id="company-list-right">
           <form>
               <div class="typeahead-container">
                   <div class="typeahead-field">

            <span class="typeahead-query">
                <input id="search-input-box"
                       name="search-input-box"
                       type="search"
                       autocomplete="off">
            </span>
            <span class="typeahead-button">
                <button type="submit">
                    <span class="typeahead-search-icon"></span>
                </button>
            </span>

                   </div>
               </div>
           </form>
           <!--<div>
               <a role="button"> 搜索</a>
               <label class="search-company">
                   <input type="text" id="search-input-box" >
               </label>
           </div>-->
           <div id="search-result" style="visibility:hidden">
           <table  width="500">
               <tr>
                   <td  class="company-info-list">公司名称:</td>
                   <td id="company-name">{companyName}</td>
               </tr>
               <tr>
                   <td class="company-info-list">营业执照编号:</td>
                   <td>{businessLicenseNum}</td>
               </tr>
               <tr>
                   <td class="company-info-list">公司类型:</td>
                   <td>{types}</td>
               </tr>
               <tr>
                   <td class="company-info-list">公司规模:</td>
                   <td>{workers}</td>
               </tr>
               <tr>
                   <td class="company-info-list">公司资本:</td>
                   <td>{regCapital}</td>
               </tr>
               
               <tr>
                   <td class="company-info-list">所在地址:</td>
                   <td>{address}</td>
               </tr>
               <tr>
                   <td class="company-info-list">关注航线:</td>
                   <td>{advancedRoute}</td>
               </tr>
           </table>

           <ul class="img-list" id="img-list-right">
               <li class="corp_license">
                   <img data-corplicense="yes" src="{businessLicenseImg}">
                  <!-- <img data-corplicense="yes" src="corp_license.jpg">--><!--{business_license_img}-->
               </li>
               <li class="tax_license">
                  <img data-taxlicense="yes" src="{taxImg}">
                   <!--<img data-taxlicense="yes" src="tax_license.jpg">--><!--{tax_img}-->
               </li>
               <li class="license">
                   <img data-orgnizelicense="yes" src="{companyCodeImg}">
                   <!--<img data-orgnizelicense="yes"  src="orgnize_license.jpg">--><!--{company_code_img}-->
               </li>
           </ul>
          </div>
       </div>
       <div class="zoom-up-image-right">
         
            <img src="" alt="公司三证">
       </div>

   
  <table class="verify-content-zone">
      <tr>
          <td class="audit-opinion">审核意见:</td>
          <td> <textarea class="audit-advice" id="audit-advice"  ></textarea> </td>
       </tr>
      <tr>
          <td colspan="2">
          <button id="verify-passed">认证通过</button>
          <button id="verify-fail">认证拒绝</button>
          <button id="add-verified-company">添加认证公司</button>
          <button id="back-button">返回</button>
          </td>
      </tr>

   </table>



<script>
var ossRoot1 ='http://${grailsApplication.config.oss.endpointDomain}/${grailsApplication.config.oss.publicbucket}/'
</script>
	<%--<div class="row">
		<div class="col-lg-12">
			<div class="block">
				<table id="list">
		<formTable:tr title='猛戳这里'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" id="rec" value="认证该公司">
					 
					</formTable:tr>
					<g:if test="${params}">
						<g:each in="${params }" var="d" status="b">
							<formTable:tr title='图片${b+1}'>
								<img
									src="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/${d.businessLicenseImg}" />
							</formTable:tr>
						</g:each>
					
					</g:if>
					<g:else>
					<h1>此公司暂未上传三证 /(ㄒoㄒ)/~~</h1>
					<br/>
					<a href="" onclick="javascript:history.back();">猛戳-->返回 </a>
					</g:else>
				</table>
			</div>
		</div>
	</div>
	<script>
	$("#rec").click(function() {
			window.location.href = '${request.contextPath}/company/recognized?id=${companyId}';
						});
	
var selectedDatas = []
$(function() {
	$('#list').bootstrapTable({
		url : '${request.contextPath}/company/certificate?dataType=json&requestDate='+new Date(),
		sidePagination : 'server', // client or server
		formatSearch : function() {
			return '图片名';
		},
		columns : [ {
			checkbox : true
		}, {
			field : 'image',
			title : '图片',
			formatter : function (value, row, index) {
				return '<img src="http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/' + value + '" />';
			}
		},  {
			field : 'id',
			title : '操作',
			formatter : function (value, row, index) {
				return [
						'<a class="datatable_operation edit" href="javascript:void(0)" title="修改">',
						'修改', 
						'</a>' 
				].join('');
			},
			events : operateEvents
		} ]
	}).on('check.bs.table', function (e, row) {
		triggerRowSelection();
    }).on('uncheck.bs.table', function (e, row) {
    	triggerRowSelection();
    }).on('check-all.bs.table', function (e) {
    	triggerRowSelection();
    }).on('uncheck-all.bs.table', function (e) {
    	selectedDatas.length = 0;
    });

	
	var addBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-primary-flat table-btn">创建</a>')
	$(".datatable-search-btn").before(addBtn);
	addBtn.click(function() {
		window.location.href = '${request.contextPath}/advCorp/data/new';
	})
	
	var deleteBtn = $('<a href="javascript:;" class="button button-glow button-rounded button-caution-flat table-btn">删除</a>')
	$(addBtn).before(deleteBtn);
	deleteBtn.click(function() {
		if(selectedDatas.length > 0) {
			BootstrapDialog.confirm("确定要删除选定记录吗？", function(result) {
				if(result) {
					window.location.href = '${request.contextPath}/advCorp/delete/?ids=' + selectedDatas.join();
				}
			});
		} else {
			BootstrapDialog.show({
				message: '请选择至少一条记录'
			});
		}
	})
});

window.operateEvents = {
	'click .edit' : function(e, value, row, index) {
		window.location.href = '${request.contextPath}
		/advCorp/data/'
						+ value
			}
		};
	</script>
--%>

</div>
</body>
</html>
