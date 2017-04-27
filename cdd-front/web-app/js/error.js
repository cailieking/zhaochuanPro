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