// JavaScript Document

$(function()
{
    //处理登录
    $("#submit_login").on("click",function()
    {
        //初始化
        var j_username=$.trim($("#j_username").val());
        var j_password=$.trim($("#j_password").val());

        //检查账号密码
        if(!j_username)
        {
            $("#login_error").html("账号不能为空");
            $("#j_username").focus();
            return false;
        }
        if(!j_password)
        {
            $("#login_error").html("密码不能为空");
            $("#j_password").focus();
            return false;
        }
        
        $("#form_login").submit();
    });
});

$(function() {
	/** *2 3 4 楼切换效果 */
	(function($) {
		$.fn.Tab2 = function(idName, selecd, noselecd) {
			$("#" + idName).find(".f_title_tab a").each(function(i) {
				$(this).mouseover(function() {
					$("#" + idName).find(".f_title_tab a").removeClass(selecd);
					$("#" + idName).find(".f_title_tab a").addClass(noselecd);
					$(this).removeClass(noselecd);
					$(this).addClass(selecd);
					$("#" + idName).find(".content_top_xhzy").hide();
					$("#" + idName).find(".content_top_xhzy").eq(i).show();
					$("#" + idName).find(".content_text_list").hide();
					$("#" + idName).find(".content_text_list").eq(i).show();
				})
			})
		};
	})(jQuery);

	$().Tab2('new_fourf', 'four_selecd', 'four_noselecd');
	$().Tab2('new_threef', 'three_selecd', 'three_noselecd');
	$().Tab2('new_twof', 'two_selecd', 'two_noselecd');

	/** 第一个楼层切换效果* */
	(function($) {
		$.fn.tab = function(idName, selecdName) {
			$("#" + idName).find(".f_title_tab a").each(
					function(i) {
						$(this).mouseover(
								function() {
									$("#" + idName).find(".f_title_tab a")
											.removeClass(selecdName);
									$(this).addClass(selecdName);
									$("#" + idName).find(".content_top_xhzy")
											.hide();
									$("#" + idName).find(".content_top_xhzy")
											.eq(i).show();
									$("#" + idName).find(".content_text_list")
											.hide();
									$("#" + idName).find(".content_text_list")
											.eq(i).show();
								})
					})

		};
	})(jQuery);

	$().tab('new_hangyunf', 'selected');

	/** 价格走势横条滑动效果* */
	/*
	 * $(".price_region a").each(function(i){ $(this).mouseover(function(){ var
	 * l=$(this).width(); $(".price_cont").hide();
	 * $(".price_cont").eq(i).show(); $(".focus_bg").stop(true);
	 * $(".focus_bg").animate({left:l*i},300); }); });
	 */
	$(".price_title_right a").each(function(i) {
		$(this).mouseover(function() {
			$(".price_content").hide();
			$(".price_content").eq(i).show();
			$(".price_title_right .line").stop();
			var w = $(".price_title_right .line").width();
			$(".price_title_right .line").animate({
				left : w * i
			}, 300);
		});
	});
	$(".price_content").each(function() {
		$(this).find(".content_block").last().css({
			"border" : '0'
		})
	})
	/** 搜索物性表和搜现货效果** */
	$(".sear_title span").click(function() {
		$(".sear_title span").removeClass("on");
		$(this).addClass("on");
	});

	/** **资讯效果*** */

	$(".zixun_box").each(function(i) {
		$(this).mouseover(function() {
			$(".zixun_box").css('background', '#f8f8f8');
			$(this).css('background', '#fff');
			$(".zixundt .line").stop();
			$(".zixundt .line").animate({
				'left' : $(".zixun_box").width() * (i + 1)
			}, 200);
		});

	});

	/** 移入提示信息详情效果* */
	$(".content_text_list li ").each(
			function(i) {
				$(this)
						.mousemove(
								function(ev) {
									var str = $(this).find('p').eq(0).html()
											+ '&nbsp;'
											+ $(this).find('p').eq(1).html();
									$("#tip_message").show();
									$("#tip_message").html(str);
									var t = $(window).scrollTop();
									var x = ev.clientX
											- $("#tip_message").width() - 40;
									var y = ev.clientY + t - 15;
									$("#tip_message").css({
										left : x,
										top : y
									});
								});
				$(this).mouseout(function() {
					$("#tip_message").hide();
				});

			});

	// 订单动态移入提示效果
	$(".mj_message_table").on('mousemove', '.td_w84', function(ev) {
		var str = $(this).parent().find(".td_w84").attr("title");
		$("#tip_message").show();
		$("#tip_message").html(str);
		var t = $(window).scrollTop();
		var x = ev.clientX + 20;
		var y = ev.clientY + t - 15;
		$("#tip_message").css({
			left : x,
			top : y
		});
	});
	$(".mj_message_table").on('mouseout', '.td_w84', function(ev) {
		$("#tip_message").hide();
	});

	/** **滚动条滑动显示顶层搜索框效果****** */
	var searchToggle = {
		tab : function() {

			$(window).scroll(function() {
				if ($(window).scrollTop() > 100) {
					$("#search").show().css({
						position : 'fixed'
					})
					$(".lift").css({
						"top" : "72px"
					});
				} else {
					$("#search").hide().css({
						position : ''
					})
					$(".lift").css({
						"top" : "192px"
					});
				}
			})
		}
	}
	searchToggle.tab();

	// 电梯效果
	var lift = {
		pos : {},
		get_pos : function() {
			$("body").find(".floor_flag").each(function(index) {
				lift.pos[index] = $(this).offset().top;
			});
		},
		style : function(index) {
			var $this = $(".lift ul").find("li").eq(index);
			var color = $this.css("borderLeftColor");
			$this.css({
				"background" : color,
				"color" : "#FFFFFF"
			}).siblings("li").each(function() {
				$(this).css({
					"background" : "#FFFFFF",
					"color" : $(this).css("border-color")
				});
			});
			$(".lift").find(".arrow").css({
				"top" : (19 + 52 * index) + "px",
				"border-left-color" : color
			});
		},
		go : function() {
			$(".lift ul").find("li").on("click", function() {
				$(window).off("scroll", lift.scroll);
				var index = $(this).index();
				$("html,body").animate({
					scrollTop : lift.pos[index] - 60
				}, 500, function() {
					lift.style(index);
					$(window).on("scroll", lift.scroll);
				});

			});
		},
		go_top : function() {
			$(".lift").find(".go_top").on("click", function() {
				$("html,body").animate({
					scrollTop : "0"
				}, 500);
			});
		},
		scroll : function() {
			var s_top = $(window).scrollTop();
			if (s_top > lift.pos[0] - 100) {
				$(".lift").fadeIn(500);
				var n = $(".lift ul").find("li").length;
				for (i = 0; i < n; i++) {
					if ($("body").find(".floor_flag").eq(i).offset().top - 60 <= s_top) {
						lift.style(i);
					}
				}
			} else {
				$(".lift").fadeOut(500);
			}
		},
		init : function() {
			lift.get_pos();
			lift.go();
			lift.go_top();
			$(window).on("scroll", lift.scroll);
		}
	};
	lift.init();

	// 轮播图
	var gallery = {
		i : 0,
		n : $(".banner_img .banner_focus").find("a").length,
		timer : null,
		change : function(index) {
			$(".banner_img .img_list").find("li").eq(index).show().siblings()
					.hide();
			$(".banner_img .banner_focus").find("a").eq(index).addClass("on")
					.siblings().removeClass("on");
		},
		start : function() {
			gallery.timer = setInterval(function() {
				gallery.i == gallery.n - 1 ? gallery.i = 0 : ++gallery.i
				gallery.change(gallery.i);
			}, 3000);
		},
		stop : function() {
			clearInterval(gallery.timer);
		},
		event : function() {
			$(".banner_img .banner_focus").find("a").on("mouseover",
					function() {
						gallery.change($(this).index());
						gallery.stop();
					}).on("mouseout", gallery.start);
			$(".banner_img .img_list").find("li").on("mouseover", gallery.stop)
					.on("mouseout", gallery.start);
		},
		init : function() {
			gallery.change(0);
			gallery.start();
			gallery.event();
		}
	};

	// 首页登录按钮
	$("#login_index").on("click", function() {
		show_dialog_login();
	});

	// 登录注册移入边框变色效果;
	$(".logoin_before .log").hover(function() {
		$(this).css({
			'border' : '1px solid #3399EE'
		});
	}, function() {
		$(this).css({
			'border' : '1px solid #ddd'
		});
	});

	$(".logoin_before .lj_reg").hover(function() {
		$(this).css({
			'border' : '1px solid #3399EE'
		});
		$(".logoin_before .log").css('borderRight', '0');
	}, function() {
		$(this).css({
			'border' : '1px solid #ddd'
		});
		$(".logoin_before .log").css('borderRight', '1px solid #ddd');
		$(this).css({
			'borderLeft' : '0'
		});
	})

	$(".span_a .close").click(function(e) {

		$.setcookie('name', 'banner');
		$("#mlzx_a").hide();
		e.preventDefault();
		e.cancelBubble = true;
		e.stopPropagation();
		return false;

	});
	

	$.ajax(
        {
        url:SITE_URL+'index/advInfo',
        type:"get",
        success:function(rs)
        {
            if(rs && rs.data)
            {
            	if (rs.data.imageInfos) {
	            	for (var i=0; i<rs.data.imageInfos.length; i++) {
	            		var imgObj = rs.data.imageInfos[i];
	            		var imgObjStyle = (i==0) ? "display: list-item;":"display: none;";
	            		
	            		var theUrl = (imgObj.content.indexOf("http") > -1 ||  imgObj.content.indexOf("index") > -1) ? imgObj.content : "javascript:void(0)";
	            		var theTitle = (imgObj.content.indexOf("http") > -1 ||  imgObj.content.indexOf("index") > -1) ? "" : imgObj.content;
	            		
	            		$(".img_list").append("<li style='"+imgObjStyle+"'><a target='_blank' href='"+theUrl+"' title='找船网'><img src='"+ossDomain+imgObj.image+"' width='730' height='270' alt='找船网；深圳市找船网络科技有限公司 航运交易平台 货代 最新运价信息'></a></li>");
	            		$(".banner_focus").append("<a href='javascript:void(0)' class=''></a>");
	            	}
            	}
            	
            	if (rs.data.article) {	
            		if (rs.data.article.imageInfo) {
            			var artImageInfo = rs.data.article.imageInfo;
	            		$(".zixundt .box1").append(
	            			'<a target="_blank" href="/article/data?id='+artImageInfo.id+'"><img src="'+ossDomain+artImageInfo.image+'"></a>'
	            			+'<a class="a2" target="_blank" href="/article/data?id='+artImageInfo.id+'">'+artImageInfo.title+'</a>'
	            		);
            		}
            		
            		if (rs.data.article.ftlist) {
            			var ftlist = rs.data.article.ftlist;
            			for (var i=0; i<ftlist.length; i++) {
            				var ftObj = ftlist[i];
		            		$(".zixundt .box2 .zixun_box_ul").append(
	            				'<li><span class="nub">'+ftObj.dateCreatedStr+'</span><a target="_blank"'
    							+' href="/article/data?id='+ftObj.id+'" class="link">'+ftObj.title+'</a></li>'
		            		);
            			}	
            			
             			var tplist = rs.data.article.tplist;
            			for (var i=0; i<tplist.length; i++) {
            				var tpObj = tplist[i];
		            		$(".zixundt .box3 .zixun_box_ul").append(
	            				'<li><span class="nub">'+tpObj.dateCreatedStr+'</span><a target="_blank"'
    							+' href="/article/data?id='+tpObj.id+'" class="link">'+tpObj.title+'</a></li>'
		            		);
            			}	
            			
             			var comlist = rs.data.article.comlist;
            			for (var i=0; i<comlist.length; i++) {
            				var comObj = comlist[i];
		            		$(".zixundt .box4 .zixun_box_ul").append(
	            				'<li><span class="nub">'+comObj.dateCreatedStr+'</span><a target="_blank"'
    							+' href="/article/data?id='+comObj.id+'" class="link">'+comObj.title+'</a></li>'
		            		);
            			}	
            			
            			
            		}
            	}
            	
            	
            }
            
            gallery.init();
            
        }
    });
	
	
	
	
	$.ajax(
	        {
	        url:SITE_URL+'index/dataInfo',
	        type:"get",
	        success:function(rs)
	        {
	        	$("tr.loading").hide();
	        	var verify = false;
	            if(rs && rs.data)
	            {	
	            	//航运
	            	if (rs.data.cargoShip) {
	            		verify = rs.data.cargoShip.verified || false;
	            		if (rs.data.cargoShip.list) {	
			            	for (var i=0; i<rs.data.cargoShip.list.length; i++) {
			            		var trClass = i%2 == 0 ? " tr_blue" : "";
			            		
			            		var row = rs.data.cargoShip.list[i];
			            		
			            		var infoId = row.infoId ? row.infoId : '';
			    				var startPort = row.startPort ? row.startPort : '';
			    				    startPort = startPort.replace(/\([a-zA-Z]+\)$/g,'');
			    				var endPort = row.endPort ? row.endPort : '';
			    				var shipCompany = row.shipCompany ? row.shipCompany : '';
			    				var shippingDay = row.shippingDay ? row.shippingDay : '';
			    				var shippingDays = row.shippingDays ? row.shippingDays : '';
			    				var shippingDays = row.shippingDays ? row.shippingDays : ''
		    					var startDate = row.startDate ? row.startDate : ''
	    						var endDate = row.endDate ? row.endDate : ''
	    						var gp20 = row.gp20 === 0? '$'+0:( row.gp20 ? '$'+row.gp20: '-')
	    						var gp40 = row.gp40 === 0? '$'+0:( row.gp40 ? '$'+row.gp40: '-')
	    						var hq40 = row.hq40 === 0? '$'+0:( row.hq40 ? '$'+row.hq40: '-')
	    						var gp20Vip = row.gp20Vip === 0? '$'+0:( row.gp20Vip ? '$'+row.gp20Vip: '-')
	    			    		var gp40Vip = row.gp40Vip === 0? '$'+0:( row.gp40Vip ? '$'+row.gp40Vip: '-')
	    			    		var hq40Vip = row.hq40Vip === 0? '$'+0:( row.hq40Vip ? '$'+row.hq40Vip: '-')
			            		
			            		$("#hangyunTable tbody").append(
									['<tr class="tr_auto'+trClass+'" >',
									'<td width="400px;">',
									'<a class="login_flag" data-ship="/ships/ship.html?startPort='+startPort+'&endPort='+endPort+'&transType=" href="javascript:void(0)" target="_blank">',
				                    '<h3 class="font_title">'+startPort+' → '+endPort+'<div class="font_title4">特</div></h3>',
									'</a>',
									'</td>',
									'<td width="135px;">',
									'<h3 class="font_title2">20\'GP<h3>',
									'</td>',
									'<td width="135px;">',
									'<h3 class="font_title2">40\'GP<h3>',
									'</td>',
									'<td width="135px;">',
									'<h3 class="font_title2">40\'HQ<h3>',
									'</td>',
									'<td width="100px;"></td>',
									'</tr>',
									'<tr class="tr_auto'+trClass+'" >',
									
									'<td><h5 class="font_title5">',
									'<p>承运人：' + shipCompany + '</p>',
									'<p>班期：' + shippingDay + '</p>',
									'<p>航程：' + shippingDays + '</p>',
									'</h5></td>',
									'<td>',
									'<div class="font_title3">'+gp20+'</div>',
									'<div class="font_title3 discount-price">'+gp20Vip+'</div>',
									'</td>',

									'<td>',
									'<div class="font_title3">'+gp40+'</div>',
									'<div class="font_title3 discount-price">'+gp40Vip+'</div>',
									'</td>',
									
									'<td>',
									'<div class="font_title3">'+hq40+'</div>',
									'<div class="font_title3 discount-price">'+hq40Vip+'</div>',
									'</td>',
									
									'<td><p class="sp_w60">',
											'<a href="/publish/findship?verify='+verify+'&infoId='+infoId+'&startPort='+startPort+'&endPort='+endPort+'" class="supply_button" target="_blank" >在线订舱</a>',
									'</p></td>',
						             
						             '</tr>'
									
									].join('')
								);
			            	}
	            		}
	            		if (rs.data.cargoShip.orders) {
			            	for (var i=0; i<rs.data.cargoShip.orders.length; i++) {
			            		var orderObj = rs.data.cargoShip.orders[i];
			            		var lastUpdated = orderObj.lastUpdated ? orderObj.lastUpdated : '';
			            		var orderStr = orderObj.startPort+' - '+orderObj.endPort+' '+lastUpdated;
			            		$("#hangyunScrollTable tbody").append(
										['<tr class="tr_30">',
										'<td class="td_w65 fcolor_1">'+orderObj.contactName+'</td>',
										'<td class="td_w84 fcolor_3 text_hide" title="'+orderStr+'"><span>'+orderStr+'</span></td>',
										'<td class="td_w84 fcolor_1" title="交易成功">交易成功</td></tr>'
										].join('')
									);
			            	}	
	            		}
	            		if (rs.data.cargoShip.imageInfos) {
			            	for (var i=0; i<rs.data.cargoShip.imageInfos.length; i++) {
			            		var row = rs.data.cargoShip.imageInfos[i];
			     				var content = row.content ? row.content : '';
			    				var image = row.image ? row.image : '';
			            		$("#new_hangyunf .f_content_bot").append(
										[
											'<a target="_blank" href="http://www.zhao-chuan.com/">',
											'<img alt="" src="'+ossDomain+image+'" width="121" height="52"></a>'
										].join('')
									);
			            	}	
	            		}
	            	}
	            	
	            	//1L 家具
	            	initOrdersFloor(rs.data.furniture, 1);
	            	initOrdersFloor(rs.data.building, 2);
	            	initOrdersFloor(rs.data.clothing, 3);
	            	initOrdersFloor(rs.data.pinxiang, 4);
	            }
	            if(!verify){
	            	$('.discount-price').siblings().css({color:'#ff540c'});
	            	$('.discount-price').hide();
	            } 
	        	// 订单动态滚动
	        	$(".purchase_scroll0").find("table").scrollcontent(50);
	        	$(".purchase_scroll1").find("table").scrollcontent(50);
	        	$(".purchase_scroll2").find("table").scrollcontent(50);
	        	$(".purchase_scroll3").find("table").scrollcontent(50);
	        	$(".purchase_scroll4").find("table").scrollcontent(50);
	            
	        }
	    });

});

