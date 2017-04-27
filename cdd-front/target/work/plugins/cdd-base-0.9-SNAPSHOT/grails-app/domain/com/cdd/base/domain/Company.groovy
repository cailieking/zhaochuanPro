package com.cdd.base.domain

import com.cdd.base.enums.AgentType

/***
 * this is a huodai class
 * recommanded route  is in the front user
 * @author duo
 *
 */
class Company extends BaseDomain{
				String companyName;   		//公司名称+
				
				String  englishName          //英文名称
				String advancedRoute         //优势航线
				
				String address;          	//公司地址+
				String city;             	//公司所在地址+
				String specialService; 		//	特色服务（服务内容）specialService;+
				boolean verified;			//认证公司+
				boolean honest;			//认证公司+
				boolean safety;			//认证公司+
				String introduce			//	公司简介 introduce【2000个字】
				String workers					//	公司规模（人） workers
				String    scale				//	业务规模（T） scale
				String website				//	公司网址  website
				String	mailbox				//	邮箱  mailbox
				String    telephone			//	联系人：联系电话 telephone
				String 	businessRange		//	业务范围  businessRange
				AgentType type			  		//	类型（船东、一级货代 、二级货代、中小货代）
				String priceInfo				//	运价情况  price
				String remark		  		//	备注，remark
		        String   bulidTime			//	成立时间bulidTime(如：1991)
			    String   regCapital			//	注册资本regCapital(万)
				String businessLicenseNum   //营业执照ID
				String businessLicenseImg	//营业执照图片
				String taxImg				//税务登记证
				String companyCodeImg		//企业代码证
				static hasMany=[frontUser :FrontUser]
				static mapping = { table 'company' }
	    static constraints = {
		companyName nullable: false, blank: false, unique: true, maxSize: 255
		city nullable: false
		address nullable: false, blank: false, unique: false, maxSize: 500
		specialService nullable: true, blank: false, unique: false, maxSize: 255
		frontUser nullable: true
		introduce nullable: true, blank: false, unique: false, maxSize: 2000
		workers nullable: true, blank: false, unique: false, maxSize: 50
		scale nullable: true, blank: false, unique: false, maxSize: 50
		website nullable: true, blank: false, unique: false, maxSize: 50
		scale nullable: true, blank: false, unique: false, maxSize:50
		mailbox nullable: true, blank: false, unique: false, maxSize: 50
		telephone nullable: true, blank: false, unique: false, maxSize: 50
		businessRange nullable: true, blank: false, unique: false, maxSize: 255
		type nullable: false
		priceInfo nullable: true, blank: false, unique: false, maxSize: 255
		remark nullable: true, blank: false, unique: false, maxSize: 255
		bulidTime nullable: true, blank: false, unique: false, maxSize: 255
		regCapital nullable: true, blank: false, unique: false, maxSize: 255
		englishName nullable: true, blank: false, unique: true, maxSize: 255
		advancedRoute nullable: true, blank: false, unique: false, maxSize: 255
		businessLicenseNum nullable:true,maxSize:50
		businessLicenseImg nullable:true,maxSize:500
		taxImg nullable:true,maxSize:500
		companyCodeImg nullable:true,maxSize:500
	}
}
