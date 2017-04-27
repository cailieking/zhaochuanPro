String.prototype.trim = function(){
    return this.replace(/^\s+|\s+$/g,'');
};
var ExtraCharge = function(options){
    var defaults = {

    };
    this.options = $.extend({},defaults,options);
    this.$ctn = this.options.$ctn;//引用此组件的容器
    this.initData = this.options.initData;
    this.data = [];//{key:'ACF',value:'ACF_BOX_12_0_0_0_CNY'}
    this.len = this.options.len || 1; // 数据记录的标志
    this.init();

};
ExtraCharge.prototype = {
  init:function(){
     var tpl = this.getTpl(this.initData,true);
     this.$ctn.append(tpl);
     this.initEvent();
  },
  initEvent:function(){
      this.show();
      var _this = this;
      var $ctn = this.$ctn;
      var data = [];// [{name:'ASK',index:'1'},{name:'GBK',index:'2'}]
      var $ul = $ctn.find('ul').last();
      var $extraChargeInput = $ul.find('select[name="extraCharge"]');
      var extraChargeVal = '';
      var obj = {};
      var  flag = false;
      var listInd = 0;
      $extraChargeInput.change(function(evt){
          obj = {};
          data = _this.data;
          flag = false;
          extraChargeVal = '';
          msg = '';
         extraChargeVal  =  $(this).val();
              listInd  = $(this).parents('.extra-charge-item').data('index');
         if(extraChargeVal === ''){
             msg = '请选择附加费名称';
             alert(msg);
         }else{
             for (var ind in  data) {
                 if (data[ind]['name'] === extraChargeVal) {
                     msg = '不能选择相同的附加费名称';
                     flag = true;
                     alert(msg);
                 }else if(data[ind]['name'] !== extraChargeVal && data[ind]['index'] === listInd ){
                     flag = true;
                     data[ind]['name'] = extraChargeVal;
                 }
             }
         }
         if(!flag){
             obj['name'] = extraChargeVal;
             obj['index'] = listInd;
             data.push(obj);
             _this.data = data;
         }

      });
      $ul.find('input[name="gp20Num"],input[name="gp40Num"],input[name="hq40Num"],input[name="piecePrice"]').blur(function(evt){
         msg =  _this.checkInputData($(evt.target));
         if(msg){
             alert(msg);
         }else if(!msg && !extraChargeVal){
             alert('请选择附加费类型');
         }
      });
      $ul.find('select[name="unit"]').change(function(evt){
          var unitVal = $(this).val();
          var $piecePrice = $ul.find('input[name="piecePrice"]');
          var $boxType = $ul.find('.box-type').find('input');
          if( unitVal === 'box'){
              $piecePrice.val('');
              $piecePrice.prop({disabled:true});
              $boxType.prop({disabled:false});
          }else if ( unitVal === 'piece'){
              $boxType.val('');
              $piecePrice.prop({disabled:false});
              $boxType.prop({disabled:true});
          }
      })
      $ul.parent('.extra-charge-item').next().on('click', $.proxy(_this.btnClick,_this));
  },
  getAllData:function(){
      var $ctn = this.$ctn;
      var dataTemp = {};
      var obj = {};
      var data = [];
      var $ul = $ctn.find('ul');
      $ul = $ul.filter(function(ind,item){ // 过滤掉所有没有选择附加费名称的选项,第一项是个标题ul,需要做过滤
          return $(item).find('select[name="extraCharge"]').length > 0 && $(item).find('select[name="extraCharge"]').val()!== '';
      });
      if($ul.length >0){
          $.each($ul,function(ind,ul){
              dataTemp = {};
              obj = {};
              dataTemp['extraCharge'] =  $(ul).find('select[name="extraCharge"]').val();
              dataTemp['unit'] = $(ul).find('select[name="unit"]').val();
              dataTemp['gp20Num'] = $(ul).find('input[name="gp20Num"]').val().trim()? $(ul).find('input[name="gp20Num"]').val().trim() :'0' ;
              dataTemp['gp40Num'] = $(ul).find('input[name="gp40Num"]').val().trim()? $(ul).find('input[name="gp40Num"]').val().trim() :'0' ;
              dataTemp['hq40Num'] = $(ul).find('input[name="hq40Num"]').val().trim()? $(ul).find('input[name="hq40Num"]').val().trim() :'0' ;
              dataTemp['piecePrice'] = $(ul).find('input[name="piecePrice"]').val().trim()? $(ul).find('input[name="piecePrice"]').val().trim() :'0' ;
              dataTemp['currency'] = $(ul).find('select[name="currency"]').val();
              dataTemp['together'] = dataTemp['extraCharge']+
                  '-'+dataTemp['unit']+
                  '-'+dataTemp['gp20Num']+
                  '-'+dataTemp['gp40Num']+
                  '-'+ dataTemp['hq40Num']+
                  '-'+dataTemp['piecePrice']+
                  '-'+dataTemp['currency'];
              obj['key'] = dataTemp['extraCharge'];
              obj['value'] = dataTemp['together'];
             // obj[dataTemp['extraCharge']] =  dataTemp['together'];
              data.push(obj);
          })
      }
      return data;
  },
  delete:function($button){ //[{name:'ASK',index:'1'},{name:'GBK',index:'2'}]9
      var key = '';
      var data = this.data;
      if(!$button)return;
      var len = this.len;
      this.len = len - 1;
      key = $button.siblings().find('select[name="extraCharge"]').val();
      if(key){
         data =  $.grep(data,function(item,ind){
               if(item['name'] === key){
                   return false;
               }
             return true;
          })
      }
      this.data = data;
      $button.parent().find('select').unbind();
      $button.parent().find('input').unbind();
      $button.unbind();
      $button.parent().remove();

  },
  append:function($button){
      var len = this.len;
      if(len >9){
          alert('附加费只能添加10个');
          return;
      }
      this.len = len+1;
      var tpl = this.getTpl();
      this.$ctn.append(tpl);
      this.initEvent();
  },
  btnClick:function(evt){
      var btnLabel = $(evt.target).data('name');
      if(btnLabel === 'add'){
         this.append($(evt.target));
      }
      else if(btnLabel === 'delete'){
         this.delete($(evt.target));
      }

  },
  show:function(){
    this.$ctn.find('.list-item').show();
  },
  checkInputData:function($input){
      var inputVal = $input.val().replace(/^\s+|\s+$ /g,'');
      var msg = '';
      var dataTemp = this.dataTemp;
      if($input.prop('name') === 'receiptPrice'){
           if(inputVal && !/^\d+\.?\d+$/g.test(inputVal)){
               msg = '请输入数字';
           }else if(inputVal){
              inputVal = parseInt(inputVal).toFixed(2);
              dataTemp['receiptPrice'] = inputVal;
           }
      }else{
          if( inputVal &&! /\d+/g.test(inputVal)){
              msg = '请输入数字';
          }
      }
      return msg;
  },
  getTpl:function(params,initLoading){ // 初始值传入实例化模板，拼接成html模板
      this.len = params ? params.length : this.len;
      var btnLabel = [];
          btnLabel = initLoading ? ['add','添加']:['delete','删除'];
      var extraChargeItems = [];
      var tplTile = [
            '<div class="list-item" style="display:none;">',
                '<div class="extra-charge-item">',
                   '<ul>',
                      '<li>名称</li>',
                      '<li>单位</li>',
                      '<li class="box-type">柜型</li>',
                      '<li>单票</li>',
                      '<li>币种</li>',
                   '</ul>',
                '</div>',
            '</div>',
      ];
      var tplContent = [
          '<div class="list-item" style="display:none;">',
             '<div class="extra-charge-item" data-index="'+this.len+'">',
               '<ul>',
                  '<li>',
                     '<select name="extraCharge">',
                         '<option value="">请选择</option>',
                         '<option value="ACF">ACF</option>',
                         '<option value="AMS">AMS</option>',
                         '<option value="DOC">DOC</option>',
                         '<option value="EIR">EIR</option>',
                         '<option value="ISPS">ISPS</option>',
                         '<option value="ORC">ORC</option>',
                         '<option value="PSD">PSD</option>',
                         '<option value="SEAL">SEAL</option>',
                         '<option value="TLX">TLX</option>',
                         '<option value="other">其他</option>',
                     '</select>',
                  '</li>',
                  '<li>',
                     '<select name="unit">',
                        '<option value="box" selected>箱</option>',
                        '<option value="piece">票</option>',
                     '</select>',
                   '</li>',
                  '<li class="box-type">',
                      '<span>',
                         '<b>20\'</b>',
                         '<input type="text" name="gp20Num"/>',
                      '</span>',
                      '<span>',
                         '<b>40\'</b>',
                         '<input type="text" name="gp40Num"/>',
                      '</span>',
                      '<span>',
                         '<b>40H\'</b>',
                         '<input type="text" name="hq40Num"/>',
                      '</span>',
                  '</li>',
                  '<li>',
                      '<input type="text" name="piecePrice" disabled/>',
                  '</li>',
                  '<li>',
                      '<select name="currency">',
                         '<option value="CNY">CNY</option>',
                         '<option value="USD">USD</option>',
                         '<option value="EUR">EUR</option>',
                         '<option value="HKD">HKD</option>',
                      '</select>',
                  '</li>',
               '</ul>',
             '</div>',
             '<a role="button" data-name="'+btnLabel[0]+'" class="item-btn">'+btnLabel[1]+'</a>',
          '</div>'
      ];
      if(initLoading){
          tplContent =  tplTile.join('') + tplContent.join('');
      }else{
          tplContent = tplContent.join('');
      }
     /* $.each(params,function(index,item){
          extraChargeItems = item.split('_');

      })*/
     return tplContent;
  }

};