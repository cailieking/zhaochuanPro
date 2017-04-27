//设置iframe高度
function setIframeheight(height){
	//console.log('body高度',$('.contentBg0').height());
	$('#iframepage').attr('height',height);
}
//窗口变化事件处理
function windowResized(){
	$(window).resize(function(){
		topWidthChanges();//顶部块在窗口宽度变化时的处理
	})
}
//顶部块在窗口宽度变化时的处理
function topWidthChanges(){
	$('.topBg0').height($('.topBg').height());
}
//读取js和css文件
function loadJs(url,callback) {
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = url;
	//document.body.appendChild(script);
	document.getElementsByTagName('head')[0].appendChild(script);
	script.onload = callback;
}
function loadCss(url,callback) {
	var css = document.createElement("link");
	css.type = "text/css";
	css.rel = 'stylesheet';
	css.href = url;
	//document.body.appendChild(css);
	document.getElementsByTagName('head')[0].appendChild(css);
	css.onload = callback;
}
//读取js和css文件 end

//使用元素可拖拽移动
function setEleMove($ele){
	var diffX,diffY;
	$ele.mousedown(function(e){
		diffX = e.pageX-$ele.offset().left;
		diffY = e.pageY-$ele.offset().top;
		$("body").on("mousemove", mousemove)
		$("body").on("mouseup", removeEvent)
	});
	function mousemove(e){
		$ele.css({
			left:e.pageX-diffX,
			top:e.pageY-diffY
		});
	}
	function removeEvent(){
		objDiv = '';
		$("body").off("mousemove", mousemove)
		$("body").off("mouseup", removeEvent)
	}
}






/**
 * 
 *
 * @author yangjiupei
 * @version 1.0
 * Fun:TimeSpan
 * @param totalMilliseconds
 * @param 
 * @return 
 */
function TimeSpan(totalMilliseconds){
	
	this.totalMilliseconds = parseInt(totalMilliseconds);
	this.totalSeconds = parseInt(this.totalMilliseconds / 1000) ;	
	this.seconds = this.totalSeconds % 60;
	this.totalMinutes = parseInt(this.totalSeconds / 60);
    this.minutes = this.totalMinutes % 60; 
	this.totalHours = parseInt(this.totalMinutes / 60);
    this.hours = this.totalHours % 24; 
	
	this.days = parseInt(this.totalHours / 24);
   		
}

var DateTimeConvert = {
    /**
      * Fun:日期字符串转日期
      * @str:日期字符串
	  * @author yangjiupei
      *  
    */	
	str2Date : function(str){
		return new Date(Date.parse(str));
	},
    /**
      * Fun:日期转time stamp
      * @ptime:日期
	  * @author yangjiupei
      *  
    */		
	date2TimeStamp : function(ptime){
		return ptime.valueOf();
	},

    /**
      * Fun:日期字符串转日期
      * @str:日期字符串
	  * @author yangjiupei
      *  
    */		
	str2TimeStamp : function(str){		
		return DateTimeConvert.date2TimeStamp(DateTimeConvert.str2Date(str));
	},
	
    /**
      * Fun:time stamp转日期
      * @ts:time statmp，日期毫秒
	  * @author yangjiupei
      *  
    */		
	timestamp2Date : function(ts){
		return new Date(parseInt(ts));
	},	
    /**
      * Fun:time 格式化时间
      * @pdate:pdate，要格式化字符串的时间
	  * @pformat:格式，"yyyy-MM-dd hh:mm:ss"; 
	  * @author yangjiupei
      *  
    */		
	formatTime : function(pdate,pformat){
		//alert('pdate=' + pdate + ';;pformat::' + pformat);
        var o = {  
                  "M+" : pdate.getMonth() + 1, // month  
                  "d+" : pdate.getDate(), // day  
                  "h+" : pdate.getHours(), // hour  
                  "m+" : pdate.getMinutes(), // minute  
                  "s+" : pdate.getSeconds(), // second  
                  "q+" : Math.floor((pdate.getMonth() + 3) / 3), // quarter  
                  "S" : pdate.getMilliseconds()  
                  // millisecond  
               }  
	   if (/(y+)/.test(pformat)) {  
           pformat = pformat.replace(RegExp.$1, (pdate.getFullYear() + "").substr(4  
                        - RegExp.$1.length));  
       } 
	   
       for (var k in o) {  
          if (new RegExp("(" + k + ")").test(pformat)) {  
              pformat = pformat.replace(RegExp.$1, RegExp.$1.length == 1  
                            ? o[k]  
                            : ("00" + o[k]).substr(("" + o[k]).length));  
          }  
       }  	   	   
	
	  //alert('pformat::' + pformat);	
	  return pformat;		
	},
    /**
      * Fun:格式化日期
      * @ts:time statmp，日期毫秒
	  * @pformat:格式 如：yyyy-MM-dd hh:mm:ss
      *  
	  * @author yangjiupei
    */	
	formatTimeStamp : function(ts,pformat){        	  	
	  return DateTimeConvert.formatTime(DateTimeConvert.timestamp2Date(ts),pformat);
	}		
}; 

