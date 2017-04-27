
import grails.test.mixin.*
import spock.lang.Specification

import com.cdd.base.domain.FrontUser
import com.cdd.front.constant.Constant
import com.cdd.front.controller.RegisterController
import com.google.code.kaptcha.Constants

@TestFor(RegisterController)
@Mock(FrontUser)
class RegisterControllerSpec extends Specification {
	def 'test goStep2 when mobile is wrong format'() {
		when:
		params.mobile = 'sdf' 
		controller.goStep2()
		
		then:
		assert response.json.status == RegisterController.STATUS_MOBILE_FORMAT_ERROR
		
		when:
		params.mobile = '123' 
		controller.goStep2()
			
		then:
		assert response.json.status == RegisterController.STATUS_MOBILE_FORMAT_ERROR
		
	}
	
	def 'test goStep2 when success'() {
		when:
		params.mobile = '12333556644'
		params.image = 'test'
		params.code = '1111'
		session[Constants.KAPTCHA_SESSION_KEY] = 'test'
		session[Constant.SESSION_SMS_CODE] = '1111'
		controller.goStep2()
		
		then:
		assert response.json.status == Constant.STATUS_SUCCESS
	}
}
