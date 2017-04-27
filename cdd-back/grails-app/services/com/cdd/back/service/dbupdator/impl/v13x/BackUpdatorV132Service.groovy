package com.cdd.back.service.dbupdator.impl.v13x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV132Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		sqls << """
			alter table article_information add  read_count bigint(16) NOT NULL DEFAULT 0, add to_share varchar(16) COLLATE utf8_bin DEFAULT NULL,
		
			add `article_state` VARCHAR(16) COLLATE utf8_bin DEFAULT NULL, add  `article_category` VARCHAR(16) COLLATE utf8_bin DEFAULT NULL, add  `tweet_title`

			varchar(32) COLLATE utf8_bin DEFAULT NULL, add  `article_summary` varchar(252) COLLATE utf8_bin DEFAULT NULL, add source_url varchar(252) COLLATE utf8_bin DEFAULT NULL,

			add `head_title` varchar(32) COLLATE utf8_bin DEFAULT NULL, add `key_words` varchar(32) COLLATE utf8_bin DEFAULT NULL, add `page_tag` varchar(252) COLLATE utf8_bin DEFAULT NULL,
		
			add description varchar(512) COLLATE utf8_bin DEFAULT NULL, add `article_imgs` varchar(2048) COLLATE utf8_bin DEFAULT NULL

			
	   """

		sqls << """
			update article_information set article_state = 'Issue' where article_state is null
		"""	
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			[
				[url: '/article/listArticles/**', description: '查看文章', authority: "AUTH_LIST_ARTICLES"],
				[url: '/article/execute/**', description: '上传图片', authority: "AUTH_EXECUTE_IMG"],
				[url: '/article/updateCategory/**', description: '更新特推，置顶状态', authority: "AUTH_UPDATE_CATEGORY"],
				[url: '/article/updateState/**', description: '更新发布状态', authority: "AUTH_UPDATE_STATE"],
				[url: '/article/ossDomains/**', description: '获取图片地址', authority: "AUTH_GET_IMG"],
				[url: '/article/showDetails/**', description: '文章详情', authority: "AUTH_SHOW_DETAILS"],
				[url: '/article/delImg/**', description: '删除图片', authority: "AUTH_DEL_IMG"],
//				[url: '/departmentPrice/listPrice/**', description: '查看部门应价', authority: "AUTH_LIST_DEPARTMENT_PRICES"],
//				[url: '/departmentInquiry/detailInquiry/**', description: '查看部门询盘详情', authority: "AUTH_DETAIL_DEPARTMENT_INQUIRY"],
//				[url: '/departmentPrice/detailPrice/**', description: '查看部门应价详情', authority: "AUTH_DETAIL_DEPARTMENT_PRICE"],
//				[url: '/historyInquiry/listInquirys/**', description: '查看历史询盘', authority: "AUTH_LIST_HISTORY_INQUIRYS"],
//				[url: '/historyPrice/listPrice/**', description: '查看历史应价', authority: "AUTH_LIST_HISTORY_PRICES"],
//				[url: '/historyInquiry/detailInquiry/**', description: '查看历史询盘详情', authority: "AUTH_DETAIL_HISTORY_INQUIRY"],
//				[url: '/historyPrice/detailPrice/**', description: '查看历史应价详情', authority: "AUTH_DETAIL_HISTORY_PRICE"],
//				[url: '/allInquiry/listInquirys/**', description: '查看全部询盘', authority: "AUTH_LIST_ALL_INQUIRYS"],
//				[url: '/allPrice/listPrice/**', description: '查看全部应价', authority: "AUTH_LIST_ALL_PRICES"],
//				[url: '/allInquiry/detailInquiry/**', description: '查看全部询盘详情', authority: "AUTH_DETAIL_ALL_INQUIRY"],
//				[url: '/allPrice/detailPrice/**', description: '查看全部应价详情', authority: "AUTH_DETAIL_ALL_PRICE"],
				
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
		return 132
	}
}