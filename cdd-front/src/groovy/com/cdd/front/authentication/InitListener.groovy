package com.cdd.front.authentication

import com.cdd.front.server.FrontWebServerImpl
import java.text.SimpleDateFormat
import javax.servlet.ServletContext
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener
import javax.xml.ws.Endpoint;
import com.cdd.base.domain.ArticleInformation
import freemarker.template.Configuration
import freemarker.template.Template
import com.cdd.base.constant.CommonArguments

class InitListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		initNews(arg0.getServletContext());
		//String ip = InetAddress.getLocalHost().getHostAddress()
		//log.info "localhost IP: " + ip
		String address="http://localhost:9999/frontWebServer";
		def aa =  new FrontWebServerImpl()
		//aa.setContext(arg0.getServletContext())
		Endpoint.publish(address, aa);
		//TestServer.say()
	}
	
	def initNews(ServletContext sc){
		def a = ArticleInformation.list()
		a?.collect{
			if(it.newsUrl == null){
				ArticleInformation af = createNews(it,sc)
				af.save()
			}
			
		}
	}
	
	def createNews(ArticleInformation ai, ServletContext sc){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss")
		Map<String,Object> newsMap = new HashMap<String,Object>();
		Configuration cfg = null;
		cfg = new Configuration();
		cfg.setServletContextForTemplateLoading(sc,"/templates");
		Template t = cfg.getTemplate(CommonArguments.NEWSTEMP);
		//Map newsMap = new HashMap();
		newsMap.put("headTitle", ai.headTitle?:ai.title);
		newsMap.put("title", ai.title?:"");
		newsMap.put("keywords", ai.keyWords?:"");
		newsMap.put("description", ai.description?:"");
		newsMap.put("comes", ai.comes?:"");
		newsMap.put("lastUpdated",sdf.format(ai.issueDate));
		newsMap.put("content", ai.content?:"");
		//newsMap.put("frontName", frontName);
		def tgs = []
		if(ai.pageTag){
			def tags = ai.pageTag?.split(",")
			tags?.collect{
				def m = it.split(":")
				if(m.size() == 2){
					tgs.add(m[1])
					//tgs.add(m[1])//bind exception class java.util.ArrayList nor any of its super class is known to this context.]
				}
			}
		}
		
		newsMap.put("tgs", tgs)
		String path = sc.getRealPath("/news");
		File f =  new File(path)
		if(!f.exists()){
			 f.mkdir()
		}
		
		def newsfileName = sdf.format(ai.dateCreated)+".html"
		def fileName = path + "/"+newsfileName
		
		BufferedWriter  bw = new BufferedWriter(new FileWriter(fileName));
		t.process(newsMap, bw)
		bw.close()
		ai.newsUrl = "/news/"+newsfileName
		//ai.save()
		return ai
	}
}
