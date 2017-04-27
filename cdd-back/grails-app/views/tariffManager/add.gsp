<!DOCTYPE html>
<html>
<head>
	<title>运价发布</title>
    <meta name="layout" content="main">
	<asset:stylesheet src="c_css/common.css" />
	<asset:stylesheet src="c_css/shipping_send.css" />
	<asset:stylesheet type="text/css" href="c_css/error.css" />
	
	<asset:javascript src="c_js/common.js" />
	<asset:javascript src="c_js/jquery.js" />
	<asset:javascript src="c_js/shipping_send.js" />
	<asset:javascript src="/c_js/My97DatePicker/WdatePicker.js"/>
	<asset:javascript src="c_js/ajaxfileupload.js"/>
	<asset:javascript src="c_js/shipcommon.js"/>
</head>
<body>
<!--后台管理中部-->
<div class="manage_middle">
	<div class="manage_md_left">
    	
    </div>
    <div class="manage_md_right">
    	<div class="rTitle"><span></span></div>
        <ul class="rightNav1">
        	<li class="sel">单条发布</li>
            <li>批量导入</li>
        </ul>
        <!--右侧主体-->
        <div class="rContent">
        	<!--单次发布-->
         <form action="${request.contextPath}/tariffManager/bactchSave"  method="post" id="dataFormCreat" >
        	<div class="singleBg">
                <div>
                	<div class="sLabel">供应商：<div class="imp">*</div></div>
                    <input type="text" name="companyName"  id="companyName" class="box1 modTextBox" style="width:360px;" />
                    <div class="tishi1 modTishiBg">
                    	<div class="modTishiTxt">*为必填项</div>
                    </div>
                </div>
                <div>
                	<div class="sLabel">联系人：<div class="imp">*</div></div>
                    <input type="text" name="contactName" id="contactName" class="box1 modTextBox" />
                </div>
                <div>
                	<div class="sLabel">联系方式：<div class="imp">*</div></div>
                    <input type="text" name="phone" id="phone"  class="box1 modTextBox" />
                </div>
            	<div>
                	<div class="sLabel">起始港：<div class="imp">*</div></div>
                    <input type="text" name="startPort" id="startPort"  class="box1 modTextBox" />
                </div>
                <div>
                	<div class="sLabel">目的港：<div class="imp">*</div></div>
                    <input type="text" name="endPort" id="endPort" class="box1 modTextBox" />
                </div>
                <div>
                	<div class="sLabel">目的港：<div class="imp">*</div></div>
                	<input id="group1Radio1" name="group1" type="radio" checked onClick="transPortShow()" />
                    <label for="group1Radio1">直航</label>
                    <input id="group1Radio2" name="group1" type="radio" onClick="transPortShow()" />
                    <label for="group1Radio2">中转</label>
                    <div class="transPort">
                    	<span>中转港：</span>
                        <input type="text"  id="middlePort"  name="middlePort"  class="box1 modTextBox" />
                    </div>
                </div>
                <div>
                	<div class="sLabel">航程（天）：<div class="imp">*</div></div>
                	<input type="text"  name="shippingDays" id="shippingDays"  class="box2 modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))"/>
                    <div class="tishi2 modTishiBg">
                    	<div class="modTishiTxt">*请填写航程天数，例如：10、31。</div>
                    </div>
                </div>
                <div id="companysDiv">
                	<div class="sLabel">船公司：<div class="imp">*</div></div>
                	<input id="companysInputbox" type="text"  name="shipCompany"  class="box1 modTextBox" />
                    <div class="companysBg" style="display:none;">
                    	<div class="caption">请选择船公司</div>
                        <div class="cListLabel">A-G</div>
                        <ul class="cList">
                        	<li>ANL</li>
                            <li>APL</li>
                            <li>CMA</li>
                            <li>COSCO</li>
                            <li>CSCL</li>
                            <li>DELMAS</li>
                            <li>EMC</li>
                            <li>ESL</li>
                        </ul>
                        <div class="cListLabel">H-J</div>
                        <ul class="cList">
                        	<li>HMM</li>
                            <li>HPL</li>
                            <li>IAL</li>
                            <li>HANJIN</li>
                            <li>HEUNG-A</li>
                            <li>HAMBURG-SUD</li>
                        </ul>
                        <div class="cListLabel">K-N</div>
                        <ul class="cList">
                        	<li>K-LINE</li>
                            <li>KMTC</li>
                            <li>MARIANA</li>
                            <li>MCC</li>
                            <li>MOL</li>
                            <li>MSC</li>
                            <li>MSK</li>
                            <li>NYK</li>
                            <li>NAMSUNG</li>
                        </ul>
                        <div class="cListLabel">O-Z</div>
                        <ul class="cList">
                        	<li>OOCL</li>
                            <li>PHL</li>
                            <li>PIL</li>
                            <li>RCL</li>
                            <li>SAF</li>
                            <li>SITC</li>
                            <li>TSL</li>
                            <li>UASC</li>
                            <li>WHL</li>
                            <li>YML</li>
                            <li>ZIM</li>
                            <li>SINOTRANS</li>
                        </ul>
                        <div class="cListLabel">其他</div>
                        <ul class="cList">
                        	<li>不指定船公司</li>
                        </ul>
                    </div>
                </div>
                
                <div id="shipDayDiv">
                	<div class="sLabel">船期：<div class="imp">*</div></div>
                	<div class="shipDayBg">
                    	<div class="dayBoxBg">
                        	<input type="text" class="dayBox" id="jj" onkeyup="setInputOnlyNumDay($(this))" onafterpaste="setInputOnlyNumDay($(this))" />
                            <div class="dayBoxBtnBg">
                            	<div class="add" onClick="addShipDayNum($(this))">+</div>
                                <div class="sub" onClick="subShipDayNum($(this))">-</div>
                            </div>
                        </div>
                        <div class="dayLabel">截</div>
                        <div class="dayBoxBg">
                        	<input type="text" class="dayBox" id="kk"  onkeyup="setInputOnlyNumDay($(this))" onafterpaste="setInputOnlyNumDay($(this))" />
                            <div class="dayBoxBtnBg">
                            	<div class="add" onClick="addShipDayNum($(this))">+</div>
                                <div class="sub" onClick="subShipDayNum($(this))">-</div>
                            </div>
                        </div>
                        <div class="dayLabel">开</div>
                        <div class="dayAdd" onClick="addShipDay()">+</div>
                    </div>
                      <input type='hidden' name="total_shipping_date"  >
                </div>
                <div>
                	<div class="sLabel">运输类别：<div class="imp">*</div></div>
                	<input id="group2Radio1" name="group2" type="radio" checked  value="Whole"  onClick="boxPriceShow()" />
                    <label for="group2Radio1">整箱</label>
                    <input id="group2Radio2" name="group2" type="radio" value="Together" onClick="boxPriceShow()" />
                    <label for="group2Radio2">拼箱</label>
                </div>
                <div id="unitPrice" style="display:none;">
                	<div class="sLabel">单价(USD/CBM)：<div class="imp">*</div></div>
                	<input type="text"  name="per_price"  class="box1 modTextBox" />
                </div>
                <div id="minPrice" style="display:none;">
                	<div class="sLabel">最低消费(USD)：<div class="imp">*</div></div>
                	<input type="text" name="min_charge" class="box1 modTextBox" />
                </div>
                <div>
                	<div class="sLabel">有效期：<div class="imp">*</div></div>
                	<input type="text" name="startDate" id="startDate"  onClick="WdatePicker()"    class="box1 modTextBox" />
                    <div class="midLine">一</div>
                    <input type="text" name="endDate" id="endDate"  onClick="WdatePicker()"   class="box1 modTextBox" />
                </div>
                <div id="boxesPrice">
                	<div class="sLabel">运价：<div class="imp">*</div></div>
                	<div class="modTextBox shipPriceBg" style="height:64px;padding-top:10px;">
                    	<div style="clear:both;height:32px;line-height:32px;text-align:center;">
                        	<div style="margin:0 5px 0 55px;width:58px;height:32px;color:#2a9de9;float:left;">公开价</div>
                            <div style="margin:0 5px 0 0;width:58px;height:32px;color:#f00;float:left;">优惠价</div>
                            <div style="margin:0 5px 0 55px;width:58px;height:32px;color:#2a9de9;float:left;">公开价</div>
                            <div style="margin:0 5px 0 0;width:58px;height:32px;color:#f00;float:left;">优惠价</div>
                            <div style="margin:0 5px 0 55px;width:58px;height:32px;color:#2a9de9;float:left;">公开价</div>
                            <div style="margin:0 5px 0 0;width:58px;height:32px;color:#f00;float:left;">优惠价</div>
                        </div>
                    	<span>20GP</span>
                        <input type="text" name="gp20_common_price" id="gp20"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />
                        <input type="text" name="gp20_specical_price" id="gp20Vip" class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />
                        <span>40GP</span>
                        <input type="text"  name="gp40_common_price" id="gp40"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />
                        <input type="text"  name="gp40_specical_price" id="gp40Vip"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />
                        <span>40HQ</span>
                        <input type="text" name="hq40_common_price" id="hq40"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />
                        <input type="text" name="hq40_specical_price" id="hq40Vip"  class="pBox modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" style="margin-right:5px;" />
                    </div>
                    <div class="tishi3 modTishiBg" style="margin-left:5px;width:150px;">
                    	<div class="modTishiTxt">请至少填写一种箱型的运价，运价单位为“$"</div>
                    </div>
                </div>
                <div>
                	<div class="sLabel">附加费：<div class="imp"></div></div>
                	<div class="tishi4 modTishiBg">
                    	<div class="modTishiTxt">没有则不需要填写</div>
                    </div>
                    <div class="additional">
                    	<div class="gridTopBg">
                        	<div class="w1">名称</div>
                            <div class="w2">单位</div>
                            <div class="w3">柜型</div>
                            <div class="w4">单票价格</div>
                            <div class="w5">币种</div>
                            <div class="w6"></div>
                        </div>
                        <div class="gridRow">
                        	<div class="w1">
                            	<select>
                                	<option>请选择</option>
                                    <option>ACF</option>
                                    <option>AMS</option>
                                    <option>DOC</option>
                                    <option>EIR</option>
                                    <option>ISPS</option>
                                    <option>ORC</option>
                                    <option>PSD</option>
                                    <option>SEAL</option>
                                    <option>TLX</option>
                                    <option>其他</option>
                                </select>
                            </div>
                            <div class="w2">
                            	<select onchange="additionalBoxTypeChange($(this))">
                                	<option selected="selected">箱</option>
                                    <option>票</option>
                                </select>
                            </div>
                            <div class="w3">
                                <span>20&#39;</span>
                                <input type="text" name="gp20Num" />
                                <span>40&#39;</span>
                                <input type="text" name="gp40Num" />
                                <span>40H&#39;</span>
                                <input type="text" name="hq40Num" />
                            </div>
                            <div class="w4">
                            	<input type="text"  name="total_local_cost"  disabled="disabled" />
                            </div>
                            <div class="w5">
                            	<select>
                                	<option>CNY</option>
                                    <option>USD</option>
                                    <option>EUR</option>
                                    <option>HKD</option>
                                </select>
                            </div>
                            <div class="w6">
                            	<div class="btnMod1" onClick="addAdditionalRow()">添加</div>
                            </div>
                        </div>
                    </div>
                    <input type='hidden' name="total_shipextra_date"  >
                </div>
                <div>
                	<div class="sLabel">限重：<div class="imp"></div></div>
                	<input type="text" name="limit_weight"  class="box2 modTextBox" onkeyup="setInputOnlyNum($(this))"  onafterpaste="setInputOnlyNum($(this))" maxlength="2"/>
                    <div class="tishi2 modTishiBg">
                    	<div class="modTishiTxt">请填写两位整数，重量单位是吨（T）</div>
                    </div>
                </div>
                <div>
                	<div class="sLabel">备注：<div class="imp"></div></div>
                	<textarea class="modTextBox" name="remark" placeholder="请控制在120字以内"></textarea>
                </div>
                <div class="singleBottom">
                	<div class="btnMod1" onClick="ShipNoBtn()">取消</div>
                    <div class="btnMod1" onclick="shipSubmit()">发布</div>
                </div>
            </div>
           </form>
            <!--单次发布 end-->
            <!--批量导入-->
            <form method="post">
        	<div class="batchBg">
            	<div class="bg1">
                	<div class="rLayoutLabel">步骤一：</div>
                    <div class="bLine">
                    	<div class="bLabel">模板：</div>
                        <div class="bBtn btnMod2"><a  class="bBtn btnMod2"  href="/tariffManager/downloadExample/">点击下载模板</a></div>
                        <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: red">最新的模版更新于2016年8月5日</span></div>
                    </div>
                    <div class="bTishi modTishiBg">
                    	<div class="modTishiTxt">下载最新的Excel导入模版文件，保存至本地文件夹。</div>
                    </div>
                </div>
                <div class="bg2">
                	<%--<div class="rLayoutLabel">步骤二：</div>
                	<div>
                		&nbsp;&nbsp;&nbsp;<div class="rLayoutLabel">关联供应商：<span style="color:red">*</span><input type="text"  name="mobile" id="mobile"  placeholder="输入关联供应商注册手机号"  class="box1 modTextBox" style="background: none repeat scroll 0 0 white !important;color: #000000!important;width:196px;height:33px"/></div>
               		</div>
               		
                    --%><div class="bLine">
                    	<div class="bLabel">上传：</div> 
                        <div id="shiFileBtn" class="bBtn btnMod2">点击上传文件</div>
                        <input  type="file" class="file filetset" name="xls"  id="xls"  style="display:none;">
                        <div class="shipFileData">
                        	<div class="fileName">2017年3月23日运价上传文件.xls</div>
                            <div class="fileDel">删除</div>
                        </div>
                    </div>
                    <div class="bTishi modTishiBg">
                    	<div class="modTishiTxt">确认是否为最新的运价模版，若不是，请重新在步骤一中下载；</div>
                        <div class="modTishiTxt">仅支持Excel文件格式,建议使用97-2003版本；</div>
                        <div class="modTishiTxt">文件不能大于1M（1024K）；</div>
                        <div class="modTishiTxt">一次性导入的运价数量不要超过200条；</div>
                        <div class="modTishiTxt">表格中起始港、目的港、船公司、开船日、运输类别、有效期为必填项，不能为空，必须填写；</div>
                    </div>
                </div>
                <div class="batchBottom">
                	<div class="btnMod1 Button">发布</div>
                </div>
            </div>
          </form>
            <!--批量导入 end-->
        </div>
        <!--右侧主体 end-->
    </div>
