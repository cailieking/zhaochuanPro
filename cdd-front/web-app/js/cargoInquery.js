String.prototype.trim= function(){
   return this.replace(/^\s+|\s+$/img,'');
};
var tipsMapping = {
        userName : '用户名不能为空',
     companyName : '公司不能为空',
          mobile : '联系电话不能为空',

        startPort: '起始港不能为空',
          endPort: '目的港不能为空',
        cargoName: '货物名称不能为空',
        cargoWeight: '毛重不能为空',
         cargoCube : '体积不能为空',
         cargoNums : '件数不能为空',
            endDate: '出货日不能为空',
            number:'箱型不能为空，可多填',
       cargoBoxType: '箱型不能为空',

      /*numberFormatError:'不能为负',*/
      mobileFormatError : '手机格式错误',
       qqFormatError : '格式错误,只能为数字', 
       cargoWeightFormatError: '格式错误,只能为数字',  
       cargoCubeFormatError: '格式错误,只能为数字',
       cargoNumsFormatError:'格式错误,只能为数字'

};
var validateFormWhenSubmit = function($common_form,form,isNewCargo){ //用户什么都不填提交时进行的检测
    var msg = '';
    if(!$common_form)return;
    if(!isNewCargo){
        if(!$common_form.find('input[name="userName"]').val().trim()){
          msg = tipsMapping['userName'];
        }
        if(!$common_form.find('input[name="companyName"]').val().trim()){
          msg = tipsMapping['companyName'];
        }
        if(!$common_form.find('input[name="mobile"]').val().trim()){
         msg = tipsMapping['mobile'];
        }
    }
 
     if(isNewCargo){
    	 if(!form.startPort.value.trim()){
             msg = tipsMapping['startPort'];
         }
         if(!form.endPort.value.trim()){
         	 msg = tipsMapping['endPort'];
         }
         if(!form.cargoName.value.trim()){
         	 msg = tipsMapping['cargoName'];
         }
         if(!form.endDate.value.trim()){
         	msg = tipsMapping['endDate'];
         }
         if(form.transType.value.trim()==="Whole"){ 	 
        	 if(!form.box20GP.value && !form.box40GP.value && !form.box40HQ.value ){
         	msg = tipsMapping['cargoBoxType'];
         }
         }
         if(!form.cargoWeight.value.trim()){
         	msg = tipsMapping['cargoWeight'];
         }
         if(!form.cargoCube.value.trim()){
         	msg = tipsMapping['cargoCube'];
         }
         if($(form.cargoNums).is(':hidden')){
        	 $(form.cargoNums).val('0');
         }
         if(form.cargoNums && !form.cargoNums.value.trim() && !$(form.cargoNums).is(':hidden')){ //件数只有拼箱才有这个输入框       	 
        	 msg = tipsMapping['cargoNums'];
         }
    }

   
    return msg; //到时候根据msg 是否为空提交给后台

};
var validateInputWhenChange = function(inputEl){
	if(!inputEl)return;
	var msg = '';
	var inputEl = inputEl;
	var val = inputEl.val().trim();
	switch(inputEl[0].name){
		case 'qq':
		if(!/^\d{6,13}$/.test(val)) msg = tipsMapping['qqFormatError'];
		break;
		case 'mobile':
		if(!/^1\d{10}$/.test(val)) msg = tipsMapping['mobileFormatError'];
		break;
		case 'cargoWeight':
		case 'cargoCube':
		case 'cargoNums':
		 if(!/^\d+(\.\d+)?$/.test(val)) msg = tipsMapping['cargoCubeFormatError'];
		break;

	}
	return msg;
};

