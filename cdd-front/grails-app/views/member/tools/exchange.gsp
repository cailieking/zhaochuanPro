<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>外汇货币兑换查询 - 找船网</title>
<meta name="keywords" content="找船网">
<meta name="description" content="找船网">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<link rel="stylesheet" type="text/css" href="/css/c_css/common.css">
<link rel="stylesheet" type="text/css" href="/css/dialog.css">
<link rel="stylesheet" type="text/css" href="/css/member/member.css">
<link rel="stylesheet" type="text/css" href="/css/tools.css">
<style type="text/css">
.w960{width:1140px;}
.enter{
  width: 960px;
  float: left;
  clear: none;
}
</style>
<script src="/js/jquery.js"></script>
<script src="/js/js.js"></script>
<script src="/js/c_js/common.js"></script>
<script src="/js/common.js"></script>
<script src="/js/dialog.js"></script>
<script language="Javascript" src="http://www.usd-cny.com/t1.js"></script>
<script language="Javascript" src="http://www.usd-cny.com/t2.js"></script>
<script language="Javascript" src="http://www.usd-cny.com/t3.js"></script>
<body>
	<div class="w960">
		<div class="enter">
			<div class="tools_nav">
				<ul>
					<li><a href="port.html">港口</a></li>
                    <li><a href="shipping.html">海运</a></li>
					<li><a href="hscode.html">HS编码查询</a></li>
					
					<li><a href="corporation.html">船公司查询</a></li>
					<li><a href="currency.html">世界各国货币名称</a></li>
					<li class="current"><a href="exchange.html">外汇货币兑换查询</a></li>
					<li><a href="dangerous.html">危险品标志</a></li>
				</ul>
			</div>
			<div class="exchange">
				<form onsubmit="calculate(); return false;" name="currcalc">
				    <p>
				      <input type="hidden" name="translation3" value="该转换工具只能在 Netscape Navigator 或者 Microsoft Internet Explorer 4.0 以上版本中使用。"> 
				      <input type="hidden" name="translation2" value="请输入您想兑换的货币数量。"> 
				      <input type="hidden" name="translation1" value="您的选择出现了一点问题，请重新选择两种货币再试。"> 
				      <input type="hidden" name="translation"> 
				      <input type="hidden" name="tz">
				      <input type="hidden" name="disptkc" value="British Pound"> 
				      <input type="hidden" name="displayres" value="  GBP"> 
				      <input type="hidden" name="exp2" value="us1"> 
				      <input type="hidden" name="version" value="us"> 
				      <input type="hidden" name="d_list" value="1"> 
				      <input type="hidden" name="result" value="1"> 
				      <input type="hidden" name="flag" value="0">
				      </p>
				    <p><strong><span class="STYLE2">请输入要兑换的货币数额</span>：</strong>
				      <input name="amount" class="smallinput" value="1" size="12">
				    </p>
				    <p>原始货币：<select class="select" size="1" name="from_tkc">
				    <option value="USD:CUR" selected="selected">美元(USD)</option>
				    <option value="CAD:CUR">加元(CAD)</option>
				    <option value="USD:CUR">美元(USD)</option>
				    <option value="CNY:CUR">人民币(CNY)</option>
				    <option value="HKD:CUR">港币(HKD)</option>
				    <option value="TWD:CUR">台币(TWD)</option>
				    <option>———————</option>
				    <option value="AUD:CUR">澳元(AUD)</option>
				    <option value="BEF:CUR">比利时法郎(BEF)</option>
				    <option value="GBP:CUR">英镑(GBP)</option>
				    <option value="DKK:CUR">丹麦克朗(DKK)</option>
				    <option value="NLG:CUR">荷兰盾(NLG)</option>
				    <option value="EUR:CUR">欧元(EUR)</option>
				    <option value="FRF:CUR">法国法郎(FRF)</option>
				    <option value="DEM:CUR">德国马克(DEM)</option>
				    <option value="ITL:CUR">意大利里拉(ITL)</option>
				    <option value="JPY:CUR">日元(JPY)</option>
				    <option value="CHF:CUR">瑞士法郎(CHF)</option>
				    <option value="SGD:CUR">新加坡元(SGD)</option>
				<option value="KRW:CUR">韩国元(KRW)</option>
				<option value="MOP:CUR">澳门元(MOP)</option>
				<option value="SEK:CUR">瑞典克朗(SEK)</option>
				<option value="PHP:CUR">菲律宾比索(PHP)</option>
				<option value="NOK:CUR">挪威克朗(NOK)</option>
				<option value="THB:CUR">泰国铢(THB)</option>
				    </select>
				    
				    </p><p>目标货币：<select class="select" size="1" name="to_tkc">
				        <option value="CNY:CUR" selected="selected">人民币(CNY)</option>
				        <option value="CAD:CUR">加元(CAD)</option>
				        <option value="USD:CUR">美元(USD)</option>
				        <option value="CNY:CUR">人民币(CNY)</option>
				        <option value="HKD:CUR">港币(HKD)</option>
				        <option value="TWD:CUR">台币(TWD)</option>
				        <option>———————</option>
				        <option value="AUD:CUR">澳元(AUD)</option>
				        <option value="BEF:CUR">比利时法郎(BEF)</option>
				        <option value="GBP:CUR">英镑(GBP)</option>
				        <option value="DKK:CUR">丹麦克朗(DKK)</option>
				        <option value="NLG:CUR">荷兰盾(NLG)</option>
				        <option value="EUR:CUR">欧元(EUR)</option>
				        <option value="FRF:CUR">法国法郎(FRF)</option>
				        <option value="DEM:CUR">德国马克(DEM)</option>
				        <option value="ITL:CUR">意大利里拉(ITL)</option>
				        <option value="JPY:CUR">日元(JPY)</option>
				        <option value="CHF:CUR">瑞士法郎(CHF)</option>
				        <option value="SGD:CUR">新加坡元(SGD)</option>
				<option value="KRW:CUR">韩国元(KRW)</option>
				<option value="MOP:CUR">澳门元(MOP)</option>
				<option value="SEK:CUR">瑞典克朗(SEK)</option>
				<option value="PHP:CUR">菲律宾比索(PHP)</option>
				<option value="NOK:CUR">挪威克朗(NOK)</option>
				<option value="THB:CUR">泰国铢(THB)</option>
				<option value="CNY:CUR" selected="selected">人民币(CNY)
				      </option></select> 
				      </p>
				    <p>
				      <input class="buttonface" onclick="calculate()" type="button" name="cal" value="查询汇率 开始计算">
				    </p>
				    <p>
				      <span class="STYLE5"><script language="Javascript">loadResults();</script></span></p><div id="crncyres"></div><p></p><div id="crncyres"></div><p></p>
				</form>
			</div>
		</div>
	</div>
	<div class="backpage backtools needtop"></div>
</body>
</html>