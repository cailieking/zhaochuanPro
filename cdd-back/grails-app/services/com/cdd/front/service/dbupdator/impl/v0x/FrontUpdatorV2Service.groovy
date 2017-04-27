package com.cdd.front.service.dbupdator.impl.v0x

import com.cdd.front.service.dbupdator.AbstractFrontDatabaseUpdator



class FrontUpdatorV2Service extends AbstractFrontDatabaseUpdator {

	@Override
	def updateSchema() {
		def sqls = []

		sqls << """
			CREATE TABLE `city` (
			  `id` bigint(20) NOT NULL AUTO_INCREMENT,
			  `pcode` int(6) NOT NULL,
			  `code` int(6) NOT NULL,
			  `name` varchar(10) DEFAULT NULL,
			  PRIMARY KEY (`id`),
			  UNIQUE KEY `pcode_code` (`pcode`,`code`)
			) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
			"""
		sqls << """insert into city(code, pcode, name) values(110100,110000,'北京');"""

		sqls << """insert into city(code, pcode, name) values(340100,340000,'合肥');"""
		sqls << """insert into city(code, pcode, name) values(340200,340000,'芜湖');"""
		sqls << """insert into city(code, pcode, name) values(340300,340000,'蚌埠');"""
		sqls << """insert into city(code, pcode, name) values(340400,340000,'淮南');"""
		sqls << """insert into city(code, pcode, name) values(340500,340000,'马鞍山');"""
		sqls << """insert into city(code, pcode, name) values(340600,340000,'淮北');"""
		sqls << """insert into city(code, pcode, name) values(340700,340000,'铜陵');"""
		sqls << """insert into city(code, pcode, name) values(340800,340000,'安庆');"""
		sqls << """insert into city(code, pcode, name) values(341000,340000,'黄山');"""
		sqls << """insert into city(code, pcode, name) values(341100,340000,'滁州');"""
		sqls << """insert into city(code, pcode, name) values(341200,340000,'阜阳');"""
		sqls << """insert into city(code, pcode, name) values(341300,340000,'宿州');"""
		sqls << """insert into city(code, pcode, name) values(341500,340000,'六安');"""
		sqls << """insert into city(code, pcode, name) values(341600,340000,'亳州');"""
		sqls << """insert into city(code, pcode, name) values(341700,340000,'池州');"""
		sqls << """insert into city(code, pcode, name) values(341800,340000,'宣城');"""
		sqls << """insert into city(code, pcode, name) values(350100,350000,'福州');"""
		sqls << """insert into city(code, pcode, name) values(350200,350000,'厦门');"""
		sqls << """insert into city(code, pcode, name) values(350300,350000,'莆田');"""
		sqls << """insert into city(code, pcode, name) values(350400,350000,'三明');"""
		sqls << """insert into city(code, pcode, name) values(350500,350000,'泉州');"""
		sqls << """insert into city(code, pcode, name) values(350600,350000,'漳州');"""
		sqls << """insert into city(code, pcode, name) values(350700,350000,'南平');"""
		sqls << """insert into city(code, pcode, name) values(350800,350000,'龙岩');"""
		sqls << """insert into city(code, pcode, name) values(350900,350000,'宁德');"""
		sqls << """insert into city(code, pcode, name) values(440100,440000,'广州');"""
		sqls << """insert into city(code, pcode, name) values(440200,440000,'韶关');"""
		sqls << """insert into city(code, pcode, name) values(440300,440000,'深圳');"""
		sqls << """insert into city(code, pcode, name) values(440400,440000,'珠海');"""
		sqls << """insert into city(code, pcode, name) values(440500,440000,'汕头');"""
		sqls << """insert into city(code, pcode, name) values(440600,440000,'佛山');"""
		sqls << """insert into city(code, pcode, name) values(440700,440000,'江门');"""
		sqls << """insert into city(code, pcode, name) values(440800,440000,'湛江');"""
		sqls << """insert into city(code, pcode, name) values(440900,440000,'茂名');"""
		sqls << """insert into city(code, pcode, name) values(441200,440000,'肇庆');"""
		sqls << """insert into city(code, pcode, name) values(441300,440000,'惠州');"""
		sqls << """insert into city(code, pcode, name) values(441400,440000,'梅州');"""
		sqls << """insert into city(code, pcode, name) values(441500,440000,'汕尾');"""
		sqls << """insert into city(code, pcode, name) values(441600,440000,'河源');"""
		sqls << """insert into city(code, pcode, name) values(441700,440000,'阳江');"""
		sqls << """insert into city(code, pcode, name) values(441800,440000,'清远');"""
		sqls << """insert into city(code, pcode, name) values(441900,440000,'东莞');"""
		sqls << """insert into city(code, pcode, name) values(442000,440000,'中山');"""
		sqls << """insert into city(code, pcode, name) values(445100,440000,'潮州');"""
		sqls << """insert into city(code, pcode, name) values(445200,440000,'揭阳');"""
		sqls << """insert into city(code, pcode, name) values(445300,440000,'云浮');"""
		sqls << """insert into city(code, pcode, name) values(44060011,440000,'乐从');"""


		sqls << """insert into city(code, pcode, name) values(450100,450000,'南宁');"""
		sqls << """insert into city(code, pcode, name) values(450200,450000,'柳州');"""
		sqls << """insert into city(code, pcode, name) values(450300,450000,'桂林');"""
		sqls << """insert into city(code, pcode, name) values(450400,450000,'梧州');"""
		sqls << """insert into city(code, pcode, name) values(450500,450000,'北海');"""
		sqls << """insert into city(code, pcode, name) values(450600,450000,'防城港');"""
		sqls << """insert into city(code, pcode, name) values(450700,450000,'钦州');"""
		sqls << """insert into city(code, pcode, name) values(450800,450000,'贵港');"""
		sqls << """insert into city(code, pcode, name) values(450900,450000,'玉林');"""
		sqls << """insert into city(code, pcode, name) values(451000,450000,'百色');"""
		sqls << """insert into city(code, pcode, name) values(451100,450000,'贺州');"""
		sqls << """insert into city(code, pcode, name) values(451200,450000,'河池');"""
		sqls << """insert into city(code, pcode, name) values(451300,450000,'来宾');"""
		sqls << """insert into city(code, pcode, name) values(451400,450000,'崇左');"""


		sqls << """insert into city(code, pcode, name) values(500100,500000,'重庆');"""


		sqls << """insert into city(code, pcode, name) values(520100,520000,'贵阳');"""
		sqls << """insert into city(code, pcode, name) values(520200,520000,'六盘水');"""
		sqls << """insert into city(code, pcode, name) values(520300,520000,'遵义');"""
		sqls << """insert into city(code, pcode, name) values(520400,520000,'安顺');"""
		sqls << """insert into city(code, pcode, name) values(520500,520000,'毕节');"""
		sqls << """insert into city(code, pcode, name) values(520600,520000,'铜仁');"""
		sqls << """insert into city(code, pcode, name) values(522300,520000,'黔西南');"""
		sqls << """insert into city(code, pcode, name) values(522600,520000,'黔东南');"""
		sqls << """insert into city(code, pcode, name) values(522700,520000,'黔南');"""


		sqls << """insert into city(code, pcode, name) values(620100,620000,'兰州');"""
		sqls << """insert into city(code, pcode, name) values(620200,620000,'嘉峪关');"""
		sqls << """insert into city(code, pcode, name) values(620300,620000,'金昌');"""
		sqls << """insert into city(code, pcode, name) values(620400,620000,'白银');"""
		sqls << """insert into city(code, pcode, name) values(620500,620000,'天水');"""
		sqls << """insert into city(code, pcode, name) values(620600,620000,'武威');"""
		sqls << """insert into city(code, pcode, name) values(620700,620000,'张掖');"""
		sqls << """insert into city(code, pcode, name) values(620800,620000,'平凉');"""
		sqls << """insert into city(code, pcode, name) values(620900,620000,'酒泉');"""
		sqls << """insert into city(code, pcode, name) values(621000,620000,'庆阳');"""
		sqls << """insert into city(code, pcode, name) values(621100,620000,'定西');"""
		sqls << """insert into city(code, pcode, name) values(621200,620000,'陇南');"""
		sqls << """insert into city(code, pcode, name) values(622900,620000,'临夏');"""
		sqls << """insert into city(code, pcode, name) values(623000,620000,'甘南');"""


		sqls << """insert into city(code, pcode, name) values(820100,820000,'澳门半岛');"""
		sqls << """insert into city(code, pcode, name) values(820200,820000,'澳门离岛');"""
		sqls << """insert into city(code, pcode, name) values(820300,820000,'无堂划分域');"""



		sqls << """insert into city(code, pcode, name) values(130100,130000,'石家庄');"""
		sqls << """insert into city(code, pcode, name) values(130200,130000,'唐山');"""
		sqls << """insert into city(code, pcode, name) values(130300,130000,'秦皇岛');"""
		sqls << """insert into city(code, pcode, name) values(130400,130000,'邯郸');"""
		sqls << """insert into city(code, pcode, name) values(130500,130000,'邢台');"""
		sqls << """insert into city(code, pcode, name) values(130600,130000,'保定');"""
		sqls << """insert into city(code, pcode, name) values(130700,130000,'张家口');"""
		sqls << """insert into city(code, pcode, name) values(130800,130000,'承德');"""
		sqls << """insert into city(code, pcode, name) values(130900,130000,'沧州');"""
		sqls << """insert into city(code, pcode, name) values(131000,130000,'廊坊');"""
		sqls << """insert into city(code, pcode, name) values(131100,130000,'衡水');"""



		sqls << """insert into city(code, pcode, name) values(220100,220000,'长春');"""
		sqls << """insert into city(code, pcode, name) values(220200,220000,'吉林');"""
		sqls << """insert into city(code, pcode, name) values(220300,220000,'四平');"""
		sqls << """insert into city(code, pcode, name) values(220400,220000,'辽源');"""
		sqls << """insert into city(code, pcode, name) values(220500,220000,'通化');"""
		sqls << """insert into city(code, pcode, name) values(220600,220000,'白山');"""
		sqls << """insert into city(code, pcode, name) values(220700,220000,'松原');"""
		sqls << """insert into city(code, pcode, name) values(220800,220000,'白城');"""
		sqls << """insert into city(code, pcode, name) values(222400,220000,'延边');"""


		sqls << """insert into city(code, pcode, name) values(230100,230000,'哈尔滨');"""
		sqls << """insert into city(code, pcode, name) values(230200,230000,'齐齐哈尔');"""
		sqls << """insert into city(code, pcode, name) values(230300,230000,'鸡西');"""
		sqls << """insert into city(code, pcode, name) values(230400,230000,'鹤岗');"""
		sqls << """insert into city(code, pcode, name) values(230500,230000,'双鸭山');"""
		sqls << """insert into city(code, pcode, name) values(230600,230000,'大庆');"""
		sqls << """insert into city(code, pcode, name) values(230700,230000,'伊春');"""
		sqls << """insert into city(code, pcode, name) values(230800,230000,'佳木斯');"""
		sqls << """insert into city(code, pcode, name) values(230900,230000,'七台河');"""
		sqls << """insert into city(code, pcode, name) values(231000,230000,'牡丹江');"""
		sqls << """insert into city(code, pcode, name) values(231100,230000,'黑河');"""
		sqls << """insert into city(code, pcode, name) values(231200,230000,'绥化');"""
		sqls << """insert into city(code, pcode, name) values(232700,230000,'大兴安岭');"""


		sqls << """insert into city(code, pcode, name) values(320100,320000,'南京');"""
		sqls << """insert into city(code, pcode, name) values(320200,320000,'无锡');"""
		sqls << """insert into city(code, pcode, name) values(320300,320000,'徐州');"""
		sqls << """insert into city(code, pcode, name) values(320400,320000,'常州');"""
		sqls << """insert into city(code, pcode, name) values(320500,320000,'苏州');"""
		sqls << """insert into city(code, pcode, name) values(320600,320000,'南通');"""
		sqls << """insert into city(code, pcode, name) values(320700,320000,'连云港');"""
		sqls << """insert into city(code, pcode, name) values(320800,320000,'淮安');"""
		sqls << """insert into city(code, pcode, name) values(320900,320000,'盐城');"""
		sqls << """insert into city(code, pcode, name) values(321000,320000,'扬州');"""
		sqls << """insert into city(code, pcode, name) values(321100,320000,'镇江');"""
		sqls << """insert into city(code, pcode, name) values(321200,320000,'泰州');"""
		sqls << """insert into city(code, pcode, name) values(321300,320000,'宿迁');"""


		sqls << """insert into city(code, pcode, name) values(360100,360000,'南昌');"""
		sqls << """insert into city(code, pcode, name) values(360200,360000,'景德镇');"""
		sqls << """insert into city(code, pcode, name) values(360300,360000,'萍乡');"""
		sqls << """insert into city(code, pcode, name) values(360400,360000,'九江');"""
		sqls << """insert into city(code, pcode, name) values(360500,360000,'新余');"""
		sqls << """insert into city(code, pcode, name) values(360600,360000,'鹰潭');"""
		sqls << """insert into city(code, pcode, name) values(360700,360000,'赣州');"""
		sqls << """insert into city(code, pcode, name) values(360800,360000,'吉安');"""
		sqls << """insert into city(code, pcode, name) values(360900,360000,'宜春');"""
		sqls << """insert into city(code, pcode, name) values(361000,360000,'抚州');"""
		sqls << """insert into city(code, pcode, name) values(361100,360000,'上饶');"""


		sqls << """insert into city(code, pcode, name) values(410100,410000,'郑州');"""
		sqls << """insert into city(code, pcode, name) values(410200,410000,'开封');"""
		sqls << """insert into city(code, pcode, name) values(410300,410000,'洛阳');"""
		sqls << """insert into city(code, pcode, name) values(410400,410000,'平顶山');"""
		sqls << """insert into city(code, pcode, name) values(410500,410000,'安阳');"""
		sqls << """insert into city(code, pcode, name) values(410600,410000,'鹤壁');"""
		sqls << """insert into city(code, pcode, name) values(410700,410000,'新乡');"""
		sqls << """insert into city(code, pcode, name) values(410800,410000,'焦作');"""
		sqls << """insert into city(code, pcode, name) values(410900,410000,'濮阳');"""
		sqls << """insert into city(code, pcode, name) values(411000,410000,'许昌');"""
		sqls << """insert into city(code, pcode, name) values(411100,410000,'漯河');"""
		sqls << """insert into city(code, pcode, name) values(411200,410000,'三门峡');"""
		sqls << """insert into city(code, pcode, name) values(411300,410000,'南阳');"""
		sqls << """insert into city(code, pcode, name) values(411400,410000,'商丘');"""
		sqls << """insert into city(code, pcode, name) values(411500,410000,'信阳');"""
		sqls << """insert into city(code, pcode, name) values(411600,410000,'周口');"""
		sqls << """insert into city(code, pcode, name) values(411700,410000,'驻马店');"""
		sqls << """insert into city(code, pcode, name) values(419000,410000,'直辖');"""


		sqls << """insert into city(code, pcode, name) values(420100,420000,'武汉');"""
		sqls << """insert into city(code, pcode, name) values(420200,420000,'黄石');"""
		sqls << """insert into city(code, pcode, name) values(420300,420000,'十堰');"""
		sqls << """insert into city(code, pcode, name) values(420500,420000,'宜昌');"""
		sqls << """insert into city(code, pcode, name) values(420600,420000,'襄阳');"""
		sqls << """insert into city(code, pcode, name) values(420700,420000,'鄂州');"""
		sqls << """insert into city(code, pcode, name) values(420800,420000,'荆门');"""
		sqls << """insert into city(code, pcode, name) values(420900,420000,'孝感');"""
		sqls << """insert into city(code, pcode, name) values(421000,420000,'荆州');"""
		sqls << """insert into city(code, pcode, name) values(421100,420000,'黄冈');"""
		sqls << """insert into city(code, pcode, name) values(421200,420000,'咸宁');"""
		sqls << """insert into city(code, pcode, name) values(421300,420000,'随州');"""
		sqls << """insert into city(code, pcode, name) values(422800,420000,'恩施');"""
		sqls << """insert into city(code, pcode, name) values(429000,420000,'直辖');"""


		sqls << """insert into city(code, pcode, name) values(430100,430000,'长沙');"""
		sqls << """insert into city(code, pcode, name) values(430200,430000,'株洲');"""
		sqls << """insert into city(code, pcode, name) values(430300,430000,'湘潭');"""
		sqls << """insert into city(code, pcode, name) values(430400,430000,'衡阳');"""
		sqls << """insert into city(code, pcode, name) values(430500,430000,'邵阳');"""
		sqls << """insert into city(code, pcode, name) values(430600,430000,'岳阳');"""
		sqls << """insert into city(code, pcode, name) values(430700,430000,'常德');"""
		sqls << """insert into city(code, pcode, name) values(430800,430000,'张家界');"""
		sqls << """insert into city(code, pcode, name) values(430900,430000,'益阳');"""
		sqls << """insert into city(code, pcode, name) values(431000,430000,'郴州');"""
		sqls << """insert into city(code, pcode, name) values(431100,430000,'永州');"""
		sqls << """insert into city(code, pcode, name) values(431200,430000,'怀化');"""
		sqls << """insert into city(code, pcode, name) values(431300,430000,'娄底');"""
		sqls << """insert into city(code, pcode, name) values(433100,430000,'湘西');"""


		sqls << """insert into city(code, pcode, name) values(460100,460000,'海口');"""
		sqls << """insert into city(code, pcode, name) values(460200,460000,'三亚');"""
		sqls << """insert into city(code, pcode, name) values(460300,460000,'三沙');"""
		sqls << """insert into city(code, pcode, name) values(469000,460000,'直辖');"""



		sqls << """insert into city(code, pcode, name) values(140100,140000,'太原');"""
		sqls << """insert into city(code, pcode, name) values(140200,140000,'大同');"""
		sqls << """insert into city(code, pcode, name) values(140300,140000,'阳泉');"""
		sqls << """insert into city(code, pcode, name) values(140400,140000,'长治');"""
		sqls << """insert into city(code, pcode, name) values(140500,140000,'晋城');"""
		sqls << """insert into city(code, pcode, name) values(140600,140000,'朔州');"""
		sqls << """insert into city(code, pcode, name) values(140700,140000,'晋中');"""
		sqls << """insert into city(code, pcode, name) values(140800,140000,'运城');"""
		sqls << """insert into city(code, pcode, name) values(140900,140000,'忻州');"""
		sqls << """insert into city(code, pcode, name) values(141000,140000,'临汾');"""
		sqls << """insert into city(code, pcode, name) values(141100,140000,'吕梁');"""


		sqls << """insert into city(code, pcode, name) values(150100,150000,'呼和浩特');"""
		sqls << """insert into city(code, pcode, name) values(150200,150000,'包头');"""
		sqls << """insert into city(code, pcode, name) values(150300,150000,'乌海');"""
		sqls << """insert into city(code, pcode, name) values(150400,150000,'赤峰');"""
		sqls << """insert into city(code, pcode, name) values(150500,150000,'通辽');"""
		sqls << """insert into city(code, pcode, name) values(150600,150000,'鄂尔多斯');"""
		sqls << """insert into city(code, pcode, name) values(150700,150000,'呼伦贝尔');"""
		sqls << """insert into city(code, pcode, name) values(150800,150000,'巴彦淖尔');"""
		sqls << """insert into city(code, pcode, name) values(150900,150000,'乌兰察布');"""
		sqls << """insert into city(code, pcode, name) values(152200,150000,'兴安盟');"""
		sqls << """insert into city(code, pcode, name) values(152500,150000,'锡林郭勒盟');"""
		sqls << """insert into city(code, pcode, name) values(152900,150000,'阿拉善盟');"""


		sqls << """insert into city(code, pcode, name) values(210100,210000,'沈阳');"""
		sqls << """insert into city(code, pcode, name) values(210200,210000,'大连');"""
		sqls << """insert into city(code, pcode, name) values(210300,210000,'鞍山');"""
		sqls << """insert into city(code, pcode, name) values(210400,210000,'抚顺');"""
		sqls << """insert into city(code, pcode, name) values(210500,210000,'本溪');"""
		sqls << """insert into city(code, pcode, name) values(210600,210000,'丹东');"""
		sqls << """insert into city(code, pcode, name) values(210700,210000,'锦州');"""
		sqls << """insert into city(code, pcode, name) values(210800,210000,'营口');"""
		sqls << """insert into city(code, pcode, name) values(210900,210000,'阜新');"""
		sqls << """insert into city(code, pcode, name) values(211000,210000,'辽阳');"""
		sqls << """insert into city(code, pcode, name) values(211100,210000,'盘锦');"""
		sqls << """insert into city(code, pcode, name) values(211200,210000,'铁岭');"""
		sqls << """insert into city(code, pcode, name) values(211300,210000,'朝阳');"""
		sqls << """insert into city(code, pcode, name) values(211400,210000,'葫芦岛');"""


		sqls << """insert into city(code, pcode, name) values(310100,310000,'上海');"""


		sqls << """insert into city(code, pcode, name) values(370100,370000,'济南');"""
		sqls << """insert into city(code, pcode, name) values(370200,370000,'青岛');"""
		sqls << """insert into city(code, pcode, name) values(370300,370000,'淄博');"""
		sqls << """insert into city(code, pcode, name) values(370400,370000,'枣庄');"""
		sqls << """insert into city(code, pcode, name) values(370500,370000,'东营');"""
		sqls << """insert into city(code, pcode, name) values(370600,370000,'烟台');"""
		sqls << """insert into city(code, pcode, name) values(370700,370000,'潍坊');"""
		sqls << """insert into city(code, pcode, name) values(370781,370000,'青州');"""
		sqls << """insert into city(code, pcode, name) values(370800,370000,'济宁');"""
		sqls << """insert into city(code, pcode, name) values(370900,370000,'泰安');"""
		sqls << """insert into city(code, pcode, name) values(371000,370000,'威海');"""
		sqls << """insert into city(code, pcode, name) values(371100,370000,'日照');"""
		sqls << """insert into city(code, pcode, name) values(371200,370000,'莱芜');"""
		sqls << """insert into city(code, pcode, name) values(371300,370000,'临沂');"""
		sqls << """insert into city(code, pcode, name) values(371400,370000,'德州');"""
		sqls << """insert into city(code, pcode, name) values(371500,370000,'聊城');"""
		sqls << """insert into city(code, pcode, name) values(371600,370000,'滨州');"""
		sqls << """insert into city(code, pcode, name) values(371700,370000,'菏泽');"""


		sqls << """insert into city(code, pcode, name) values(510100,510000,'成都');"""
		sqls << """insert into city(code, pcode, name) values(510300,510000,'自贡');"""
		sqls << """insert into city(code, pcode, name) values(510400,510000,'攀枝花');"""
		sqls << """insert into city(code, pcode, name) values(510500,510000,'泸州');"""
		sqls << """insert into city(code, pcode, name) values(510600,510000,'德阳');"""
		sqls << """insert into city(code, pcode, name) values(510700,510000,'绵阳');"""
		sqls << """insert into city(code, pcode, name) values(510800,510000,'广元');"""
		sqls << """insert into city(code, pcode, name) values(510900,510000,'遂宁');"""
		sqls << """insert into city(code, pcode, name) values(511000,510000,'内江');"""
		sqls << """insert into city(code, pcode, name) values(511100,510000,'乐山');"""
		sqls << """insert into city(code, pcode, name) values(511300,510000,'南充');"""
		sqls << """insert into city(code, pcode, name) values(511400,510000,'眉山');"""
		sqls << """insert into city(code, pcode, name) values(511500,510000,'宜宾');"""
		sqls << """insert into city(code, pcode, name) values(511600,510000,'广安');"""
		sqls << """insert into city(code, pcode, name) values(511700,510000,'达州');"""
		sqls << """insert into city(code, pcode, name) values(511800,510000,'雅安');"""
		sqls << """insert into city(code, pcode, name) values(511900,510000,'巴中');"""
		sqls << """insert into city(code, pcode, name) values(512000,510000,'资阳');"""
		sqls << """insert into city(code, pcode, name) values(513200,510000,'阿坝');"""
		sqls << """insert into city(code, pcode, name) values(513300,510000,'甘孜');"""
		sqls << """insert into city(code, pcode, name) values(513400,510000,'凉山');"""


		sqls << """insert into city(code, pcode, name) values(610100,610000,'西安');"""
		sqls << """insert into city(code, pcode, name) values(610200,610000,'铜川');"""
		sqls << """insert into city(code, pcode, name) values(610300,610000,'宝鸡');"""
		sqls << """insert into city(code, pcode, name) values(610400,610000,'咸阳');"""
		sqls << """insert into city(code, pcode, name) values(610500,610000,'渭南');"""
		sqls << """insert into city(code, pcode, name) values(610600,610000,'延安');"""
		sqls << """insert into city(code, pcode, name) values(610700,610000,'汉中');"""
		sqls << """insert into city(code, pcode, name) values(610800,610000,'榆林');"""
		sqls << """insert into city(code, pcode, name) values(610900,610000,'安康');"""
		sqls << """insert into city(code, pcode, name) values(611000,610000,'商洛');"""

		sqls << """insert into city(code, pcode, name) values(630100,630000,'西宁');"""
		sqls << """insert into city(code, pcode, name) values(632100,630000,'海东');"""
		sqls << """insert into city(code, pcode, name) values(632200,630000,'海北');"""
		sqls << """insert into city(code, pcode, name) values(632300,630000,'黄南');"""
		sqls << """insert into city(code, pcode, name) values(632500,630000,'海南');"""
		sqls << """insert into city(code, pcode, name) values(632600,630000,'果洛');"""
		sqls << """insert into city(code, pcode, name) values(632700,630000,'玉树');"""
		sqls << """insert into city(code, pcode, name) values(632800,630000,'海西');"""

		sqls << """insert into city(code, pcode, name) values(640100,640000,'银川');"""
		sqls << """insert into city(code, pcode, name) values(640200,640000,'石嘴山');"""
		sqls << """insert into city(code, pcode, name) values(640300,640000,'吴忠');"""
		sqls << """insert into city(code, pcode, name) values(640400,640000,'固原');"""
		sqls << """insert into city(code, pcode, name) values(640500,640000,'中卫');"""




		sqls << """insert into city(code, pcode, name) values(120100,120000,'天津');"""

		sqls << """insert into city(code, pcode, name) values(330100,330000,'杭州');"""
		sqls << """insert into city(code, pcode, name) values(330200,330000,'宁波');"""
		sqls << """insert into city(code, pcode, name) values(330281,330000,'余姚');"""
		sqls << """insert into city(code, pcode, name) values(330300,330000,'温州');"""
		sqls << """insert into city(code, pcode, name) values(330400,330000,'嘉兴');"""
		sqls << """insert into city(code, pcode, name) values(330500,330000,'湖州');"""
		sqls << """insert into city(code, pcode, name) values(330600,330000,'绍兴');"""
		sqls << """insert into city(code, pcode, name) values(330700,330000,'金华');"""
		sqls << """insert into city(code, pcode, name) values(330800,330000,'衢州');"""
		sqls << """insert into city(code, pcode, name) values(330900,330000,'舟山');"""
		sqls << """insert into city(code, pcode, name) values(331000,330000,'台州');"""
		sqls << """insert into city(code, pcode, name) values(331100,330000,'丽水');"""

		sqls << """insert into city(code, pcode, name) values(530100,530000,'昆明');"""
		sqls << """insert into city(code, pcode, name) values(530300,530000,'曲靖');"""
		sqls << """insert into city(code, pcode, name) values(530400,530000,'玉溪');"""
		sqls << """insert into city(code, pcode, name) values(530500,530000,'保山');"""
		sqls << """insert into city(code, pcode, name) values(530600,530000,'昭通');"""
		sqls << """insert into city(code, pcode, name) values(530700,530000,'丽江');"""
		sqls << """insert into city(code, pcode, name) values(530800,530000,'普洱');"""
		sqls << """insert into city(code, pcode, name) values(530900,530000,'临沧');"""
		sqls << """insert into city(code, pcode, name) values(532300,530000,'楚雄');"""
		sqls << """insert into city(code, pcode, name) values(532500,530000,'红河');"""
		sqls << """insert into city(code, pcode, name) values(532600,530000,'文山');"""
		sqls << """insert into city(code, pcode, name) values(532800,530000,'西双版纳');"""
		sqls << """insert into city(code, pcode, name) values(532900,530000,'大理');"""
		sqls << """insert into city(code, pcode, name) values(533100,530000,'德宏');"""
		sqls << """insert into city(code, pcode, name) values(533300,530000,'怒江');"""
		sqls << """insert into city(code, pcode, name) values(533400,530000,'迪庆');"""

		sqls << """insert into city(code, pcode, name) values(540100,540000,'拉萨');"""
		sqls << """insert into city(code, pcode, name) values(542100,540000,'昌都地');"""
		sqls << """insert into city(code, pcode, name) values(542200,540000,'山南');"""
		sqls << """insert into city(code, pcode, name) values(542300,540000,'日喀则');"""
		sqls << """insert into city(code, pcode, name) values(542400,540000,'那曲');"""
		sqls << """insert into city(code, pcode, name) values(542500,540000,'阿里');"""
		sqls << """insert into city(code, pcode, name) values(542600,540000,'林芝');"""


		sqls << """insert into city(code, pcode, name) values(650100,650000,'乌鲁木齐');"""
		sqls << """insert into city(code, pcode, name) values(650200,650000,'克拉玛依');"""
		sqls << """insert into city(code, pcode, name) values(652100,650000,'吐鲁番');"""
		sqls << """insert into city(code, pcode, name) values(652200,650000,'哈密地');"""
		sqls << """insert into city(code, pcode, name) values(652300,650000,'昌吉');"""
		sqls << """insert into city(code, pcode, name) values(652700,650000,'博尔塔拉');"""
		sqls << """insert into city(code, pcode, name) values(652800,650000,'巴音郭楞');"""
		sqls << """insert into city(code, pcode, name) values(652900,650000,'阿克苏');"""
		sqls << """insert into city(code, pcode, name) values(653000,650000,'克孜勒苏柯尔克孜');"""
		sqls << """insert into city(code, pcode, name) values(653100,650000,'喀什地');"""
		sqls << """insert into city(code, pcode, name) values(653200,650000,'和田');"""
		sqls << """insert into city(code, pcode, name) values(654000,650000,'伊犁');"""
		sqls << """insert into city(code, pcode, name) values(654200,650000,'塔城地');"""
		sqls << """insert into city(code, pcode, name) values(654300,650000,'阿勒泰');"""
		sqls << """insert into city(code, pcode, name) values(659000,650000,'自治直辖');"""

		sqls << """insert into city(code, pcode, name) values(810100,810000,'香港岛');"""
		sqls << """insert into city(code, pcode, name) values(810200,810000,'九龙');"""
		sqls << """insert into city(code, pcode, name) values(810300,810000,'新界');"""


		return sqls
	}

	@Override
	def updateData() {
		return null
	}

	@Override
	public int getOrder() {
		return 2;
	}
}
