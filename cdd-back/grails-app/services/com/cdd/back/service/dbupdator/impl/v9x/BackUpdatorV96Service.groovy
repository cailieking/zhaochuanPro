package com.cdd.back.service.dbupdator.impl.v9x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.back.util.MenuHelper
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.User

class BackUpdatorV96Service extends AbstractBackDatabaseUpdator {

	MenuHelper menuHelper
	@Override
	def updateSchema() {
		def sqls = []
		
		
		sqls << """

			ALTER TABLE new_route ADD COLUMN route_english_name  VARCHAR(255)  default null after route_name

		"""
			
		sqls << """

			UPDATE  new_route SET route_english_name = 'YingBa'  where  route_name = '中东印巴红海线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'ZhongNanMei'  where  route_name = '中美加勒比海墨西哥线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'OuDi'  where  route_name = '欧洲线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'FeiZhou'  where  route_name = '非洲线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'NanMei'  where  route_name = '南美线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'YingBa'  where  route_name = '中东印巴红海线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'AoXin'  where  route_name = '澳新太平洋群岛线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'MeiJia'  where  route_name = '北美线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'ZhYa'  where  route_name = '中亚俄罗斯线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'DiZh'  where  route_name = '地中海黑海线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'DongNanYa'  where  route_name = '东南亚日韩台湾线'

		"""
		
		sqls << """

			UPDATE  new_route SET route_english_name = 'Other'  where  route_name = '其他'

		"""
		
		sqls << """

			UPDATE  recommended_route SET category = 'DongNanYa'  where  category = 'YuanDong'

		"""
		return sqls
	}

	@Override
	def updateData() {
		
		return null
	}

	@Override
	public int getOrder() {
		return 96
	}
}