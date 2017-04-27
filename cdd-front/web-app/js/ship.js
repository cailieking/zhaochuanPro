
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
    /*
         DFP.filterConditionStore({
             priceRange:{
                cargoBoxType:cargoBoxInput,
                priceStart:filterData['startPrice']['cn'],
                priceEnd:filterData['endPrice']['cn']
              }
        });
    */
	  filterConditionStore : function(filterConditionData){ //这儿是添加修改的逻辑，还没有删除的逻辑
	  	  var data = this.data;
	  	  var previousData = this.previousData; 
	  	  var filterLabelEl = this.filterLabelEl;
	  	  var listDataPosEl = this.listDataPosEl;
	  	  /*if(isInit){ // 首次有可能是sessionStorage出现的情况
	  	  	  filterLabelEl.trigger('createExsitFilter',[data]);
              listDataPosEl.trigger('filterStoreChange',data);
             return;
	  	  }*/
        if(filterConditionData['priceRange']){
          filterLabelEl.trigger('createExsitFilter',['priceRange',filterConditionData['priceRange']]);
          return  // 对价格塞选做图书处理
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
        	 if(filterKey === 'expireDate'){
        		 $('#expireDate').val('');
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
          /*
             DFP.filterConditionStore({
             priceRange:{
                cargoBoxType:cargoBoxInput,
                priceStart:filterData['startPrice']['cn'],
                priceEnd:filterData['endPrice']['cn']
              }
        });
            
          */
	  createFilterConditionLabel:function(data){
	  	 var map = {
             shipCompany:'船公司',
             commodityType: '货物类型',
              destPortFilter: '目的港',
              startPortFilter: '起始港',
              expireDate: '有效期',
              priceRange: '价格'
	  	 };
	  	 var filterLabelEl = this.filterLabelEl;
	  	 var htmlFragment = '';
	  	 var data = data ;
       if(data[0] === 'priceRange' && data[1]){
          htmlFragment = [
            '<div class="selected_item_list" data-command="'+data[0]+'">',
               '<span>',
                   map[data[0]]+'&nbsp;:&nbsp;&nbsp;',
                '</span>',
               '<b>',
                  data[1]['cargoBoxType']+'&nbsp;&nbsp;&nbsp;',
               '</b>',
               '<span>',
                 data[1]['priceStart']+'&nbsp;&nbsp;&nbsp;',
               '</span>',
                '<span>',
                 data[1]['priceEnd'],
               '</span>',  
               '<s>X</s>',
            '</div>'
         ].join('');
          var filterEl = filterLabelEl.find('.selected_item_list');
          $.each(filterEl,function(index,item){
             if($(item).data('command') === 'priceRange')$(item).remove();
          })
          
          filterLabelEl.append(htmlFragment);

         return ;
       }
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

	  	} /*else if(!data[1]){ //初始化时显示的过滤效果
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
            
	  	}*/
	  	
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
         if(filterConditionKey === 'priceRange'){
           $('#cargoBoxType').find("option[value='']").attr("selected",true);
           $('#startPrice').val('');
           $('#endPrice').val('');
           $('.price-input-tips').html('');
           this.data['cargoBoxType'] = '';
           this.data['startPrice'] = '';
           this.data['endPrice'] = '';



         }
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

var princeCountEl = $('#prince_count');
var startPortListEl = $('#start_port_list');
var startPortEl = startPortListEl.find('.port_select_list');//起始港占位区
var startPortMoreEl = $('#start_port_more');
var endPortListEl = $('#end_port_list');
var endPortEl = endPortListEl.find('.port_select_list');
var destPortMoreEl = $('#dest_port_more');

var endPortListDetailsEl = $('#end_port_list_details');
var endPortDetailEl = endPortListDetailsEl.find('.list');
var endPortDetailsMoreEl = $('#end_port_details_more');
var shipCompanyMoreEl = $('#ship-company-list-more');
//var letterSelectedEl = $('#end_port_list_details').find('.cate');

var destPortSearchBoxEl = $('#dest_port_search_box');
var callapseExpandAreaEl= $('#callapse_expand_area');
var filterCallapseEl = $('#filter_callapse');

//var boxTypeEl = $('#company_type');
var shipCompanyListEl = $('#shipCompanyList');
var expireDate = $('#expireDate');

var cargoBoxType = $('#cargoBoxType');
var startPrice = $('#startPrice');
var endPrice = $('#endPrice');
var btnPriceEnsure = $('#btn-price-ensure');

var cargoListCtn = $('#cargo_list_ctn');

var destPortData = window['destPortData'] ? window['destPortData'] : null ;
var isLoadeddestPortDetail = false;
var queryParams =  {};
/* var queryParams =  {} ;// 給bootstrap-table中的queryParams函數使用
if(sessionStorage && sessionStorage.getItem('queryParams')){
   queryParams = sessionStorage.getItem('queryParams');
   queryParams = JSON.parse(queryParams);
};*/

var DFP = new DataFilterPlugin({
   data:{
      startPortFilter : queryParams['startPortFilter'] || '',//{en:'',cn:''}
      destPortFilter : queryParams['destPortFilter'] || '',
      cargoBoxType : queryParams['cargoBoxType'] || '',
      startPrice :  queryParams['startPrice'] || '',
      endPrice : queryParams['endPrice'] || '',
      shipCompany : queryParams['shipCompany'] || '',
      expireDate : queryParams['expireDate'] || '' 
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
      /* case 'shipCompany':
          filterConditionData['shipCompany'] = seletedVal;
          break;*/
       case 'shipCompany':
          filterConditionData['shipCompany'] = seletedVal;
          break;
       case 'expireDate':
          filterConditionData['expireDate'] = seletedVal;
          break;
      // default; 
    };
    DFP.filterConditionStore(filterConditionData);
 };
var getShipCompanyHtml = function(){
    var shipCompany = '';
    var data = [
{shipCompanyCn:'中远',shipCompany:'COSCO'},
{shipCompanyCn:'现代商船',shipCompany:'HMM'},
{shipCompanyCn:'高丽海运',shipCompany:'KMTC'},
{shipCompanyCn:'马士基',shipCompany:'MSK'},
{shipCompanyCn:'MCC运输',shipCompany:'MCC'},
{shipCompanyCn:'地中海航运',shipCompany:'MSC'},
{shipCompanyCn:'宏海箱运',shipCompany:'RCL'},
{shipCompanyCn:'阿拉伯轮船',shipCompany:'UASC'},
{shipCompanyCn:'以星',shipCompany:'ZIM'},
{shipCompanyCn:'澳航',shipCompany:'ANL'},
{shipCompanyCn:'法国达飞',shipCompany:'CMA'},
{shipCompanyCn:'达贸',shipCompany:'DELMAS'},
{shipCompanyCn:'长荣',shipCompany:'EMC'},
{shipCompanyCn:'赫伯罗特',shipCompany:'HPL'},
{shipCompanyCn:'日本邮船',shipCompany:'NYK'},
{shipCompanyCn:'浦海',shipCompany:'PHL'},
{shipCompanyCn:'南非航运',shipCompany:'SAF'},
{shipCompanyCn:'山东海丰',shipCompany:'SITC'},
{shipCompanyCn:'万海',shipCompany:'WHL'},
{shipCompanyCn:'美国总统',shipCompany:'APL'},
{shipCompanyCn:'韩进海运',shipCompany:'HANJIN'},
{shipCompanyCn:'川崎汽船',shipCompany:'K-LINE'},
{shipCompanyCn:'太平船务',shipCompany:'PIL'},
{shipCompanyCn:'德翔航运',shipCompany:'TSL'},
{shipCompanyCn:'阳明海运',shipCompany:'YML'},
{shipCompanyCn:'中海',shipCompany:'CSCL'},
{shipCompanyCn:'阿联酋航运',shipCompany:'ESL'},
{shipCompanyCn:'兴亚海运',shipCompany:'HEUNG-A'},
{shipCompanyCn:'亚川船务',shipCompany:'IAL'},
{shipCompanyCn:'大阪三井',shipCompany:'MOL'},
{shipCompanyCn:'东方海外',shipCompany:'OOCL'},
{shipCompanyCn:'南星海运',shipCompany:'NAMSUNG'},
{shipCompanyCn:'中外运',shipCompany:'SINOTRANS'},
{shipCompanyCn:'玛丽亚那',shipCompany:'MARIANA'},
{shipCompanyCn:'汉堡南美',shipCompany:'HAMBURG-SUD'}

    ];
    $.each(data,function(key,item){
         cn = item.shipCompanyCn;
         en = item.shipCompany;
         shipCompany += '<li title="'+cn+'"data-name="'+cn+'">'+en+'</li>'; 
    }); 
    return shipCompany;
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
   	  	cn = item.endPortCn;         
           en = item.endPort;
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
shipCompanyListEl.click(function(evt){
 getSeletedItem('shipCompany',evt);
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

};
shipCompanyMoreEl.click(function(){
 var btnVal = '';
 shipCompanyListEl.toggleClass('more_condition_filter');
 shipCompanyListEl.parent('.port_select').toggleClass('more_condition_filter');
 $('.shipping-company-area').toggleClass('more_condition_filter');
   butVal = $(this).html();
        butVal = butVal === '更多'? '收起' : '更多' ;
        $(this).html(butVal);
})


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
/*


*/
var filterData = DFP.getFilterData();
var cargoBoxInput = '';
var startPriceInput = '';
var endPriceInput = '';
var msg = '';
cargoBoxType.change(function(){
  btnPriceEnsure.next().html('');
  msg= '';
  var val = $(this).val();
  if(!val) { 
   btnPriceEnsure.next().html('请选择货柜类型'); 
   return;
  } 
  cargoBoxInput = val;
  filterData['cargoBoxType'] = {cn:cargoBoxInput, en:cargoBoxInput};
  DFP.setFilterData(filterData);
});
startPrice.change(function(){
   startPriceInput = startPrice.val(); 
   msg = showErrorMsg(startPriceInput);
   if(msg){
      btnPriceEnsure.next().html(msg); 
      startPriceInput = '';
      return;
   }
    filterData['startPrice'] = {cn:startPriceInput,en:startPriceInput};
    DFP.setFilterData(filterData);

}).focus(function(){
   msg= '';
   btnPriceEnsure.next().html(''); 
   $(this).val('');
}).blur(function(){
	 var val = $(this).val();
	 if(!val){
       filterData['startPrice'] = {cn:'',en:''};
       DFP.setFilterData(filterData);
	 }
});

endPrice.change(function(){
   endPriceInput = endPrice.val(); 
   msg = showErrorMsg(endPriceInput);
   if(msg){
      btnPriceEnsure.next().html(msg); 
      endPriceInput = '';
   }
   filterData['endPrice'] = {cn:endPriceInput,en:endPriceInput};
    DFP.setFilterData(filterData);

}).focus(function(){
    msg= '';
    btnPriceEnsure.next().html(''); 
    $(this).val('');
}).blur(function(){
	 var val = $(this).val();
	 if(!val){
       filterData['endPrice'] = {cn:'',en:''};
       DFP.setFilterData(filterData);
	 }
});

btnPriceEnsure.click(function(){
	if(!cargoBoxInput){
        cargoBoxType.change();
        return;
   }
   if(msg) return;
   if((!filterData['startPrice'] ||  !filterData['startPrice']['cn'])&& (!filterData['endPrice'] || !filterData['endPrice']['cn'])){
   	btnPriceEnsure.next().html('请输入价格区间');
   	return;
   }
   if( !filterData['cargoBoxType'] || !filterData['cargoBoxType']['cn']){
     btnPriceEnsure.next().html('请选择货柜类型');
     return 
   }
   DFP.filterConditionStore({
        priceRange:{
           cargoBoxType:filterData['cargoBoxType']?filterData['cargoBoxType']['cn'] :'',
           priceStart:filterData['startPrice']?filterData['startPrice']['cn'] :'',
           priceEnd:filterData['endPrice']?filterData['endPrice']['cn'] :''
         }
   });
   
   $('.datatable-search-btn').click();
  // DFP.filterConditionStore(filterConditionData);
});
var showErrorMsg = function(inputData){
   if(!inputData) {
     msg = '请输入价格';
     return msg;
   }  
   if(!(/^(-)?\d{1,4}$/.test(inputData))) {
      msg = '格式不正确,请核对后重新填写';
      return msg;
   }
   return '';
}


    /*filterData['cargoBoxType'] = {cn:cargoBoxInput, en:cargoBoxInput};
    filterData['endPrice'] = {cn:endPriceInput,en:endPriceInput};
    filterData['startPrice'] = {cn:startPriceInput,en:startPriceInput};
   DFP.setFilterData(filterData);*/
expireDate.datepicker({
   yearRange:'2015:+10',
   onSelect:function(dataText,inst){
       getSeletedItem('expireDate',dataText);
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
        url  : "/route/list",
        type :  "post",
        cache: true,
     dataType: "json",
      success: function(rs){
           var html = '';
           if(rs.status === 1){
              princeCountEl.html(rs.total);
              html = getPortHTML({
                  data : rs.result.endPort,
                  destPort : true
              });
              endPortEl.html(html);
              startPortEl.html(getPortHTML({data:rs.result.startPort}))  
              shipCompanyListEl.html(getShipCompanyHtml());
              
           };
           bindEndPortSearch();
     },
     error:function(rs){
     }
  })

// 底部显示数据列表
var verify = false;
cargoListCtn.bootstrapTable({
    url : "/ship/list",
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
		 width : 140,
        sortable : true,
        formatter : function (value, row, index) {
            var startPort = row.startPort ? row.startPort : row.startPortCn;
            var startPortCn = row.startPortCn ? row.startPortCn : '';
           return ['<span title="'+startPortCn+'" style=\"color:#0000FF; width:230px\">'+startPort+'</span>'];
        }
    },{
       field : 'endPort',
       title : '目的港',
		width : 150,
       sortable : true,
       formatter : function (value, row, index) {
          var endPort = row.endPort ? row.endPort : row.startPortCn;
          var endPortCn = row.endPortCn ? row.endPortCn : '';
            return ['<span title="'+endPortCn+'" style=\"color:#0000FF; width:250px\">'+endPort+'</span>'];
       }
    },{
        field : 'gp20',
        title : '20\'GP',
		 width : 100,
  formatter:function(value,row,index){
	  var value =  value == null || typeof value === 'undefined' ? '-': value  
  var gp20Vip = row.gp20Vip == null || typeof row.gp20Vip === 'undefined '? '优惠价':row.gp20Vip ;
      return ['<span style="display:inline-block;padding-bottom:5px; width:90px;">'+value+'</span><span  class="price-vip" style="display:inline-block;color:#ff540c;"><b class="price-box"></b>'+gp20Vip+'</span>'];

  },
        sortable : false
    },
    {
       field : 'gp40',
       title : '40\'GP',
		width : 100,
  formatter:function(value,row,index){
	   var value = value == null || typeof value === 'undefined' ? '-': value  
  var gp40Vip = row.gp40Vip == null || typeof row.gp40Vip === 'undefined '? '优惠价':row.gp40Vip ;
      return ['<span style="display:inline-block;padding-bottom:5px; width:90px;">'+value+'</span><span  class="price-vip" style="display:inline-block;color:#ff540c;">'+gp40Vip+'</span>'];

  },
       sortable : false
    },
    {
       field : 'hq40',
       title : '40\'HQ',
		width : 100,
  formatter:function(value,row,index){
  var value = value == null ||  typeof value === 'undefined' ? '-': value  
	   var hq40Vip = row.hq40Vip == null || typeof row.hq40Vip === 'undefined '? '优惠价':row.hq40Vip ; // 0 undefined num

      return ['<span style="display:inline-block;padding-bottom:5px; width:90px;">'+value+'</span><span class="price-vip" style="display:inline-block;color:#ff540c;">'+hq40Vip+'</span>'];

  },
       sortable :true
    },
    {
      field : 'shipCompany',
      title : '船公司',
	   width : 100,
      sortable : true
    },{
        field : 'shippingDays',
        title : '航程' ,  
		 width : 100
    },{
        field : 'shippingDay',
        title : '船期' ,  
		 width : 100,
		 formatter:function(value, row, index){
			 var val = value;
			 if(val && val.length>4){
				 val = val.substr(0,4)+'...';
			 }
			 return [
			         '<span style="white-space:nowrap;" title="'+value+'">', 
			          val,
			         '</span>'
			 ].join('');
		 }
    },{
        field : 'endDate',
        title : '截止日期' ,  
		 width : 150
    },
    {
        field : 'orderId',
        title : '',
        width : 150,
        formatter : function (value, row, index) {
            var infoId = row.infoId ? row.infoId : '';
            var startPort = row.startPort ? row.startPort : '';
            var endPort = row.endPort ? row.endPort : '';
            var startPortCn = row.startPortCn ? row.startPortCn : '';
            var endPortCn = row.endPortCn ? row.endPortCn : '';
            return [
                '<p class="sp_w60"><a href="/publish/findship?verify='+verify+'&infoId='+infoId+'&startPort='+startPort+'&endPort='+endPort+'&startPortCn='+startPortCn+'&endPortCn='+endPortCn+'" class="supply_button" target="_blank">在线订舱</a></p>'
           ].join('');
        }
    }],
	 responseHandler:function(res){
		var cargocount =window['cargocount'];
		if(!cargocount){
          window['cargocount'] = cargocount = res.total;			   
		}  
		princeCountEl.html(cargocount);
		 verify = res.verified
		return res;
		 
    },
    onAll:function(){
        if(!verify){
          $('.price-vip').hide();
        }
        return false;
    },
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
       params['cargoBoxType'] = q['cargoBoxType'] ? q['cargoBoxType']['en'] : '',
       params['startPrice'] = q['startPrice']? q['startPrice']['en'] : '',
       params['endPrice'] = q['endPrice'] ? q['endPrice']['en'] : '',
       params['shipCompany'] = q['shipCompany']?q['shipCompany']['cn']:'';
       params['endDate'] = q['expireDate']?q['expireDate']['en'] :'';
		params['transType'] = urlParams['transType'] || '';
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

$('.datatable-search-btn').parent('.pull-left').css({visibility:"hidden"}); 



