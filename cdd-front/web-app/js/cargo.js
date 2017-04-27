
/*
 运价查询  var data = { //这应该是个全局变量  //这儿值需要传到queryParams:function(){}
		startPortFilter : '', item_key item_value  {cn:'好样的',en:'abc' }
		destPortFilter : '',
		shipCompanyFilter : '',
		expireDateFilter : '',
		priceRangeFilter : '' 
	};
货盘查询  var data = {
	startPortFilter : '',
	destPortFilter : '',
		BoxType : '',
		CommodityType : '',
		outputDate : '' 
}	

*/
var DataFilterPlugin = function(options){
	var defaultSetting = { //作为运价查询和货盘塞选共享的的东西
		startPortFilter : '', //item_key item_value  {cn:'好样的',en:'abc' }
		destPortFilter : ''
	}
	this.options  = $.extend(defaultSetting,options);
	this.data = this.options.data;
	this.previousData = {};
	this.filterLabelEl = this.options.filterLabel || $('#filterLabel');
	this.listDataPosEl = this.options.listDataPos || $('#listDataPos');
	this.initEvent();
	this.filterConditionStore(this.data,true);// 从sessionStorage中读取值；
	

};

DataFilterPlugin.prototype = {
	  constructor : DataFilterPlugin,
	  initEvent : function(){
	  	  var me = this;
	  	  var labelEl = this.filterLabelEl;
          labelEl.bind('click',$.proxy(me.filterLabelClose,me));
          labelEl.bind('replaceExistFilter',function(evt,key,val){
          	  me.replaceExistLabel([key,val]);//jquery中的自定义函数传参数有点情况
          });
          labelEl.bind('createExsitFilter',function(evt,key,val){ //,val
          	 me.createFilterConditionLabel([key,val]);
          });
          me.listDataPosEl.bind('filterStoreChange',function(evt,target){
             me.updateListData(target);
          }); 
          labelEl.bind('deleteExsitFilter',function(evt,target){
          	 me.deleteFilterConditionLabel(target)
          });
	  },
	  getFilterData:function(){
           return this.data;
	  },
	  setFilterData:function(data){
          this.data = data;
	  },
	  filterConditionStore : function(filterConditionData,isInit){ //这儿是添加修改的逻辑，还没有删除的逻辑
	  	  var data = this.data;
	  	  var previousData = this.previousData; 
	  	  var filterLabelEl = this.filterLabelEl;
	  	  var listDataPosEl = this.listDataPosEl;
	  	  if(isInit){ // 首次有可能是sessionStorage出现的情况
	  	  	  filterLabelEl.trigger('createExsitFilter',[data]);
              listDataPosEl.trigger('filterStoreChange',data);
             return;
	  	  }
          for(var filterKey in filterConditionData){ //{cn:'好样的',en:'abc' }
		    if(data[filterKey] && data[filterKey]['en'] != filterConditionData[filterKey]['en']){ ///标明过滤条件已经成在
		      previousData[filterKey] = data[filterKey]; 
              data[filterKey]  = filterConditionData[filterKey]; // 触发筛选框数据变化
              filterLabelEl.trigger('replaceExistFilter',[filterKey,data[filterKey]]);
              listDataPosEl.trigger('filterStoreChange',data); 
            } else if( !data[filterKey]) { // && data[filterKey] != filterConditionData[filterKey]
              data[filterKey]  = filterConditionData[filterKey];
              filterLabelEl.trigger('createExsitFilter',[filterKey,data[filterKey]]);
              listDataPosEl.trigger('filterStoreChange',data);  
            }
	      }
	      this.data = data;
	      this.previous = previousData;
	      return this;
	  },
	  replaceExistLabel:function(data){ //[filterKey,data[filterKey]]
           var filterLabelEl = this.filterLabelEl;
           var labelDataEl = filterLabelEl.find('.selected_item_list');
           labelDataEl.each(function(key,item){
               if($(item).data('command') === data[0]){
               	  $(item).find('b').data('name',data[1]['en']);
               	  $(item).find('b').html(data[1]['cn']);
               }
           });
	  },
	  deleteDataFromStore:function(filterConditionData,targetEl){
		  
	  	 var data = this.data;
	  	 var previousData = this.previousData; 
	  	 var filterLabelEl = this.filterLabelEl;
	  	 var listDataPosEl = this.listDataPosEl;
         if(!filterConditionData)return;
         for(var filterKey in filterConditionData){
        	 if(filterKey === 'outputDate'){
        		 $('#output_date').val('');
        	 }
         	 previousData[filterKey] = data[filterKey];
             data[filterKey] = '';
             filterLabelEl.trigger('deleteExsitFilter',targetEl);
             listDataPosEl.trigger('filterStoreChange',data);  
         }	
         this.data = data;
	     this.previous = previousData;
	     return this;

	  },
	/* boxType: ""
        commodityType: ""
        destPortFilter: ""
         outputDate: ""
          startPortFilter: */
	  createFilterConditionLabel:function(data){
	  	 var map = {
             boxType:'运输类型',
             commodityType: '货物类型',
              destPortFilter: '目的港',
              startPortFilter: '起始港',
              outputDate:'预计出货日'
	  	 };
	  	 var filterLabelEl = this.filterLabelEl;
	  	 var htmlFragment = '';
	  	 var data = data ;
	  	if(data[1]){ //用户选择过滤
             htmlFragment = [
	  	      '<div class="selected_item_list" data-command="'+data[0]+'">',
	  	         '<span>',
	  	             map[data[0]]+"&nbsp;:",
	  	          '</span>',
	  	         '<b data-command="'+data[1]['en']+'">',
	  	            data[1]['cn'],
	  	         '</b>',
	  	         '<s>X</s>',
	  	      '</div>'
	     	].join('');

	  	} else if(!data[1]){ //初始化时显示的过滤效果
	  		data = data[0];
	  		for(var filterKey in data){
	  			if(data[filterKey]){ //有些是空值，必须去掉
	  				htmlFragment += [
	  	             '<div class="selected_item_list" data-command="'+filterKey+'">',
	  	                '<span>',
	  	               map[filterKey],
	  	              '</span>',
	  	               '<b data-name="'+ data[filterKey]['en']+'">',
	  	                 data[filterKey]['cn'],
	  	               '</b>',
	  	               '<s>X</s>',
	  	             '</div>'
	     	      ].join('');
	  			}	
	  		}
            
	  	}
	  	
        filterLabelEl.append(htmlFragment);
	  },
	  /*showFilterCondition:function(){

	  },*/
	  deleteFilterConditionLabel:function(target){
	  	if(!target)return;
	  	var target = $(target);
            target.remove();
	  },
      updateListData:function(data){
      	if(!data)return;
      	var ctn =  this.listDataPosEl;
      //	queryParams = data;// 使用bootstrap-table中的queryParams 函数中的变量
      	if(sessionStorage){
      		sessionStorage.setItem('queryParams',JSON.stringify(data));
      	}
      	$('.datatable-search-btn').click();//模拟bootstrap-table 查询按钮被点击事件
      	
          
      },
     
      filterLabelClose:function(evt){
		 var tarEl = $(evt.target);
    	 if(tarEl[0].tagName.toLowerCase()!=='s')return;
      	 var filterConditionData = {};
      	 var targetEl = $(evt.target).parent('.selected_item_list');//通过父元素获取b元素所有信息
      	 var labelEl = targetEl.find('b');
      	 var filterConditionKey = targetEl.data('command');//统一在selected_item_list b中加data-command = 'startPortFilter';
         var filterConditionVal = {en: labelEl.data('name'), cn:labelEl.html()};
         filterConditionData[filterConditionKey] = filterConditionVal;
         this.deleteDataFromStore(filterConditionData,targetEl);

      }

};
// 修改一下common.js中搜索框的源码

