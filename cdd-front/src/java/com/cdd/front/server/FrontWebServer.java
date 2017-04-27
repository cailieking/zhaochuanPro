package com.cdd.front.server;

import java.util.Map;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;

@WebService  
public interface FrontWebServer {
	@WebMethod(exclude=false)
	public String createHtml(@XmlJavaTypeAdapter(MapAdapter.class) Map<String, Object> htmlMap);
	
	@WebMethod(exclude=false)
	public boolean createNewsDetails(@XmlJavaTypeAdapter(MapAdapter.class) Map<String, Object> m);
}
