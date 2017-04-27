<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
        <meta name="layout" content="main">
        <asset:stylesheet src="form-table.css" />
        <asset:javascript src="jquery-1.8.0.min.js"/>
        <asset:javascript src="jquery.validate.js"/>
    <style type="text/css">
		 .red { 
            display: inline-block;
            font-weight: normal;
            color: #ff0000;
            margin-left: 5px;
        }
    </style>
    <script type="text/javascript">

      		 function validate(form)
      		 {
      			var portName = $.trim($("#portName").val());

    			var portEnglishName = $.trim($("#portEnglishName").val());
    			
    			var code = $.trim($("#code").val());

    			var codeSimple = $.trim($("#codeSimple").val());

    			var countryCh = $.trim($("#countryCh").val());

    			var countryEn = $.trim($("#countryEn").val());

    			if(portName==""||portName==null){
    				$("#span_portName").text("请输入中文名!");
    				 portName.focus();
    				return false;
    			}else{
    					$("#span_portName").text(" ");
        			}
    			if(portEnglishName==""||portEnglishName==null){
    				$("#b_portEnglishName").text("请输入英文名!");
    				portEnglishName.focus();
    				return false;
    			}else{
    					$("#b_portEnglishName").text(" ");
        			}
    			if(code==""||code==null){
					 $("#b_code").text("请输入港口编码!");
    				  code.focus();
    				  return false;
        		}else{
        			 	$("#b_code").text(" ");
            		}
				if(codeSimple==""||codeSimple==null){
					$("#b_codeSimple").text("请输入编码简称!");
					codeSimple.focus();
					return false;
				}else{
						$("#b_codeSimple").text(" ");
					}
				if(countryCh==""||countryCh==null){
					$("#b_countryCh").text("请输入国家中文名!");	
					countryCh.focus();
					return false;
				}else{
						$("#b_countryCh").text(" ");	
					}
    			if(countryEn==""||countryEn==null){
        			$("#b_countryEn").text("请输入国家英文名!");
        			countryEn.focus();
        			return false;
        		}else{
        				$("#b_countryEn").text("");
            		}
          		$("#dataForm").submit();
      		 } 
    </script>
</head>
<body>
<div class="col-lg-12">
		<div class="lump">
		        <div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">目的港信息</div>
<form action="${request.contextPath}/endPort/save" method="post" id="dataForm" >
  
     <formTable:table>
        <tr>
       		 <input type="hidden" name="id" value="${data.id}" />
        </tr>
	     	 	<formTable:tr title='中文名:'>
					<input type="text"  value="${data.portName}" name="portName" placeholder="中文名" id="portName" /><span class="red" id="span_portName">*</sapn>
				</formTable:tr>
				<formTable:tr title='英文名:'>
					<input type="text"  value="${data.portEnglishName}"   name="portEnglishName" placeholder="英文名" id="portEnglishName" /><b class="red" id="b_portEnglishName">*</b>
				</formTable:tr>
				<formTable:tr title='港口编码:'>			  
					<input type="text"  value="${data.code}"   name="code"  placeholder="港口编码" id="code" /><b class="red" id="b_code">*</b>
				</formTable:tr>
				<formTable:tr title='编码简称:'>
					<input  type="text" value="${data.codeSimple}"  name="codeSimple"  placeholder="编码简称" id="codeSimple" /><b class="red" id="b_codeSimple">*</b>
				</formTable:tr>
				<formTable:tr title='国家中文名:'>
					<input type="text"   value="${data.countryCh}"   name="countryCh"  placeholder="国家中文名" id="countryCh" /><b class="red" id="b_countryCh">*</b>
				</formTable:tr>
				<formTable:tr title='国家英文名:'>
					<input type="text"    value="${data.countryEn}"   name="countryEn" placeholder="国家英文名" id="countryEn" /><b class="red" id="b_countryEn">*</b>
				</formTable:tr>
	      		<formTable:tr title='所属航线：'>
					<select name="route" id="route-select" class="selectpicker">
							<option value="">--请选择--</option>
							<option value="${data.route?.id}" selected="selected">${data.route?.routeName}</option>
	                      		<option value="1">中东印巴红海线</option>
	                      		<option value="2">中美加勒比海墨西哥线</option>                    
	                      		<option value="3">欧洲线</option>
	                     			<option value="4">非洲线</option>
	                      		<option value="5">南美线</option>
	                     			<option value="6">澳新太平洋群岛线</option>
	                      		<option value="7">北美线</option>
	                     			<option value="8">中亚俄罗斯线</option>
	                     			<option value="9">地中海黑海线</option>
	                      		<option value="10">东南亚日韩台湾线</option>
	                      		<option value="11">其他</option>
	                  </select><b class="red">*</b>
				</formTable:tr>
				<formTable:tr title='备注:'>
						<textarea type="text"  name="remark"  placeholder="备注" style="height:100px">${data.remark}</textarea>
					</formTable:tr>
				<%--
            	
            
            <tr>
                <td class="td-first"><span style="color:#717171">所属航线</span></td>
                <td class="td-second">
                    <select name="route" id="route-select" >
                    
                        <option value="${data.route?.id}">${data.route?.routeName}</option>
                        <option value="1">中东印巴红海线</option>
                        <option value="2">中美加勒比海墨西哥线</option>                    
                        <option value="3">欧洲线</option>
                        <option value="4">非洲线</option>
                        <option value="5">南美线</option>
                        <option value="6">澳新太平洋群岛线</option>
                        <option value="7">北美线</option>
                        <option value="8">中亚俄罗斯线</option>
                        <option value="9">地中海黑海线</option>
                        <option value="10">东南亚日韩台湾线</option>
                        <option value="11">其他</option>
                        
                        
                    </select><b>*</b>

                </td>
            </tr>
            --%><%--
            <tr>
                <td></td>
                <td>
                    <input type="submit" id="revise-btn" class="revise-btn"   value="保存"/>
                    <button type="button" id="return-btn" class="return-btn" >取消</button>
                    <p style="margin-bottom: -25px;">带有*的为必填项</p>
                </td>
            </tr>
        </table> onclick="$('#dataForm').submit();"
        --%></formTable:table>
       	<div class="buttons">
        		<a href="javascript:;"   onclick="return validate(this.form)" class="button button-glow button-rounded button-raised button-primary pull-right">保存</a>
				<a href="javascript:;" onclick="window.history.back()"  class="button button-glow button-rounded button-raised button-primary" id="back" style="margin-left: 930px;">返回</a>
        		 <p style="margin-bottom: -25px;">带有*的为必填项</p>
        		<div class="clearfix"></div>
		</div>
        </form>
       </div>
      </div> 
</form>
</body>
</html>