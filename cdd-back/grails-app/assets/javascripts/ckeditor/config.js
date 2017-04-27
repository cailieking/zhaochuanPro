/**
 * @license Copyright (c) 2003-2016, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
config.filebrowserUploadUrl="../../upload/excute";
	
//	config.plugins =
//		'about,' +
//		'a11yhelp,' +
//		'basicstyles,' +
//		'bidi,' +
//		'blockquote,' +
//		'clipboard,' +
//		'colorbutton,' +
//		'colordialog,' +
//		'contextmenu,' +
//		'dialogadvtab,' +
//		'div,' +
//		'elementspath,' +
//		'enterkey,' +
//		'entities,' +
//		'filebrowser,'+
//		'find,' +
//		'flash,' +
//		'floatingspace,' +
//		'font,' +
//		'format,' +
//		'forms,' +
//		'horizontalrule,' +
//		'htmlwriter,' +
//		'image,' +
//		'iframe,' +
//		'indentlist,' +
//		'indentblock,' +
//		'justify,' +
//		'language,' +
//		'link,' +
//		'list,' +
//		'liststyle,' +
//		'magicline,' +
//		'maximize,' +
//		'newpage,' +
//		'pagebreak,' +
//		'pastefromword,' +
//		'pastetext,' +
//		'preview,' +
//		'print,' +
//		'removeformat,' +
//		'resize,' +
//		'save,' +
//		'selectall,' +
//		'showblocks,' +
//		'showborders,' +
//		'smiley,' +
//		'sourcearea,' +
//		'specialchar,' +
//		'stylescombo,' +
//		'tab,' +
//		'table,' +
//		'tabletools,' +
//		'templates,' +
//		'toolbar,' +
//		'undo,' +
//		'wysiwygarea';
	
	//config.uiColor = '#F7B42C';
	config.format_tags = 'pre';
	//是否强制复制来的内容去除格式 plugins/pastetext/plugin.js
    config.forcePasteAsPlainText =false //不去除
    //是否强制用“&”来代替“&amp;”plugins/htmldataprocessor/plugin.js
    config.forceSimpleAmpersand = false;
    //对address标签进行格式化 plugins/format/plugin.js
    config.format_address = { element : 'address', attributes : { class : 'styledAddress' } };
    //对DIV标签自动进行格式化 plugins/format/plugin.js
    config.format_div = { element : 'div', attributes : { class : 'normalDiv' } };
    //对H1标签自动进行格式化 plugins/format/plugin.js
    config.format_h1 = { element : 'h1', attributes : { class : 'contentTitle1' } };
    //对H2标签自动进行格式化 plugins/format/plugin.js
    config.format_h2 = { element : 'h2', attributes : { class : 'contentTitle2' } };
    //对H3标签自动进行格式化 plugins/format/plugin.js
    config.format_h1 = { element : 'h3', attributes : { class : 'contentTitle3' } };
    //对H4标签自动进行格式化 plugins/format/plugin.js
    config.format_h1 = { element : 'h4', attributes : { class : 'contentTitle4' } };
    //对H5标签自动进行格式化 plugins/format/plugin.js
    config.format_h1 = { element : 'h5', attributes : { class : 'contentTitle5' } };
    //对H6标签自动进行格式化 plugins/format/plugin.js
    config.format_h1 = { element : 'h6', attributes : { class : 'contentTitle6' } };
    //对P标签自动进行格式化 plugins/format/plugin.js
    config.format_p = { element : 'p', attributes : { class : 'normalPara' } };
    //对PRE标签自动进行格式化 plugins/format/plugin.js
    config.format_pre = { element : 'pre', attributes : { class : 'code' } };
    //用分号分隔的标签名字 在工具栏上显示 plugins/format/plugin.js
    config.format_tags = 'p;h1;h2;h3;h4;h5;h6;pre;address;div';
    //是否使用完整的html编辑模式 如使用，其源码将包含：<html><body></body></html>等标签
    config.fullPage = false;
    //是否忽略段落中的空字符 若不忽略 则字符将以“”表示 plugins/wysiwygarea/plugin.js
    config.ignoreEmptyParagraph = true;
    //在清除图片属性框中的链接属性时 是否同时清除两边的<a>标签 plugins/image/plugin.js
    config.image_removeLinkByEmptyURL = true;
    //一组用逗号分隔的标签名称，显示在左下角的层次嵌套中 plugins/menu/plugin.js.
    config.menu_groups ='clipboard,form,tablecell,tablecellproperties,tablerow,tablecolumn,table,anchor,link,image,flash,checkbox,radio,textfield,hiddenfield,imagebutton,button,select,textarea';
    //显示子菜单时的延迟，单位：ms plugins/menu/plugin.js
    config.menu_subMenuDelay = 400;
    //当执行“新建”命令时，编辑器中的内容 plugins/newpage/plugin.js
    config.newpage_html = '';
    //当从word里复制文字进来时，是否进行文字的格式化去除 plugins/pastefromword/plugin.js
    config.pasteFromWordIgnoreFontFace = true; //默认为忽略格式
    //是否使用<h1><h2>等标签修饰或者代替从word文档中粘贴过来的内容 plugins/pastefromword/plugin.js
    config.pasteFromWordKeepsStructure = false;
    //字体 后面加+config.font_names 是为了把不匹配的ko掉
    config.font_names = '宋体/SimSun;新宋体/NSimSun;仿宋/FangSong;楷体/KaiTi;仿宋_GB2312/FangSong_GB2312;'+  
    '楷体_GB2312/KaiTi_GB2312;黑体/SimHei;华文细黑/STXihei;华文楷体/STKaiti;华文宋体/STSong;华文中宋/STZhongsong;'+  
    '华文仿宋/STFangsong;华文彩云/STCaiyun;华文琥珀/STHupo;华文隶书/STLiti;华文行楷/STXingkai;华文新魏/STXinwei;'+  
    '方正舒体/FZShuTi;方正姚体/FZYaoti;细明体/MingLiU;新细明体/PMingLiU;微软雅黑/Microsoft YaHei;微软正黑/Microsoft JhengHei;'+  
    'Arial Black/Arial Black;'+ config.font_names;

    //字体大小
     config.fontSize_sizes = '小六/8px;六号/10px;小五/12px;五号/14px;小四/16px;四号/18px;小三/20px/;三号/21px;小二/24px;二号/29px;小一/32px;一号/34px;小初/48px;初号/56px;' ;
    
    //回车时产生的标签 
	//config.enterMode = CKEDITOR.ENTER_DIV;
	//config.shiftEnterMode = CKEDITOR.ENTER_DIV
	
};
