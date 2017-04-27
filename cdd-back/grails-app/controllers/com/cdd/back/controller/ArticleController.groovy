package com.cdd.back.controller

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.hibernate.SessionFactory

import com.cdd.back.client.FrontWebServer
import com.cdd.back.client.FrontWebServer_Service
import com.cdd.back.client.MapConvertor
import com.cdd.back.client.MyMapEntry
import com.cdd.base.domain.ArticleInformation
import com.cdd.base.domain.BackUser;
import com.cdd.base.enums.ArticleType
import com.cdd.base.enums.ArticleState
import com.cdd.base.service.OssService;

import freemarker.template.Configuration
import freemarker.template.Template
import grails.converters.JSON
import java.text.SimpleDateFormat
import java.util.regex.Matcher
import java.util.regex.Pattern
import com.cdd.base.constant.CommonArguments

class ArticleController extends BaseController {
	def model = 'article'
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
	def list() {
		render view:"/${model}/list"
	}
	
	def listArticles() {
//		if(params.search) {
//			params.f_like_title = "%${params.search}%"
//		}
		params.limit = params.resultCount ?: 10
		params.offset = params.pageOffSet ?: 0
		params.sort = 'dateCreated'
		params.order = "desc"
		
		//def result = CRUDService.list(BackDepartment,params)
		params.dataType = "json"
//		def articles =  getList(model: model, domainClass: ArticleInformation) { item, map ->
//			map.type = item.articleType?.text
//			map.state = item.articleState?.text
//		}

		//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd")
		//result.stateCounts = []
		
		def articles = getList(model: model, domainClass: ArticleInformation,isConjunction: true, queryHandler:{
			if(params.searchKey) {
				or {
					//like "contactPersons", ContactPerson.findByPersonName(params.serachKey)
					//like "contactPersons",aa
					like "title", "%"+params.searchKey+"%"
					like "createBy", "%"+params.searchKey+"%"
				}
			}
			if(params.state){
				if(params.state.toString().trim().equals("草稿")){
					and {
						eq 'articleState',  ArticleState.valueOf("Draft")
					}
				}else{
					and {
						like "articleCategory", "%"+params.state+"%"
					}
				}
				
			}
			if(params.type){
				and {
						eq 'articleType',  ArticleType.valueOf(params.type)
					}
			}
//			if(params.tagName && "rgb(255, 255, 255)" != params.tagName && "transparent" != params.tagName){
//				and {
//						eq "tagManager", TagManager.findByTagName(params.tagName)
//					}
//			}
//			if(params.demandId && "全部" != params.demandId){
//				and {
//					eq "demandClass", DemandClass.get(params.demandId as long)
//				}
//			}
//			if(params.typeId && "全部" != params.typeId ){
//				and {
//					eq "clientType", ClientType.get(params.typeId as long)
//				}
//			}
//			if(params.groupId && "全部" != params.groupId){
//				and {
//					eq "groupManager", GroupManager.get(params.groupId as long)
//				}
//			}
			if(params.startDate && params.endDate){
				def date1=sdf.parse(params.startDate)
				def date2=sdf.parse(params.endDate)
				and {
				   between ("dateCreated" , date1,date2)
				}
			}else if(params.startDate){
				def date = sdf.parse(params.startDate)
				and {
					//le "dateCreated", date
					ge "dateCreated", date
//					and{
//						ge "endDate", date
//					}
				}
			}else if(params.endDate){
				def date=sdf.parse(params.endDate)
					and {
						//le "startDate", date
						//and{
							le "dateCreated", date
							//ge "dateCreated", date
						//}
				}
			}else{
			
			}
			}){ item, map ->
				map.type = item.articleType?.text
				map.state = item.articleState?.text
		}
		def aMap = articles.getProperties()
		render ([totalCount:aMap.target.total,rows:aMap.target.rows,stateCounts:countByStatus()] as JSON)
		//render articles
		return 
	}