!function($) {
    "use strict"; // jshint ;_;
    var Typeaheads  = function(element, options) {
        this.$element = $(element);
        this.options = $.extend({}, $.fn.typeaheads.defaults, options);
        this.focusShow = this.options.focusShow || false;
        this.matcher = this.options.matcher || this.matcher;
        this.sorter = this.options.sorter || this.sorter;
        this.highlighter = this.options.highlighter || this.highlighter;
        this.updater = this.options.updater || this.updater;
        this.source = this.options.source;
        this.$menu = $(this.options.menu);
        this.shown = false;
        this.listen();
    };
    Typeaheads.prototype = {
        constructor: Typeaheads,
        select: function() {
            var val = this.$menu.find('.active').data('value');
            var lab = this.$menu.find('.active').data('label');
            this.$element.val(this.updater(lab)).change();
            $('#' + this.input_id).val(val);
            return this.hide();
        },
        updater: function(item) {
            return item;
        },
        show: function(result) {
            var pos = $.extend({}, this.$element.position(), {
                height: this.$element[0].offsetHeight,
                addLeft:parseInt(this.$element.css('marginLeft').replace('px',''))
                
            });
            this.$menu.insertAfter('input[name="startPort"]').css({top: pos.top + pos.height, left: pos.left + pos.addLeft}).show();
            this.shown = true;
            if (this.options.width) {
                this.$menu.css({width: this.options.width + 'px'});
            } else {
                result.isLongResult ? this.$menu.css({width: this.$element.width() + result.countExceed}):this.$menu.css({width: this.$element.width()});

            }

            /*     this._element_width = this.$element.width();
             this._menu_width = this.$menu.width();
             if (this._element_width > this._menu_width) {
             this.$menu.css({width: this._element_width + 'px'});
             }*/
            return this;
        },
        hide: function(blurTrigger) {

            var val = this.$menu.find('.active').data('value');
            var lab = this.$menu.find('.active').data('label');
            if (this.$element.val() === '') {
                val = '';
                lab = '';
            }
            if(!blurTrigger){ this.$element.val(lab);} //能让用户输入
            $('#' + this.input_id).val(val);
            this.$menu.hide();
            this.shown = false;
            return this;
        },
        lookup: function(event) {
            var items;
            this.query = this.$element.val();
            if ((!this.query && !this.focusShow) || this.query.length < this.options.minLength) {
                return this.shown ? this.hide() : this;
            }
            items = $.isFunction(this.source) ? this.source(this.query, $.proxy(this.process, this)) : this.source;
            return items ? this.process(items) : this;
        },
        process: function(items) {
            var that = this;
            var result = null;
            items = $.grep(items, function(item) {
                if (typeof (item) !== 'object') {
                    item = {label: item, value: item};
                }

                item.value = item.value || item;
                item.label = item.label || item.value;

                return that.matcher(item.label, item.title);
            });
            items = this.sorter(items);

            if (!items.length) {
                items = [{value: this.options.noneValue || '', label: this.options.noneLabel}];
            }
            this.items = items.length;
            result = this.checkLongResult(items.slice(0, this.options.items));
            return this.render(items.slice(0, this.options.items)).show(result);
        },
        matcher: function(item, ititle) {
            var result = false;
            var item = item.toLowerCase().replace(/\s+/g,'');
            var query = this.query.toLowerCase().replace(/\s+/g,'');
            var ititle = ititle.toLowerCase().replace(/\s+/g,'');

            var index = ~item.indexOf(query);
            if (!index && ititle && ~ititle.indexOf(query)) {
                index =  ~ititle.indexOf(query);
            }
            result = (index <= -1 ? true : false);
            return result;
        },
        sorter: function(items) {
            if (this.query === '') {
                return items;
            }
            var that = this;
            return items.sort(function(a, b) {
                return a.label.toLowerCase().indexOf(that.query.toLowerCase())
                    - b.label.toLowerCase().indexOf(that.query.toLowerCase());
            });
        },
        highlighter: function(item) {
            return '<span>'+ item + '</span>';
        },
        render: function(items) {

            var that = this;
            items = $(items).map(function(i, item) {  //TODO jquery的高级属性
                i = $(that.options.item);
                for (var b in item) {
                    i.attr('data-' + b, item[b]);
                }
                i.html(that.highlighter(item.label) + '<b>' + (item.title || '') + ' </b>');
                return i[0];
            });

            //items.first().addClass('active');
            this.$menu.html(items);
            return this;
        },
        checkLongResult :function(items){
            var  result = {
                isLongResult:false,
                countExceed:0
            };
            var  diff = 0;
            if(!items || items[0].label == this.options.noneLabel)return false;//有可能是nonelabel的值
            for(var i in items){
                diff = items[i].label.length + items[i].title.length -10;
                if(diff > 0){
                    result.isLongResult = true;
                    result.countExceed = result.countExceed <= diff ? diff : result.countExceed ;
                }
            }
            result.countExceed = result.countExceed *8;
            return result;
        },
        next: function(event) {
            var active = this.$menu.find('.active').removeClass('active'), next = active.next();
            if (!next.length) {
                next = $(this.$menu.find('li')[0]);
            }
            next.addClass('active');
        },
        prev: function(event) {
            var active = this.$menu.find('.active').removeClass('active'), prev = active.prev();
            if (!prev.length) {
                prev = this.$menu.find('li').last();
            }
            prev.addClass('active');
        },
        element_click: function() {
            if (this.$element.val() === this.options.noneLabel) {
                this.$element.val('');
            }
        },
        listen: function() {
            this.$element
                .on('focus', $.proxy(this.focus, this))
                .on('blur', $.proxy(this.blur, this))
                .on('keypress', $.proxy(this.keypress, this))
                .on('keyup', $.proxy(this.keyup, this))
                .on('click', $.proxy(this.element_click, this));
            if (this.eventSupported('keydown')) {
                this.$element.on('keydown', $.proxy(this.keydown, this));
            }
            this.$menu
                .on('click', $.proxy(this.click, this))
                .on('mouseenter', 'li', $.proxy(this.mouseenter, this))
                .on('mouseleave', 'li', $.proxy(this.mouseleave, this))
        },
        eventSupported: function(eventName) {
            var isSupported = eventName in this.$element;
            if (!isSupported) {
                this.$element.setAttribute(eventName, 'return;');
                isSupported = typeof this.$element[eventName] === 'function';
            }
            return isSupported;
        },
        move: function(e) {
            if (!this.shown) {
                return;
            }
            switch (e.keyCode) {
                case 9: // tab
                case 13: // enter
                case 27: // escape
                    e.preventDefault();
                    break
                case 38: // up arrow
                    e.preventDefault();
                    this.prev();
                    break
                case 40: // down arrow
                    e.preventDefault();
                    this.next();
                    break
            }
            e.stopPropagation();
        },
        keydown: function(e) {
            this.suppressKeyPressRepeat = ~$.inArray(e.keyCode, [40, 38, 9, 13, 27]);
            this.move(e);
        },
        keypress: function(e) {
            if (this.suppressKeyPressRepeat) {
                return;
            }
            this.move(e);
        },
        keyup: function(e) {
            switch (e.keyCode) {
                case 40: // down arrow
                case 38: // up arrow
                    var val = this.$menu.find('.active').data('value');
                    var lab = this.$menu.find('.active').data('label');
                    this.$element.val(this.updater(lab)).change();
                    $('#' + this.input_id).val(val);
                    break;
                case 16: // shift
                case 17: // ctrl
                case 18: // alt
                    break
                case 9: // tab
                    if (this.$menu.find('li').index('.active') > 0) {
                        return;
                    }
                case 13: // enter
                    if (!this.shown) {
                        return;
                    }
                    this.select();
                    break;
                case 27: // escape
                    if (!this.shown) {
                        return;
                    }
                    this.hide();
                    break;
                default:
                    this.shown = true;
                    this.lookup();
            }
            e.stopPropagation();
            e.preventDefault();
        },
        focus: function(e) {
            this.shown = true;
            this.lookup();
            this.focused = true;
        },
        blur: function() {
            this.focused = false;
            if (!this.mousedover && this.shown) {
                this.hide(true);
            }
        },
        click: function(e) {
            e.stopPropagation();
            e.preventDefault();
            this.$element.next().remove();
            this.select();
// this.$element.focus();
        },
        mouseenter: function(e) {
            this.mousedover = true;
            this.$menu.find('.active').removeClass('active');
            $(e.currentTarget).addClass('active');
        },
        mouseleave: function(e) {
            this.mousedover = false;
            if (!this.focused && this.shown) {
                this.hide();
            }
        }
    };
    /* TYPEAHEAD PLUGIN DEFINITION
     * =========================== */
    var old = $.fn.typeaheads;
    $.fn.typeaheads = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data('typeaheads'), options = typeof (option) === 'object' && option;
            if (!data) {
                $this.data('typeaheads', (data = new Typeaheads(this, options)));
            }
            if (typeof (option) === 'string') {
                data[option]();
            }
        });
    };
    $.fn.typeaheads.defaults = {
        noneLabel: '没有找到对应的港口',
        source: [],
        items: 8,
        menu: '<ul class="typeaheads ui-port-list" style="font-size:12px;position:absolute;margin-top:2px;"></ul>',
        item: '<li></li>',
        minLength: 0,
        focusShow: true
    };
    $.fn.typeaheads.Constructor = Typeaheads;
    /* TYPEAHEAD NO CONFLICT
     * =================== */
    $.fn.typeaheads.noConflict = function() {
        $.fn.typeaheads = old;
        return this;
    };
    /* TYPEAHEAD DATA-API
     * ================== */
    $(document).on('focus.typeaheads.data-api', '[data-provide="typeaheads"]', function(e) {
        var $this = $(this);
        if ($this.data('typeaheads')) {
            return;
        }
        $this.typeaheads($this.data());
    });
}(window.jQuery);

