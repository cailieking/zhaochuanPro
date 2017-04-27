package com.cdd.base.domain

import com.cdd.base.enums.RouteCategory
import com.cdd.base.enums.RouteType

class RecommendedRoute extends BaseDomain {
	String category
	
	static belongsTo = [user: FrontUser]

	static mapping = { table 'recommended_route' }

	static constraints = {
		category nullable: true
		user nullable: false
	}
}
