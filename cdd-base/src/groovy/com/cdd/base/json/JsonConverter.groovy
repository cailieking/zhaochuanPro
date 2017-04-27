package com.cdd.base.json

import org.codehaus.groovy.grails.commons.GrailsApplication
import org.codehaus.jackson.map.MapperConfig
import org.codehaus.jackson.map.ObjectMapper
import org.codehaus.jackson.type.TypeReference

class JsonConverter extends ObjectMapper {
	GrailsApplication grailsApplication
	
	public JsonConverter() {
		getSerializationConfig().addMixInAnnotations(JsonObject, PropertiesFilterMixin)
		getDeserializationConfig().addMixInAnnotations(JsonObject, PropertiesFilterMixin)
		setDeserializerProvider(deserializerProvider)
	}

	public void setEnableConfigure(MapperConfig.ConfigFeature feature) {
		this.configure(feature, true)
	}

	public void setdisableConfigure(MapperConfig.ConfigFeature feature) {
		this.configure(feature, false)
	}

	public String toJSON(Object object) {
		return writeValueAsString(object)
	}

	public <T> T toPOJO(String json, Class<T> pojoClass) {
		return readValue(json, pojoClass) 
	}
	
	public Map<String, Object> toMap(String json) {
		return this.readValue(json, new TypeReference<HashMap<String, Object>>() {})
	}
}
