import java.text.SimpleDateFormat

import org.codehaus.jackson.map.SerializationConfig.Feature

import com.cdd.back.security.authentication.AuthenticationSuccessEventHandler
import com.cdd.back.security.authentication.UserDetailsProvider
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.CommonConstant
import com.cdd.base.json.JsonConverter
import com.cdd.base.json.JsonConverterFactory

// Place your Spring DSL code here
beans = {
	authenticationSuccessEventHandler(AuthenticationSuccessEventHandler)

	detailsAuthenticationProvider(UserDetailsProvider) { springSecurityService = ref('springSecurityService') }

	jsonConverterFactory(JsonConverterFactory) { grailsApplication = ref('grailsApplication') }

	jsonConverter(JsonConverter) { definition ->
		definition.singleton = false
		disableConfigure = org.codehaus.jackson.map.DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES
		enableConfigure = Feature.WRITE_DATES_AS_TIMESTAMPS
		dateFormat = new SimpleDateFormat(CommonConstant.DATE_TIME_MILLI_FORMAT)
	}

	menuHelper(MenuHelper)
	
}
