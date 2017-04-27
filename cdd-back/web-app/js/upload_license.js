$(function(){
    var magnifiedAreaLeftEl = $('.zoom-up-image-left');
    var magnifiedAreaRightEl = $('.zoom-up-image-right');
    var imglistleftEl = $('#img-list-left');
    var imglistrightEl = $('#company-list-right');
        imglistleftEl.click(function(e){ //左右两边的事件都绑定了
           imgClick(e,'left');
        });
        imglistrightEl.click(function(e){
            imgClick(e,'right');
        });
       $('.delete-btn').click(function(){
           magnifiedAreaLeftEl.css('visibility','hidden');
           magnifiedAreaRightEl.css('visibility','hidden');
       })
    var imgClick = function(e,direction){

        if(/\{[\s\S]+\}/g.test(decodeURIComponent(imglistrightEl.find('img').prop('src'))))return; //右侧img使用模板在显示，如果右侧没显示，左侧图片不放大
        var target = e.target;
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
        magnifiedAreaLeftEl.css('visibility','visible');
        magnifiedAreaRightEl.css('visibility','visible');
    };


    //搜索框动态显示区
    $('#search-input-box').typeahead({
               /*   order:'desc',*/
              minLength:0,
                /* offset:true,*/
                maxItem:8,
                   hint:true,
                dynamic:true,
                  delay:500,
          emptyTemplate: 'No result for',
                 source:{
                     url:['./company.json','data']
                 },
                backdrop:{
                    'background-color': '#3879d9',
                    'opacity': '0.1',
                     'filter': 'alpha(opacity=10)'
                },
               callback:{
                   onSubmit:function(){
                       var companyName = decodeURIComponent(location.href.match(/(search-input-box=)([\s\S]+)$/ig)[0].split('=')[1]);
                       $.get('./company_info.json',{companyName:companyName},function(data){
                         var $searchResult =  $('#search-result');
                         var searchResultHtml = $searchResult.html();
                             searchResultHtml =  searchResultHtml.format(data);
                              $searchResult.html(searchResultHtml);
                              $searchResult.css('visibility','visible');
                       });
                       return false
                   }
               }

    })

    //按钮提交区
    var auditAdviceEl = $('#audit-advice');
    var auditAdvice = auditAdviceEl.val().trim();
    $('#verify-fail').click(function(){
        location.href = '/company/certifyImg?verifyState=-1&auditAdvice='+auditAdvice;
    });
    $('#verify-passed').click(function(){
        location.href = '/company/certifyImg?verifyState=1&auditAdvice='+auditAdvice;
    })
    $('back-button').click(function(){
         window.history.back();
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