	def data() {
		def name;
		if(params.id){
			name = '编辑文章'
		}else{
			name = "创建文章"
		}
		render data(model: model, menuName: name, domainClass: ArticleInformation)
	}
	
	def showDetails(){
		def ac = ArticleInformation.get(params.id as long)
		if(ac){
			render ac as JSON
		}else{
			render null
		}
	}

	int maxSize = 1024 * 1024 * 10
	
	GrailsApplication grailsApplication
	
	SessionFactory sessionFactory
	
	OssService ossService

	def save() {
		
		ArticleInformation data
		if(params.id) {
			data = ArticleInformation.get(params.id as Long)
		} else {
			data = new ArticleInformation()
		}
		try {
			data.articleType = ArticleType.valueOf(params.articleType) 
		} catch(e) {
			
		}
		if(params.articleState != "update" ){
			data.articleState = ArticleState.valueOf(params.articleState?:ArticleState.Draft)
		}else{
		
		}
		data.content = params.articleContent   
		StringBuffer imgs = getImgs()
		data.articleImgs = imgs.toString()
		data.title = params.title
		data.comes = params.comes
		data.image = params.image
		data.headTitle = params.headTitle
		data.tweetTitle = params.tweetTitle
		data.keyWords = params.keywords
		data.sourceUrl = params.sourceUrl
		data.comes = params.comes
		data.articleSummary = params.articleSummary
		data.description = params.description

		//data.articleCategory = params.articleCategory
		//Pattern p = Pattern.compile("<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>")
		//Pattern p = Pattern.compile("src\\s*=\\s*\"?(.*?)(\"|>|\\s+)")
		data.articleCategory = ""
		def cArray = params.articleCategory.toString().split(",")
		data = assembleCategory(cArray, data)
		data.pageTag = ""
		for(int i = 0;i<params.pageTag.length;i++){
			if(data.pageTag == ""){
				data.pageTag += i + ":" + params.pageTag[i]
			}else{
				data.pageTag += "," + i + ":" + params.pageTag[i]
			}
		}
		def suffix = new SimpleDateFormat("yyyyMMddhhmmss").format(new Date())+".html"
//		def frontName = initFrontName(request.getServerName())
//		if(frontName.equals("www.zhao-chuan.com")){
//			data.newsUrl = "http://"+ frontName +":8080/news/"+suffix
//		}else{
//			data.newsUrl = "http://"+request.getServerName()+":" + request.getServerPort()+"/news/"+suffix
//		}
		
		data.newsUrl = "/news/"+suffix
		data.issueDate = new Date()
		data.save()
		
		def result 
		if(data.hasErrors()){
			result = false
			println data.errors
		}else {
			//createNewsDetails(data,suffix,frontName)
			createNewsDetails(data,suffix)
			result = true
		}
		
		render result
		return
//		def f = request.getFile('file')
//		if(f.size > maxSize) {
//			flash.errors = [:]
//			flash.errors.msgs = ['图片不能超过10MB']
//			redirect uri: "/${model}/data/${data.id ?: 'new'}"
//			return
//		}
//		if(f.size > 0) {
//			String fileName = "files/adv/article/" + URLEncoder.encode("${f.fileItem.fileName}", "UTF-8")
//			//now transfer file
////			File fileDest = new File("${grailsApplication.config.appInfo.rootPath}${fileName}")
////			fileDest.mkdirs()
////			f.transferTo(fileDest)
//			ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket, 
//					"files/adv/article/" + f.fileItem.fileName)
//			data.image = fileName
//			//sessionFactory.currentSession.createSQLQuery("update article_information set image=null").executeUpdate()
//		}
		//save(data, model)
	}

	
	def assembleCategory(String[] cArray, ArticleInformation data) {
		if(cArray.size() == 2 ){
			def result = CRUDService.list(ArticleInformation,params){
				//if(params.articleCategory){
				and {
					like "articleCategory", "%特推%"
				}
				//}
			}
			if(result.totalCount != 0){
				if(result.list[0].articleCategory.split(",").size() > 1){
					result.list[0].articleCategory = "置顶"
				}else {
					result.list[0].articleCategory = null
				}
				result?.list[0].save()
			}

			params.articleCategory?.collect{
				if(data.articleCategory == ""){
					data.articleCategory += it
				}else{
					data.articleCategory += ","+it
				}
			}
		}else{
			if(params.articleCategory == "特推"){
				def result = CRUDService.list(ArticleInformation,params){
					//if(params.articleCategory){
					and {
						like "articleCategory", "%特推%"
					}
					//	}
				}
				if(result.totalCount != 0){
					if(result.list[0].articleCategory.split(",").size() > 1){
						result.list[0].articleCategory = "置顶"
					}else {
						result.list[0].articleCategory = null
					}
					result?.list[0].save()
				}
			}
			data.articleCategory = params.articleCategory
		}
		return data
	}

