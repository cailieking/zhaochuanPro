$(function(){
	clickChecksAll();//全选复选框点击
	//iframe高度自适应
	//$(window.parent.document.getElementById("iframepage")).attr('height',$('.child_content').height());
	timesStatus();//时间状态判断
})

//全选复选框点击
function clickChecksAll(){
	$('.checksAll').click(function(){
		$('.check').prop('checked',$(this).prop('checked'));
	});
}
//时间状态判断
function timesStatus(){
	var infoList=$('.infoList');
	for(var i=0;i<infoList.length;i++){
		var listTxt=infoList.eq(i).find('.txt');
		//转换时间为毫秒数
		var today=new Date();
		var sTime=[today.getFullYear(),today.getMonth()+1,today.getDate()];
		var eTime=listTxt.eq(3).html().split('-');
		//console.log('sTime',sTime);
		//console.log('eTime',eTime);
		var sTime_num=TimeUtil.getSpecTimeByTimeStamp(parseInt(sTime[0]),parseInt(sTime[1]),parseInt(sTime[2]),0,0,0,0);
		var eTime_num=TimeUtil.getSpecTimeByTimeStamp(parseInt(eTime[0]),parseInt(eTime[1]),parseInt(eTime[2]),0,0,0,0);
		var defNum=30*24*60*60*1000;//一个月的毫秒数
		var isOpen=listTxt.eq(0).attr('data-status');
		//对时间进行判断
		if(isOpen==1){
			listTxt.eq(3).css('color','black');
			listTxt.eq(0).css('color','red');
			listTxt.eq(0).html('禁用');
		}else if(sTime_num>=eTime_num){
			listTxt.eq(3).css('color','red');
			listTxt.eq(0).css('color','red');
			listTxt.eq(0).html('已到期');
		}else if(eTime_num-sTime_num<defNum){
			listTxt.eq(3).css('color','red');
			listTxt.eq(0).css('color','red');
			listTxt.eq(0).html('月内到期');
		}else{
			listTxt.eq(3).css('color','black');
			listTxt.eq(0).css('color','green');
			listTxt.eq(0).html('启用');
		}
	}
}
//查看原图点击
function imageLookClick($this){
	var src=$this.attr('data-src');
	var lookHtml='<div class="showImage">'
	+'<img src="'+src+'" /></div>';
	$('body').append($(lookHtml));
	$('.showImage').click(function(){
		$('.showImage').remove();
	});
	$('.showImage img').get(0).onload=function(){
		var wImage=$('.showImage').width();
		var hImage=$('.showImage').height();
		$('.showImage').css({
			top:'50%',
			left:'50%',
			marginLeft:-wImage/2,
			marginTop:-hImage/2
		})
	}
}

//banner创建弹出框隐藏
function bannerCreateHide(){
	$('#bannerCreate').hide();
}
//banner创建弹出框显示
function bannerCreateShow(){
	
	$('#bannerCreate').show();
}
//banner修改弹出框隐藏
function bannerEditHide(){
	$('#bannerEdit').hide();
}
//banner修改弹出框清理
function bannerEditClear(){
	$('#editId').val('');
    $('#editTitle').val('');
    $('#editAlt').val('');
    $('#editHref').val('');
    $('#editEndDate').val('');
    $('#editOrder').val('');
    $('#editImage').attr('src','');
    $('#editLookImage').attr('data-src','');
}
//banner修改弹出框显示
function bannerEditShow(id){
	  $.ajax({
          type: "GET",
          url: "/imageInfo/data",
          data: {id:id},
          dataType: "json",
          success: function(rs){
        	  console.log('修改数据',rs);
              $('#editId').val(rs.id);
              $('#editTitle').val(rs.title);
              $('#editAlt').val(rs.alt);
              $('#editHref').val(rs.href);
              $('#editEndDate').val(rs.endDate.split('T')[0]);
              $('#editOrder').val(rs.order);
              var oss=$('#editImage').attr('data-oss')
              $('#editImage').attr('src',oss+rs.image);
              $('#editLookImage').attr('data-src',oss+rs.image);
                   },
          error:function(rs){
        	  console.log('读取失败');
           			
           		},
      });
	$('#bannerEdit').show();
}
//启用禁用
function bannerState(id,state){
	if(state==1){
		if(confirm("确定要关闭吗？"))
		{
			window.location.href='/imageInfo/changeState/?id=' +id;
		}
	}else{
		if(confirm("确定要启用吗？"))
		{
			window.location.href='/imageInfo/changeState/?id=' +id;
		}
		
	}
	
}
//指定删除
function bannerDelete(id){
	if(confirm("确定要删除该数据吗？"))
	{
		window.location.href='/imageInfo/delete/?ids=' + id;
	}
}
//批量删除
function bannerMultDelete(){
	var selChekcs=$('.child_table .check:checked');
	if(selChekcs.length<1){alert('请选择删除项！');return;}
	var strDel='';
	for(var i=0;i<selChekcs.length;i++){
		strDel+=selChekcs.eq(i).attr('data-id');
		if(i!=selChekcs.length-1){
			strDel+=',';
		}
	}
	console.log('删除的id字符串',strDel);
	window.location.href='/imageInfo/delete/?ids=' + strDel;
}
//banner创建 提交
function createSubmit(){
	if($('#createEndDate').val()==''){alert('到期时间必填！');return;}
	if($('#createOrder').val()==''){alert('顺序为空！');return;}
	if($('#createFile').val()==''){alert('图片为空！');return;}
	$('#dataFormCreat').submit();
}
//banner修改 提交
function editSubmit(){
	if($('#editEndDate').val()==''){alert('到期时间必填！');return;}
	if($('#editOrder').val()==''){alert('顺序为空');return;}
	if($('#editImageFile').val()==''&&$('#editImage').attr('src')==''){alert('图片为空');return;}
	$('#dataFormEdit').submit();
}
function deleteOssImage(){
	if(confirm('确定删除图片么？')){
		var id = $('#editId').val()
		//window.location.href='/imageInfo/deleteOssImage/?id=' + id;
		  $.ajax({
	          type: "GET",
	          url: "/imageInfo/deleteOssImage",
	          data: {id:id},
	          dataType: "json",
	          success: function(rs){
	              if(rs.state==1){
	            	  $('#editImage').attr('src','');
	                  $('#editLookImage').attr('data-src','');
	              }
	                   },
	          error:function(rs){
	        	  console.log('失败');
	           		},
	      });
	}
	
}