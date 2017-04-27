package com.cdd.base.json

import org.codehaus.groovy.grails.commons.GrailsApplication

class JsonConverterFactory {
	GrailsApplication grailsApplication
	
	JsonConverter create() {
		grailsApplication.mainContext.getBean(JsonConverter)
	} 
}