	private StringBuffer getImgs() {
		StringBuffer imgs = new StringBuffer()
		Pattern p = Pattern.compile("<img.+?src=\"(.+?)\".+?/?>")
		Matcher m = p.matcher(params.articleContent);
		while(m.find()){
			if(imgs.toString() == ""){
				imgs.append(m.group(1))
			}else{
				imgs.append("," + m.group(1))
			}
		}
		return imgs
	}
	
//	public void destroy() {
//		super.destroy();
//	}
//	
//	public void doGet(HttpServletRequest request, HttpServletResponse response)
//		throws ServletException, IOException {
//		doPost(request, response);
//		}
	
	def delete() {
		def ids = params.ids.split(",")
		def objs = []
		for(def id in ids){
			def obj = ArticleInformation.get(id as long)
			def d = obj.newsUrl.split("/")
			String fe = servletContext.getRealPath("/news/"+d.last());
			File f =  new File(fe)
			if(f.exists()){
				f.delete()
			}
			objs << obj
		}
		ArticleInformation.deleteAll(objs)
		render true 
		return 
	}
	
	
	def countByStatus(){
		def counts = []
		def status = ["draft":0,"stick":0,"tweet":0]
		def countDraft = sessionFactory.currentSession.createSQLQuery("select count(article_state)  from article_information where article_state = 'Draft' ").uniqueResult()
		def countTweet = sessionFactory.currentSession.createSQLQuery("select count(*)  from article_information where article_category like '%特推%' ").uniqueResult()
		def countStick = sessionFactory.currentSession.createSQLQuery("select count(*)  from article_information where article_category like '%置顶%' ").uniqueResult()
		status.draft = countDraft
		status.stick = countStick
		status.tweet = countTweet
		return status
	}
	
	
	def execute(){
		def imgName = params.imgName
		def f = request.getFile(imgName)
		//String onlyMark = java.util.UUID.randomUUID().toString();
		String fileName = java.util.UUID.randomUUID().toString() + f.fileItem.fileName;
		String path = "files/adv/article"
		if(f.size <= 0 ) {
			flash.errors = [:]
			flash.errors.msgs = ['请上传一张图片']
			redirect uri: "/${model}/list/${data.id ?: 'new'}"
			return
		}
		if(f.size > maxSize) {
			flash.errors = [:]
			flash.errors.msgs = ['图片不能超过10MB']
			redirect uri: "/${model}/list/${data.id ?: 'new'}"
			return
		}
		if(f.size > 0) {
			//def inout = f.getInputStream()
			uploadFile(path, f, fileName)
		}
		
		render path+"/"+fileName
		
	}
	