var TimeUtil = {
    /**
      * Fun:获取两个时间差
      * @ts1:time statmp，日期毫秒
	  * @ts2:time statmp，日期毫秒
      *  
	  * @author yangjiupei
    */	
	getTimeSpan : function(ts1,ts2){
		//$.messager.alert('提示信息','ts1=' + ts1 + '\r\nts2=' + ts2,'info');
		return (new TimeSpan(Math.abs(parseInt(ts2))-parseInt(ts1)));
	},
    /**
      * Fun:会诊时间倒计时计算
      * @ts:time statmp，日期毫秒
	  * 
	  * @author yangjiupei
      *  
    */	
	countdownTimeSpan : function(ts){
		return TimeUtil.getTimeSpan(DateTimeConvert.date2TimeStamp(new Date()),ts);
	},
    /**
      * Fun:获取指定时间的星期几
      * @date:日期
	  * 
	  * @author yangjiupei
      *  
    */		
	getDayOfWeek : function(date){		
		return date.getDay(); //返回值是 0（周日） 到 6（周六） 之间的一个整数
	},
    /**
      * Fun:获取指定时间的星期几
      * @ts:time statmp，日期毫秒
	  * 
      *  
	  * @author yangjiupei
    */		
	getTimeSpanOfWeek : function(ts){
		return DateTimeConvert.timestamp2Date(ts).getDay();
	},
    /**
      * Fun:获取指定时间的增加指定天数后的time stamp
      * @ts:time statmp，日期毫秒
	  * @day:增加的天数
      *  
	  * @author yangjiupei
    */	
	addDayOfTimeSpan : function(ts,day){
		var date = DateTimeConvert.timestamp2Date(ts);
		return date.setDate(date.getDate() + day);
	},
    /**
      * Fun:获取指定时间的增加指定月数后的time stamp
      * @ts:time statmp，日期毫秒
	  * @month:增加的月数
      *  
	  * @author yangjiupei
    */		
	addMonthOfTimeSpan : function(ts,month){
		var date = DateTimeConvert.timestamp2Date(ts);
		return data.setDate(date.getMonth() + month);
	},
    /**
      * Fun:获取指定时间的指定小时、分钟、秒数后的时间
      * @ts:time statmp，日期毫秒
	  * @hour:几点
	  * @minutes:分钟
	  * @second:秒
      *  
	  * @author yangjiupei
    */	
	setHoursOfTimeSpan : function(ts,hour,minutes,second){
		var date = new Date(parseInt(ts));
		return date.setHours(hour,minutes,second,0);
	}, 
	addTimeOfTimeSpan : function(ts,addtime){			
		var times = addtime.split(":");
		if(times != null){
			if(times.length > 2){
				return TimeUtil.setHoursOfTimeSpan(ts,times[0],times[1],times[2]);
			}else{
				return TimeUtil.setHoursOfTimeSpan(ts,times[0],times[1],0);
			}
			
		}
	},
    /**
      * Fun:获取的星期几
      * @weekId:星期几的ID
	  * 
      *  
	  * @author yangjiupei
    */		
	getWeekOfDay : function(weekId){
		var ret = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六"] ;
        return ret[weekId]; 
	},
	getYearOfTimeSpan : function(ts){
		return (DateTimeConvert.timestamp2Date(ts)).getFullYear();
	},
	getMonthOfTimeSpan : function(ts){
		return ((DateTimeConvert.timestamp2Date(ts)).getMonth() + 1);
	},
	getHoursOfTimeSpan : function(ts){
		return (DateTimeConvert.timestamp2Date(ts)).getHours();
	},
	getMinutesOfTimeSpan : function(ts){
		return (DateTimeConvert.timestamp2Date(ts)).getMinutes();
	},
	getMonthDays : function(year,month){
		return  (new Date(year, month-1, 1) - new Date(year, month, 1))/(1000 * 60 * 60 * 24); 
	},
	getMonthStartTimeStamp : function(year,month){
		return TimeUtil.getSpecTimeByTimeStamp(year,month,1,0,0,1); 
	},
	getMonthEndTimeStamp : function(year,month){
		return TimeUtil.getSpecTimeByTimeStamp(year,month,getMonthDays(year,month),23,59,59); 
	},
	getDayStartTimeStamp : function(year,month,day){
		return TimeUtil.getSpecTimeByTimeStamp(year,month,day,0,0,1);
	},
	getDayEndTimeStamp : function(year,month,day){
		return TimeUtil.getSpecTimeByTimeStamp(year,month,day,23,59,59);
	},
	getSpecTimeByTimeStamp : function(year,month,day,hours,minutes,seconds,microseconds){
		//alert(year+';' + month + ';' + day + ';' + hours + ';' + minutes + ';' + seconds + ';' + microseconds);		
		if(microseconds==undefined){	
		    if(seconds==undefined){
				return DateTimeConvert.date2TimeStamp(new Date(year,month-1,day,hours,minutes,0));
			}else{
				return DateTimeConvert.date2TimeStamp(new Date(year,month-1,day,hours,minutes,seconds));
			}
			
		}else{
			return DateTimeConvert.date2TimeStamp(new Date(year,month-1,day,hours,minutes,seconds,microseconds));
		}
		
	}
};