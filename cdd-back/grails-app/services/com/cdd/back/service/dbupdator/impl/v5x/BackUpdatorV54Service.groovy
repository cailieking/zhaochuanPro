package com.cdd.back.service.dbupdator.impl.v5x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.AdvCorporation
import com.cdd.base.domain.ArticleInformation
import com.cdd.base.domain.ImageInformation
import com.cdd.base.service.OssService

class BackUpdatorV54Service extends AbstractBackDatabaseUpdator {

	@Override
	def updateSchema() {
		return null
	}

	OssService ossService

	def grailsApplication

	@Override
	def updateData() {
		[
			[clazz: ImageInformation, path: 'files/adv/imageInfo/'],
			[clazz: AdvCorporation, path: 'files/adv/corporation/'],
			[clazz: ArticleInformation, path: 'files/adv/article/'],
		].each { map ->
			map.clazz.all.each { data ->
				if(data.image) {
					try {
						String fileName = URLEncoder.encode(data.image.replace(map.path, ""), "UTF-8")
						ossService.uploadFile(new FileInputStream("${grailsApplication.config.appInfo.rootPath}${data.image}"),
								grailsApplication.config.oss.publicbucket, data.image)
						data.image = map.path + fileName
						data.save()
					} catch(e) {
					}
				}
			}
		}
		return null
	}


	@Override
	public int getOrder() {
		return 54
	}
}