	def uploadFile(String path, def f, String fileName) {
			
		ossService.uploadFile(f.inputStream, grailsApplication.config.oss.publicbucket,path+"/"+fileName)
		
//			String uploadPath = servletContext.getRealPath(path);
//			InputStream inp = null;
//			OutputStream out = null;
//			File file =new File(uploadPath);
//			if(!file.exists()){
//				file.mkdir();
//			}
//			try{
//				def inOut = f.getInputStream()
//				inp = new BufferedInputStream(inOut,16 * 1024);
//				byte[] buffer = new byte[16 * 1024];
//				out = new BufferedOutputStream(new FileOutputStream(new File(uploadPath,fileName)))
//
//				while(true){
//					def len = inp.read(buffer)
//					if(len > 0){
//						out.write(buffer,0,len)
//					}else{
//						break;
//					}
//				}
//			}catch(Exception e){
//				e.printStackTrace();
//			} finally {
//				if (null != inp) {
//					inp.close();
//				}
//				if (null != out) {
//					out.close();
//				}
//			}
		}
	
	 def updateCategory(){
		 def articles = params.articles.split(",")
		 def category = params.category
		 def objs = []
		 switch(Integer.parseInt(category)){
			 case 0: 
			 		for(def id in articles) {
						 def aIf =  ArticleInformation.get(id as Long)
						 if(aIf.articleCategory == null){
						 	aIf.articleCategory = "置顶"
						 }else if(aIf.articleCategory.split(",").size() == 1 && aIf.articleCategory == "特推"){
						 	 aIf.articleCategory += ",置顶"
						 }
						 aIf.issueDate = new Date()
						 objs << aIf
					 }
					 break;
			 case 1:  
			 	    for(def id in articles) {
						 def aIf =  ArticleInformation.get(id as Long)
						 if(aIf.articleCategory.split(",").size()>1){
							 aIf.articleCategory = "特推"
						 }else if(aIf.articleCategory.split(",").size() == 1 && aIf.articleCategory == "置顶"){
						 	aIf.articleCategory = null
						 }
						 aIf.issueDate = new Date()
						 objs << aIf
					 }
					 break;
			 case 2:  
			 		def result = CRUDService.list(ArticleInformation,params){
						 and {
							 like "articleCategory", "%特推%"
						 }
					 }
					 if(result.totalCount != 0){
						 def af = result.list[0]
						 if(af.articleCategory.split(",").size() > 1){
							 af.articleCategory = "置顶"
						 }else{
						 	  af.articleCategory = null
						 }
						 af.issueDate = new Date()
						 af.save()
						 if(af.hasErrors()){
							 println af.errors 
							 render false 
							 return 
						 }
					 }
			 		 for(def id in articles) {
						 def aIf =  ArticleInformation.get(id as Long)
						 if(aIf.articleCategory == null){
							 aIf.articleCategory = "特推"
						 }else if(aIf.articleCategory.split(",").size() == 1 && aIf.articleCategory == "置顶"){
						 	 aIf.articleCategory += ",特推"
						 }
						 aIf.issueDate = new Date()
						 objs << aIf
					 }
					 break;
			 case 3:
					 for(def id in articles) {
						 def aIf =  ArticleInformation.get(id as Long)
						 if(aIf.articleCategory.split(",").size()>1){
							 aIf.articleCategory = "置顶"
						 }else if(aIf.articleCategory.split(",").size() == 1 && aIf.articleCategory == "特推"){
						 	aIf.articleCategory = null
						 }
						 aIf.issueDate = new Date()
						 objs << aIf
					 }
					 break;
			 default : 
			 		 break;
		 }
		 ArticleInformation.saveAll(objs)
		 render true
		 return 
	 }
	 
