<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    
    <title></title>
    <meta name="layout" content="main">
    <asset:stylesheet src="form-table.css" />
<style>

</style>
    
</head>
<body>
   <div class="col-lg-12">
		<div class="lump">
        <div class="layui-layer-title" style="cursor: move;border-radius:5px" move="ok">起始港信息</div>
			<form  id="dataForm">
        <formTable:table>
        	<formTable:tr title='中文名:'>
						<input type="text"   value=${data.portName} placeholder="中文名" readonly=true/>
					</formTable:tr>
					<formTable:tr title='英文名:'>
						<input type="text"  value=${data.portEnglishName}  placeholder="英文名" readonly=true/>
					</formTable:tr>
					<formTable:tr title='港口编码:'>
						<input type="text"  value=${data.code} placeholder="港口编码"  readonly=true/>
					</formTable:tr>
					
					<formTable:tr title='编码简称:'>
						<input  type="text" value="${data.codeSimple}"  placeholder="编码简称" readonly=true />
					</formTable:tr>
					<formTable:tr title='国家中文名:'>
						<input type="text"  class="datepicker"  value=${data.countryCh}  placeholder="国家中文名" readonly=true />
					</formTable:tr>
					<formTable:tr title='国家英文名:'>
						<input type="text"    value=${data.countryEn}  placeholder="国家英文名" readonly=true/>
					</formTable:tr>
					<formTable:tr title='所属航线:'>
						<textarea type="text"  readonly=true placeholder="所属航线" style="height:100px">value=${data.route.routeName}</textarea>
					</formTable:tr>
					<formTable:tr title='备注:'>
						<textarea type="text"  readonly=true placeholder="备注" style="height:100px">${data.remark}</textarea>
					</formTable:tr>
       		
        </formTable:table>
        </form>
       		 <div class="buttons">
				<button type="button" id="return-btn" class="button button-glow button-rounded button-raised button-primary pull-right" onclick="window.history.back()">返回</button>
					<div class="clearfix"></div>
      	 </div>
            
        
         <!-- <div>
       		<button type="button"  onclick="$('#myform').submit();"  id="reg-btn"   class="reg-btn" >注册</button>
       	  </div>-->

       </div>
      </div> 
      


</body>
</html>