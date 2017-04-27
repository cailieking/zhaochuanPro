//(function(a){(jQuery.browser=jQuery.browser||{}).mobile=/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))})(navigator.userAgent||navigator.vendor||window.opera,'http://detectmobilebrowser.com/mobile')


function getLength(str){
    return str.replace(/[^\x00-xff]/g,"xx").length;  //\x00-xff 此区间是单子节 ，除了此区间都是双字节。
}
function findStr(str,n){
    var tmp=0;
    for(var i=0;i<str.length;i++){
        if(str.charAt(i)==n){
            tmp++;
        }
    }
    return tmp;
}
window.onload=function(){
    var aInput=document.getElementsByTagName('input');
    var mobile=aInput[1];
    var capcha=aInput[1];
//    var pwd=aInput[3];
//    var pwd2=aInput[4];
    
    var aP=document.getElementsByTagName('p');
    var name_msg=aP[0];
    var dx_msg=aP[0];
    var pwd_msg=aP[0];
    var pwd2_msg=aP[0];
    var name_length=0;
    var send=document.getElementById('send'),
        
	    times=60,
	    timer=null;
	    send.onclick=function(){      

	        var mobile_num=$.trim($("#mobile").val());
//	        
//	        if(mobile_num.trim()==null || mobile_num.trim()==""){
//	        	 name_msg.innerHTML='<i>请输入手机号</i>';
//	             mobile.style.border='1px solid red';
//	        .
//	             return false
//	        }
//	        if(!$.ismobile(mobile_num))
//	        {	
//	        	 name_msg.innerHTML='<i>手机号不正确</i>';
//	             mobile.style.border='1px solid red';
//	             return false
//	         } else {
//	        	// name_msg.style.display='none';
//	           //  mobile.removeAttribute("placeholder");
//	        	 name_msg.innerHTML='<i></i>';
//	             mobile.style.border='1px solid #fff';
//	         }
        timer = setInterval(djs,1000);
	        $.getJSON(SITE_URL+"captcha/sms",{"mobile":mobile_num},function(rs){
	            if(rs.status<0){
	                //countdown.stop();
	            	name_msg.innerHTML='<i>该手机号已注册</i>';
	            }
	            else{
//	                name_msg.innerHTML='<i>验证码</i>';
	            	//name_msg.innerHTML='<i>该手机号已注册</i>'
	            }
	        });
//	     
    } 
        function djs(){
/*        	  var  verifyCodeInputEl = $('#captcha');
              verifyCodeInputEl.next().next().removeClass('verify-wrong').html('');*/
//         if(!(verifyCodeInputEl.val().trim())){
//             verifyCodeInputEl.next().next().addClass('verify-wrong').html('请输入验证码');
//              return
//         } 
         
         send.value = times+"秒后重试";
         send.setAttribute('disabled','disabled');
         send.style.background='#ccc';
         send.style.border='1px solid #ccc';
			times--;
			if(times <= 0){
				send.value = "发送验证码";
				send.removeAttribute('disabled');
				times = 60;
				clearInterval(timer);
			}
        	
    		
		}
    
    
    //用户名检测
    
    mobile.onfocus=function(){
        name_msg.style.display='block';
        mobile.removeAttribute("placeholder");
        mobile.style.border='1px solid #fff';
    }
       
//    var aa=function(){
//        // 含有非法字符 ，不能为空 ，长度少于5个字符 ，长度大于25个字符
//        var tel = /^1[3|4|5|7|8][0-9]\d{8}$/;
//        if(!tel.test(this.value)){
//            name_msg.innerHTML='<i>手机号不正确</i>';
//            mobile.style.border='1px solid red';
//            return false
//        }
//        else{
//        	mobile.style.border='1px solid #fff';
//        	return true
//        }
//    }
    mobile.onblur = function(){
        // 含有非法字符 ，不能为空 ，长度少于5个字符 ，长度大于25个字符
        var tel = /^1[3|4|5|7|8][0-9]\d{8}$/;
        //alert(this.value)
        if(!tel.test(this.value)){
            name_msg.innerHTML='<i>手机号不正确</i>';
            mobile.style.border='1px solid red';
            return false
        }
        else{
        	mobile.style.border='1px solid #fff';
        	name_msg.innerHTML='<i></i>';
        	return true
        }
    }
    //短信验证码检测
    
    capcha.onfocus=function(){
        dx_msg.style.display='block';
        capcha.removeAttribute("placeholder");
        capcha.style.border='1px solid #fff';
    }
    
    $("#submit_register").on("click",function()
    	    {
    	        var mobile=$.trim($("#mobile").val());
    	        var captcha=$.trim($("#captcha").val());
    	        var verifycode=$.trim($("#verifycode").val());
    	        var invitationCode=$.trim($("#invitationCode").val());
    	        if(!$('#is_agree')[0].checked){
    	            alert('请阅读《找船网用户服务协议》');
    	            return false;
    	        }
    	        $.post(SITE_URL+"register/goStep2",{"mobile":mobile,"invitationCode":invitationCode,"image":captcha,"code":verifycode},function(rs)
    	        {
    	        	//location.href=SITE_URL+'register/registerMobile2';
    	            if(rs.status<0)
    	            {
    	            	name_msg.innerHTML='<i>'+rs.msg+'</i>'
//    	                alert(rs.msg);
    	            }
    	            else
    	            {
    	                location.href=SITE_URL+'register/registerMobile2';
    	            }
    	        },"json");
    	    });
    
    //密码检测
//    pwd.onfocus=function(){
//        pwd_msg.style.display='block';
//        pwd.removeAttribute("placeholder");
//        pwd.style.border='1px solid #fff';
//    }
//    pwd.onblur=function(){
//        var m=findStr(pwd.value,pwd.value[0]);
//        var re_n=/[^\d]/g;
//        var re_t=/[^a-zA-Z]/g;
//        if(this.value==""){
//            pwd_msg.innerHTML='<i>密码不可为空</i>';
//            pwd.style.border='1px solid red';
//        }else if(m==this.value.length){
//            pwd_msg.innerHTML='<i>密码不可使用相同的字符</i>';
//            pwd.style.border='1px solid red';
//        }else if(this.value.length<6 || this.value.length>16){
//            pwd_msg.innerHTML='<i>密码长度应为6到16个字符</i>';
//            pwd.style.border='1px solid red';
//        }else if(!re_n.test(this.value)){
//            pwd_msg.innerHTML='<i>密码不能全为数字</i>';
//            pwd.style.border='1px solid red';
//        }else if(!re_t.test(this.value)){
//            pwd_msg.innerHTML='<i>密码不能全为字母</i>';
//            pwd.style.border='1px solid red';
//        }else{
//            pwd.style.border='1px solid #fff';
//        }
//    }
    
    //确认密码
//    pwd2.onblur=function(){
//        if(this.value!=pwd.value){
//            pwd2_msg.innerHTML='<i></i>两次密码输入到不一致';
//            pwd.style.border='1px solid red';
//        }else if(this.value==""){
//            pwd2_msg.innerHTML='<i></i>请输入密码';
//            pwd.style.border='1px solid red';
//        }else{
//            pwd2.style.border='1px solid #fff';
//        }
//    }
        
}







































