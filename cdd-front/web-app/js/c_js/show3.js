$(function(){
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(-2);//添加找船网公用顶部UI
	$('#show_qqBtn').click(function(){
		$(window.frames[1].document.getElementById("launchBtn")).trigger('click');
	});
})