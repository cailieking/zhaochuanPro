<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${headTitle}</title>
	<meta name="keywords" content="${keywords}">
	<meta name="description" content="${description}">
    <link rel="stylesheet" type="text/css" href="/css/common.css">
    <link rel="stylesheet" type="text/css" href="/css/news_css/child3.css">
    <script src="/js/jquery.js"></script>
    <script src="/js/common.js"></script>
    <script src="/js/news_js/child3.js"></script>
    
</head>
<body>

<div class="contentBg0" style="background:#e9eaec;float:left;">
	<div class="child3_mdBg md1200">
       <input type="hidden" value="${frontName}" id="frontName"> 
    	<div class="child3_left">
        	<div class="msgsBg">
            	<div class="title">${title}</div>
                <div class="from">
                	<span>来源：<span class="link">${comes}</span></span>
                    <span>日期：<span>${lastUpdated}</span></span>
                </div>
                <img class="image" />
                <div class="msgContent">
                 	 ${content}
                </div>
                 <ul class="tag_li"><label style="color:orange">标签：</label><li></li>
                 <#list tgs as x>
                 	<li ><a class="nofocus" href="javascript:void(0);">${x}</a></li>
                 </#list>
        		</ul>
            </div>
        </div>
        
        <div class="child3_right">
        	<div class="msgsBg">
            	<div class="title">【免责声明】</div>
                <div class="msg">
1、找船网发布此信息的目的在于传播更多信息，与本网站立场无关。
                </div>
                <div class="msg">
2、找船网不保证该信息（包括但不限于文字、数据及图表）全部或者部分内容的准确性、真实性、完整性、有效性、及时性、原创性等。
                </div>
                <div class="msg">
3、相关信息并未经过本网站证实，不对您构成任何投资建议、据此操作、风险自担。
                </div>
                <div class="msg">
4、如有侵权请直接与作者联系或书面发函至本公司转达。处理。
                </div>
                <div class="wxImageBg">
                	<img class="wxImage" src="/images/c_images/btmWxImage1.png" />
                    <div class="wxName">www.zhao-chuan.com</div>
                </div>
            </div>
        </div>
        
    </div>
</div>

</body>
</html>
