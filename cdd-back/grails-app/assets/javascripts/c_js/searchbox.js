

var SearchComponent = function (element,options){
     if(!element)return;
     this.el = $(element);
     this.dataSource = options.dataSource || [];
     this.options = options;
     this.initEvent();
     return this;
};    

var dtd = $.Deferred();
SearchComponent.prototype  = {
    Constructor : SearchComponent,
    initEvent:function(){
         var me = this;
         me.start_port_el = $('#start_port_input');
         me.end_port_el = $('#dest_port_input');
		 me.s_company_el = $('#s_company_input');
         /*me.tabParentEl =  $('.ui-tab-type');
         me.tabParentEl.click(function(e){
             var targetEl = $(e.target);
             me.toggleTab(targetEl);
        });*/
        /*$('#port_search_btn').click(function(){
			var type=$(this).attr('data-type');
            me.sendPortQuery(type);
        });*/
        me.bindingDataSource();
        return me;
    },
    bindingDataSource:function(){
        var me = this;
        var start_port_el = this.start_port_el;
        var end_port_el = this.end_port_el;
		var s_company_el = this.s_company_el;
		console.log(me.dataSource.start_port_list)
        start_port_el.typeahead({
            source: me.dataSource.start_port_list　|| [],
			always: me.dataSource.start_port_list_always || [],
            items: me.options.items || 8
        })
        end_port_el.typeahead({
           source: me.dataSource.end_port_list || [],
		   always: me.dataSource.end_port_list_always || [],
            items: me.options.items || 8
        })
		s_company_el.typeahead({
           source: me.dataSource.s_company_list || [],
		   always: me.dataSource.s_company_list_always || [],
            items: me.options.items || 8
        })
        return me;
    },
    sendPortQuery:function(type){
        var start_port_val = this.start_port_el.val();
        var dest_port_val = this.end_port_el.val();
		var s_company_val = this.s_company_el.val();
        //var category = this.tabParentEl.find('.ui-tab-whole').data('category');
        var isRequire = !start_port_val && !dest_port_val && !s_company_val || start_port_val == '没有找到对应的港口' || dest_port_val == '没有找到对应的港口' || s_company_val == '没有找到对应的公司';
        /*if(!userName){
        	location.href= host+'/login';
        	return ;
        }*/
        if(!isRequire){
        	/*if($('.datatable-search-btn').length === 0){
        		location.href = host + '/ships/ship.html?transType='+category+'&startPort='+start_port_val+'&endPort='+dest_port_val;
        	}else{
                location.href = location.pathname+'?transType='+category+'&startPort='+start_port_val+'&endPort='+dest_port_val;
            }*/
			if(type=='index'){
				console.log('首页运价搜索');
				var indexSearchData={startPort:start_port_val,endPort:dest_port_val}
				sessionStorage.setItem("indexToShippingSearchData", JSON.stringify(indexSearchData));
				window.location="shipping.html";
				//var value = json.parse(sessionStorage.getItem("key"));
				//sessionStorage.removeItem("key");
			}
			if(type=='shipping'){
				console.log('运价信息页运价搜索');
				var mydate = new Date();
				var firstTime = mydate.getTime()
				//getShippingData(1,1,1,10,null)
				$.when(InfoRelevantTime(dtd)).done(function(){
						var lastTime = new Date().getTime()
						var consuming = (lastTime - firstTime)/1000
						var resultCount = $("#totalCount").val()
						$.post("/ship/saveInfoConsuming",{startPort:start_port_val,endPort:dest_port_val,shipCompany:s_company_val,resultCount:resultCount,consuming:consuming},function(data){
					})
				})
				//getShippingData(1,1,1,10);//获取运价信息数据，在shipping.js中定义
			}
			if(type=='pallet'){
				console.log('货盘信息页搜索');
				getPalletData(1,1,1,10);//获取运价信息数据，在在pallet.js中定义
			}
        }else{
			if(type=='shipping'){
				getShippingData(1,1,1,10);//获取运价信息数据，在shipping.js中定义
			}
			if(type=='pallet'){
				console.log('货盘信息页搜索');
				getPalletData(1,1,1,10);//获取运价信息数据，在pallet.js中定义
			}
		}
        return this;

    }/*,
    toggleTab:function(selectedTab){
        if(!selectedTab || selectedTab && selectedTab.hasClass('.ui-tab-whole')) return;
        var tabParentEl = this.tabParentEl;
        tabParentEl.find('span').removeClass();
        selectedTab.addClass('ui-tab-whole');
        selectedTab.siblings().addClass('ui-tab-together');
    }*/
}
$.fn.searchComp = function(options){
     if(typeof options === 'object')
    	 new SearchComponent(this,options);
    return this;
};
$.fn.searchComp.Constructor = SearchComponent;

