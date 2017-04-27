var m_rotateSpeed;
var m_rotateStatus;//运行状态
var m_rotateSelIndex;//选中的序列号
$(function(){
	addRightQQ();//添加右侧的QQ联系UI
	addZcTopUI(-2);//添加找船网公用顶部UI
	
	
	//图片的宽高
	var wid = 240;
	var hei = 180;
	
	//椭圆长、短边半径
	a = 340;
	b = 50;
	
	//中心点横、纵坐标	
	var dotLeft = $('.index_menu').width()/2 - wid/4;
	var dotTop = b + 50;
	//设置圆的中心点的位置
	$(".carousel_container").css({left: dotLeft, top: dotTop});

	//每一个BOX对应的角度;
	var avd = 360/$(".carousel_container figure").length;
	//每一个BOX对应的弧度;
	var ahd = avd*Math.PI/180;
	//运行状态 0正常旋转状态 1快速旋转状态 2选中固定状态
	m_rotateStatus = 0;
	//选中序列号
	m_rotateSelIndex = -1;
	//运动的速度
	var move = 0;
	var speedNum=0.6;
	m_rotateSpeed = speedNum;

	//缩放范围
	var maxscale = 1;
	var minscale = 0.5;	
	
	//运动函数
	function fun_animat(){
		//运运的速度
		move = move<2140000000?move:0;
		move+=m_rotateSpeed;	
		//运动距离，即运动的弧度数;
		var ainhd = move*Math.PI/180;
		//按速度来定位DIV元素
		$(".carousel_container figure").each(function(index, element){	
			var perscale = (maxscale-minscale)/2*Math.sin(ahd*index+ainhd)+(maxscale+minscale)/2;
			$(this).css({
				left: Math.cos((ahd*index+ainhd))*a,
				top: Math.sin((ahd*index+ainhd))*b,
				zIndex: Math.ceil(perscale*100),
				'-moz-transform':'scale('+perscale+')',
				'-webkit-transform':'scale('+perscale+')',
				'-o-transform':'scale('+perscale+')'
			});
		 });
		 //快速转动时的处理
		 if(m_rotateStatus==1)
		 {
			 //$(".carousel_container figure").eq(m_rotateSelIndex).children('.papaw').attr('src','images/papaw_light.png');
			 $(".carousel_container figure").eq(m_rotateSelIndex).children('.papaw').addClass('highLight');
			 var selRad=ahd*m_rotateSelIndex+ainhd;//获取累计的弧度值
			 while(selRad>2*Math.PI)
			 {
				 selRad-=2*Math.PI;
			 }
			 var radMin=Math.PI/2-Math.PI/20;
			 var radMiddle=Math.PI/2;
			 var radMax=Math.PI/2+Math.PI/20;
			 //转到缓冲区域时降速
			 if(selRad>=radMiddle&&selRad<radMax)
			 {
				 m_rotateSpeed = -speedNum*2;
			 }
			 if(selRad<radMiddle&&selRad>radMin)
			 {
				 m_rotateSpeed = speedNum*2;
			 }
			 //转到位后
			 if(selRad<radMiddle+Math.PI/180&&selRad>radMiddle-Math.PI/180)
			 {
				 m_rotateStatus = 2;
				 m_rotateSpeed = 0;
				 $(".carousel_container figure").eq(m_rotateSelIndex).addClass('rotateNavSel');
			 }
		 }
	}
	var atime = 40; 
	//定时调用运动函数	
	var setAnimate = setInterval(fun_animat,atime);
	//正常运动模式下鼠标移入停止，移出恢复
	$(".carousel_container figure").hover(function() {
		if(m_rotateStatus==0)
		{
			m_rotateSpeed = 0;
			//$(this).children('.papaw').attr('src','images/papaw_light.png');
			$(this).children('.papaw').addClass('highLight');
		}
	}, function() {
		if(m_rotateStatus==0)
		{
			m_rotateSpeed = speedNum;
			//$(this).children('.papaw').attr('src','images/papaw.png');
			$(this).children('.papaw').removeClass('highLight');
		}
	});
	
	//点击根窗口恢复正常模式
	$(".layout").click(function() {
		if(m_rotateStatus==2)
		{
			$(".carousel_container figure").removeClass('rotateNavSel');
			//$(".carousel_container figure").children('.papaw').attr('src','images/papaw.png');
			$(".carousel_container figure").children('.papaw').removeClass('highLight');
			m_rotateStatus = 0;
			m_rotateSpeed = speedNum;
			m_rotateSelIndex = -1;
		}
	});
	
	//打开新页面
	$('.carousel_container figure').click(function(e){
		//阻止响应父元素事件
		if (e && e.stopPropagation) {//非IE浏览器 
		　　e.stopPropagation(); 
		} 
		else {//IE浏览器 
			window.event.cancelBubble = true; 
		} 
		var commonObjId = e.currentTarget.id; 
		if(m_rotateStatus!=1&&!$(this).hasClass('rotateNavSel'))//非旋转状态点击未选中的导航
		{
			var thisIndex=$(this).index();
			if(m_rotateSelIndex!=thisIndex)
			{
				$(".carousel_container figure").removeClass('rotateNavSel');
				//$(".carousel_container figure").children('.papaw').attr('src','images/papaw.png');
				$(".carousel_container figure").children('.papaw').removeClass('highLight');
				m_rotateSelIndex=thisIndex;
				m_rotateStatus = 1;
				
				var selRad=ahd*thisIndex+move*Math.PI/180;
				while(selRad>2*Math.PI)
				{
					selRad-=2*Math.PI;
				}
				//根据位置的左右来确定旋转方向
				if(selRad>Math.PI/2&&selRad<Math.PI*1.5)
				{
					m_rotateSpeed = -8;
				}else
				{
					m_rotateSpeed = 8;
				}
			}
		}else if(m_rotateStatus==2&&$(this).hasClass('rotateNavSel'))//停止状态点击选中的导航
		{
			switch(commonObjId){
				
			}
		}
		
	});
})