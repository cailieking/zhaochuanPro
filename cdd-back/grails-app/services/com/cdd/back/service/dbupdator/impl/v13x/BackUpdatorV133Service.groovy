package com.cdd.back.service.dbupdator.impl.v13x

import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV133Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []
		
		sqls  << """

			alter table article_information add news_url varchar(128) default null,add issue_date datetime default NULL

		"""
		
		sqls << """

			update article_information SET issue_date = date_created WHERE issue_date IS NULL
			
		"""
		return sqls
	}

	MenuHelper menuHelper

	@Override
	def updateData() {
		def systemUser = User.SYSTEM.username
		
		[
			[url: '/news/*.html', description: 'template', authority: 'permitAll'],
			[url: '/article/viewArticle', description: '查看文章', authority: "permitAll"]
		].each { params ->
			params.createBy = systemUser
			params.updateBy = systemUser
			Requestmap map = new Requestmap(params)
			map.save()
		}
		return null
		
	}
	@Override
	public int getOrder() {
		return 133;
	}
}