	 def updateState(){ 
		 def article = ArticleInformation.get(params.id as long)
		 def result 
		 if(article != null){
			 article.articleState = ArticleState.valueOf(params.state)
			 article.issueDate = new Date()
			 article.save()
			 if(article.hasErrors()){
				 println article.errors 
				 result = false
			 }else{
			 	 result = true
			 }
		 }
		 render result
		 return
	 }
	 
	 
	 def ossDomains(){
		 def ossDomain = "${grailsApplication.config.oss.endpointDomain}/${grailsApplication.config.oss.publicbucket}"
		 render ([ossDomain:ossDomain] as JSON)
	 }
	 	
	 
	 def delImg(){
		 def rs
		 def content = params.content
		 if(params.imgName != null && params.imgName.trim() != ""){
			 boolean result = ossService.isExist(grailsApplication.config.oss.publicbucket, params.imgName)
			 if(result){
				 ossService.deleteFile(grailsApplication.config.oss.publicbucket, params.imgName)
				 rs = true
			 }else {
			 	 rs = false
			 }
		 }
		 if(params.id != null && params.id.trim() != ""){
			 def article = ArticleInformation.get(params.id as long)
			 if(article){
				 def imgs = ""
				 article.articleImgs?.split(",").collect{
					 if(it.indexOf(params.imgName) <= 0){
						 if(imgs == ""){
							 imgs += it
						 }else{
							 imgs += ","+it
						 }
					 }
				 }
				 Pattern p = Pattern.compile("<img.+?src=\"(.+?)\".+?/?>")
				 Matcher m = p.matcher(content);
				 while(m.find()){
					 if(m.group().indexOf(params.imgName)>0){
						 content = content.replaceAll(m.group(), "")
						// content = ct
					 }
				 }
				 
				 article.articleImgs = imgs
//				 Pattern p = Pattern.compile("<img.+?src=\"(.+?)\".+?/?>")
				 m = p.matcher(article.content);
				 while(m.find()){
					 if(m.group().indexOf(params.imgName)>0){
						 def ct = article.content.replaceAll(m.group(), "")
						 article.content = ct
						 article.save()
					 }
				 }
			 }
		 }else{
		 		Pattern p = Pattern.compile("<img.+?src=\"(.+?)\".+?/?>")
				Matcher m = p.matcher(content);
		 		while(m.find()){
				if(m.group().indexOf(params.imgName)>0){
				content = content.replaceAll(m.group(), "")
				// content = ct
				}
			}
		 }
		 render ([state:rs,content:content] as JSON)
		 return 
	 }
	 
