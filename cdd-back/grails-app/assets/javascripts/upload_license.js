$(function(){
    var magnifiedAreaLeftEl = $('.zoom-up-image-left');
    var magnifiedAreaRightEl = $('.zoom-up-image-right');
    var imglistleftEl = $('#img-list-left');
    var imglistrightEl = $('#company-list-right');
        imglistleftEl.click(function(e){ //�������ߵ��¼�������
           imgClick(e,'left');
        });
        imglistrightEl.click(function(e){
            imgClick(e,'right');
        });
       $('.zoom-up-image-left').click(function(){
           magnifiedAreaLeftEl.css('visibility','hidden');
           magnifiedAreaRightEl.css('visibility','hidden');
       })
        $('.zoom-up-image-right').click(function(){
           magnifiedAreaLeftEl.css('visibility','hidden');
           magnifiedAreaRightEl.css('visibility','hidden');
       })
    var imgClick = function(e,direction){
    	var target = e.target;
    	var rightImgExsits = true;
        if(/\{[\s\S]+\}/g.test(decodeURIComponent(imglistrightEl.find('img').prop('src'))))rightImgExsits = false; //�Ҳ�imgʹ��ģ������ʾ������Ҳ�û��ʾ�����ͼƬ���Ŵ�
        if(target.nodeName.toLowerCase() != 'img')return;   
        var imgUrl = $(target).prop("src");
        var certAttr = $(target).data();
        var key = null;
        for(var index in certAttr){
            key = index;
        }
        var oppsiteImgEl = '';
        var oppsiteImg = '';
        if(!direction)return ;
        if(direction === 'left'){
            oppsiteImg = imglistrightEl.find('img').filter(function(index,item){
                return $(item).data(key) ==='yes';
            });
            oppsiteImgEl = $(oppsiteImg);
            magnifiedAreaLeftEl.find('img').prop({src:imgUrl});
            magnifiedAreaRightEl.find('img').prop({src:oppsiteImgEl.prop('src')});

        }else{
            oppsiteImg = imglistleftEl.find('img').filter(function(index,item) {
                return $(item).data(key) === 'yes';
            });
            oppsiteImgEl = $(oppsiteImg);
            magnifiedAreaLeftEl.find('img').prop({src:oppsiteImgEl.prop('src')});
            magnifiedAreaRightEl.find('img').prop({src:imgUrl});

        }
        if(rightImgExsits){
        	  magnifiedAreaRightEl.css('visibility','visible');
        	}
       
        magnifiedAreaLeftEl.css('visibility','visible');
    };


    //������̬��ʾ��
    var relativePath = location.origin 
    var $searchResult =  $('#search-result');
    var searchResultHtml = '';
    $('#search-input-box').typeahead({
               /*   order:'desc',*/
              minLength:0,
                /* offset:true,*/
                maxItem:8,
       searchResultHtml:'',// extend prop
                   hint:true,
                dynamic:true,
                  delay:500,
                  emptyTemplate: 'No result for "{{query}}"',
                  source:{
                      url:[{
                          url: relativePath+ '/company/getQueryCompanyList',
                          data: {companyName: "{{query}}"}
                      },"nameList"]

                  },

                backdrop:{
                    'background-color': '#3879d9',
                    'opacity': '0.1',
                     'filter': 'alpha(opacity=10)'
                },
               callback:{
                   onSubmit:function(node,form,item,event){
                       var companyName = decodeURIComponent(item.display);
                       searchResultHtml = window.searchResultHtml = window.searchResultHtml ? window.searchResultHtml : $searchResult.html();
                       $.post(relativePath+'/company/getCompanyDetail',{companyName:companyName},function(data){
                         var data = data;
                             for(var key in data){
                            	 if((key.indexOf('Img'))!=-1){
                            		 data[key] = ossRoot1 + data[key]; 
                            	 }
                            	 if((key.indexOf('types'))!=-1){
                    	            data[key] = data[key]['name']; 
                                 }
                             }
                             searchResultHtml =  searchResultHtml.format(data);
                              $searchResult.html(searchResultHtml);
                              $searchResult.css('visibility','visible');
                       });
                       return false
                   }
               }

    })

    //��ť�ύ��
    
    
    $('#verify-fail').click(function(){
    	var companyName = $('#company-name').html().trim();
    	var companyCertificateId = $('#companyCertificateId').val().trim();
    	var auditAdviceEl = $('#audit-advice');
        var auditAdvice = auditAdviceEl.val().trim();
        location.href = '/company/recognized?verifyState=-1&auditAdvice='+auditAdvice+'&companyName='+companyName+'&companyCertificateId='+companyCertificateId;
    });
    $('#verify-passed').click(function(){
    	var auditAdviceEl = $('#audit-advice');
        var auditAdvice = auditAdviceEl.val().trim();
    	var companyName = $('#company-name').html().trim(); 
    	var companyCertificateId = $('#companyCertificateId').val().trim();
        location.href = '/company/recognized?verifyState=1&auditAdvice='+auditAdvice +'&companyName='+companyName+'&companyCertificateId='+companyCertificateId;
    })
    $('#back-button').click(function(){
         window.history.back();
    })
    $('#add-verified-company').click(function(){
    	var auditAdviceEl = $('#audit-advice');
        var auditAdvice = auditAdviceEl.val().trim();
    	var companyName = $('#company-name').html().trim(); 
    	var companyCertificateId = $('#companyCertificateId').val().trim();
        location.href = '/company/recognized?verifyState=0&auditAdvice='+auditAdvice +'&companyName='+companyName+'&companyCertificateId='+companyCertificateId;
    })
})

String.prototype.format = function(data){
    if(!data)return;
      var parseData =  this.replace(/\{[(\s\S)]+?\}/mig,function(key){
                            var parseKey = key.replace(/^(\{)|(\})$/g,'');
                            if(data[parseKey])return data[parseKey];
                               return '--';
         });
        return  parseData;
}