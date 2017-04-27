 var $transType =$('.container-size');				
			$transType.change(function(){
             if($(this).val().trim()==="Together"){
               $('#piece').show();
              $(".box-size").hide();
           }else
             {
               $('#piece').hide();
               $(".box-size").show();
                
             }
         });
         
         var showErrorMsg = function(inputEl){
             var msg = '';
             var msgHTML = '';
             if(inputEl.val().trim()) {
                msg = validateInputWhenChange(inputEl);
                if(msg) {
                   msgHTML = '<span class="error-msg">'+msg+'</span>';
                  $(msgHTML).insertAfter(inputEl);
                }   
            }else{
                msgHTML = '<span class="error-msg"  style="color:red;font-size:12px;margin-left:15px;">输入框内容不能为空</span>';
                $(msgHTML).insertAfter(inputEl);
            }
                
         };
         var inputArr = $('#create-cargo').find('input[type="text"]');
         $.each(inputArr,function(index,input){  
            var flag = $(input).prop('name') !== 'startPort' &&
                       $(input).prop('name') !=='endPort' && 
                       $(input).prop('name') !=='shipCompany'; //和搜索框组件相互干扰        
            if(flag){
                $(input).blur(function(){
                    var inputEl = $(input);
                    showErrorMsg(inputEl);
                }).focus(function(){
                    var inputEl = $(input);
                    if(inputEl.next()) inputEl.next().remove();

                })
            };

         });
         $('#create-cargo').find('input[name="endDate"]').datepicker({ //这儿在点时间组件时会触发blur事件
             yearRange:'2015:+11',
             onSelect:function(dataText,inst){
                 $(this).next().remove();
             }
         });
         setTimeout(function(){
           $('input[name="startPort"]').typeaheads({
              source:start_port_list || window['start_port_list'],
               items:8

          });
           $('input[name="endPort"]').typeaheads({
             source:end_port_list || window['end_port_list'],
              items:8

          }); 
         },3000)
          $('input[name="shipCompany"]').focus(function(evt){
              $('body').unbind('mousedown'); 
               $('body').bind('mousedown',function(evt){
                   var $shippingCompanyList = $('.shipping-company-list');
                   var $target = $(evt.target);
                   var flag = $target.hasClass('shipping-company-list') || 
                              $target.parent().hasClass('shipping-company-list')||
                              $target.parent().parent().hasClass('shipping-company-list');
                   if(!$shippingCompanyList.is(':hidden') && !flag){
                      $shippingCompanyList.hide();
                   }           
                   evt.stopPropagation();
              })   
              if($(this).next('.error-msg').length>0){
                 $(this).next().remove();
               }
               var $companyCollection = $(this).next().show();
               $companyCollection.animate({
                  width:450,height:230
               },'slow')

           }).blur(function(evt){
               
           });
            $('input[name="shipCompany"]').parent().find('.shipping-company-list').click(function(evt){
               var $tar = $(evt.target);
               if($tar[0].tagName === 'LI'){
               $('input[name="shipCompany"]').val($tar.html().trim());
                 $(this).css({display:"none"});
                 }
                      });
          $('textarea[name="orderDescript"]').focus(function(evt){
            var tarEl = $(evt.target);
               tarEl.val('');
         });
          $('#create-cargo').find('.submit-btn').click(function(evt){
              var result = validateFormWhenSubmit($('#create-cargo'),$('#create-cargo')[0],true);
              if(result){
                window.alert(result);
                return;
              }
              $('#create-cargo').submit();
              
          });