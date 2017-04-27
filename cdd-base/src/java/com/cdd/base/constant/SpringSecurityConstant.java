package com.cdd.base.constant;

public interface SpringSecurityConstant {
	String DEFAULT_ENTRY_POINT_URI = "/entry/";
	String DEFAULT_LOGIN_URI = "/login/";
	String DEFAULT_LOGIN_FORM_AUTH_URI = "/j_spring_security_check";
	String DEFAULT_LOGOUT_URI = "/logout/";
	String DEFAULT_ERROR_URI = "/errors/";

	String ATTR_NAME_SESSIONID = "sid";
	
	String AUTH_PERMIT_ALL = "permitAll";
	String AUTH_USER = "AUTH_USER";
	String AUTH_USER_ADMIN = "AUTH_USER_ADMIN";
	String AUTH_ALL = "AUTH_ALL";

	String HTTP_METHOD_ANY = "ANY";
	String HTTP_METHOD_POST = "POST";
	String HTTP_METHOD_GET = "GET";
	String HTTP_METHOD_PUT = "PUT";
	String HTTP_METHOD_DELETE = "DELETE";

}