var MessageBox = function(options){
    var defaults = {
            width: 700,
           height: 220,
            modal: true,
             hide: false,
          buttons:[],
        draggable:true, //暂时不实现
         appendTo:"body",
         position:'center',//top
            title:null,
        // callbacks
             open:null,
             close:null,
           beforeClose:null,
              dragStart:null,
              dragStop:null,
                open:null
    }
    this.options = $.extend({},defaults,options);
    this.options['$content'] = $(this.options.content);
    this.buttons = this.options.buttons;
    this.title = this.options.title;
    this.init();


}
MessageBox.prototype = {
    init:function(){
       var ele = this.options.appendTo;
       var msgTpl = [
           '<div class="popup-area" style="position:absolute;";>',
              '<div class="popup-bg" style="width:100%;height:100%"></div>',
              '<div class="ui-msg-widget">',
                 '<div>',
                    '<div class="delete"><span>X</span></div>',
                    '<div class="title"></div>',
                '</div>',
                '<div class="ui-msg-content">',
                 /*'<ul class="">',
                     '<li><b class="box"></b><span>你的咨询问题已经提交</span></li>',
                     '<li><b class="box"></b><span>你的咨询问题已经提交</span></li>',
                 '</ul>',*/
				 
                '</div>',
                '<div class="function-area btn-area">',
                 /* '<a href="javascript:void(0)" class="active">发布货盘</a>',
                  '<a href="javasript:void(0)">咨询管理</a>',
                  '<a href="javascript:void(0)">返回</a>',*/
                '</div>',
             '</div>',
           '</div>'
       ].join('');
        this.$msg = $(msgTpl);
        this.setMsgBoxStyle(this.$msg);
        this.$msg.find('.title').html(this.options.title);
        this.$msg.find('.ui-msg-content').append(this.options.$content);
        this.bindBtn();
        this.$msg.appendTo(ele);// 放置到body后面



    },
    bindBtn:function(){
        var me= this;
        var buttons = this.buttons;
        if(buttons.length === 0){
        	me.$msg.find('.btn-area').remove();
        }
        var $msg = me.$msg;
        var butType =Object.prototype.toString.call(buttons);
        var $closeIcon = $msg.find('.delete');
        //绑定底部的click
        if(buttons.length !==0 && butType === '[object Array]'){
            var $btnArea = $msg.find('.btn-area');
            $.each(buttons,function(index,btn){
                var text = btn['text'];
                var btnClass = btn['cls'];
                var handler = btn['handler'];
                var html = '<a href="javascript:void(0)" class="'+btnClass+'">'+text+'</a>';
                $btnArea.append(html);
                $btnArea.find('.'+btnClass).click(function(){
                    handler.call(me);
                })
            });
        }
        //绑定顶部的事件
        $closeIcon.on('click', $.proxy(me.close,me));

    },
    setMsgBoxStyle:function($msg){
        var evt = this.options.evt;

        $msg.css({
            top:0,
            width:"100%",
            height:$('body').height()

        });
        var $widget = $msg.find('.ui-msg-widget');
        $widget.css({
            zIndex:3000,
            background:'#ffe',
            position:'fixed',
            width:this.options.width,
            height:this.options.height,
            left:($(window).width() - this.options.width) /2,
            top:($(window).height() - this.options.height)/2

        })
        this.$msg = $msg;

    },
    show:function(){
       this.$msg.show();
    },
    /*initEvent:function(){

    },*/
    open:function(){

    },
    close:function(){
      this.$msg.hide();
    },
    alert:function(){

    },
    confirm:function(){

    },
    prompt:function(){

    },
    customisedDialog:function(){

    }
}
window['Msg'] =  MessageBox;


var getUrlParam = function(url){
	var urlParams = '';
	if(url){
		urlParams = url.split('?');
		if( urlParams.length >1){
           urlParams = '?'+ urlParams[1];
        } 
	}else{
		urlParams = location.search;
    }
    var result = {

    };
    if(!urlParams)return;
    if(urlParams.indexOf('redirect_uri')){ //标明了含有第三方登录的情况
       urlParams = urlParams.split('redirect_uri')[0];
    }
    urlParams = urlParams.replace(/\?/,'&').split('&');
    $.each(urlParams,function(ind,item){
         var item = item;
         if(item){
           item = item.split('='); 
           result[item[0]] = item[1];
         }
    })
    return result;

}

