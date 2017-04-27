package com.cdd.front.service.dbupdator.impl.v0x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV5Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """insert into city(name, pcode, code) values("北京", 0, 110000);"""
		sqls << """insert into city(name, pcode, code) values("安徽", 0, 340000);"""
		sqls << """insert into city(name, pcode, code) values("福建", 0, 350000);"""
		sqls << """insert into city(name, pcode, code) values("广东", 0, 440000);"""
		sqls << """insert into city(name, pcode, code) values("广西", 0, 450000);"""
		sqls << """insert into city(name, pcode, code) values("重庆", 0, 500000);"""
		sqls << """insert into city(name, pcode, code) values("贵州", 0, 520000);"""
		sqls << """insert into city(name, pcode, code) values("甘肃", 0, 620000);"""
		sqls << """insert into city(name, pcode, code) values("澳门", 0, 820000);"""
		
		sqls << """insert into city(name, pcode, code) values("河北", 0, 130000);"""
		sqls << """insert into city(name, pcode, code) values("吉林", 0, 220000);"""
		sqls << """insert into city(name, pcode, code) values("黑龙江", 0, 230000);"""
		sqls << """insert into city(name, pcode, code) values("江苏", 0, 320000);"""
		sqls << """insert into city(name, pcode, code) values("江西", 0, 360000);"""
		sqls << """insert into city(name, pcode, code) values("河南", 0, 410000);"""
		sqls << """insert into city(name, pcode, code) values("湖北", 0, 420000);"""
		sqls << """insert into city(name, pcode, code) values("湖南", 0, 430000);"""
		sqls << """insert into city(name, pcode, code) values("海南", 0, 460000);"""
		
		sqls << """insert into city(name, pcode, code) values("山西", 0, 140000);"""
		sqls << """insert into city(name, pcode, code) values("内蒙古", 0, 150000);"""
		sqls << """insert into city(name, pcode, code) values("辽宁", 0, 210000);"""
		sqls << """insert into city(name, pcode, code) values("上海", 0, 310000);"""
		sqls << """insert into city(name, pcode, code) values("山东", 0, 370000);"""
		sqls << """insert into city(name, pcode, code) values("四川", 0, 510000);"""
		sqls << """insert into city(name, pcode, code) values("陕西", 0, 610000);"""
		sqls << """insert into city(name, pcode, code) values("青海", 0, 630000);"""
		sqls << """insert into city(name, pcode, code) values("宁夏", 0, 640000);"""
		
		sqls << """insert into city(name, pcode, code) values("天津", 0, 120000);"""
		sqls << """insert into city(name, pcode, code) values("浙江", 0, 330000);"""
		sqls << """insert into city(name, pcode, code) values("云南", 0, 530000);"""
		sqls << """insert into city(name, pcode, code) values("西藏", 0, 540000);"""
		sqls << """insert into city(name, pcode, code) values("新疆", 0, 650000);"""
		sqls << """insert into city(name, pcode, code) values("香港", 0, 810000);"""
		
		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 5;
	}
}
