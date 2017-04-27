var path = require('path');
var gulp = require('gulp');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var minifyCss = require('gulp-minify-css');
var _ = require('lodash');
var static_res = require('./static_res');
var cssDestPath = path.join(__dirname,static_res.libCssConfig.basePath,static_res.libCssConfig.packDir);
var jsDestPath = path.join(__dirname,static_res.libJsConfig.basePath,static_res.libJsConfig.packDir);
gulp.task('default',function(){
    var cssDir = path.join(__dirname,static_res.libCssConfig.basePath,'/*');
    var jsDir = path.join(__dirname,static_res.libJsConfig.basePath,'/*');//监听js文件夹下的文件变化
    gulp.watch(cssDir,['lib_pack','module_pack']);
    gulp.watch(jsDir,['lib_pack','module_pack']);
})
gulp.task('lib_pack',function(){
  var  libJsConfig = static_res.libJsConfig;
  var libCssConfig = static_res.libCssConfig;
  var cssSource =  pathSwitch(libCssConfig['libCssFilename']);
  var jsSource = pathSwitch(libJsConfig['libJsFilename']);
  gulp.src(cssSource)
      .pipe(concat(libCssConfig['packName']))
      .pipe(minifyCss())
      .pipe(gulp.dest(cssDestPath));
  gulp.src(jsSource)
      .pipe(concat(libJsConfig['packName'])) 
      .pipe(uglify())
      .pipe(gulp.dest(jsDestPath))   

});
gulp.task('module_pack',function(){
    var cssModules = static_res.moduleCssConfig.cssModules;
    var jsModules = static_res.moduleJsConfig.jsModules;
    for(var key in cssModules){
        var packName = key.substring(0,key.length -6) + '.min.css' ;
        var source = cssModules[key]['source'];

        if(cssModules[key]['isUpdate']){
            source = pathSwitch(source);
            gulp.src(source)
                .pipe(concat(packName)) 
                .pipe(minifyCss())
                .pipe(gulp.dest(cssDestPath));
        }  

    }
    for(var key in jsModules){
       var packName = key.substring(0,key.length -6) + '.min.js' ;
       var source = jsModules[key]['source'];
       if(jsModules[key]['isUpdate']){
          source = pathSwitch(source);
          gulp.src(source)
               .pipe(concat(packName))
               .pipe(uglify())
               .pipe(gulp.dest(jsDestPath)); 
       }

    }
   
})
var pathSwitch = function(source){
   var source = source;
   if(!source)return [];
   if(!(source instanceof Array)) throw new Error('hi,guy,param is type of Array !!');
   source =  _.map(source,function(val,index){
              if(val.indexOf('js') != -1){
                    return  path.join(__dirname,'../js',val);
              }
              if(val.indexOf('css')!= -1){
                 return  path.join(__dirname,'../css',val);
              }
   })
   return source;
}