var checkInput = function($input){
    if(!$input)return;
    var msg = '';
    var fieldName = $input.prop('name');
    var inputVal  = $input.val();
    if(fieldName.toLowerCase().indexOf('email')!== -1){
        if(inputVal && !/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/g.test(inputVal)){
            msg = '邮箱格式错误'
        }
    }
    if(fieldName.toLowerCase().indexOf('phone') !==-1){
    	var phoneReg = /^(\d{3,4}\-)?\d{7,8}$/i; 
    	var flag = /\d{11}/.test(inputVal) || phoneReg.test(inputVal);
        if(inputVal && !flag){
            msg = '格式错误，手机号码必须为数字'
        }
       
    }
    return msg
}


var isEmptyInput = function(form){
	var msg = '';
	if(!form.bookingName.value.trim()){
		msg = '订舱人Name不能为空';
		return msg;
	}
	if(!form.bookingContact.value.trim()){
		msg = '订舱人Contact不能为空';
		return msg;
	}
	if(!form.bookingEmail.value.trim()){
		msg = '订舱人Email不能为空';
		return msg;
	}else{
		msg = checkInput($(form.bookingEmail));
		if(msg)return msg;
	}
	if(!form.bookingPhone.value.trim()){
		msg = '订舱人TEl不能为空';
		return msg;
	}else{
		msg = checkInput($(form.bookingPhone));
		if(msg)return msg;
	}
	if(!form.etd.value.trim()){
		msg = '开船时间不能为空';
		return msg;
	}
	if(!form.placeReceipt.value.trim()){
		msg = '装货地不能为空';
		return msg;
	}
    if(!form.placeDelivery.value.trim()){
		msg = '目的地不能为空';
		return msg;
	}
	if(!form.gp20Num.value.trim()&&!form.gp40Num.value.trim()&&!form.hq40Num.value.trim()){
		msg = '集装箱包装件数不能为空';
		return msg;
	}else{
		if(form.gp20Num.value.trim()&&!(form.gp20Quantity.value.trim())){
			msg = '20GP集装箱数量不能为空';
			return msg;
		}
		if(form.gp40Num.value.trim()&&!(form.gp40Quantity.value.trim())){
			msg = '40GP集装箱数量不能为空';
			return msg;
		}
		if(form.hq40Num.value.trim()&&!(form.hq40Quantity.value.trim())){
			msg = '40HP集装箱数量不能为空';
			return msg;
		}
		
	}
	if(!form.commodity.value.trim()){
		msg = '货品描述不能为空';
		return msg;
	}
	return msg ;
	
	
}

 //加载完后判断是否显示用户
 
 	var queryParams = getUrlParam(); 
	var isTrue = queryParams && queryParams['verify'];
	if(!isTrue ||  (isTrue && isTrue==='false')){

	   $(".gp20Vip,.gp40Vip,.hq40Vip").html("优惠价");

	}else{
		$(".gp20Vip,.gp40Vip,.hq40Vip").each(function(){
			var el =$(this);
			if(!el.html().trim().substring(1)){
				el.html("优惠价")			
			}		
		})		
	}
	$(".gp20,.gp40,.hq40").each(function(){
		var el =$(this);
		if(!el.html().trim().substring(1)){
			el.html("--")			
		}		
	})		
 
 
 
var $shipStartDate = $('input[name="etd"]');
$shipStartDate.datepicker();
$shipStartDate.change(function(evt){
  var $date = $(this);
   if($date &&  !$date.val()){
     alert('开船日期不能为空');
   }
})
var checkNumsOfBoxType = function($input){
    if(!$input)return;
    var msg = '';
    var num = '';
    var boxType = $input.parents('tr').data('name');
    var boxNum = $input.prop('name');
    if( boxNum!== 'gp20Num' && boxNum!== 'gp40Num' && boxNum!== 'hq40Num'){
        num = $input.parents('tr').find('input[name="'+boxType+'Num"]').val();
    }
    if(!num){
       msg = boxType + '件数不能为空'
    }
    return msg;
}
$('input[name="gp20Num"],input[name="gp40Num"],input[name="hq40Num"]').focus(function(evt){
}).blur(function(evt){
     if( $(this).val() && !/\d+/g.test($(this).val())){
          alert('格式错误，请输入数字');
          $(this).val('');
     }
});
$('input[name="gp20Quantity"],input[name="gp40Quantity"],input[name="hq40Quantity"]').focus(function(evt){
    var msg =  checkNumsOfBoxType($(this));
    if(msg){
        alert(msg);
        return;
    }

}).blur(function(){

});
$('input[name="gp20Volume"],input[name="gp40Volume"],input[name="hq40Volume"]').focus(function(evt){
    var msg =  checkNumsOfBoxType($(this));
    if(msg){
        alert(msg);
        return;
    }
}).blur(function(evt){
    if( $(this).val() && !/\d+/g.test($(this).val())){
        alert('格式错误，请输入数字');
        $(this).val('');
    }
});
$('input[name="gp20Weight"],input[name="gp40Weight"],input[name="hq40Weight"]').focus(function(evt){
    var msg =  checkNumsOfBoxType($(this));
    if(msg){
        alert(msg);
        return;
    }
}).blur(function(){
    if( $(this).val() && !/\d+/g.test($(this).val())){
        alert('格式错误，请输入数字');
        $(this).val('');
    }
});
$('input[name="bookingEmail"],input[name="shipperEmail"],input[name="consigneeEmail"],input[name="notifyPartyEmail"],input[name="charge_email"]').focus(function(evt){
}).blur(function(evt){
    var msg = checkInput($(this))
    if(msg){
        alert(msg);
        return;
    }
});
$('input[name="bookingPhone"],input[name="shipperPhone"],input[name="consigneeEmail"],input[name="notifyPartyEmail"],input[name="charge_email"]').focus(function(evt){
}).blur(function(evt){
    var msg = checkInput($(this))
    if(msg){
        alert(msg);
        return;
    }
});