function initOrdersFloor(data, floorId) {
	
	if (data) {
		if (data.list) {	
			
			var wrapperDivId="";
			switch (floorId) {
				case 1 : wrapperDivId="new_onef";break;
				case 2 : wrapperDivId="new_twof";break;
				case 3 : wrapperDivId="new_threef";break;
				case 4 : wrapperDivId="new_fourf";break;
			}
			
        	for (var i=0; i<data.list.length; i++) {
        		
        		var row = data.list[i];
        		var infoDetail = "";
				var startPort = row.startPort ? row.startPort : '';
				var endPort = row.endPort ? row.endPort : '';
				var startPortCn = row.startPortCn ? row.startPortCn : '';
				var endPortCn = row.endPortCn ? row.endPortCn : '';
				var startDate = row.startDate ? row.startDate : '';
				var endDate = row.endDate ? row.endDate : '';
				var transType = row.transType ? row.transType : '';
				var orderId = row.orderId ? row.orderId : '';
				var cargoBoxType = row.cargoBoxType ? row.cargoBoxType : '';
				var cargoBoxNums = row.cargoBoxNums ? row.cargoBoxNums : '';
				var cargoNums = row.cargoNums ? row.cargoNums : '';
				var cargoWeight = row.cargoWeight ? row.cargoWeight : '';
				var cargoCube = row.cargoCube ? row.cargoCube : '';
				var cargoName = row.cargoName ? row.cargoName : '';
        		
				if (row.transType == '整箱') {
					infoDetail = [
						cargoBoxNums,
						' * ',
						cargoBoxType
			        ].join('');
				} else {
					infoDetail = [
						' 件数：',
						cargoNums,
						' 重量：',
						cargoWeight,
						'KG 体积：',
						cargoCube,
						'CBM'
			        ].join('');
				}
				
				var trClass = i%2 == 0 ? " tr_blue" : "";
        		
        		$("#floorTable"+floorId+" tbody").append(
					[
					'<tr class="tr_38'+trClass+'">',
					'<td><span class="td_nowrap_140">'+startPort+'</span></td>',
					'<td><span class="td_nowrap_140">'+endPort+'</span></td>',
					'<td>'+cargoName+'</td>',
					'<td>'+infoDetail+'</td>',
					'<td>'+startDate+' - '+endDate+'</td>',
					'<td>'+transType+'</td>',
					'<td><p class="sp_w60">',
					'<a href="/publish/findcargo?orderId='+orderId+'&startPort='+startPort+'&endPort='+endPort+'&startPortCn='+startPortCn+'&endPortCn='+endPortCn+'" class="supply_button" target="_blank">我要报价</a>',
					'</p></td></tr>'
					].join('')
				);
        	}
		}
		if (data.orders) {
        	for (var i=0; i<data.orders.length; i++) {
        		var row = data.orders[i];
				var startPort = row.startPort ? row.startPort : '';
				var endPort = row.endPort ? row.endPort : '';
				var startDate = row.startDate ? row.startDate : '';
				var orderStatusName = row.orderStatus ? row.orderStatus : '';
				var lastUpdated = row.lastUpdated ? row.lastUpdated : '';
        		var orderStr = startPort+' - '+endPort+' '+lastUpdated;
        		var orderStatus = (!orderStatusName || orderStatusName.name == 'UnTrade' || orderStatusName.name == 'InTrade') ? "正在洽谈" : "交易成功";
        		var orderStyle = (!orderStatusName || orderStatusName.name == 'UnTrade' || orderStatusName.name == 'InTrade') ? "fcolor_0" : "fcolor_1";
        		$("#floorScrollTable"+floorId+" tbody").append(
						['<tr class="tr_30">',
						'<td class="td_w84 fcolor_3 text_hide" title="'+orderStr+'"><span>'+row.contactName+'</span></td>',
						'<td class="td_w84 '+orderStyle+'" title="'+orderStatus+'">'+orderStatus+'</td>',
						'<td class="td_w84" >'+lastUpdated+'</td></tr>'
						].join('')
					
					);
        	}	
		}
		if (data.imageInfos) {
        	for (var i=0; i<data.imageInfos.length; i++) {
        		var row = data.imageInfos[i];
 				var content = row.content ? row.content : '';
				var image = row.image ? row.image : '';
        		$("#"+wrapperDivId+" .f_content_bot").append(
						[
							'<a target="_blank" href="http://www.zhao-chuan.com">',
							'<img alt="" src="'+ossDomain+image+'" width="121" height="52"></a>'
						].join('')
					);
        	}	
		}
	}
}

