<%@page import="com.cdd.base.domain.BackUser"%>
<%@page import="com.cdd.base.enums.ArticleType"%>
<g:set var="ossDomain" value="http://${grailsApplication.config.oss.endpointDomain}/${grailsApplication.config.oss.publicbucket}"></g:set>
<!DOCTYPE>
<html>
<head>
<title>合作商信息</title>
<meta name="layout" content="main">
<ckeditor:resources/>
<asset:javascript src="jquery.multi-select.js" />
<asset:stylesheet src="form-table.css" />
<asset:stylesheet src="role/data.css" />
<asset:stylesheet src="c_css/common.css" />
<asset:stylesheet src="c_css/animate.min.css" />
<asset:stylesheet src="c_css/light-bootstrap-dashboard.css" />
<asset:stylesheet src="c_css/pe-icon-7-stroke.css" />
<asset:stylesheet src="c_css/demo.css" />
<asset:stylesheet src="c_css/article.css" />
<asset:javascript src="replace.js" />
<asset:javascript src="c_js/article.js" />
<asset:javascript src="c_js/common.js" />
<asset:javascript  src="/ckeditor/ckeditor.js" />
<asset:javascript  src="replace.js" />
 <asset:javascript src="jquery.validate.min.js"/>
</head>
<body>
<div class="col-lg-12">
 <div class="content">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-8" style="width:100%">
                        <div class="card">
                            <div class="header">
                                <h4 class="title"></h4>
                            </div>
                            <div class="content">
                                <form id="article_form" enctype="multipart/form-data" action=""   >
                                	<input type="hidden" value="${data?.id}" name="id"/>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><span class="red" >*</span>&nbsp;文章标题：</label>
                                                <input type="text" class="form-control" placeholder="文章标题"  name="title" id="title" value="${data?.title}" maxlength="50"/>
                                            </div>        
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><span class="red" >*</span>&nbsp;特推标题：</label>
                                                <input type="text" class="form-control" placeholder="特推标题" name="tweetTitle" id="tweetTitle"  value="${data?.tweetTitle}" maxlength="16"/>
                                            </div>        
                                        </div>
                                    </div>
                                     <div class="row">
                                    	<div class="col-md-12">
                                            <div class="form-group">
                                                <label><span class="red" >*</span>&nbsp;文章概要：</label>
                                                <input type="text" class="form-control" placeholder="文章概要" name="articleSummary" id="articleSummary" value="${data?.articleSummary}" maxlength="72"/>
                                            </div>        
                                        </div>
                                    </div>
                                    <div class="row">
                                    <div class="col-md-6">
                                            <div class="form-group">
                                                <label>来源说明：</label>
                                                <input type="text" class="form-control" placeholder="来源" name="comes"  value="${data?.comes}" />
                                            </div>        
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>来源链接：</label>
                                                <input type="text" class="form-control" placeholder="来源链接" name="sourceUrl"  value="${data?.sourceUrl}" />
                                            </div>        
                                        </div>
                                   </div>
                                    
                                    
                                     <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>title：</label>
                                                <input type="text" class="form-control" placeholder="title" name="headTitle" value="${data?.headTitle}" />
                                            </div>        
                                        </div>
                                     </div>
                                    
                                    
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>keywords：</label>
                                                <input type="text" class="form-control" placeholder="keywords" name="keywords" value="${data?.keyWords}" />
                                            </div>        
                                        </div>
                                    </div>
                                      <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>Description：</label>
                                                <textarea rows="5" class="form-control" placeholder="描述。。"  name="description"> ${data?.description}</textarea>
                                            </div>        
                                        </div>
                            		 </div>
                          	        <div class="row">
                                  		  <div class="col-md-4" style="width: 12%;">
                                            <!--  <div class="form-group">-->
                                                 <label>页面标签：</label>
                                                <!-- <span  class="form-control" ></span> -->
                                          <!--  </div>     -->   
                                        </div>
                                        <g:if test="${data?.pageTag}">
                                        	<g:each in="${data?.pageTag?.split(',')}" var="tag" status="m">
                                         	 <div class="col-md-4" style="width: 16%;">
                                           		 <div class="form-group">
                                              		  <label></label>
                                               		 <input type="text" class="form-control" placeholder="标签+${m+1}" name="pageTag" value="${tag.substring(tag.indexOf(':')+1)}">
                                          		  </div>        
                                        		</div>
                                       		 </g:each>
                                        </g:if>
                                       	<g:else>
                           	            	<g:each in="${(1..<6)}" var="tag" status="m">
                                       		<div class="col-md-4" style="width: 16%;">
                                           		 <div class="form-group">
                                              		  <label></label>
                                               		 <input type="text" class="form-control" placeholder="标签${m }" name="pageTag" value="">
                                          		  </div>        
                                        		</div>
                                        	</g:each>
                                       	</g:else>
                                    </div>
                                    
                       <div class="row">         
		                     <div class="form-group">
		                        <label class="col-sm-2 control-label col-lg-2" for="inputSuccess" ><span class="red" >*</span>&nbsp;文章类型：</label>
		                        <div class="col-lg-10" style="width:30%">
		                        	<g:each in="${ArticleType.values()}" var="type" >
										<g:if test="${data?.articleType == type}">
											 <label class="checkbox-inline">
		                              		  	<input type="radio" id="inlineCheckbox1" value="${type.name()}" name="articleType" checked="true">${type.text}
		                            		 </label>
										</g:if>
										<g:else>
										 <label class="checkbox-inline">
		                               		 <input type="radio" id="inlineCheckbox2" value="${type.name()}" name="articleType"> ${type.text}
		                            	</label>
										</g:else>
								</g:each>
		
		                        </div>
                        </div>  
                        </div>          
                          
                               <div class="row" style="margin-top: 15px">
                               		<div class="form-group" >
                               				<label class="col-sm-2 control-label col-lg-2" for="inputSuccess"><span class="red" >*</span>&nbsp;标题图片：</label>
							                <div class="imageUpBg" style="height:auto" name="first_row">
							                	
							                	<g:if test="${data?.image != null && data?.image != ""}">
							                		<div id="createImageUpBtn" class="upBtn btnMod2" style="display:none;" >上传图片</div>
							                		<img src="${ossDomain+'/'+data?.image}" class="imageShow"/>
							                		<input id="createImageUpFile" type="file" style="display:none;" name="titleImg" id="titleImg"/>
							                		<div style="clear:both;" >
							                  			<div class="row" style="padding-left: 10px">
							                    			<div class="blueBtn" >查看原图</div><div class="blueBtnD">删除</div><div class="blueBtnU" onclick='upBodyImg("createImageUpBtn")'>修改</div>
														</div>
														<div class="row" style="width: 200%">
															<span  style="margin:5px 0px 0px 14px;float:left;">连接： </span><a class="blueBtn" >${ossDomain+"/"+data?.image}</a><input type="hidden" value="${data?.image}" name="image" id="image"/><div class="blueBtnU"  onclick="Copy(event)">复制连接</div>
														</div>
													</div>
							                	</g:if>
												<g:else>
													<div id="createImageUpBtn" class="upBtn btnMod2" ">上传图片</div>
													<img src="${ossDomain+'/'+data?.image}" class="imageShow" style="display:none;" />
													<input id="createImageUpFile" type="file" style="display:none;" name="titleImg" id="titleImg"/>
													<div style="clear:both;display:none;" >
							                  			<div class="row" style="padding-left: 10px">
							                    			<div class="blueBtn" >查看原图</div><div class="blueBtnD">删除</div><div class="blueBtnU" onclick='upBodyImg("createImageUpBtn")'>修改</div>
														</div>
														<div class="row" style="width: 200%">
															<span  style="margin:5px 0px 0px 14px;float:left;">连接： </span><a class="blueBtn" ></a><input type="hidden" value="${data?.image}" name="image" id="image"/><div  class="blueBtnU"  onclick="Copy(event)">复制连接</div>
														</div>
													</div>
												</g:else>
							                		<!--  <input id="createImageUpFile" type="file" style="display:none;" name="titleImg" />-->
							                </div>
							                <div class="imageDataBg">
							                    <div class="fileName"></div>
							                </div>
                               				<!--<label class="col-sm-2 control-label col-lg-2" for="inputSuccess">文章类型</label>-->
                               		</div>
                               </div>  
                               
                               <textarea id="image_url" style="width:0px;height:0px;opacity:0;filter:alpha(opacity=0);"></textarea>
                                 <div class="row" style="margin-top: 15px">
                               		<div class="form-group">
                               				<!--  <div class="wLabel">图片：<div class="imp"></div></div>-->
                               				<label class="col-sm-2 control-label col-lg-2" for="inputSuccess">正文图片：</label>
                               				<g:if test="${data?.articleImgs}">
                               					<g:each in="${data?.articleImgs.split(',')}" var="img" status="m">
                               						<g:if test="${m==0}">
                               							<div class="row">
							            		   			<div class="imageUpBg" style="height:auto" name="first_row">
							                				<div id="createImageBodyBtn" class="upBtn btnMod2" style="display:none;">上传图片</div>
															<img src="${img}" class="imageShow" />
							                				<input id="createImageBodyFile" type="file" style="display:none;" name="bodyImg" />
							                  		   		<div style="clear:both;" >
							                    			<div class="row" style="padding-left: 10px">
							                    				<div class="blueBtn" >查看原图</div><div class="blueBtnD">删除</div><!--onclick='upBodyImg("createImageBodyBtn")' -->
							                    			</div>
							                    			<div class="row" style="width: 200%">
															<span  style="margin:5px 0px 0px 14px;float:left;">连接： </span><a href="${img}" class="blueBtn" >${img}</a><input type="hidden" value="${img.substring(img.indexOf('/files')+1)}" /><div class="blueBtnU"  onclick="Copy(event)">复制连接</div>
															<div style="margin:5px;float:left;color:#0088dd;cursor: pointer" name="insert_img" >插入文章</div>
															</div>
														</div>
							              	  			</div>
							              	  			</div>
                               						</g:if>
                               						<g:else>
                               								<label class="col-sm-2 control-label col-lg-2" for="inputSuccess"></label>
                               								<div class="row">
							            		   			<div class="imageUpBg" style="height:auto" >
							                				<div id="createImageBodyBtn" class="upBtn btnMod2" style="display:none;">上传图片</div>
															<img src="${img}" class="imageShow" />
							                				<input id="createImageBodyFile" type="file" style="display:none;" name="bodyImg" />
							                  		   		<div style="clear:both;" >
							                    			<div class="row" style="padding-left: 10px">
							                    				<div class="blueBtn" >查看原图</div><div class="blueBtnD">删除</div><!--onclick='upBodyImg("createImageBodyBtn")' -->
							                    			</div>
							                    			<div class="row" style="width: 200%">
															<span  style="margin:5px 0px 0px 14px;float:left;">连接： </span><a href="${img}" class="blueBtn" >${img}</a><input type="hidden" value="${img.substring(img.indexOf('/files')+1)}" /><div class="blueBtnU"  onclick="Copy(event)">复制连接</div>
															<div style="margin:5px;float:left;color:#0088dd;cursor: pointer" name="insert_img" >插入文章</div>
															</div>
														</div>
							              	  			</div>
							              	  			</div>
                               						
                               						</g:else>
                               					</g:each>
                               				</g:if>
                               				<g:else>
                               					<div class="row">
							            		    <div class="imageUpBg" style="height:auto" name="first_row">
							                			<div id="createImageBodyBtn" class="upBtn btnMod2">上传图片</div>
														<img src="" class="imageShow" style="display:none;"/>
							                			<input id="createImageBodyFile" type="file" style="display:none;" name="bodyImg" />
							                  		    <div style="clear:both;display:none;" >
							                    			<div class="row" style="padding-left: 10px">
							                    				<div class="blueBtn" >查看原图</div><div class="blueBtnD">删除</div><!--onclick='upBodyImg("createImageBodyBtn")' -->
							                    			</div>
							                    		<div class="row" style="width: 200%">
															<span  style="margin:5px 0px 0px 14px;float:left;">连接： </span><a href="" class="blueBtn" ></a><input type="hidden" value="" /><div class="blueBtnU"  onclick="Copy(event)">复制连接</div>
															<div style="margin:5px;float:left;color:#0088dd;cursor: pointer" name="insert_img" >插入文章</div>
														</div>
													</div>
							              	  	</div>
							              	  	</div>
                               				</g:else>
                               				
							                <div class="imageDataBg" id="imageDataBgId">
							                    <div class="fileName"></div>
							                </div>
                               		</div>
                               </div>  
                               <g:if test="${data?.articleImgs}">
                             	  <div class="row" style="padding-left:10px;margin-top:15px; id="continue">
                             		  <div class="form-group">
                             	  		<label class="col-sm-2 control-label col-lg-2" for="inputSuccess" ></label>
										<div  onclick='continueImg("createImageBodyFile",event)' style="margin-left: -12px;color: #0088dd;cursor: pointer; float: left;">继续上传</div> 
								 	 </div>			
									</div>
                          		 </g:if>
                          		 <g:else>
                          			 <div class="row" style="padding-left:10px;margin-top:15pxd;display:none; id="continue">
                             		 	 <div class="form-group">
                             	  			<label class="col-sm-2 control-label col-lg-2" for="inputSuccess" ></label>
											<div  onclick='continueImg("createImageBodyFile",event)' style="margin-left: -12px;color: #0088dd;cursor: pointer; float: left;">继续上传</div> 
								 		 </div>			
										</div>
                          		 </g:else>
                           <div class="row" style="margin-top:15px">             
		                     <div class="form-group">
		                        <label class="col-sm-2 control-label col-lg-2" for="inputSuccess" style="width:100px">正文内容：</label>
		                        <div class="col-lg-10" style="width:16%">
		                          <p class="text-center">
		                          		<g:if test="${data?.articleState?.text=="草稿"}" >
		                          				<span class="label label-default">草稿</span>
		                          		</g:if>
		                          		<g:elseif test="${data?.articleState?.text=="撤销"}" >
		                          				<span class="label label-repeal">撤销</span>
		                          		</g:elseif>
		                          		<g:elseif test="${data?.articleState?.text=="发布"}" >
		                          				<span class="label label-success">发布</span>
		                          		</g:elseif>
		                          		<g:if test="${data?.articleCategory != null && data?.articleCategory.split(',').length == 2 }" >
		                          			<span class="label label-danger">置顶</span>
											<span class="label label-primary">特推</span>
		                          		</g:if>
		                          		<g:elseif test="${data?.articleCategory != null && data?.articleCategory.split(',').length != 2}">
		                          				<g:if test="${data?.articleCategory == '置顶'}">
		                          					<span class="label label-danger">置顶</span>
		                          				</g:if>
		                          				<g:else>
		                          					<span class="label label-primary">特推</span>
		                          				</g:else>
		                          		</g:elseif>
								  </p>	
		                        </div>
		                        <div class="col-lg-10"  style="width: 39.5%;margin-left:120px ">
		                            <g:if test="${data?.articleCategory != null && data?.articleCategory.split(',').length == 2 }">
										<label class="checkbox-inline">
											<input id="inlineCheckbox1" value="置顶" type="checkbox" name="articleCategory" checked="true">
											栏目置顶
										</label>
										<label class="checkbox-inline" style="margin-left:50px ">
											<input id="inlineCheckbox3" value="特推" type="checkbox" name="articleCategory" checked="true">
											首页特推	
										</label>
									</g:if>
									<g:elseif test="${data?.articleCategory != null && data?.articleCategory.split(',').length != 2}">
										<g:if test="${data?.articleCategory == '置顶'}"> 
											<label class="checkbox-inline">
												<input id="inlineCheckbox1" value="置顶" type="checkbox" name="articleCategory" checked="true">
												栏目置顶
											</label>
											<label class="checkbox-inline" style="margin-left:50px ">
												<input id="inlineCheckbox3" value="特推" type="checkbox" name="articleCategory">
												首页特推	
											</label>
										</g:if>
										<g:else>
											<label class="checkbox-inline">
												<input id="inlineCheckbox1" value="置顶" type="checkbox" name="articleCategory" >
												栏目置顶
											</label>
											<label class="checkbox-inline" style="margin-left:50px ">
												<input id="inlineCheckbox3" value="特推" type="checkbox" name="articleCategory" checked="true">
												首页特推	
											</label>										
										</g:else>
									</g:elseif>
									<g:else>
										<label class="checkbox-inline">
												<input id="inlineCheckbox1" value="置顶" type="checkbox" name="articleCategory" >
												栏目置顶
											</label>
											<label class="checkbox-inline" style="margin-left:50px ">
												<input id="inlineCheckbox3" value="特推" type="checkbox" name="articleCategory" >
												首页特推	
											</label>	
									</g:else>
								</div>
								<!--  <p style="">
									<button class="btn btn-default btn-sm" type="button" id="preview">预 览</button>
									 <button class="btn btn-default btn-sm" type="button">提 交</button>
									<button class="btn btn-default btn-sm" type="button">返 回</button> 
								</p>-->
		                    </div>
                        </div>  
							 <div class="row" style="margin-top:10px">
                                     <div class="col-md-12">
                                         <div class="form-group">
								<%-- <div class="modTextBox" style="width:956px;height:400px;">    id="${row.tagName}" name="${row.tagName}"
									 <textarea  cols="80" rows="10">  ${row.content?.encodeAsRaw()}</textarea> --%>
									 <textarea rows="5" class="form-control" placeholder="描述。。" name="articleContent" id="articleContent" style="margin-top: 20px">${data?.content.encodeAsRaw()}</textarea>
								 	  <script>
										 <%-- CKEDITOR.replace(${profile.catName});--%>
						 					$(function(){
						 						replace("articleContent")
						 						<%-- replace(${row.tagName})--%>
							 				})
								 		</script>
									</div>
 					   			</div>        
                              </div>
									<!--  <button type="submit" class="btn btn-info btn-fill pull-right" style="margin-left: 25px">预览</button>-->
                                 <div class="row" style="margin-top:10px;width: 77.5%">   
                                    <g:if test="${data?.articleState?.text == '发布' }">
                                   		  <input type="submit" class="btn btn-info btn-fill pull-right" style="margin-left: 25px;border-color: rgba(0, 0, 0, 0) !important"  value="撤销" /><input value="Repeal" type="hidden"></input>
                                          <input type="submit" class="btn btn-info btn-fill pull-right" style="margin-left: 25px;border-color: rgba(0, 0, 0, 0) !important"  value="提交" /><input value="update" type="hidden"></input>
                                         <!--   <button type="button" class="btn btn-info btn-fill pull-right" style="margin-left: 25px" onclick="createArticle('Repeal')">撤销</button>
                                          <button type="button" class="btn btn-info btn-fill pull-right" style="margin-left: 25px" onclick="createArticle('update')">提交</button>-->
                                    </g:if>
                                    <g:else>
                                    	  <input type="submit" class="btn btn-info btn-fill pull-right" style="margin-left: 25px;border-color: rgba(0, 0, 0, 0) !important"  value="发布"></input><input value="Issue" type="hidden"></input>
                                          <input type="submit" class="btn btn-info btn-fill pull-right" style="margin-left: 25px;border-color: rgba(0, 0, 0, 0) !important"  value="存为草稿"></input><input value="Draft" type="hidden"></input>
                                    	  <!--   <button type="button" class="btn btn-info btn-fill pull-right" style="margin-left: 25px" onclick="createArticle('Issue')">发布</button>
                                         <button type="button" class="btn btn-info btn-fill pull-right" style="margin-left: 25px" onclick="createArticle('Draft')">存为草稿</button> -->
                                    </g:else>
                                    <%-- <button type="button" class="btn btn-info btn-fill pull-right" style="margin-left: 25px" onclick="createArticle('Draft')">存为草稿</button>--%>
                                    <button type="button" class="btn btn-info btn-fill pull-right"  onclick="window.history.back()" style="margin-left: 25px" >返回</button>
                                    <button class="btn btn-info btn-fill pull-right" type="button" id="preview">预 览</button>
                                    </div>
                                    <div class="clearfix"></div>
                                </form>
                            </div>
                        </div>
                    </div>
                      <!-- <div class="col-md-4">
                        <div class="card card-user">
                            <div class="image">
                                <img src="https://ununsplash.imgix.net/photo-1431578500526-4d9613015464?fit=crop&fm=jpg&h=300&q=75&w=400" alt="..."/>   
                            </div>
                            <div class="content">
                                <div class="author">
                                     <a href="#">
                                    <img class="avatar border-gray" src="assets/img/faces/face-3.jpg" alt="..."/>
                                   
                                      <h4 class="title">Mike Andrew<br />
                                         <small>michael24</small>
                                      </h4> 
                                    </a>
                                </div>  
                               
                            </div>
                            <hr>
                            <div class="text-center">
                                <button href="#" class="btn btn-simple"><i class="fa fa-facebook-square"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-twitter"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-google-plus-square"></i></button>
    
                            </div>
                        </div>
                    </div> -->
               
                </div>                    
            </div>
        </div>
        </div>
    </body>
</html>    