$('#booking_ensure').click(function(evt){
var $agreement = $('input[name="agree"]');
var quantity = 0;
var boxType = '';
var keyCollection = {};
    keyCollection['startPort'] = $('.start-port').html().trim();
    keyCollection['endPort'] =  $('.end-port').html().trim();
    keyCollection['expireDate'] =  $('.expire-date').html().replace(/\s+/gm,'');
    keyCollection['shipCompany'] = $('.shippingCmp').html().trim();
    quantity = $('#gp20Nums').val();
    quantity? boxType = quantity + '*20GP ' :'';
    quantity = $('#gp40Nums').val();
    quantity? boxType += quantity + '*40GP ' :'';
    quantity = $('#hq40Nums').val();
    quantity? boxType += quantity + '*40HQ' :'';
    keyCollection['boxType'] = boxType;
var content = '<ul class="booking_info">'+    
                 '<li><span>起始港</span><span class="key_val">'+keyCollection['startPort']+'</span></li>' +
                 '<li><span>目的港</span><span class="key_val">'+keyCollection['endPort']+'</span></li>'+
                 '<li><span>船公司</span><span class="key_val">'+keyCollection['shipCompany']+'</span></li>'+
                 '<li style="width:300px;margin-right:10px;"><span>箱型</span><span class="key_val">'+keyCollection['boxType']+'</span></li>'+
                 '<li style="width:250px;"><span>有效期</span><span class="key_val">'+keyCollection['expireDate']+'</span></li>'+
                '</ul' 
if($agreement.prop('checked')){
   var msg = isEmptyInput($('form[name="form_booking_online"]')[0]);
            if(msg){
              alert(msg);
              return;
            }
  new MessageBox({
     title:'确认订单',
     evt:evt,
     content:content,
     buttons:[{
        text:'确认',
        cls:'ensure',
        handler:function(){
            this.close();
            $('form[name="form_booking_online"]').submit();
        }
     },{
        text:'取消',
        cls:'ensure',
        handler:function(){
           this.close();
        }
     }] 
  });
}else{
  new MessageBox({
     title:'温馨提示',
     evt:evt,
     content:'<div class="dialog_bookingOnline">请接受找船网在线订舱协议!</div>',
    
  });
}
})
//------------------------------
$('#bookingOnline').click(function(evt){
var $bookingOnlineCtn = $('.booking-online-ctn');
var $registrantInfo = $('.registrant-inf');
var $shippingInfo = $('.shipping-inf');
if($bookingOnlineCtn.is(':hidden')){
	$registrantInfo.hide();
	$shippingInfo.css({height:'2650px'});
	$bookingOnlineCtn.show();
 }
$(this).parents('.list').find('li').removeClass('sel');
$(this).parents('li').addClass('sel');
})
$('#inquiryOnline').click(function(evt){
var $bookingOnlineCtn = $('.booking-online-ctn');
var $registrantInfo = $('.registrant-inf');
var $shippingInfo = $('.shipping-inf');
if($registrantInfo.is(':hidden')){
	$bookingOnlineCtn.hide();
	var $htmlVal =$('.tabs .active').find('a').html();
    if($htmlVal=="货盘描述"){
		$shippingInfo.css({height:'1570px'});
	}else{
		$shippingInfo.css({height:'2120px'});
	}
	$registrantInfo.show();
}
$(this).parents('.list').find('li').removeClass('sel');
$(this).parents('li').addClass('sel');
})
//计算运价

	
$("#gp20Nums,#gp40Nums,#hq40Nums").blur(function(){
	var Rep =/^\d+$/img;
	var neWRep =/^(-)?\d+$/img;
//20gp的价格
var $pricegp20 = $(".gp20").html()&&neWRep.test(parseInt($(".gp20").html().trim().substring(1)))?$(".gp20").html().trim().substring(1):'0';
var $pricegp20Vip =($(".gp20Vip").html())&&(parseInt($(".gp20Vip").html().trim().substring(1))!=NaN)?$(".gp20Vip").html().trim().substring(1):'0';
//40gp的价格
var $pricegp40 = $(".gp40").html()&&/^(-)?\d+$/img.test(parseInt($(".gp40").html().trim().substring(1)))?($(".gp40").html().trim().substring(1)):'0';
var $pricegp40Vip =$(".gp40Vip").html()&&parseInt($(".gp40Vip").html().trim().substring(1))!=NaN?$(".gp40Vip").html().trim().substring(1):'0'

//40hq的价格
var $pricehq40 = $(".hq40").html()&&/^(-)?\d+$/img.test(parseInt($(".hq40").html().trim().substring(1)))?($(".hq40").html().trim().substring(1)):'0';
var $pricehq40Vip =$(".hq40Vip").html()&&parseInt($(".hq40Vip").html().trim().substring(1))!=NaN?$(".hq40Vip").html().trim().substring(1):'0';	
//是否使用优惠价
var $price20gp =0;
var $price40gp=0;
var $price40hq = 0;
var $isNotVip =$('input[name="isVip"]').prop("checked");
if($isNotVip){
	$price20gp  =$pricegp20;
	$price40gp = $pricegp40;
	$price40hq =$pricehq40;
}else{
				// $(".gp20").html()   &&Rep.       test(parseInt($(".gp20").html().trim().substring(1)))?$(".gp20").html().trim().substring(1):'0';
	$price20gp = $(".gp20Vip").html()&& neWRep.test(parseInt($(".gp20Vip").html().trim().substring(1)))?$(".gp20Vip").html().trim().substring(1):$pricegp20;
	$price40gp = $(".gp40Vip").html()&& neWRep.test(parseInt($(".gp40Vip").html().trim().substring(1)))?$(".gp40Vip").html().trim().substring(1):$pricegp40;
	$price40hq = $(".hq40Vip").html()&& neWRep.test(parseInt($(".hq40Vip").html().trim().substring(1)))?$(".hq40Vip").html().trim().substring(1):$pricehq40;
}



var $gp20Quantity =$("#gp20Nums");
var $gp40Quantity =$("#gp40Nums");
var $hq40Quantity =$("#hq40Nums");
var ofMoney =$("#of_money");
var usdMoney =$("#money");
var total20gp =($("#gp20Nums").val())?(parseInt($price20gp)*parseInt($gp20Quantity.val().trim())):"0";
var total40gp =($("#gp40Nums").val())?(parseInt($price40gp)*parseInt($gp40Quantity.val().trim())):"0";
var total40hq =($("#hq40Nums").val())?(parseInt($price40hq)*parseInt($hq40Quantity.val().trim())):"0";
sumTotal =parseInt(total20gp)+parseInt(total40gp)+parseInt(total40hq);
ofMoney.val(sumTotal).css("color","red");
var $gp20NumsLocal =$("#gp20Nums").val()?$("#gp20Nums").val().trim():'0';
var $gp40NumsLocal =$("#gp40Nums").val()?$("#gp40Nums").val().trim():'0';
var $hq40NumsLocal =$("#hq40Nums").val()?$("#hq40Nums").val().trim():'0';


 $(".local_list").each(function(){
var $extraChargeVal =$(this).find('input[name="extraCharge"]').val().trim();
var	$tUnit = $(this).find('input[name="unit"]').val().trim();
var $20gp_local =$(this).find('input[name="gp20Num"]').val()?$(this).find('input[name="gp20Num"]').val().trim():'0';
var $40gp_local =$(this).find('input[name="gp40Num"]').val()?$(this).find('input[name="gp40Num"]').val().trim():'0';
var $40hq_local =$(this).find('input[name="hq40Num"]').val()?$(this).find('input[name="hq40Num"]').val().trim():'0';
var $piecePrice =$(this).find('input[name="piecePrice"]').val()?$(this).find('input[name="piecePrice"]').val().trim():'0';
var totalCharge =0;
if($tUnit==='箱'){
  totalCharge  =parseInt($20gp_local)*parseInt($gp20NumsLocal)+
      			parseInt($40gp_local)*parseInt($gp40NumsLocal)+
       			parseInt($40hq_local)*parseInt($hq40NumsLocal);
 }else if($tUnit==='票'){
 totalCharge = $piecePrice;
 
 	}
 
 

  $(".local_total").find('input[name="'+$extraChargeVal+'"]').val(totalCharge).css({'color':'red'})
})
//获取附加费的值
var CNYTotal =0;
 var USDTotal =0;
 var EURTotal =0;
 var HKDTotal =0;
$(".local_charge_unit").each(function(){
   if($(this).html().trim()==='CNY'){
		CNYTotal += parseInt($(this).parent().find('.total').val().trim())
	}else if($(this).html().trim()==='USD'){
		USDTotal += parseInt($(this).parent().find('.total').val().trim())
	}else if($(this).html().trim()==='EUR'){
		EURTotal += parseInt($(this).parent().find('.total').val().trim())
	}
	else if($(this).html().trim()==='HKD'){
		HKDTotal += parseInt($(this).parent().find('.total').val().trim())
	}
	
})	
	var CNYTotalshow=CNYTotal!=0?(CNYTotal+'CNY,'):'';
	var USDTotalshow=USDTotal!=0?(USDTotal+'USD,'):'';
	var EURTotalshow=EURTotal!=0?(EURTotal+'EUR,'):'';
	var HKDTotalshow=HKDTotal!=0?(HKDTotal+'HKD,'):'';

 var totalCharge =CNYTotalshow+USDTotalshow+EURTotalshow+HKDTotalshow;
 var AllToTalCharge =CNYTotalshow+(USDTotal+sumTotal)+'USD'+EURTotalshow+HKDTotalshow;
	$("#local_money").val(totalCharge).css({'color':'red'});
	usdMoney.html(AllToTalCharge);
	
	
})