!function($) {
    "use strict"; // jshint ;_;
    var Typeahead = function(element, options) {
    	console.log(element)
        this.$element = $(element);
        this.options = $.extend({}, $.fn.typeahead.defaults, options);
        this.focusShow = this.options.focusShow || false;
        this.matcher = this.options.matcher || this.matcher;
        this.sorter = this.options.sorter || this.sorter;
        this.highlighter = this.options.highlighter || this.highlighter;
        this.updater = this.options.updater || this.updater;
        this.source = this.options.source;
		this.always = this.options.always;
        this.$menu = $(this.options.menu);
        this.shown = false;
        this.listen();

    };
    Typeahead.prototype = {
        constructor: Typeahead,
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
                height: this.$element[0].offsetHeight
            });
            this.$menu.insertAfter('#port_search_btn').css({top: pos.top + pos.height +15, left: pos.left}).show();
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
			if(this.query==""&&this.always.length!=0){
				items = this.always;
			}else{
				items = $.grep(items, function(item) {
					if (typeof (item) !== 'object') {
						item = {label: item, value: item};
					}
	
					item.value = item.value || item;
					item.label = item.label || item.value;
	
					return that.matcher(item.label, item.title);
				});
				items = this.sorter(items);
			}

            if (!items.length) {
                items = [{value: this.options.noneValue || '', label: this.options.noneLabel}];
            }
            this.items = items.length;
             result = this.checkLongResult(items.slice(0, this.options.items));
            return this.render(items.slice(0, this.options.items)).show(result);
        },
        matcher: function(item, ititle) {
            /*var result = false;
            var item = item.toLowerCase().replace(/\s+/g,'');
            var query = this.query.toLowerCase().replace(/\s+/g,'');
            var ititle = ititle.toLowerCase().replace(/\s+/g,'');

            var index = ~item.indexOf(query);
            if (!index && ititle && ~ititle.indexOf(query)) {
                index =  ~ititle.indexOf(query);
            }
            result = (index <= -1 ? true : false);*/
        	var result = false;
        	var patt1 = new RegExp(this.query,"gi");
        	result = patt1.test(item)||patt1.test(ititle);
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
			var showItem=item;
			if(this.query){
				var qry=this.query;
				var reg=new RegExp(qry,'i');
				var toStr='<strong style="color:#f00;">'+qry.toUpperCase()+'</strong>';
				showItem=item.replace(reg,toStr)
			}
            return '<span>'+ showItem + '</span>';
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

			items.first().addClass('active');
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
            	diff = items[i].label.length + items[i].title.length -21;
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
    
    var old = $.fn.typeahead;
    $.fn.typeahead = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data('typeahead'), options = typeof (option) === 'object' && option;
            if (!data) {
                $this.data('typeahead', (data = new Typeahead(this, options)));
            }
            if (typeof (option) === 'string') {
                data[option]();
            }
        });
    };
    $.fn.typeahead.defaults = {
        noneLabel: '没有找到对应的港口',
        source: [],
        items: 8,
        menu: '<ul class="typeahead ui-port-list" style="font-size:12px;position:absolute;margin-top:2px;"></ul>',
        item: '<li></li>',
        minLength: 0,
        focusShow: true
    };
    $.fn.typeahead.Constructor = Typeahead;
    /* TYPEAHEAD NO CONFLICT
     * =================== */
    $.fn.typeahead.noConflict = function() {
        $.fn.typeahead = old;
        return this;
    };
    /* TYPEAHEAD DATA-API
     * ================== */
    $(document).on('focus.typeahead.data-api', '[data-provide="typeahead"]', function(e) {
        var $this = $(this);
        if ($this.data('typeahead')) {
            return;
        }
		console.log('$this.data()',$this.data());
        $this.typeahead($this.data());
    });
}(window.jQuery);
function InfoRelevantTime(dtd){
	getShippingData(1,1,1,10,dtd);
	return dtd
}