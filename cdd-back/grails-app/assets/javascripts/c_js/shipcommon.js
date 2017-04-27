var cacheStore = {
     flag: !!window.sessionStorage,
     expires: 5*60*1000,
     getAllCached :function(){
         var data = {};
         var cookieData = {};
         var store = null;
         var key = '';
         if(this.flag){
            store = window.sessionStorage;
            for(var i= 0,len= store.length;i<len;i++){
                key = store.key(i);
                data[key] = store.getItem(key);
            }
         }else{
             cookieData = document.cookie.replace(/\s+/g,'').split(';');
             for(var ind in cookieData){
                 key = cookieData[ind].split('=')
                 data[key[0]] = key[1];
             }
         }
         return data;

     },
     getCacheValByKey:function(key){
         var store  = null;
         var val = '';
         var keyReg = new RegExp('(^|\\s*|;)'+key+'=(\\w+)','g'); //这儿是个坑
        if(!key)return;
        if(this.flag){
            store = window.sessionStorage;
            val = store.getItem(key)
        }else{
            val =  keyReg.exec(document.cookie)[2];
			console.log(val)
        }
        return val;
     },
     setData2CacheStore:function(options){
         var options = options;
         var data = '';
         var store = null;
		 var linkData = '';
         if(!options)return;
         if(this.flag){
             store = window.sessionStorage;
             for(var key in options){
				 if(key != 'expires'){
					 store.setItem(key,options[key]);
				 }                
             }
         }else{
             for(var key in options){    
				  if(key != 'expires'){
					  linkData =  key +'='+options[key];
				  }				    
			      this.setCookieAttrs(linkData,options['expires']);			  
             }  
         }

     },
     setCookieAttrs:function(linkData,expires){
       var path = '/';
       var date = new Date();
	   var linkData = linkData;
           date.setTime(date.getTime()+(expires || this.expires));//默认5分钟后过期
           expires = date.toUTCString();
           document.cookie =linkData+';path='+path+';expires='+expires;// 不能缓存document.cookie;又是一个坑

     },
     isExsitInCacheStore:function(name){
         var val = '';
         val = this.getCacheValByKey(name);
         if(val)return true;
         return false;

     },
     clearAllCacheData:function(names){
        var key = [];
        var store = null;   
        var val = '';
        var temp = '';
        if(!names)return;
        if(typeof names ==='string') key.push(names);
        if(Object.prototype.toString.call(names) === '[object Array]')key = names;
        for(var i = 0; i<key.length;i++){
            if(this.flag){
				store = window.sessionStorage;
                store.removeItem(key[i]);
            }else{
				this.clearOneCahceData(key[i]); 
            }
        }
       
     },
     clearOneCahceData:function(name){
        var store =  null;
        var val = '';
        var options = {};
        var linkData = '';
        if(!name)return;
        if(this.flag){
		   store = window.localStorage; 
           store.removeItem(name);
        }else{
            val = this.getCacheValByKey(name);
            options[name] = val;
			options['expires'] = -this.expires;
            linkData = this.setData2CacheStore(options);
        }
     }

}
//全局变量
var SITE_URL='http://'+window.location.host+'/';
var STATIC_URL=SITE_URL;
var IMAGE_URL=SITE_URL;
var FILE_URL=SITE_URL;
document.write('<script type="text/javascript">');
document.write('_atrk_opts = { atrk_acct:"XBojm1akKd60em", domain:"zhao-chuan.com",dynamic: true};');
document.write('(function() { var as = document.createElement("script"); as.type = "text/javascript"; as.async = true; as.src = "https://d31qbv1cthcecs.cloudfront.net/atrk.js"; var s = document.getElementsByTagName("script")[0];s.parentNode.insertBefore(as, s); })();');
document.write('</script>');
document.write('<noscript><img src="https://d5nxst8fruw4z.cloudfront.net/atrk.gif?account=XBojm1akKd60em" style="display:none" height="1" width="1" alt="" /></noscript>');
var userName = '';
host = 'http://'+location.host;
$.extend({
	  getUrlVars: function(){
	    var vars = [], hash;
		var href = window.location.href;
		if (href.indexOf('#') > -1) {
			href = href.split("#")[0];
		}
	    var hashes = href.slice(href.indexOf('?') + 1).split('&');
	    for(var i = 0; i < hashes.length; i++) {
	      hash = hashes[i].split('=');
	      vars.push(hash[0]);
	      vars[hash[0]] = hash[1];
	    }
	    return vars;
	  },
	  getUrlVar: function(name){
	    return $.getUrlVars()[name];
	  }
});