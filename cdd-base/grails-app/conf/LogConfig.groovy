import net.logstash.log4j.JSONEventLayoutV1

import org.apache.log4j.DailyRollingFileAppender
import org.apache.log4j.Level


grails.logging.jul.usebridge = false

def enableLogginBridge = {
	grails.logging.jul.usebridge = true
}

environments {
	development enableLogginBridge
	test enableLogginBridge
}

def layoutPattern = [conversionPattern:'%d [%t] %-5p %c{2}:%L %x - %m%n']

def developmentLogSetting = {
	appenders {
		console name: 'stdout', layout: pattern(layoutPattern)
	}
	
	warn  'com',
				'org',
				'net',
				'de'      

	debug 'groovy.util.GroovyTestCase',
			'com.cdd',
			'grails.app'

}

def productionLogSetting = {
	def appName = this.appInfo.name
	def logHome = this.logInfo.rootdir // root location of logs
	def datePattern = "'.'yyyy-MM-dd"
		
	appender new DailyRollingFileAppender(
			name: 'logstash',
			datePattern: datePattern,  
			fileName: "${logHome}/${appName}/logstash/logstash.log",
			threshold: Level.INFO,
			layout: new JSONEventLayoutV1()
	)
	
	appender new DailyRollingFileAppender(
			name: 'detail',
			datePattern: datePattern,
			fileName: "${logHome}/${appName}/detail/detail.log",
			threshold: Level.INFO,
			layout: pattern(layoutPattern)
	)
	
	root {
		info 'detail', 'logstash'
	}
	
}

// log4j configuration
log4j.main = {
	environments {
		development developmentLogSetting
		test developmentLogSetting
		uat productionLogSetting
		production productionLogSetting
	}
}