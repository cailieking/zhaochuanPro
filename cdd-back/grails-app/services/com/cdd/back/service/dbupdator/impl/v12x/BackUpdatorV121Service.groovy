package com.cdd.back.service.dbupdator.impl.v12x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User
import com.cdd.base.domain.JobTitle
import com.cdd.base.constant.SpringSecurityConstant
class BackUpdatorV121Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		sqls << """
			ALTER TABLE `inquiry_offer_price` add column `final_reason` varchar(500)  default NULL
		
		"""
		
		
		return sqls
	}

	@Override
		def updateData() {
			def systemUser = User.SYSTEM.username
			
			
			
			[
				[url: '/inquiryOfferPrice/saveInquiry/**', description: '保存询盘', authority: "AUTH_INQUIRYOFFERPRICE_SAVEINQUIRY"],
				[url: '/inquiryOfferPrice/getShow/**', description: '获取询盘show', authority: "AUTH_INQUIRYOFFERPRICE_GETSHOW"],
				[url: '/inquiryOfferPrice/getDetails/**', description: '获取详情', authority: "AUTH_INQUIRYOFFERPRICE_GETDETAILS"],
				[url: '/inquiryOfferPrice/updateInquiry/**', description: '补充询盘', authority: "AUTH_INQUIRYOFFERPRICE_UPDATEINQUIRY"],
				[url: '/inquiryOfferPrice/finishInquiry/**', description: '终止', authority: "AUTH_INQUIRYOFFERPRICE_FINISHINQUIRY"],
				[url: '/inquiryOfferPrice/offerPriceSave/**', description: '应价保存', authority: "AUTH_INQUIRYOFFERPRICE_OFFERPRICESAVE"],
				[url: '/inquiryOfferPrice/getBusinessList/**', description: '获取商务列表', authority: "AUTH_INQUIRYOFFERPRICE_GETBUSINESSLIST"],
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
		return 121
	}
}