//获取local费用
var locaLTotal  =$(".locaL-total").val()?$(".locaL-total").val().trim():'';
var EXg =/^[A-Za-z]+\-[A-Za-z]+\-\d+\-\d+\-\d+\-\d+\-[A-Za-z]+/img;
if($(".locaL-total").val()&&EXg.test($(".locaL-total").val().trim())){
  //  console.log('local-total------>', $(".locaL-total").val());
var Arr0 =locaLTotal.split(";")

if(Arr0.length>0){
 var Arr=[];
 var arrIndex=0;
 for(var i=0;i<Arr0.length;i++){
	 if(Arr0[i].length>2){
		 Arr[arrIndex]=Arr0[i];
		 arrIndex++;
	 }
 }
 $(".list-seven").css({'height':35*(Arr.length+1)+"px"});
 $("#shipping-inf").css({'height':35*Arr.length+2300+220+"px"});
	for(var i =0;i<Arr.length;i++){	
		var arrListMsg =Arr[i].split("-");
	 	 arrMsg =$.map(arrListMsg,function(item){
				if(item==="piece") return "票";
				if(item==="box") return "箱";
				if(item==="0") return "";
				return item 		 	
		}); 	
	   	var listMsg =[
				'<ul class="local_list">',
				'<li class="list_one">',
				   '<input type="text" name="extraCharge"  value="'+arrMsg[0]+'">',
				'</li>',
				 '<li class="list_two">',
					'<input type="text" name="unit" value="'+arrMsg[1]+'">',
				'</li>',
				 '<li class="list_three">',
					'<span style="margin-right:25px">',
						'<b >20GP</b>',
						'<input type="text" name="gp20Num" value="'+arrMsg[2]+'">',
					'</span>',
					'<span style="margin-right:25px">',
						'<b>40GP</b>',
						'<input type="text" name="gp40Num" value="'+arrMsg[3]+'">',
					'</span>',
					'<span>',
						 '<b>40HQ</b>',
						 '<input type="text" name="hq40Num" value="'+arrMsg[4]+'">',
					'</span>',
				'</li>',
				'<li class="list_four">',
					'<input type="text" name="piecePrice" value="'+arrMsg[5]+'">',	         
				'</li>',
				'<li class="list_five">',
					'<input type="text" name="currency" value="'+arrMsg[6]+'" >',
				'</li>',
				'</ul>' 							  		
			].join("");	
	var showLocalMsg =[
				'<li class="local_total_list">',
           				'<span class="title_name"  style="display:inline-block;*display:inline;*zoom:1;width:32px;text-align:center">',arrMsg[0],'</span>',
           				'<input type="text"  class="total" name="',arrMsg[0],'">',
           				'<span class="local_charge_unit">',arrMsg[6],'</span>',
           			'</li>' 	
	].join("");		
		$(".additional").append(listMsg);
		$(".local_total").append(showLocalMsg);
		$(".additional,.local_total_charge").find("input").prop("disabled",true)
	
		}	 
	}
}else{
	
	$(".additional").html(locaLTotal).parent().css({'height':'80px'});
	$(".local_total_charge").html(locaLTotal).css({'padding':'15px'})
	
}



