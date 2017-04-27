package com.cdd.base.json;

import org.codehaus.jackson.annotate.JsonAutoDetect;
import org.codehaus.jackson.annotate.JsonAutoDetect.Visibility;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;

@JsonIgnoreProperties({ "parent", "springSecurityService", "errors", "properties", "dirtyPropertyNames", "defaultReadOnly" })
@JsonAutoDetect(isGetterVisibility = Visibility.NONE)
public class PropertiesFilterMixin {

}