function viewScore(target) {
	$(target).find('.dt_oper_view_div').show();
}
function hideScore(target) {
	$(target).find('.dt_oper_view_div').hide();
}

var ossDomain = 'http://${grailsApplication.config.oss.publicbucket}.${grailsApplication.config.oss.endpointDomain}/';

var type='bdi',title='波罗的海综合运价指数';
var datas = [];
var line = [];
var category = [];
var showBDI = function(BIDWeekData,BIDDayData){
    if(BIDWeekData && typeof BIDWeekData ==='object'){
        $.each(BIDWeekData,function(index,item){
              line = item['date'].split('-');
              datas.push(parseInt(item['index']));
              category.push(line[1]+ '-' + line[2]);// 
        })
        var options = {id:'bdi-container',data:[{name:type,data:datas,BIDDayData:BIDDayData}],title:title,categories:category};
        $('#bdi-container').bdiWeekChart(options);
    }
};
var weekCNMap = {
		1:'星期一',
		2:'星期二',
		3:'星期三',
		4:'星期四',
		5:'星期五',
		6:'星期六',
		0:'星期天'
};
$.ajax(
    {
        url:SITE_URL+'index/newComeIn',
        type:"get",
        success:function(rs)
        {  var d = new Date();
           showBDI(rs.BIDWeek,rs.BIDDay);
           $('#year').html(d.getFullYear() + '年');
           $('#datetime').html(d.getMonth()+1 +'月'+ d.getDate()+'日');
           $('#curRate').html(rs.rate);
           $('#week').html(weekCNMap[d.getDay()]);
        }
    }
)
