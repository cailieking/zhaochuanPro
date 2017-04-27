package com.cdd.back.service.dbupdator.impl.v10x

import com.cdd.back.service.dbupdator.AbstractBackDatabaseUpdator
import com.cdd.base.domain.Menu
import com.cdd.base.domain.Requestmap
import com.cdd.base.domain.Role
import com.cdd.base.domain.RoleAuthority
import com.cdd.back.util.MenuHelper
import com.cdd.base.constant.SpringSecurityConstant
import com.cdd.base.domain.User

class BackUpdatorV103Service extends AbstractBackDatabaseUpdator {
	@Override
	public Object updateSchema() {
		// TODO Auto-generated method stub
		return null;
	}
	MenuHelper menuHelper
	@Override
	public Object updateData() {
		def systemUser = User.SYSTEM.username
		
			Menu menu_system = Menu.findByName('运价管理')
		
			menuHelper.createMenu([authority: 'AUTH_TARIFFMANAGER_LIST',
				url: '/tariffManager/list/**',
				description: '运价维护'],
			[name: '运价维护', icon: 'file-text-o'], menu_system)
				
			[
				[url: '/tariffManager/batchTenPricingInfo/**', description: '查看批次内10条运价信息', authority: "AUTH_TARIFFMANAGER_BATCHTENPRICINGINFO"],
				[url: '/tariffManager/batchFiftyPricingInfo/**', description: '查看批次内50条运价信息', authority:"AUTH_TARIFFMANAGER_BATCHFIFTYPRICINGINFO"],
				[url: '/tariffManager/batchTwoHundredPricingInfo/**', description:'查看批次内200条运价信息', authority:"AUTH_TARIFFMANAGER_BATCHTWOHUNDREDPRICINGINFO"],
				
				[url: '/tariffManager/batchTwentyTariff/**', description:'查看20条批次运价', authority:"AUTH_TARIFFMANAGER_BATCHTWENTYTARIFF"],
				[url: '/tariffManager/batchFiftyTariff/**', description: '查看50条批次运价', authority: "AUTH_TARIFFMANAGER_BATCHFIFTYTARIFF"],
				[url: '/tariffManager/batchOneHundredTariff/**', description: '查看100条批次运价', authority:"AUTH_TARIFFMANAGER_BATCHONEHUNDREDTARIFF"],
				[url: '/tariffManager/details/**', description:' 查看运价详情', authority:"AUTH_TARIFFMANAGER_DETAILS"],
				[url: '/tariffManager/edit/**', description:'运价修改', authority:"AUTH_TARIFFMANAGER_EDIT"],
				
				[url: '/tariffmanager/repeal/**', description:'运价撤销 ', authority:"AUTH_TARIFFMANAGER_REPEAL"],
				[url: '/tariffManager/delete/**', description:'运价删除 ', authority:"AUTH_TARIFFMANAGER_DELETE"],
				[url: '/tariffManager/batchDelete/**', description:'运价批量删除', authority:"AUTH_TARIFFMANAGER_BATCHDELETE"],
				[url: '/tariffManager/batchRepeal/**', description:'运价批量撤销', authority:"AUTH_TARIFFMANAGER_BATCHREPEAL"],
				
				[url: '/tariffManager/save/**', description: '运价保存', authority: "AUTH_TARIFFMANAGER_SAVE"],
				
				[url: '/tariffmanager/importData/**', description: '导入运价信息', authority:"AUTH_TARIFFMANAGER_IMPORTDATA"],
				[url: '/tariffManager/downloadExample/**', description: '运价模板下载', authority:"AUTH_TARIFFMANAGER_DOWNLOADEXAMPLE"],
				[url: '/tariffManager/twentyShipInfo/**', description: '查看20条运价信息 ', authority:"AUTH_TARIFFMANAGER_TWENTYSHIPINFO"],
				[url: '/tariffManager/fiftyShipInfo/**', description: '查看50条运价信息', authority:"AUTH_TARIFFMANAGER_FIFTYSHIPINFO"],
				[url: '/tariffManager/oneHundredShipInfo/**', description: '查看100条运价信息', authority:"AUTH_TARIFFMANAGER_ONEHUNDREDSHIPINFO"],
				[url: '/tariffManager/wubaiShipInfo/**', description: '查看500条运价信息', authority:"AUTH_TARIFFMANAGER_WUBAISHIPINFO"],
				[url: '/tariffManager/thousandShipInfo/**', description: '查看1000条运价信息', authority:"AUTH_TARIFFMANAGER_THOUSANDSHIPINFO"],
				[url: '/tariffManager/bactchList/**', description: '查询批次运价信息', authority:"AUTH_TARIFFMANAGER_BACTCHLIST"],
				[url: '/tariffManager/add/**', description: '批次管理添加', authority: "AUTH_TARIFFMANAGER_ADD"],
				[url: '/tariffManager/bactchSave/**', description: '批次管理保存', authority: "AUTH_TARIFFMANAGER_BACTCHSAVE"],
				[url: '/tariffManager/bactchEdit/**', description: '批次管理修改', authority:"AUTH_DEMANDCLASS_BACTCHEDIT"],
				[url: '/tariffManager/bactchDelete/**', description:'批次管理删除', authority:"AUTH_TARIFFMANAGER_BACTCHDELETE"],
				[url: '/tariffManager/bactchRepeal/**', description:'批次管理撤销', authority:"AUTH_TARIFFMANAGER_BACTCHREPEAL"],
				[url: '/tariffManager/recordAdd/**', description: '记录管理运价添加', authority: "AUTH_TARIFFMANAGER_CECORADD"],
				
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
		// TODO Auto-generated method stub
		return 103;
	}

}
