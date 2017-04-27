package com.cdd.front.server;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.servlet.ServletContext;








import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;










import jline.internal.Log;

//import org.codehaus.groovy.grails.web.servlet.mvc.GrailsWebRequest;
//import org.codehaus.groovy.grails.web.util.WebUtils;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import com.cdd.base.constant.CommonArguments;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
//import grails.util.Environment;
//import groovy.lang.GroovyClassLoader;
//import groovy.util.ConfigObject;
//import groovy.util.ConfigSlurper;

@WebService(endpointInterface="com.cdd.front.server.FrontWebServer", serviceName="frontWebServer")
public class FrontWebServerImpl implements FrontWebServer {
	    
		@WebMethod(exclude=false)//,operationName="differentFromMethodName"
		public String createHtml(@XmlJavaTypeAdapter(MapAdapter.class) Map<String, Object> htmlMap) {
		//public String createHtml(MapConvertor htmlMap) {
//			String address="http://localhost:9999/getJob";
//			Endpoint.publish(address, new TestServer());
			//createNewsDetails()
		//	try {
				createNewsDetails(htmlMap);
//			} catch (ClassNotFoundException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
			return "SUCCESS";
		}
		
		
		@WebMethod(exclude=false)
		//public boolean createNewsDetails(MapConvertor m) throws ClassNotFoundException{
		public boolean createNewsDetails(@XmlJavaTypeAdapter(MapAdapter.class) Map<String, Object> m) {
			String[] tgs ;
			tgs = ((String) m.get("tgs")).split(",");
			Map<String,Object> news = new HashMap<String,Object>();
			for(Entry<String,Object>  e: m.entrySet()){
				if(e.getKey().equals("tgs")){
					news.put(e.getKey(), tgs);
				}else{
					news.put(e.getKey(), e.getValue());
				}
			}
			
			//this.getClass().getClassLoader().loadClass(name);
			//GrailsWebRequest webRequest =  (GrailsWebRequest) RequestContextHolder.currentRequestAttributes();
			//ServletContext sc = WebUtils.retrieveGrailsWebRequest().getServletContext(); 
			//Class<?> defaultConfigFile = this.getClass().getClassLoader().loadClass(DEFAULT_CONFIG_FILE);
			//ServletConfig config = new ConfigSlurper(Environment.getCurrent().getName()).parse(defaultConfigFile);
			//ServletConfig config = this.getServletConfig();
			 //HttpServlet h = null;
			 //Map newsMap = new HashMap();
			// String suffix = new SimpleDateFormat("yyyyMMddhhmmss").format(new Date())+".html";
			 String suffix = (String) news.get("newsUrl");
			 Configuration cfg = null;
			 cfg = new Configuration();
			 BufferedWriter  bw = null;
			 //ServletConfig c;
			 //cfg.setServletContextForTemplateLoading(WebUtils.retrieveGrailsWebRequest().getServletContext(), "/templates");
			 Template t = null;
			 try {
				 WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();    
		         ServletContext servletContext = webApplicationContext.getServletContext();  
		         // System.out.println(WebUtils.retrieveGrailsWebRequest().getServletContext());
				 // cfg.setServletContextForTemplateLoading(WebUtils.retrieveGrailsWebRequest().getServletContext(), "/templates");
				 // cfg.setClassForTemplateLoading(WebUtils.retrieveGrailsWebRequest().getServletContext(), "/template");
				 // cfg.setDirectoryForTemplateLoading(new File("/templates"));
				 cfg.setServletContextForTemplateLoading(servletContext, "/templates");
				 t = cfg.getTemplate(CommonArguments.NEWSTEMP);
				// String path = WebUtils.retrieveGrailsWebRequest().getServletContext().getRealPath("/news");
				 String path = servletContext.getRealPath("/news");
				 File f =  new File(path);
				 if(!f.exists()){
					 f.mkdir();
				 }
				 String fileName = path + "/"+suffix ;
				 bw = new BufferedWriter(new FileWriter(fileName));
				 t.process(news, bw);
				 return true;
			 } catch (TemplateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			 } catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			 }finally{
				if(bw != null){
					 try {
						bw.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			return false;
		 }
		
//		public void setContext(ServletContext s){
//			this.s = s;
//		}
		
}
