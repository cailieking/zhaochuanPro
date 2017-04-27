$(function(){
	window.replace = function(catName){
	 CKEDITOR.replace( catName,{
         //width: 1000,
         height: 300,
         resize_dir: 'both',
         resize_minWidth: 800,
         resize_minHeight: 200,
         resize_maxWidth: 800,
         resize_maxHeight: 200,
         resize_enabled:true,
         //toolbar :[{name:"image",items:["Image"]},{name:"table",items:["Table"]}] // 设置toolbar
     });
	}
});