//对是否用vip价格进行模型
$('input[name="isVip"]').change(function(){
	
	$("#gp20Nums").blur()
	})


//在线查询和在线qq js
//var options = {
	//	src:'http://wpa.b.qq.com/cgi/wpa.php?key=XzkzODE5MDYzNF8zNDc0NzBfNDAwODc1NTE1Nl8',
		//defer:'defer',
		//async:'async',
	//	onload:function(){
	//		console.log('onload execute')
	//	},
		//oncomplete:function(){
		//	console.log('oncomplete execute')
		//} 
//}
//var script = document.createElement('script');
//for(var key in options){
//	if(!script[key]) script[key] = options[key] 
//}
//$("#spec_area").append(script);

//$("iframe").eq(1).css({'position':'relative','left':'672px','top':'-642px'})
    

     location.hash = '';
   // 设置默认input值，gsp页面val不显示     
      /*setTimeout(function(){
			var locaHash = location.hash;
			var $htmlVal =$('.tabs .active').find('a').html();
			
               var listMarginL =$("body").width()-$(".shipping-inf").width();
               var listFirstWidth =$(".list-first").width();
                var listSecondWidth =$(".list-second").width();
                var listThirdWidth =$(".list-third").width();
                var totalWidth =listMarginL/2+listFirstWidth+listSecondWidth+listThirdWidth/2;
			
		 $("iframe").eq(1).css({'position':'relative','left':totalWidth+'px','top':'-642px'})
			// $('#common-input').find('input[name="userName"]').val("${userName}"); 
         $('#common-input').find('input[name="companyName"]').val("${companyName}"); 
         $('#common-input').find('input[name="mobile"]').val("${mobile}");
         $('#common-input').find('input[name="qq"]').val("${qq}");
         $('#common-input').find('input[name="remark"]').val("${orderDescript}");
      },500)*/
      var anchorHash = '';
      $('input[name="transType"]').change(function(){
         if($(this).val()==="Together"){
            $('#piece').show();
            $(".box-size").hide();
         }else{
            $('#piece').hide();
            $(".box-size").show();
         }
     });
      $('#cargo-tabs').click(function(evt){
          var cargoHash = location.hash;
          var tarEl = $(evt.target);
          var flag = tarEl[0].tagName === 'LI' || tarEl.parent()[0].tagName === 'LI';
          if(flag &&　tarEl.html().length>0){
              tarEl =  tarEl[0].tagName === 'LI'?tarEl:tarEl.parent();//保证指向li元素
              anchorHash  = tarEl.find('a').prop('href').match('#[a-z\-]+$')[0];
              if(cargoHash !== anchorHash){
                  tabStyle(tarEl);
                  location.href = tarEl.find('a').prop('href').split('#')[0]+anchorHash;//手动改变其值                     	
                  $(anchorHash).show();
                  $(anchorHash).siblings().hide();
              }
              
              
          }
          evt.stopPropagation();
          evt.preventDefault();
           var $htmlVal =$('.tabs .active').find('a').html();
            var listMarginL =$("body").width()-$(".shipping-inf").width();
           var listFirstWidth =$(".list-first").width();
            var listSecondWidth =$(".list-second").width();
            var listThirdWidth =$(".list-third").width();
            var totalWidth =listMarginL/2+listFirstWidth+listSecondWidth+listThirdWidth/2;
            if($htmlVal=="货盘描述"){
            	$(".shipping-inf").height(1570);
            	 $("iframe").eq(1).css({'position':'relative','left':totalWidth+'px','top':'-640px'})
            
            }else{
            	$(".shipping-inf").height(2120);
            	 $("iframe").eq(1).css({'position':'relative','left':totalWidth+'px','top':'-1210px'})
            }
      })
      var tabStyle = function($li){
          if(!$li)return;
          $li.siblings().filter('.active').removeClass('active');
          $li.addClass('active');
      }