!function($) {
    "use strict"; // jshint ;_;
    var Td = function(element, options) {
        this.$element = $(element);
        this.options = $.extend({}, $.fn.td.defaults, options);
        this.$targetCtn = $(this.options.targetCtn);
    	this.$letterFilter = this.options.letterFilter;
        this.focusShow = this.options.focusShow || false;
        this.matcher = this.options.matcher || this.matcher;
        this.sorter = this.options.sorter || this.sorter;
        this.highlighter = this.options.highlighter || this.highlighter;
        this.updater = this.options.updater || this.updater;
        this.source = this.options.source;
        this.shown = false;
        this.listen();

    };
    Td.prototype = {
        constructor: Td,
        updater: function(item) {
            return item;
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
                    item = {cn: item, en: item};
                }

                item.cn = item['endPortCn'] || item;
                item.en = item['endPort'] || temp['endPortCn'];

                return that.matcher(item.en, item.cn);
            });
            items = this.sorter(items);

            if (!items.length) {
                items = [{en: this.options.noneValue || this.options.noneLabel, cn: this.options.noneLabel}];
            }
            this.items = items.length;
            return this.render(items.slice(0,this.items)); 
        },
        matcher: function(en,cn) { //item, ititle
            var result = false;
            var en = en.toLowerCase().replace(/\s+/g,'');
            var query = this.query.toLowerCase().replace(/\s+/g,'');
            var cn = cn.toLowerCase().replace(/\s+/g,'');

            var index = ~en.indexOf(query);
            if (!index && cn && ~cn.indexOf(query)) {
                index =  ~cn.indexOf(query);
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
                return a['en'].toLowerCase().indexOf(that.query.toLowerCase())
                    - b['en'].toLowerCase().indexOf(that.query.toLowerCase());
            });
        },
        highlighter: function(item) {
            return item;
        },
        render: function(items) { //{cn : '' , en: ''}  //把这儿的逻辑换成在左侧显示
           var htmlFragment = '';
          if(!items)return;
          $(items).map(function(i, item){
              htmlFragment += '<li title="'+item["cn"]+'"  data-name="'+item["en"]+'">'+item["en"]+'</li>';
          });
         
	      this.$targetCtn.html(htmlFragment);     
            return this;
        },
      
        letterFilterClick:function(evt){
        	var targetEl = $(evt.target);
        	var letter = targetEl.html();
        	if(letter && letter.length > 1)return;
        	this.$element.val(letter);
        	this.lookup(evt);


        },

        listen: function() {
        	this.$letterFilter.on('click',$.proxy(this.letterFilterClick,this))
            this.$element
                .on('focus', $.proxy(this.focus, this))
                .on('blur', $.proxy(this.blur, this))
                .on('keypress', $.proxy(this.keypress, this))
                .on('keyup', $.proxy(this.keyup, this))
                .on('click', $.proxy(this.element_click, this));
            if (this.eventSupported('keydown')) {
                this.$element.on('keydown', $.proxy(this.keydown, this));
            }
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
                   // var val = this.$menu.find('.active').data('value');
                    var lab = this.$menu.find('.active').data('en');
                    this.$element.val(this.updater(lab)).change();
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
                   // this.select();
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
            }
        },
        click: function(e) {
            e.stopPropagation();
            e.preventDefault();
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
    /* Td PLUGIN DEFINITION
     * =========================== */
    var old = $.fn.td;
    $.fn.td = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data('td'), options = typeof (option) === 'object' && option;
            if (!data) {
                $this.data('td', (data = new Td(this, options)));
            }
            if (typeof (option) === 'string') {
                data[option]();
            }
        });
    };
    $.fn.td.defaults = {
        noneLabel: '没有找到对应的目的港',
        source: [],
        items: 10,
        minLength: 0,
        focusShow: true
    };
    $.fn.td.Constructor = Td;
    /* td NO CONFLICT
     * =================== */
    $.fn.td.noConflict = function() {
        $.fn.td = old;
        return this;
    };
    /* td DATA-API
     * ================== */
    $(document).on('focus.typeahead.data-api', '[data-provide="typeahead"]', function(e) {
        var $this = $(this);
        if ($this.data('typeahead')) {
            return;
        }
        $this.td($this.data());
    });
}(window.jQuery);

