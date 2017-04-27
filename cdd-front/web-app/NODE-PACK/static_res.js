var libJsConfig = {
	basePath:'../js',
	libJsFilename:['jquery.js','jquery-ui.js','bootstrap-table.js','bootstrap.min.js','dialog.js','highcharts.js','chart.js','json2.js'],
	packDir:'module',
	packName:'lib_pack.js'
};
module.exports.libJsConfig = exports.libJsConfig = libJsConfig;

var libCssConfig = { 
	basePath :'../css',
    libCssFilename:['dialog.css','jquery-ui.css'],
    packDir:'module',
    packName:'lib_pack.css'
};

module.exports.libCssConfig = exports.libCssConfig = libCssConfig;

var moduleCssConfig = {
	basePath : libCssConfig['basePath'],
	 packDir :  libCssConfig['packDir'],
   modulesNum:  2,
   cssModules : {
   	    commonModule:{source:['common.css'],isUpdate:true},
	    indexModule:{source:['index/index.css'],isUpdate:true},
        shipModule:{source:['button.css','index/index.css','bootstrap.min.new.css','bootstrap-table-new.css','ship.css'],isUpdate:true},
        cargoModule:{source:['button.css','index/index.css','bootstrap.min.new.css','bootstrap-table-new.css','cargo.css'],isUpdate:true},
        cargoInquiryModule:{source:['tools.css','cargoInquery.css'],isUpdate:true},
        memberShipModule:{source:['member/ship.css','member/member.css'],isUpdate:true}


   }

}
exports.moduleCssConfig = moduleCssConfig;
var moduleJsConfig = {
     basePath : libJsConfig['basePath'],
     packDir  : 'module',
    modulesNum:  2,
     jsModules :{
     	commonModule:{source:['common.js','js.js'],isUpdate:true},
		indexModule:{source:['index/index.js'],isUpdate:true},
        shipModule:{source:['bootstrap-table-new.js','ship.js'],isUpdate:true},
		cargoModule:{source:['bootstrap-table-new.js','cargo.js'],isUpdate:true},
        cargoInquiryModule:{source:['cargoInquery.js'],isUpdate:true},
        memberShipModule:{source:['ExtraChargePlugin.js','cargoInquery.js','AppendShipping.js'],isUpdate:true}

     }

};
exports.moduleJsConfig = moduleJsConfig;

var setPackModule = function(options,type){
	var options = options;
	if(!options || !type )reture;
	var multiFilePath = options['filePath'];
	    multiFilePath = multiFilePath instanceof Array ? multiFilePath :[multiFilePath];
    var moduleName = options['moduleName']; 
    var type = type;	
	if(isJsRootDir === false && jsFilenames[0].indexOf('/') === -1){
        throw new Error('hi,guy u forget the new directory!!');
	}
	if(type === 'css'){
        if(!moduleCssConfig['cssModules'][moduleName +'Module']['isUpdate']) return
        moduleCssConfig['cssModules'][moduleName +'Module']['source'] = [];	
        moduleCssConfig['cssModules'][moduleName +'Module']['source'].concat(multiFilePath);
        return moduleCssConfig;
	}
	if(type === 'js'){
        if(!moduleJsConfig['jsModules'][moduleName +'Module']['isUpdate']) return //有时候js文件更新之后需要重新打包
        moduleJsConfig['jsModules'][moduleName +'Module']['source'] = [];		
        moduleJsConfig['jsModules'][moduleName +'Module']['source'].concat(multiFilePath);	
        return moduleJsConfig;
	}

};

exports.setPackModule = setPackModule;
var removePackModule = function(moduleName){
	if(!moduleName)return;
	if(moduleCssConfig['cssModules'][moduleName+'Module']){
		delete moduleCssConfig['cssModules'][moduleName+'Module'];
	}
    if(moduleJsConfig['jsModules'][moduleName+'Module']){
    	delete  moduleJsConfig['jsModules'][moduleName+'Module'];
    }
};
exports.removePackModule = removePackModule;