var limitHeight = function(evt,n){
if(evt&&evt.html()){
		var evtHtml = evt.html();
		 
		evt.html( evtHtml.substring(0,n));
		
	}};
 $limitWeight= $(".limit-weight");
 $additionalInfo =$(".additional-info");
	limitHeight($limitWeight,50);
	limitHeight($additionalInfo,80);

     var showErrorMsg = function(inputEl){
         var msg = '';
         var msgHTML = '';
         if(inputEl.parents('.registrant-inf').length ===0 || inputEl.parents('.registrant-inf').is(':hidden'))return;
         if(inputEl.val().trim()) {
            msg = validateInputWhenChange(inputEl);
            if(msg) {
              msgHTML = '<span class="error-msg" style="color:red;font-size:12px;margin-left:15px;">'+msg+'</span>';
              $(msgHTML).insertAfter(inputEl);
            }   
        }else{
            if(inputEl.prop('name')==='qq')return;
            msgHTML = '<span class="error-msg"  style="color:red;font-size:12px;margin-left:15px;">输入框内容不能为空</span>';
            $(msgHTML).insertAfter(inputEl);
        }
            
     };
     var inputArr = $('.registrant-inf').find('input[type="text"]');
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
     $('#shipping-inf').find('input[name="endDate"]').datepicker({ //这儿在点时间组件时会触发blur事件
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
             width:450,height:230},'slow')

      }).blur(function(evt){
          
      });
       $('input[name="shipCompany"]').parent().find('.shipping-company-list').click(function(evt){
          //console.log('click');
          var $tar = $(evt.target);
          if($tar[0].tagName === 'LI'){
            $('input[name="shipCompany"]').val($tar.html().trim());
            $(this).css({display:"none"});
          }
       })
      $('textarea').focus(function(evt){
        var tarEl = $(evt.target)
        if(tarEl.val().trim() === '例如货盘信息，起始港 目的港等信息' || tarEl.val().trim() === '请控制在150字以内' ){
           tarEl.val('');
        }
     });
     
     
     
      var   queryParams = getUrlParam(); // 获取url参数的json形式
      var  $shareInput = $('#common-input').find('input');
          $.each($shareInput,function(index,input){
             $(input).val(queryParams[$(input).prop('name')]);
          });

          
          
     
     var setInputHiddenVal = function($form){
         var $form = $form;
         var $commonInputs = $('#common-input').find('input');
         var options = {};
         $form.find('input[name="infoId"]').val(getUrlParam().infoId);
         $.each($commonInputs,function(index,input){
             var name = $(input).prop('name');
              options[name] = $(input).val().trim();
             $form.find('input[name="'+name+'"]').val($(input).val().trim())
             
         })
         options['remark'] = $('textarea[name="remark"]').val().trim();
         options['infoId'] = getUrlParam().infoId;
         return options
     };
      $('a[name="inquiry"]').click(function(evt){
          var result = validateFormWhenSubmit($('#common-input'),'',false);
          if(result){
            window.alert(result);
            return;
          }
          var content = '<ul class="list">'+
                          '<li>'+
                             '<b class="box"></b>'+
                             '<span>点击<a href="javascript:void(0)">【确认】</a>将提交您的订舱咨询，并跳转至<a href="javascript:void(0)">【咨询管理】</a>可查看、管理您提交的相关内容；</span>'+
                         '</li>'+
                          '<li>'+
                             '<b class="box"></b>'+
                              '点击<a href="javascript:void(0)">【确认并发布货盘】</a>将提交您的订舱咨询，并跳转至<a href="javascript:void(0)">【发布货盘】</a>，让更多的物流商给您报价；'+
                          '</li>'+
                          '<li>'+
                              '<b class="box"></b><span>点击<a href="javascript:void(0)">【返回】</a>将放弃本次订舱咨询，返回当前页面</span>'+
                          '</li>'+
                        '</ul>';
          new MessageBox({ // InqueryPrice/saveinquery
              title:'',
              evt:evt,
              content:content,
              buttons:[
                  {
                      text:'确认',
                      cls:'active',
                      handler:function(){
                          this.close();
                          var options = setInputHiddenVal($('#cargo-descript'));
                          $.ajax({
                            url:'../InqueryPrice/saveinquery',
                            type:'get',
                            dataType:'text',
                            data:options,
                            success:function(rs){
                               if(rs && rs.length === 16){
                                location.href = "../list.gsp";
                              }
                            },
                            error:function(rs){
                              if(rs['responseText'].length === 16){
                                location.href = "../list.gsp";
                              }
                            }
                            
                          })
                        //   $('#cargo-descript').submit();
                      }
                  }, {
                      text:'确认并发布货盘',
                      cls:'green',
                      handler:function(){
                          this.close();
                          var options = setInputHiddenVal($('#cargo-descript'));
                          $.ajax({
                            url:'../InqueryPrice/saveinquery',
                            type:'get',
                            dataType:'text',
                            data:options,
                            success:function(rs){
                               if(rs && rs.length === 16){
                                //location.href = "../list.gsp";
                              }
                            },
                            error:function(rs){
                              if(rs['responseText'].length === 16){
                              //  location.href = "../list.gsp";
                              }
                            }
                            
                          });
                          $('a[href="#tab-create-cargo"]').click();
                      }
                  }, {
                      text:'返回',
                      cls:'back-home',
                      handler:function(){
                         this.close();
                      }
                  }
              ]
          })
      });
      $('a[name="cargo-create"]').click(function(evt){
          var result = validateFormWhenSubmit($('#common-input'),$('#create-cargo')[0],true);
          if(result){
            window.alert(result);
            return;
          }
          $("#create-cargo").find('input[name="infoId"]').val(getUrlParam().infoId);
           var content = '<ul class="list">'+
                          '<li>'+
                             '<b class="box"></b>'+
                             '<span>点击<a>【确认】</a>将提交您的订舱咨询，并跳转至<a>【咨询管理】</a>可查看、管理您提交的相关内容；</span>'+
                         '</li>'+
                          '<li>'+
                              '<b class="box"></b><span>点击 <a href="">【返回】</a>，将放弃本次订舱咨询，返回当前页面</span>'+
                          '</li>'+
                        '</ul>';
          new MessageBox({
              title:'',
              content:content,
              evt:evt,
              buttons:[
                  {
                      text:'确认',
                      cls:'active',
                      handler:function(){
                           this.close();
                          $('#tab-create-cargo').click();
                       //   setInputHiddenVal($('#create-cargo'));
                          $('#create-cargo').submit();

                      }
                  },{
                      text:'返回',
                      cls:'back-home',
                      handler:function(){
                          this.close();
                      }
                  }
              ]
          });
      })

