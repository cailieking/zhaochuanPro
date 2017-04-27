var timer_1 = function(settingDateStr,el,callback){
    var settingDateStr = settingDateStr ;
    var settingDate = new Date(Date.parse(settingDateStr.replace(/-/g,"/")));
    var currentDate = new Date();
    var diff = settingDate.getTime() - currentDate.getTime();
    var el = el;
    var intervalId = null;
    var countdown = function(diff){
        var diff = diff;
        return function(){
            if(diff < 1000){
                diff = 0;
                clearInterval(intervalId);
                intervalId = null;
                callback();
                return;
            } else {
                diff = diff - 1000;
                var diffDate = currentDate.setTime(diff);
                var diffDay = currentDate.getUTCDate() - 1;
                var time =  currentDate.toUTCString().split(' ')[4];
                el.html(diffDay+'天'+time);
            }
          
        };
    };
    intervalId = setInterval(countdown(diff),1000);

};

var placeElCentre= function(el){
	var clientWidth = $(document.body).width();
	var targetWidth = el.width();
	el.css({marginLeft:(clientWidth-targetWidth)/2});
}