</div>
<!--后台管理中部 end-->

<script type="text/javascript">

$(function(){
	
	  $(".batchBottom .Button").on("click",function()
		{
		 	var mobile = $("#mobile").val();
		 	var url=SITE_URL+"tariffManager/importData?mobile="+mobile;
	    	var file=$.trim($("[name='xls']").val());
	    	var main_products=$.trim($("[name='main_products']").val());
	    	if(!file)
	    	{
	    		zcAlert('请选择文件');
	    		return false;
	    	}
  		   if(!file.endsWith('.xls')){
					zcAlert('只接受xls文件')
					return false;
			 }

	        $.ajaxFileUpload(
	        {
	            url: url,
	            secureuri: false,//是否启用安全提交
	            fileElementId: "xls",
	            dataType: 'JSON',
	            success:function(data)
	            {
	            	var info = data.substring(1,data.length-1).split(",");
	            	
	            	if(info.length > 0 && info[0] != null && info[0] != ""){

	            		$(function(){
	                		errorCreate();
	                		for(var i in info){
								 var index1 = info[i].indexOf("'");
								 var index2 = info[i].indexOf("【")
	                    		 var index3 = info[i].indexOf("【");
	                    		 var index4 = info[i].indexOf("】")
	                    		 var index5 = info[i].indexOf("】");
	                    		 //var index6 = info[i].indexOf("%");
	                			//addErrorTxt('<span>'+info[i].trim().trim().substring(0,4)+'</span>','<span>'+info[i].trim().substring(5,11)+'</span>','不能为空');
	                			addErrorTxt('<span style="color:gray;">'+info[i].substring(index1+1,index2)+'</span>','<span>'+info[i].substring(index3,index4+1)+'</span>',info[i].substr(index5+1,info[i].length));
	                		}
	                	})
	                }
	            	function errorCreate(){
	            		var errorHtml=
	            		'<div class="errorBg0">'+
	            	    	'<div class="errorBg">'+
	            	        	'<div class="errorHead">'+
	            	            	'<div class="title">错误信息提示</div>'+
	            	                '<div class="close">X</div>'+
	            	            '</div>'+
	            	            '<div class="errorMid">'+
	            	            	'<div class="e_table">'+
	            	                	'<div class="e_th">'+
	            	                    	'<div class="e_td w1">行数</div>'+
	            	                        '<div class="e_td w2">字段信息</div>'+
	            	                        '<div class="e_td w3">错误提示</div>'+
	            	                    '</div>'+
	            	                '</div>'+
	            	                '<div class="e_tips">'+
	            	                	'<div>■ 行数代表的是批量导入的Excel文件中的对应行数；</div>'+
	            	                    '<div>■ 字段信息给出具体错误字段</div>'+
	            	                    '<div>■ 错误提示给出错误原因</div>'+
	            	                '</div>'+
	            	            '</div>'+
	            	            '<div class="errorFoot">'+
	            	            	'<div class="ebtn">关闭</div>'+
	            	            '</div>'+
	            	        '</div>'+
	            	    '</div>';
	            		$('body').append($(errorHtml));
	            		$('.errorBg0 .close,.errorBg0 .ebtn').click(function(){
	            			$('.errorBg0').remove();
	            		})
	            	}
	            	function addErrorTxt(txt1,txt2,txt3){
	            		var rowTxt='<div class="e_tr">'+
	            						'<div class="e_td w1">'+txt1+'</div>'+
	            						'<div class="e_td w2">'+txt2+'</div>'+
	            						'<div class="e_td w3">'+txt3+'</div>'+
	            					'</div>';
	            		$('.errorBg0 .e_table').append($(rowTxt));
	            	}
				},
				
		      });
			
		})
})

</script>

</body>
</html>