var getUrlParam = function(){
    var urlParams = location.search;
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

var cargoCountEl = $('#cargo_count'); 
var startPortListEl = $('#start_port_list');
var startPortEl = startPortListEl.find('.port_select_list');//起始港占位区
var startPortMoreEl = $('#start_port_more');
var endPortListEl = $('#end_port_list');
var endPortEl = endPortListEl.find('.port_select_list');
var destPortMoreEl = $('#dest_port_more');

var endPortListDetailsEl = $('#end_port_list_details');
var endPortDetailEl = endPortListDetailsEl.find('.list');
var endPortDetailsMoreEl = $('#end_port_details_more');
//var letterSelectedEl = $('#end_port_list_details').find('.cate');

var destPortSearchBoxEl = $('#dest_port_search_box');
var callapseExpandAreaEl = $('#callapse_expand_area');
var filterCallapseEl = $('#filter_callapse');

var boxTypeEl = $('#box_type');
var commodityTypeEl = $('#commodity_type');
var outputDate = $('#output_date');


var cargoListCtn = $('#cargo_list_ctn');

var destPortData = window['destPortData'] ? window['destPortData'] : null ;
var isLoadeddestPortDetail = false;
var queryParams =  {} ;// 給bootstrap-table中的queryParams函數使用

var DFP = new DataFilterPlugin({
   data:{
      startPortFilter : queryParams['startPortFilter'] || '',//{en:'',cn:''}
      destPortFilter : queryParams['destPortFilter'] || '',
      boxType : queryParams['boxType'] || '',
      commodityType : queryParams['commodityType'] || '',
      outputDate : queryParams['outputDate'] || '' 
   },
   filterLabel:$('#selected_item'),
   listDataPos:$('#cargo_list_ctn')
 }); 
  DFP.setFilterData(queryParams);
  var urlParams = getUrlParam();
  if(!urlParams){
	   urlParams = {}; 
	   urlParams['startPort']='';
	   urlParams['endPort']='';
	   urlParams['transType']='';

  }
    //getSeletedItem
var getSeletedItem = function(selectType,evt){   //filterConditionStore : function(filterConditionData)
    var seletedItemEl = null ;
    var seletedVal = '';//{} 也是true
    var filterConditionData = {};
    if(evt && typeof evt != 'string' && $(evt.target)[0].tagName != 'UL' ){
         seletedItemEl = $(evt.target);
         urlParams['startPort'] = '';
		  urlParams['endPort'] = '';
		  urlParams['transType'] = '';
         if(selectType === 'destPort'){ //起始港和目的港显示格式不一样
             seletedVal = {cn:seletedItemEl.data('name'),en:seletedItemEl.html()};
         }else if(seletedItemEl.data('name')){
             seletedVal = {en:seletedItemEl.data('name'),cn:seletedItemEl.html()};
         }
         
         
    } else if(evt && typeof evt == 'string'){
   	
         seletedVal = {en: evt, cn: evt}
   	 
    }
    if(!seletedVal)return;
    switch(selectType){
       case 'startPort': 
          filterConditionData['startPortFilter'] = seletedVal;
          break;
       case 'destPort':
          filterConditionData['destPortFilter'] = seletedVal;
          break;
       case 'boxType':
          filterConditionData['boxType'] = seletedVal;
          break;
       case 'commodityType':
          filterConditionData['commodityType'] = seletedVal;
          break;
       case 'outputDate':
          filterConditionData['outputDate'] = seletedVal;
          break;
      // default; 
    };
    DFP.filterConditionStore(filterConditionData);
 };

var getPortHTML = function(options){
   var options = options;
   var portHtml = '';
   var miniDestPort = [];
   var cn = '';
   var en = ''; 
   if(options.destPort && options.data){
      destPortData = window['destPortData'] = options.data;       
     /*  miniDestPort = destPortData.slice(0,10); */  //先存储目的港的数据，首次只展示10条数据
     miniDestPort = [
         {endPortCn:'巴生港' ,endPort:'PORT KELANG'},  
         {endPortCn:'蒙巴萨' ,endPort:'MOMBASA'},    
         {endPortCn:'德班' ,endPort:'DURBAN'},  
         {endPortCn:'廷坎' ,endPort:'TINCAN'},  
         {endPortCn:'卡萨布兰卡' ,endPort:'CASABLANCA'},  
         {endPortCn:'卡拉奇' ,endPort:'KARACHI'},  
         {endPortCn:'迪拜' ,endPort:'DUBAI'},  
         {endPortCn:'安特卫普' ,endPort:'ANTWERP'},    
         {endPortCn:'桑托斯' ,endPort:'SANTOS'}, 
         {endPortCn:'瓜亚基尔' ,endPort:'GUAYAQUIL'}, 
         {endPortCn:'纽约' ,endPort:'NEW YORK'},  
         {endPortCn:'长滩' ,endPort:'LONG BEACH'}
     ]

     $.each(miniDestPort,function(key,item){
           cn = item["endPortCn"];
           en = item["endPort"];
           portHtml += '<li title="'+cn+'"data-name="'+cn+'">'+en+'</li>'; 
       })
   } 
   else if (!options.destPort){
       $.each(options.data,function(key,item){
           cn = item["startPortCn"];
           en = item["startPort"];
           portHtml += '<li title="'+en+'"data-name="'+en+'">'+cn+'</li>';                                        //'<li data-name='+item["startPort"]+'>'+item["startPortCn"]+'</li>'; 
       })
   }      
   return portHtml; 
};
endPortDetailEl.click(function(evt){

    getSeletedItem('destPort',evt);
});
startPortEl.click(function(evt){

    getSeletedItem('startPort',evt);
}).mousedown(function(evt){
	 mouseDownChange(evt)
}).mouseup(function(evt){
	 mouseUpChange(evt)
});
endPortEl.click(function(evt){
    getSeletedItem('destPort',evt);
}).mousedown(function(evt){
	 mouseDownChange(evt)
}).mouseup(function(evt){
	 mouseUpChange(evt)
});
boxTypeEl.click(function(evt){
   getSeletedItem('boxType',evt);
}).mousedown(function(evt){
	 mouseDownChange(evt)
}).mouseup(function(evt){
	 mouseUpChange(evt)
});
commodityTypeEl.click(function(evt){
   getSeletedItem('commodityType',evt);
}).mousedown(function(evt){
	 mouseDownChange(evt)
}).mouseup(function(evt){
	 mouseUpChange(evt)
});
var mouseDownChange =function(evt){
		var targetEl = $(evt.target);
		 if(targetEl.html() != '' ){
		 targetEl.css({'fontWeight':700})
   } 
};
var mouseUpChange = function(evt){
		var targetEl = $(evt.target);
		if(targetEl.html() != '' ){
		 targetEl.css({'fontWeight':'normal'})
   } 

}
startPortMoreEl.click(function(evt){
    var butVal = '';
        startPortListEl.toggleClass('more_condition_filter');
        startPortEl.parent('.port_select').toggleClass('more_condition_filter');
        butVal = $(this).html();
        butVal = butVal === '更多'? '收起' : '更多' ;
        $(this).html(butVal);

});
destPortMoreEl.click(function(evt){
     endPortListEl.css({display:"none"});
     endPortListDetailsEl.css({display:"block"});
     if(!isLoadeddestPortDetail){ //首次为none时 不能使用sessionStorage,刷新问题
         var endPortDetailHtml = '';
         $.each(destPortData,function(key,item){
              endPortDetailHtml += '<li title="'+item["endPortCn"]+'"  data-name='+item["endPortCn"]+'>'+item["endPort"]+'</li>'; 
         })
         endPortDetailEl.html(endPortDetailHtml);
         isLoadeddestPortDetail = true;
     }
});
endPortDetailsMoreEl.click(function(evt){
     endPortListEl.css({display:"block"});
     endPortListDetailsEl.css({display:"none"});
});

/*letterSelectedEl.click(function(evt){

});*/
outputDate.datepicker({
   yearRange:'2015:+10',
   onSelect:function(dataText,inst){
       getSeletedItem('outputDate',dataText);
   }
});



filterCallapseEl.click(function(evt){
   var  collapseEl = callapseExpandAreaEl;
   var collapseStr = $(this).html();
   if(collapseStr === '更多选项（运输种类，货物类型等）'){
      collapseEl.slideDown('slow');
      $(this).html('收起');
	    $(this).css('outline','none');
     
   }else if(collapseStr === '收起'){
      collapseEl.slideUp('slow');
      $(this).html('更多选项（运输种类，货物类型等）');
   }
});

 //数据填充区
 $.ajax({
        url  : "/order/list",
        type :  "post",
        cache: true,
     dataType: "json",
      success: function(rs){
           var html = '';
           if(rs.map.status === 1){
              cargoCountEl.html(rs.total);  
              html = getPortHTML({
                  data : rs.map.result.endPort,
                  destPort : true
              });
              endPortEl.html(html);
              startPortEl.html(getPortHTML({data:rs.map.result.startPort}))  
              
           };
           bindEndPortSearch();
     },
     error:function(rs){
     }
  })

// 底部显示数据列表
cargoListCtn.bootstrapTable({
    url : "/order/list",
    sidePagination : 'server',
    pageSize: 15,
    showColumns:false,
    showRefresh:false,
    showToggle:false,
    cache:true,
    search:true,
    toggle:false,
    columns :[{
        field : 'startPort',
        title : '起始港',
		 width : 250,
        sortable : true,
        formatter : function (value, row, index) {
            var startPort = row.startPort ? row.startPort : row.startPortCn;
            var startPortCn = row.startPortCn ? row.startPortCn : '';
           return ['<span title="'+startPortCn+'" style=\"color:#0000FF; width:250px\">'+startPort+'</span>'];
        }
    },{
       field : 'endPort',
       title : '目的港',
		width : 250,
       sortable : true,
       formatter : function (value, row, index) {
          var endPort = row.endPort ? row.endPort : row.startPortCn;
          var endPortCn = row.endPortCn ? row.endPortCn : '';
            return ['<span title="'+endPortCn+'" style=\"color:#0000FF; width:250px\">'+endPort+'</span>'];
       }
    },{
        field : 'orderType',
        title : '货物类型',
		 width : 150
    },{
        field : 'cargoBoxType',
        title : '箱型',
		 width : 150,
        sortable : false
    },{
       field : 'cargoBoxNums',
       title : '箱个数',
		width : 150,
       sortable : false
    },{
       field : 'endDate',
       title : '预出货时间',
		width : 150,
       sortable :true
    },{
      field : 'biteEndDate',
      title : '报价截至时间',
	   width : 150,
      sortable : true
    },{
        field : 'transType',
        title : '运输种类' ,  
		 width : 150
    },{
        field : 'orderId',
        title : '',
        width : 150,
        formatter : function (value, row, index) {
            var orderId = row.orderId ? row.orderId : '';
            var startPort = row.startPort ? row.startPort : '';
            var endPort = row.endPort ? row.endPort : '';
            var startPortCn = row.startPortCn ? row.startPortCn : '';
            var endPortCn = row.endPortCn ? row.endPortCn : '';
            return [
                '<p class="sp_w60"><a href="/publish/findcargo?orderId='+orderId+'&startPort='+startPort+'&endPort='+endPort+'&startPortCn='+startPortCn+'&endPortCn='+endPortCn+'" class="supply_button" target="_blank">我要报价</a></p>'
           ].join('');
        }
    }],
    queryParams : function(params){

     /*  setTimeout(function(){  // 到时该下bootstrap-table中的源码
            var marginLf = $("#cargo_list_ctn").css("margin-left");
               $(".pagination-info").css("margin-left",marginLf);
              $(".page-last").css("margin-right",marginLf);
       },100);*/

       var q = DFP.getFilterData();
       var params = params;
       params['startPort'] = q['startPortFilter']?q['startPortFilter']['en'] : urlParams['startPort']? urlParams['startPort'] : '';
       params['endPort'] = q['destPortFilter'] ?q['destPortFilter']['en']: urlParams['endPort']? decodeURI(urlParams['endPort']):'';
       params['transType'] = q['boxType'] ? q['boxType']['en']: urlParams['transType'] ? urlParams['transType'] :'';
       params['orderType'] = q['commodityType']?q['commodityType']['en']:'';
       params['endDate'] = q['outputDate']?q['outputDate']['en'] :'';
       return params
    }
});
var bindEndPortSearch = function(){
  var letterFilter = $('#end_port_list_details').find('.cate');
  var destPortSearchBoxEl = $('#dest_port_search_box');
  var endPortArea = $('#end_port_list_details').find('.list');
  destPortSearchBoxEl.td({
         source : window['destPortData'] || [], 
         targetCtn: endPortArea,
         letterFilter : letterFilter
  })

};

$(".fixed-table-container").css("border","none");
$("#cargo_list_ctn").css("text-align","center");
$(".th-inner").css("text-align","center");

$('.datatable-search-btn').parent('.pull-left').css({visibility:"hidden"}); // 必须有查询按钮，不然参数传不过去