	 def createNewsDetails(ArticleInformation ac,String fileName)throws Exception{
		 Map<String,Object> newsMap = new HashMap<String,Object>();
		 Configuration cfg = null;
		 cfg = new Configuration();
		 cfg.setServletContextForTemplateLoading(servletContext,"/templates");
		 Template t = cfg.getTemplate(CommonArguments.NEWSTEMP);
		 //Map newsMap = new HashMap();
//		 newsMap.put("headTitle", ac.headTitle?:"");
//		 newsMap.put("title", ac.title?:"");
//		 newsMap.put("keywords", ac.keyWords?:"");
//		 newsMap.put("description", ac.description?:"");
//		 newsMap.put("comes", ac.comes?:"");
//		 newsMap.put("lastUpdated",sdf.format(ac.issueDate)); 
//		 newsMap.put("content", ac.content?:"");
		 //newsMap.put("frontName", frontName);
		 def tags = ac.pageTag.split(",")
		 def tgs = ""
		 tags.collect{
			 def m = it.split(":")
			 if(m.size() == 2){
				 if(tgs == ""){
					 tgs += m[1]
				 }else{
				 	 tgs += "," + m[1]
				 }
				 //tgs.add(m[1])//bind exception class java.util.ArrayList nor any of its super class is known to this context.]
			 }
		 }
		 newsMap.put("tgs", tgs)
//		 String path = servletContext.getRealPath("/news");
//		 File f =  new File(path)
//		 if(!f.exists()){
//			 f.mkdir()
//		 }
//		 def fileName = path + "/"+suffix
//		 BufferedWriter  bw = new BufferedWriter(new FileWriter(fileName));
//		 t.process(newsMap, bw)
//		 bw.close()
		 
		 MapConvertor m = new MapConvertor();
		 [
			 "headTitle": ac.headTitle?:"",
			 "title": ac.title?:"",
			 "newsUrl": fileName?:"",
			 "keywords": ac.keyWords?:"",
			 "description": ac.description?:"",
			 "comes": ac.comes?:"",
			 "lastUpdated": sdf.format(ac.issueDate),
			 "content": ac.content?:"",
			 "tgs": tgs?:""
		 ].each { key,value ->
			 MyMapEntry me = new MyMapEntry()
			 me.key = key
			 me.value = value
			 m.addEntry(me)		
		}
		 FrontWebServer tm = new FrontWebServer_Service().getFrontWebServerImplPort()
		 tm.createHtml(m)
		 
	 }
//		 		 Service service = new Service();
//		 		 try {
//		 			 Call call = (Call) service.createCall();
//		 			 call
//		 					 .setTargetEndpointAddress("http://localhost:9999/getJob?wsdl");
//		 			 call.setOperationName("tjpcProcess");
//		 			 call.addParameter(
//		 				 "xmlParam", 
//		 				 org.apache.axis.encoding.XMLType.XSD_STRING,
//		 				 javax.xml.rpc.ParameterMode.IN);
//		 			 call.setReturnType(org.apache.axis.encoding.XMLType.XSD_STRING);
//		 			 //            call.setTimeout(5000);
//		 			 call.setUseSOAPAction(true);
//		 			 call.setSOAPActionURI("http://support.ajpc.fy.np.thunisoft.com/tjpcProcess");
//		 			 String result = (String) call.invoke(new Object[] { "<QueryParam NAjlb='1' NSpcx='2' CBhAj='6A10F8068A8015310BA2887DEFFC8960' NSyfy='1'></QueryParam>" });
//		 			 System.out.println(result);
//		 		 } catch (Exception ex) {
//		 			 ex.printStackTrace();
//		 		 }
		 
		 
//		 URL url = new URL("http://localhost:9999/getJob?wsdl");
//		 
//			   URLConnection conn = url.openConnection();
//			   HttpURLConnection httpConn = (HttpURLConnection) conn;
//			   httpConn.setDoInput(true);
//			   httpConn.setDoOutput(true);
//			   httpConn.setRequestMethod("POST");
//			   httpConn.setRequestProperty("Content-type", "text/xml;charset=UTF-8");
//		 
////			   String data = "<soapenv:Envelopexmlns:soapenv=" +
////		 
////					"\"http://schemas.xmlsoap.org/soap/envelope/\"" +
////		 
////					"xmlns:q0=\"http://server.rl.com/\"" +
////		 
////					"xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"" +
////		 
////					"xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">";
////		 
////					+"<soapenv:Body>"
////		 
////					+"<q0:sayHello>"
////		 
////					+"<arg0>renliang</arg0>"
////		 
////				   +"</q0:sayHello>"
////		 
////				   +"</soapenv:Body>"
////		 
////				   +"</soapenv:Envelope>";
	 
//			   OutputStream out = httpConn.getOutputStream();
//			   out.write(data);
//			   if(httpConn.getResponseCode() == 200){
//				   
//					//	InputStream in = httpConn.getInputStream();
//				   
////						BufferedReader reader = new BufferedReader(new InputStreamReader(in));
////				   
////						   StringBuffer sb = new StringBuffer();
////				   
////						   String line = null;
////				   
////				   
////						   while((line = reader.readLine()) != null){
////				   
////							  sb.append(line);
////				   
////						   }
//			   }
		 
		// return "/news/"+new SimpleDateFormat("yyyyMMddhhmmss").format(new Date())+".html"
		 
	 
	 def viewArticle(){
		 ArticleInformation data = ArticleInformation.get(params.id as Long)
		 def result
		 if(data){
			 ++data.readCount
			 data.save()
			 if(data.hasErrors()){
				   log.info "Error: " + data.errors
				   result = false
			 }
			 result = true
		 }
		 render result
		 return
	 }
}
