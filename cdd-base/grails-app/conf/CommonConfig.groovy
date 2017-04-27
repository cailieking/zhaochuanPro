environments {
	uat {
		grails.plugin.standalone.tomcat.memcached.memcachedNodes = 'OCS:3ccfe99b6911407a.m.cnszalist3pub001.ocs.aliyuncs.com:11211'
		grails.plugin.standalone.tomcat.memcached. transcoderFactoryClass = 'de.javakaffee.web.msm.serializer.kryo.KryoTranscoderFactory'
	}
}
grails.gorm.default.mapping = {
	autoTimestamp true
	version false
	createBy updateable: false
	dateCreated updateable: false
}

grails.databinding.dateFormats = [
	'yyyy-MM-dd', 'yyyy-MM-dd HH:mm:ss.S', "yyyy-MM-dd'T'hh:mm:ss'Z'"]