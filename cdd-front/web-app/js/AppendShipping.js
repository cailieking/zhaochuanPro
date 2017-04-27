var ec = new ExtraCharge({
				$ctn:$('.main-content')
			});
		 $('input[name="startDate"],input[name="endDate"]').datepicker();
		 var showErrorMsg = function(inputEl){
             var msg = '';
             var msgHTML = '';
             if(inputEl.val()) {
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

         var route_style = $('input[name="route_style"]');
         var box_style =$('input[name="box_style"]'); 
         route_style.change(function(){
        	 if($(this).val().trim()==='direact'){
            	 $(".middle_port").hide();
                 }
             else{
            	 $(".middle_port").show()
                 }

             })
        	box_style.change(function(){
	        		if($(this).val().trim()==='Whole'){
					$(".together_style").hide();
					$(".route_price").show();
					
            		}else{
            			$(".together_style").show();
            			$(".route_price").hide()
                		}

            	});
         //运价判断        
     	$(".normal_price,.specical_prcie").blur(function(){
     		//var gp20Price = $('input[name="gp20_commom_price"]').val();
         	//var gp40Price = $('input[name="gp40_commom_price"]').val();
         	//var hq40Price = $('input[name="hq40_commom_price"]').val();
     			//if(!gp20Price&&!gp40Price&&!hq40Price)	{
				//		alert("价格不能全为空")	
											
         		//	}	
     			if($(this).val()&&!(/^[1-9]+[0-9]*$/.test($(this).val().trim()))){
     				//$(this).css({'borer':'red'})
					alert('格式输入不对 请重新输入')
         			}				
     	})
     	
     	$(".specical_prcie").blur(function(){
     		
     			 if($(this).val()&&!$(this).parent().siblings().find(".normal_price").val()){
     				alert("填写优惠价前请填写普通价");
     				
     			}else if($(this).val()&&$(this).parent().siblings().find(".normal_price").val()&&parseInt($(this).parent().siblings().find(".normal_price").val().trim())<parseInt($(this).val().trim()))	
     				alert("优惠价必须小于普通价");
     			
     		
     		
     		
     		
     	})
     	
     	
     	//船期第一列
     	
     	$(".shipping_date").eq(0).find(".num_box").blur(function(e){
     		blurJudge(e.target);
     		
     		
     	})
     		
     		
     	
     	//增加船期
     	var msg=[
					'<div class="shipping_date">',
						'<div  class="stopping_date">',
						  '<b  class="minus"></b>',
						   '<input type="text" class="num_box" name="">',
						   	'<b class="addition"></b>',
						   	'<span style="line-height:30px;margin-left:5px;">截</span>'	,		
						 '</div>',
						 '<div  class="starting_date" style="margin-left:4px;">',
						  '<b  class="minus"></b>',
						   '<input type="text" class="num_box"  name="">',
						   '<b class="addition"></b>',
							'<span style="line-height:30px;margin-left:5px;">开</span>',
						 '</div>',
						 
						 '<div class="add_shipping_date">',
						 	'<a href="javascript:void(0)" class="delete_shipping_btn" style="margin-left:5px"></a>',
						 '</div>',
						'</div>'

                     ].join("");
     	$(".shipping_date_area").click(function(evt){
     		var $targetEL =$(evt.target);
     		if($targetEL.hasClass('minus')){//减小
     			 var siblingsEl =$targetEL.parent().find(".num_box");
                 var siblingsElVal =siblingsEl.val()?siblingsEl.val().trim():'';
                 if(siblingsElVal&&(/\d+/.test(siblingsElVal))){

                    var ParseIntVal = parseInt(siblingsElVal);
                     if(ParseIntVal>1) {
                         ParseIntVal--;
                         siblingsEl.val(ParseIntVal);
                     }
                 }
              }
     		if($targetEL.hasClass('addition')){//增加
     			var siblingsEl =$targetEL.parent().find(".num_box");
                var siblingsElVal =siblingsEl.val().trim();
                if(!siblingsElVal){
                    siblingsEl.val("1");
                }
                else if(siblingsElVal&&(/\d+/.test(siblingsElVal))){
                    var ParseIntVal = parseInt(siblingsElVal);
                    if(ParseIntVal<7){
                        ParseIntVal++;
                        siblingsEl.val(ParseIntVal);
                     }else{
                    	 ParseIntVal.val('7')
                     }   
                	}
     			};
     		 if($targetEL.hasClass('add_shipping_btn')){
     			 if($(".shipping_date").length<6){
     				 $(".shipping_date_area").append(msg);
     				 $(".shipping_date_area").find('.shipping_date').last().find('.num_box').blur(function(e){
     					 blurJudge(e.target)
     				 })	 
     			 }
     		 }
     		if($targetEL.hasClass('delete_shipping_btn')){
     			$targetEL.parent().parent().remove()
     			
     		}
             
     		});
     	
     	var blurJudge =function(target){
     		
			var siblingsEl =$(target).parent().siblings().find('.num_box');
			var isDifferent =false;
			//if(!$(target).val()){
				//if(siblingsEl.val()){
					//isDifferent =true;					
			//	}					
			//}
			if($(target).val()){
				if(!/^[1-9]+$/.test($(target).val().trim())){
					alert("截关时间格式不对");
					
				}
			//if(!siblingsEl.val()){
			//		isDifferent =true;
					
			//	}
				
			}
			if(isDifferent){
				alert("开船日和截船日必须同时注明")
				
			}

				
		}
		
				/*	$(".shipping_date_area").blur(function(evt){
						var $targetEL =$(evt.target);
						if($targetEL.hasClass("num_box")){
							var siblingsEl =$targetEL.parent().siblings().find('.num_box');
							if($targetEL.val()&&!(/^[1-9]+$/.test($targetEL.val().trim()))){
									alert("截关格式不对")
							}
							if((!$targetEL.val()&&siblingsEl.val())||($targetEL.val()&&!siblingsEl.val())){
								alert("开船日和截船日必须同时注明")
							}
						}
					})
     	*/
     	/*$(".starting_date .num_box").blur(function(){
     		var siblingsEl =$(this).parent().siblings().find('.num_box');
     		var isEror =false;
     		if($(this).val()&&!(/^[1-9]+$/.test($(this).val().trim()))){
     			isEror=true;
     			
     		}
     		if(siblingsEl.val()&&!(/^[1-9]+$/.test(siblingsEl.val().trim()))){
     			
     			isEror=true;
     		}	
     		if(($(this).val()&&!siblingsEl.val())||(!$(this).val()&&siblingsEl.val())){
     			alert("开船日和截船日必须同时注明")
     			
     		}
     		if(isEror){
     			
     			alert("截关格式不对")
     		}
     		
     	})*/
     	
     	/*
     	 *  var showMsg =[];
     	 * $('.shipping_date').each(function(){
     	 * if($(this).find('.num_box').val()){
     	 *   var  endDateInfo =$(this).find('.stopping_date').find(".num_box").val().trim();
     	 *   var  startDateInfo =$(this).find('.starting_date').find(".num_box").val().trim();
     	 *    var msg =endDateInfo+'截'+startDateInfo+'开';
     	 *    showMsg .push(msg)
     	 * }})
     	  */
     		
     		
     		
     		
     		
     		
     	
     	
		
		//提交按钮
        	var validate = function(){       	
        			var box_styleVal =$('input[name="box_style"]:checked').val().trim();      	
        			if(box_styleVal==='Whole'){
		    			 var $wholeElArr =$('input[name="startPort"],input[name="endPort"],input[name="endPort"],input[name="endPort"],input[name="shippingDays"],input[name="shipCompany"],input[name="startDate"],input[name="endDate"]');
		    			 var len =$(".num_box").length;
		    			 var ilen =$(".normal_price").length;
		        		 var t =0;
		        		 var i=0;
		    			 var showInfo='';
		    			 $wholeElArr.each(function(){
		    				 if(!$(this).val()){
		    					 showInfo='必选项不能为空';       					 
		    				 }		    				 
		    			 });
		    			 //航程判断
		    			 var $shippingDaysVal = $('input[name="shippingDays"]').val();
		    			
		    			 if($shippingDaysVal){
		    				if(!/^\d+$/img.test($shippingDaysVal.trim())){
		  					showInfo='航程格式不对';		    					
		    				}
		    			 }
		    				 
		    			 
		    			 
		    			 $(".num_box").each(function(){
		    				 
		     			 	if(!$(this).val()){
		     				 t++   				       				 
		     			 	}
		     			 	if($(this).val()&&!(/^[1-9]+$/.test($(this).val().trim()))){
		     			 		 showInfo ='船期格式不对';
		     			 		   				     				 
		     			 	}
		     			 	if($(this).val()&&!$(this).parent().siblings().find('.num_box').val()){
		     			 		 showInfo ='船期里截船和开船日必须同时填写';
		     			 		  				 
		     			 	}	
		     			 	
		     			 	 
		    			 });

		    			
		    			 $(".normal_price").each(function(){
	               		 		if(!$(this).val()){
	               		 			i++;
	               		 			
	               		 		}
	               		 		
	               		 		
	               		 	})
		    			 $(".specical_prcie").each(function(){
		    				if($(this).val()&&!(/^[1-9]+[0-9]*$/.test($(this).val().trim()))) {
		    					showInfo="运费格式不对";
		    					
		    				}else if($(this).val()&&!$(this).parent().siblings().find(".normal_price").val()){
		    					 showInfo="填写优惠价前请填写普通价";
		    	     				
		    	     		}else if($(this).val()&&$(this).parent().siblings().find(".normal_price").val()&&parseInt($(this).parent().siblings().find(".normal_price").val().trim())<parseInt($(this).val().trim())){		    	     			
		    	     				showInfo="优惠价必须小于普通价";
		    	     		}
		    			 });
		    			 if(t==len){	 
		    				  showInfo ='船期不能全为空';
		    				 
		    			 }
		    			 if(i==ilen){	 
		    				  showInfo ='运价不能全为空';
		    				 
		    			 }
		    			 var localNameArr =[];//附加费非同类判断
		    			 $('select[name="extraCharge"]').each(function(){
		    				 if($(this).val()){
		    					 localNameArr.push($(this).val())
		    				 }
		    				 
		    			 })
		    			 var newArr =localNameArr.sort();
		    			 for(var i=0;i<newArr.length;i++){
		    				 if (newArr[i]===newArr[i+1]){
		    					 showInfo ='local费用名不能重复';
		    					 
		    				 }
		    			 }	 

						 //船期时间判断
						 if($('input[name="startDate"]').val()&&$('input[name="endDate"]').val()){										

									var startDate = $('input[name="startDate"]').val().split("-").join("");
									var endDate = $('input[name="endDate"]').val().split("-").join("");
									if(startDate>=endDate){
										 showInfo ='有效期开始日期不能大于截止日期';
									};
						 }
		    			 return showInfo;
        			}
         	 
        			else{       				
        				var $togetherElArr=$('input[name="startPort"],input[name="endPort"],input[name="endPort"],input[name="endPort"],input[name="shippingDays"],input[name="shipCompany"],input[name="startDate"],input[name="endDate"],input[name="per_price"],input[name="min_charge"]')
        				var len =$(".num_box").length;
        				
               		 	var t =0;
               		 	
               		 	var showInfo='';
               		 	$togetherElArr.each(function(){               			 
               			  if(!$(this).val()){
               				 showInfo ='必选项不能为空';	 
               			  }                			  
               		 	})   
               		//航程判断
		    			 var $shippingDaysVal = $('input[name="shippingDays"]').val();
		    			
		    			 if($shippingDaysVal){
		    				if(!/^\d+$/img.test($shippingDaysVal.trim())){
		    					showInfo='航程格式不对';
		    				}	
		    				}
               	
               		 	$(".num_box").each(function(){
               		 		if(!$(this).val()){
               		 			t++   				       				 
               		 		}
               		 		if($(this).val()&&!(/^[1-9]+$/.test($(this).val().trim()))){
               		 			 showInfo ='船期格式不对';
               		 			  				     				 
               		 		}
               		 		if($(this).val()&&!$(this).parent().siblings().find('.num_box').val()){
               		 			 showInfo ='船期里截船和开船日必须同时填写';
               		 			  				 
               		 		}	
               		 	 
               		 	})
               		 	
               		 	
               		 	if(t==len){	 
               		 		 showInfo ='船期不能全为空';
               		 		
               		 	}
               		 var localNameArr =[];//附加费非同类判断
	    			 $('select[name="extraCharge"]').each(function(){
	    				 if($(this).val()){
	    					 localNameArr.push($(this).val())
	    				 }
	    				 
	    			 })
	    			 var newArr =localNameArr.sort();
	    			 for(var i=0;i<newArr.length;i++){
	    				 if (newArr[i]===newArr[i+1]){
	    					 showInfo ='local费用名不能重复';
	    					 
	    				 }
	    			 }	 
	    			 //船期时间判断

						 if($('input[name="startDate"]').val()&&$('input[name="endDate"]').val()){										

									var startDate = $('input[name="startDate"]').val().split("-").join("");
									var endDate = $('input[name="endDate"]').val().split("-").join("");
									if(startDate>=endDate){
										 showInfo ='有效期开始日期不能大于截止日期';
									};
						 }
		    			
        			}
        			return showInfo;
        	}	

			


        	//船期取值
    		var getLocalMeg =function(){
    			var showMsg =[];
    			$('.shipping_date').each(function(){
    				if($(this).find('.num_box').val()){
    					var  endDateInfo =$(this).find('.stopping_date').find(".num_box").val().trim();
    					var  startDateInfo =$(this).find('.starting_date').find(".num_box").val().trim();
    					var msg =endDateInfo+'截'+startDateInfo+'开';
    					showMsg .push(msg)
    				}
    			})
        	  $('input[name="total_shipping_date"]').val(showMsg.join(','));
    		//附加费取值	
        	  var extraChargeData = ec.getAllData();
        	  var arr =[];
        	  if(extraChargeData.length > 0){
        		 for(var i=0;i<extraChargeData.length;i++){ 			
        			arr.push( extraChargeData[i]['value'])      			 
        		 } 
        		 $('input[name="total_local_cost"]').val(arr.join(';')) 
        	  }
    		}
        	 $(".make_sure").click(function(){
        		  var showMsg =validate()
        		  if(showMsg){
        			  alert(showMsg);
        		  }
        		  else{
        			  getLocalMeg()
        			  $("#myform").submit();
        			  
        		  }
        		 
        	 })
        	
            	  
             			
        
       //清除按钮
         $(".cancel").click(function(){
        	 $("#myform")[0].reset();
        	 
        	 
         })
       //返回按钮
         $(".back").click(function(){
        	 window.location.href='http://'+window.location.host+'/member'
        	 
        	 
         })
         
         //var inputArr =$('input[name="shippingDays"],input[name="shipCompany"],input[name="startDate"],input[name="endDate"]')
		 $('input[name="shippingDays"],input[name="per_price"],input[name="min_charge"]').blur(function(){
				 showErrorMsg($(this));
				}).focus(function(){
					if($(this).next()){
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
	           $('input[name="middlePort"]').typeaheads({
		             source:end_port_list || window['end_port_list'],
		              items:8

		          }); 
	         },3000);
	         $('input[name="shipCompany"]').focus(function(evt){
              $('body').unbind('mousedown'); 
               $('body').bind('mousedown',function(evt){
                   var $shippingCompanyList =$('.shipping-company-list');
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
                $('input[name="shipCompany"]').parent().find('.shipping-company-list').click(function(evt){
               
               var $tar = $(evt.target);
               if($tar[0].tagName === 'LI'){
               $('input[name="shipCompany"]').val($tar.html().trim());
                 $(this).css({display:"none"});
                 }
          });  
              //提交
                
			
		 
	         })	