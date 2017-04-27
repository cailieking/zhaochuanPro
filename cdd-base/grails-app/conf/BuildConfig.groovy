grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"

grails.project.fork = [
	// configure settings for compilation JVM, note that if you alter the Groovy version forked compilation is required
	//  compile: [maxMemory: 256, minMemory: 64, debug: false, maxPerm: 256, daemon:true],

	// configure settings for the test-app JVM, uses the daemon by default
	test: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, daemon:true],
	// configure settings for the run-app JVM
	run: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
	// configure settings for the run-war JVM
	war: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256, forkReserve:false],
	// configure settings for the Console UI JVM
	console: [maxMemory: 768, minMemory: 64, debug: false, maxPerm: 256]
]


grails {
	project {
		repos {
			plugins {
				url = 'http://112.74.81.179:8082/nexus/content/repositories/snapshots/'
				username = 'deployment'
				password = 'admin1314'
			}
		}
	}
}
grails.project.repos.default = "plugins"

grails.project.dependency.resolver = "maven" // or ivy
grails.project.dependency.resolution = {
	// inherit Grails' default dependencies
	inherits("global") {
		// uncomment to disable ehcache
		// excludes 'ehcache'
	}
	log "warn" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
	repositories {
		grailsCentral()
		mavenLocal()
		mavenCentral()
		// uncomment the below to enable remote dependency resolution
		// from public Maven repositories
		//mavenRepo "http://repository.codehaus.org"
		//mavenRepo "http://download.java.net/maven/2/"
		//mavenRepo "http://repository.jboss.com/maven2/"
		mavenRepo (url: "http://112.74.81.179:8082/nexus/content/repositories/thirdparty/") {
			auth username: "admin", password: "admin1314"
		}
		mavenRepo "http://files.couchbase.com/maven2/"
	}
	dependencies {
		// specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
		runtime 'mysql:mysql-connector-java:5.1.29'
		compile 'net.logstash.log4j:jsonevent-layout:1.6'
		compile 'net.sf.ehcache:ehcache:2.9.0'
		compile 'org.codehaus.jackson:jackson-mapper-asl:1.9.13'
		compile 'org.codehaus.jackson:jackson-mapper-asl:1.9.13'
		compile 'com.aliyun:oss-sdk:2.0.5'
		compile 'commons-codec:commons-codec:1.9'
		compile 'commons-logging:commons-logging:1.2'
		compile 'org.hamcrest:hamcrest-core:1.1'
		compile 'org.apache.httpcomponents:httpclient:4.4.1'
		compile 'org.apache.httpcomponents:httpcore:4.4.1'
		compile 'net.sourceforge.jexcelapi:jxl:2.6.12'
		compile 'jdom:jdom:1.1'
		compile 'org.freemarker:freemarker:2.3.18'
//		compile 'de.javakaffee.msm:memcached-session-manager:1.8.3'
//		compile 'de.javakaffee.msm:memcached-session-manager-tc7:1.8.3'
//		compile 'net.spy:spymemcached:2.12.0'
//		compile 'de.javakaffee.msm:msm-kryo-serializer:1.8.0'
//		compile 'de.javakaffee:kryo-serializers:0.11'
//		compile 'com.googlecode:kryo:1.04'
//		compile 'com.googlecode:minlog:1.2'
//		compile 'com.googlecode:reflectasm:1.01'
//		compile 'asm:asm:3.2'
	}

	plugins {
		build(":release:3.0.1",
				":rest-client-builder:1.0.3") { export = false }
		build ":tomcat:7.0.55"
		compile ":hibernate4:4.3.5.5"
		compile ":spring-security-core:2.0-RC4"
		compile ":less-asset-pipeline:2.1.0"
		compile ":mail:1.0.7"
		compile ':quartz:1.0.2'

		runtime ":twitter-bootstrap:3.3.1"
		runtime ":jquery:1.11.1"
	}
}
