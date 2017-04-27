import grails.util.Environment

import java.text.SimpleDateFormat

import org.codehaus.jackson.map.SerializationConfig.Feature

import com.aliyun.oss.OSSClient
import com.cdd.base.constant.CommonConstant
import com.cdd.base.json.JsonConverter
import com.cdd.base.json.JsonConverterFactory
import com.cdd.base.service.dbupdator.AbstractDatabaseUpdator

//import de.javakaffee.web.msm.MemcachedBackupSessionManager

class CddBaseGrailsPlugin {
	// the plugin version
	def groupId = 'com.cdd'
	def version = "0.9-SNAPSHOT"
	// the version or versions of Grails the plugin is designed for
	def grailsVersion = "2.4 > *"
	// resources that are excluded from plugin packaging
	def pluginExcludes = [
		"grails-app/views/error.gsp"
	]

	// TODO Fill in these fields
	def title = "Cdd Base Plugin" // Headline display name of the plugin
	def author = "George Zeng"
	def authorEmail = ""
	def description = '''\
Brief summary/description of the plugin.
'''

	// URL to the plugin's documentation
	def documentation = "http://grails.org/plugin/cdd-base"

	// Extra (optional) plugin metadata

	// License: one of 'APACHE', 'GPL2', 'GPL3'
	//    def license = "APACHE"

	// Details of company behind the plugin (if there is one)
	//    def organization = [ name: "My Company", url: "http://www.my-company.com/" ]

	// Any additional developers beyond the author specified above.
	//    def developers = [ [ name: "Joe Bloggs", email: "joe@bloggs.net" ]]

	// Location of the plugin's issue tracker.
	//    def issueManagement = [ system: "JIRA", url: "http://jira.grails.org/browse/GPMYPLUGIN" ]

	// Online location of the plugin's browseable source code.
	//    def scm = [ url: "http://svn.codehaus.org/grails-plugins/" ]

	def doWithWebDescriptor = { xml ->
		// TODO Implement additions to web.xml (optional), this event occurs before
	}

	def doWithSpring = {

		def conf = application.config.grails.plugin.standalone.tomcat.memcached

//		tomcatSessionManager(MemcachedBackupSessionManager) {
//			enabled = (conf.enabled instanceof Boolean) ? conf.enabled : true
//			enableStatistics = (conf.enableStatistics instanceof Boolean) ? conf.enableStatistics : true
//			sessionBackupAsync = (conf.sessionBackupAsync instanceof Boolean) ? conf.sessionBackupAsync : false
//			sticky = (conf.sticky instanceof Boolean) ? conf.sticky : false
//			memcachedProtocol = conf.memcachedProtocol ?: 'binary'
//
//			if (conf.sessionBackupTimeout instanceof Number) sessionBackupTimeout = conf.sessionBackupTimeout // 100
//			if (conf.operationTimeout instanceof Number) operationTimeout = conf.operationTimeout // 1000
//			if (conf.backupThreadCount instanceof Number) backupThreadCount = conf.backupThreadCount
//			if (conf.copyCollectionsForSerialization instanceof Boolean) copyCollectionsForSerialization = conf.copyCollectionsForSerialization // false
//
//			if (conf.username) username = conf.username
//			if (conf.password) password = conf.password
//			if (conf.failoverNodes) failoverNodes = conf.failoverNodes
//			if (conf.lockingMode) lockingMode = conf.lockingMode
//			if (conf.requestUriIgnorePattern) requestUriIgnorePattern = conf.requestUriIgnorePattern
//			if (conf.sessionAttributeFilter) sessionAttributeFilter = conf.sessionAttributeFilter
//			if (conf.transcoderFactoryClass) transcoderFactoryClass = conf.transcoderFactoryClass
//			if (conf.customConverter) customConverter = conf.customConverter
//
//			// must contain all memcached nodes you have running, or the membase bucket uri(s). It should be the same for all tomcats.
//			// each node is defined as <id>:<host>:<port>. Several definitions are separated by space or comma (e.g. memcachedNodes="n1:app01:11211,n2:app02:11211")
//			// For a single node the <id> is optional so that it's allowed to set only <host>:<port> (e.g. memcachedNodes="localhost:11211")
//			// For usage with membase it's possible to specify one or more membase bucket uris, e.g.
//			//    http://host1:8091/pools,http://host2:8091/pools. Bucket name and password are specified via the attributes username and password
//			//   Connecting to membase buckets requires the binary memcached protocol
//			memcachedNodes = conf.memcachedNodes ?: 'localhost:11211'
//		}

		jsonConverterFactory(JsonConverterFactory) { grailsApplication = ref('grailsApplication') }

		jsonConverter(JsonConverter) { definition ->
			definition.singleton = false
			disableConfigure = org.codehaus.jackson.map.DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES
			enableConfigure = Feature.WRITE_DATES_AS_TIMESTAMPS
			dateFormat = new SimpleDateFormat(CommonConstant.DATE_TIME_MILLI_FORMAT)
		}

		ossClient(OSSClient, "http://${application.config.oss.endpointDomain}/",
				application.config.oss.apikey, application.config.oss.password)
	}

	def doWithDynamicMethods = { ctx ->
		// TODO Implement registering dynamic methods to classes (optional)
	}

	def doWithApplicationContext = { ctx ->
		//		ctx.getBean(RoleVoter).rolePrefix = 'AUTH_'

//		if(!Environment.developmentMode) {
//			def tomcatSessionManager = ctx.tomcatSessionManager
//			if (!tomcatSessionManager) {
//				log.debug "No tomcatSessionManager bean found, not updating the Tomcat session manager"
//				return
//			}
//			
//			def servletContext = ctx.servletContext
//
//			try {
//				if ('org.apache.catalina.core.ApplicationContextFacade'.equals(servletContext.getClass().name)) {
//					def realContext = servletContext.context
//					if ('org.apache.catalina.core.ApplicationContext'.equals(realContext.getClass().name)) {
//						def standardContext = realContext.@context
//						if ('org.apache.catalina.core.StandardContext'.equals(standardContext.getClass().name)) {
//							standardContext.manager = tomcatSessionManager
//							log.info "Set the Tomcat session manager to $tomcatSessionManager"
//						}
//						else {
//							log.warn "Not updating the Tomcat session manager, the context isn't an instance of org.apache.catalina.core.StandardContext"
//						}
//					}
//					else {
//						log.warn "Not updating the Tomcat session manager, the wrapped servlet context isn't an instance of org.apache.catalina.core.ApplicationContext"
//					}
//				}
//				else {
//					log.warn "Not updating the Tomcat session manager, the servlet context isn't an instance of org.apache.catalina.core.ApplicationContextFacade"
//				}
//			}
//			catch (Throwable e) {
//				log.error "There was a problem changing the Tomcat session manager: $e.message", e
//			}
//		}

		// update database
		def list = ctx.getBeansOfType(AbstractDatabaseUpdator)
		list.sort({ a, b ->
			int value = a.value.moduleOrder <=> b.value.moduleOrder
			if(value == 0) {
				value = a.value.order <=> b.value.order
			}
			return value
		}).each { key, bean ->
			bean.update()
		}

	}

	def onChange = { event ->
		// TODO Implement code that is executed when any artefact that this plugin is
		// watching is modified and reloaded. The event contains: event.source,
		// event.application, event.manager, event.ctx, and event.plugin.
	}

	def onConfigChange = { event ->
		// TODO Implement code that is executed when the project configuration changes.
		// The event is the same as for 'onChange'.
	}

	def onShutdown = { event ->
		// TODO Implement code that is executed when the application shuts down (optional)
	}
}
