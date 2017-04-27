<!DOCTYPE html>
<html>
<head>
<title>短信发送</title>
<meta name="layout" content="main">
<asset:stylesheet src="c_css/common.css" />
<asset:javascript src="c_js/common.js" />

</head>
<body>
<div style="margin-left: 120px">
<div><textarea placeholder="收件人，多人使用半角逗号间隔" name="phone" id="mobiles" rows="16" cols="100"  ></textarea></div>

<div style="margin-top: 20px"><textarea placeholder="短信模板CODE" name="code" id="code" rows="2" cols="100"  ></textarea></div>

<div style="margin-top: 20px"><input type="submit" name="submit" id="submit" value="发送"  style="width:120px;height:50px"></div>
</div>
<script>
$("#submit").click(function(){
	sendMessage()
});

var sendMessage = function(){
	var mobiles =$("#mobiles").val();
	var code =$("#code").val();
	var data = {
			'mobiles' : mobiles,
			'code' : code
			
	}
	$.ajax({
		type:'post',
		url:'/shortMessage/send',
		dataType:'json',
		data:data,
		success:function(rs){
			console.log('rs',rs);
				if(rs.status=="ok"){
				alert("发送成功！");
				window.location.reload();
				}
			},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			console.log(XMLHttpRequest)
			console.log(textStatus)
			console.log(errorThrown)
		}

})
} 
</script>
</body>
</html>
