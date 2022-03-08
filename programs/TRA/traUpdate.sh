#!/bin/bash

stationCodes=(1001 1002 1003 1004 1005 1006 1007 1008 1009 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023 1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1035 1102 1104 1105 1106 1107 1108 1109 1110 1111 1112 1113 1114 1115 1116 1117 1118 1120 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1217 1218 1219 1220 1221 1222 1223 1224 1225 1226 1227 1228 1229 1230 1231 1232 1233 1234 1235 1236 1238 1239 1240 1241 1242 1243 1244 1302 1304 1305 1307 1308 1310 1314 1315 1317 1318 1319 1320 1321 1322 1323 1324 1402 1403 1404 1405 1406 1407 1408 1409 1410 1411 1412 1413 1414 1415 1416 1417 1418 1502 1503 1504 1507 1508 1510 1512 1514 1516 1517 1602 1604 1605 1606 1607 1609 1610 1611 1612 1613 1614 1616 1617 1619 1621 1622 1623 1624 1625 1626 1628 1629 1630 1631 1632 1703 1704 1705 1706 1708 1709 1710 1711 1712 1713 1714 1715 1802 1803 1804 1805 1806 1807 1808 1809 1810 1811 1811 1812 1813 1814 1815 1816 1817 1818 1819 1820 1821 1822 1823 1824 1825 1826 1827 1903 1904 1905 1906 1907 1908 2203 2204 2205 2206 2207 2208 2209 2210 2211 2212 2213 2214 2702 2703 2704 2705 2706 2707 5101 5102 6103);

stationNames=("Keelung" "Badu" "Qidu" "Wudu" "Xizhi" "Nangang" "Songshan" "Taipei" "Wanhua" "Banqiao" "Shulin" "Shanjia" "Yingge" "Taoyuan" "Neili" "Zhongli" "Puxin" "Yangmei" "Fugang" "Hukou" "Xinfeng" "Zhubei" "North Hsinchu" "Hsinchu" "Xiangshan" "Qiding" "Zhunan" "Sankeng" "Baifu" "Xike" "Fuzhou" "BaiHwu" "South Shulin" "Sanxingqiao" "Tanwen" "Dashan" "Houlong" "Longgang" "Baishatun" "Xinpu" "Tongxiao" "Yuanli" "Rinan" "Dajia" "Taichung Port" "Qingshui" "Shalu" "Longjing" "Dadu" "Zhuifen" "Changhua" "Huatan" "Yuanlin" "Yongjing" "Shetou" "Tianzhong" "Ershui" "Linnei" "Shiliu" "Douliu" "Dounan" "Shigui" "Dalin" "Minxiong" "Chiayi" "Shuishang" "Nanjing" "Houbi" "Xinying" "Liuying" "Linfengying" "Longtian" "Balin" "Shanhua" "Xinshi" "Yongkang" "Tainan" "Baoan" "Zhongzhou" "Dahu" "Luzhu" "Gangshan" "Qiaotou" "Nanzi" "Zuoying" "Kaohsiung" "Daqiao" "Dacun" "Jiabei" "Xinzuoying" "Rende" "Nanke" "Zaoqiao" "Fengfu" "Miaoli" "Nanshi" "Tongluo" "Sanyi" "Taian" "Houli" "Fengyuan" "Tanzi" "Taichung" "Wuri" "Chenggong" "Daqing" "Taiyuan" "Xinwuri" "Fengshan" "Houzhuang" "Jiuqutang" "Liukuaicuo" "Pingtung" "Guilai" "Linluo" "Xishi" "Zhutian" "Chaozhou" "Kanding" "Nanzhou" "Zhenan" "Linbian" "Jiadong" "Donghai" "Fangliao" "Jialu" "Neishi" "Fangshan" "Guzhuang" "Dawu" "Longxi" "Jinlun" "Taimali" "Zhiben" "Kangle" "Jian" "Zhixue" "Pinghe" "Shoufeng" "Fengtian" "Nanping" "Fenglin" "Wanrong" "Guangfu" "Dafu" "Fuyuan" "Ruisui" "Sanmin" "Yuli" "Dongli" "Dongzhu" "Fuli" "Chishang" "Haiduan" "Guanshan" "Ruihe" "Ruiyuan" "Luye" "Shanli" "Taitung" "Yongle" "Dongao" "Nanao" "Wuta" "Hanben" "Heping" "Heren" "Chongde" "Xincheng" "Jingmei" "Beipu" "Hualien" "Nuannuan" "Sijiaoting" "Ruifang" "Houtong" "Sandiaoling" "Mudan" "Shuangxi" "Gongliao" "Fulong" "Shicheng" "Shicheng" "Dali" "Daxi" "Guishan" "Waiao" "Toucheng" "Dingpu" "Jiaoxi" "Sicheng" "Yilan" "Erjie" "Zhongli" "Luodong" "Dongshan" "Xinma" "Suaoxin" "Suao" "Dahua" "Shifen" "Wanggu" "Lingjiao" "Pingxi" "Jingtong" "Zhuzhong" "Shangyuan" "Zhudong" "Hengshan" "Jiuzantou" "Hexing" "Fugui" "Neiwan" "Ronghua" "Qianjia" "Xinzhuang" "Liujia" "Yuanquan" "Zhuoshui" "Longquan" "Jiji" "Shuili" "Checheng" "Chang Jung Christian University" "Shalun" "NMMST");

chineseNames=("基隆" "八堵" "七堵" "五堵" "汐止" "南港" "松山" "臺北" "萬華" "板橋" "樹林" "山佳" "鶯歌" "桃園" "內壢" "中壢" "埔心" "楊梅" "富岡" "湖口" "新豐" "竹北" "北新竹" "新竹" "香山" "崎頂" "竹南" "三坑" "百福" "汐科" "浮洲" "北湖" "南樹林" "三姓橋" "談文" "大山" "後龍" "龍港" "白沙屯" "新埔" "通霄" "苑裡" "日南" "大甲" "臺中港" "清水" "沙鹿" "龍井" "大肚" "追分" "彰化" "花壇" "員林" "永靖" "社頭" "田中" "二水" "林內" "石榴" "斗六" "斗南" "石龜" "大林" "民雄" "嘉義" "水上" "南靖" "後壁" "新營" "柳營" "林鳳營" "隆田" "拔林" "善化" "新市" "永康" "臺南" "保安" "中洲" "大湖" "路竹" "岡山" "橋頭" "楠梓" "左營" "高雄" "大橋" "大村" "嘉北" "新左營" "仁德" "南科" "造橋" "豐富" "苗栗" "南勢" "銅鑼" "三義" "泰安" "后里" "豐原" "潭子" "臺中" "烏日" "成功" "大慶" "太原" "新烏日" "鳳山" "後庄" "九曲堂" "六塊厝" "屏東" "歸來" "麟洛" "西勢" "竹田" "潮州" "崁頂" "南州" "鎮安" "林邊" "佳冬" "東海" "枋寮" "加祿" "內獅" "枋山" "古莊" "大武" "瀧溪" "金崙" "太麻里" "知本" "康樂" "吉安" "志學" "平和" "壽豐" "豐田" "南平" "鳳林" "萬榮" "光復" "大富" "富源" "瑞穗" "三民" "玉里" "東里" "東竹" "富里" "池上" "海端" "關山" "瑞和" "瑞源" "鹿野" "山里" "臺東" "永樂" "東澳" "南澳" "武塔" "漢本" "和平" "和仁" "崇德" "新城" "景美" "北埔" "花蓮" "暖暖" "四腳亭" "瑞芳" "猴硐" "三貂嶺" "牡丹" "雙溪" "貢寮" "福隆" "石城" "石城" "大里" "大溪" "龜山" "外澳" "頭城" "頂埔" "礁溪" "四城" "宜蘭" "二結" "中里" "羅東" "冬山" "新馬" "蘇澳新" "蘇澳" "大華" "十分" "望古" "嶺腳" "平溪" "菁桐" "竹中" "上員" "竹東" "橫山" "九讚頭" "合興" "富貴" "內灣" "榮華" "千甲" "新莊" "六家" "源泉" "濁水" "龍泉" "集集" "水里" "車埕" "長榮大學" "沙崙" "海科館");

# Closed: Antung 安通 1620
#stationCodes=(1234 1235);

directions=("CW" "CCW");

headers="<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n         \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <title>TRA</title>\n  <meta name=\"viewport\" content=\"width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;charset=utf-8\"/>\n  <link rel=\"apple-touch-icon\" href=\"images/SEScriptEditorX.png\" />\n  <meta name=\"apple-touch-fullscreen\" content=\"YES\" />\n  <link rel=\"stylesheet\" href=\"iui/iui.css\" type=\"text/css\" />\n		<script type=\"application/x-javascript\" src=\"iui/iui.js\"></script>\n		<script src=\"jquery-1.7.1.min.js\"></script>\n		<!-- https://github.com/pugetive/plist_parser -->\n		<script type=\"text/javascript\">\n        	iui.animOn = true;\n		</script>\n		\n		<meta http-equiv=\"Content-Type\" content=\"text/html;charset=UTF-8\">\n\n	</head>\n	\n	<body>\n		<div class=\"toolbar\" id=\"thisToolbar\">\n		<h1  id=\"toolbarTitle\">Station</h1>\n        	<a id=\"backButton\" class=\"button\" href=\"#\"></a>\n    	</div>\n\n		<ul id=\"home\" title=\"Station\" selected=\"true\">\n			<li><a href=\"#station-1002-CW\">Badu 八堵</a></li>\n			<li><a href=\"#station-1030-CW\">Baifu 百福</a></li>\n			<li><a href=\"#station-1033-CW\">BaiHwu 北湖</a></li>\n			<li><a href=\"#station-1107-CW\">Baishatun 白沙屯</a></li>\n			<li><a href=\"#station-1224-CW\">Balin 拔林</a></li>\n			<li><a href=\"#station-1011-CW\">Banqiao 板橋</a></li>\n			<li><a href=\"#station-1229-CW\">Baoan 保安</a></li>\n			<li><a href=\"#station-1714-CW\">Beipu 北埔</a></li>\n			<li><a href=\"#station-5101-CW\">Chang Jung Christian University 長榮大學</a></li>\n			<li><a href=\"#station-1120-CW\">Changhua 彰化</a></li>\n			<li><a href=\"#station-1411-CW\">Chaozhou 潮州</a></li>\n			<li><a href=\"#station-2707-CW\">Checheng 車埕</a></li>\n			<li><a href=\"#station-1321-CW\">Chenggong 成功</a></li>\n			<li><a href=\"#station-1215-CW\">Chiayi 嘉義</a></li>\n			<li><a href=\"#station-1624-CW\">Chishang 池上</a></li>\n			<li><a href=\"#station-1711-CW\">Chongde 崇德</a></li>\n			<li><a href=\"#station-1240-CW\">Dacun 大村</a></li>\n			<li><a href=\"#station-1117-CW\">Dadu 大肚</a></li>\n			<li><a href=\"#station-1613-CW\">Dafu 大富</a></li>\n			<li><a href=\"#station-1231-CW\">Dahu 大湖</a></li>\n			<li><a href=\"#station-1903-CW\">Dahua 大華</a></li>\n			<li><a href=\"#station-1112-CW\">Dajia 大甲</a></li>\n			<li><a href=\"#station-1812-CW\">Dali 大里</a></li>\n			<li><a href=\"#station-1213-CW\">Dalin 大林</a></li>\n			<li><a href=\"#station-1239-CW\">Daqiao 大橋</a></li>\n			<li><a href=\"#station-1322-CW\">Daqing 大慶</a></li>\n			<li><a href=\"#station-1104-CW\">Dashan 大山</a></li>\n			<li><a href=\"#station-1508-CW\">Dawu 大武</a></li>\n			<li><a href=\"#station-1813-CW\">Daxi 大溪</a></li>\n			<li><a href=\"#station-1817-CW\">Dingpu 頂埔</a></li>\n			<li><a href=\"#station-1704-CW\">Dongao 東澳</a></li>\n			<li><a href=\"#station-1417-CW\">Donghai 東海</a></li>\n			<li><a href=\"#station-1621-CW\">Dongli 東里</a></li>\n			<li><a href=\"#station-1824-CW\">Dongshan 冬山</a></li>\n			<li><a href=\"#station-1622-CW\">Dongzhu 東竹</a></li>\n			<li><a href=\"#station-1210-CW\">Douliu 斗六</a></li>\n			<li><a href=\"#station-1211-CW\">Dounan 斗南</a></li>\n			<li><a href=\"#station-1821-CW\">Erjie 二結</a></li>\n			<li><a href=\"#station-1207-CW\">Ershui 二水</a></li>\n			<li><a href=\"#station-1418-CW\">Fangliao 枋寮</a></li>\n			<li><a href=\"#station-1504-CW\">Fangshan 枋山</a></li>\n			<li><a href=\"#station-1304-CW\">Fengfu 豐富</a></li>\n			<li><a href=\"#station-1610-CW\">Fenglin 鳳林</a></li>\n			<li><a href=\"#station-1402-CW\">Fengshan 鳳山</a></li>\n			<li><a href=\"#station-1607-CW\">Fengtian 豐田</a></li>\n			<li><a href=\"#station-1317-CW\">Fengyuan 豐原</a></li>\n			<li><a href=\"#station-1020-CW\">Fugang 富岡</a></li>\n			<li><a href=\"#station-2209-CW\">Fugui 富貴</a></li>\n			<li><a href=\"#station-1623-CW\">Fuli 富里</a></li>\n			<li><a href=\"#station-1810-CW\">Fulong 福隆</a></li>\n			<li><a href=\"#station-1614-CW\">Fuyuan 富源</a></li>\n			<li><a href=\"#station-1032-CW\">Fuzhou 浮洲</a></li>\n			<li><a href=\"#station-1233-CW\">Gangshan 岡山</a></li>\n			<li><a href=\"#station-1809-CW\">Gongliao 貢寮</a></li>\n			<li><a href=\"#station-1612-CW\">Guangfu 光復</a></li>\n			<li><a href=\"#station-1626-CW\">Guanshan 關山</a></li>\n			<li><a href=\"#station-1407-CW\">Guilai 歸來</a></li>\n			<li><a href=\"#station-1814-CW\">Guishan 龜山</a></li>\n			<li><a href=\"#station-1507-CW\">Guzhuang 古莊</a></li>\n			<li><a href=\"#station-1625-CW\">Haiduan 海端</a></li>\n			<li><a href=\"#station-1708-CW\">Hanben 漢本</a></li>\n			<li><a href=\"#station-2206-CW\">Hengshan 橫山</a></li>\n			<li><a href=\"#station-1709-CW\">Heping 和平</a></li>\n			<li><a href=\"#station-1710-CW\">Heren 和仁</a></li>\n			<li><a href=\"#station-2208-CW\">Hexing 合興</a></li>\n			<li><a href=\"#station-1219-CW\">Houbi 後壁</a></li>\n			<li><a href=\"#station-1315-CW\">Houli 后里</a></li>\n			<li><a href=\"#station-1105-CW\">Houlong 後龍</a></li>\n			<li><a href=\"#station-1805-CW\">Houtong 猴硐</a></li>\n			<li><a href=\"#station-1403-CW\">Houzhuang 後庄</a></li>\n			<li><a href=\"#station-1025-CW\">Hsinchu 新竹</a></li>\n			<li><a href=\"#station-1715-CW\">Hualien 花蓮</a></li>\n			<li><a href=\"#station-1202-CW\">Huatan 花壇</a></li>\n			<li><a href=\"#station-1021-CW\">Hukou 湖口</a></li>\n			<li><a href=\"#station-1241-CW\">Jiabei 嘉北</a></li>\n			<li><a href=\"#station-1416-CW\">Jiadong 佳冬</a></li>\n			<li><a href=\"#station-1502-CW\">Jialu 加祿</a></li>\n			<li><a href=\"#station-1602-CW\">Jian 吉安</a></li>\n			<li><a href=\"#station-1818-CW\">Jiaoxi 礁溪</a></li>\n			<li><a href=\"#station-2705-CW\">Jiji 集集</a></li>\n			<li><a href=\"#station-1713-CW\">Jingmei 景美</a></li>\n			<li><a href=\"#station-1908-CW\">Jingtong 菁桐</a></li>\n			<li><a href=\"#station-1512-CW\">Jinlun 金崙</a></li>\n			<li><a href=\"#station-1404-CW\">Jiuqutang 九曲堂</a></li>\n			<li><a href=\"#station-2207-CW\">Jiuzantou 九讚頭</a></li>\n			<li><a href=\"#station-1412-CW\">Kanding 崁頂</a></li>\n			<li><a href=\"#station-1517-CW\">Kangle 康樂</a></li>\n			<li><a href=\"#station-1238-CW\">Kaohsiung 高雄</a></li>\n			<li><a href=\"#station-1001-CW\">Keelung 基隆</a></li>\n			<li><a href=\"#station-1415-CW\">Linbian 林邊</a></li>\n			<li><a href=\"#station-1222-CW\">Linfengying 林鳳營</a></li>\n			<li><a href=\"#station-1906-CW\">Lingjiao 嶺腳</a></li>\n			<li><a href=\"#station-1408-CW\">Linluo 麟洛</a></li>\n			<li><a href=\"#station-1208-CW\">Linnei 林內</a></li>\n			<li><a href=\"#station-2214-CW\">Liujia 六家</a></li>\n			<li><a href=\"#station-1405-CW\">Liukuaicuo 六塊厝</a></li>\n			<li><a href=\"#station-1221-CW\">Liuying 柳營</a></li>\n			<li><a href=\"#station-1106-CW\">Longgang 龍港</a></li>\n			<li><a href=\"#station-1116-CW\">Longjing 龍井</a></li>\n			<li><a href=\"#station-2704-CW\">Longquan 龍泉</a></li>\n			<li><a href=\"#station-1223-CW\">Longtian 隆田</a></li>\n			<li><a href=\"#station-1510-CW\">Longxi 瀧溪</a></li>\n			<li><a href=\"#station-1823-CW\">Luodong 羅東</a></li>\n			<li><a href=\"#station-1630-CW\">Luye 鹿野</a></li>\n			<li><a href=\"#station-1232-CW\">Luzhu 路竹</a></li>\n			<li><a href=\"#station-1305-CW\">Miaoli 苗栗</a></li>\n			<li><a href=\"#station-1214-CW\">Minxiong 民雄</a></li>\n			<li><a href=\"#station-1807-CW\">Mudan 牡丹</a></li>\n			<li><a href=\"#station-1705-CW\">Nanao 南澳</a></li>\n			<li><a href=\"#station-1006-CW\">Nangang 南港</a></li>\n			<li><a href=\"#station-1218-CW\">Nanjing 南靖</a></li>\n			<li><a href=\"#station-1244-CW\">Nanke 南科</a></li>\n			<li><a href=\"#station-1609-CW\">Nanping 南平</a></li>\n			<li><a href=\"#station-1307-CW\">Nanshi 南勢</a></li>\n			<li><a href=\"#station-1413-CW\">Nanzhou 南州</a></li>\n			<li><a href=\"#station-1235-CW\">Nanzi 楠梓</a></li>\n			<li><a href=\"#station-1016-CW\">Neili 內壢</a></li>\n			<li><a href=\"#station-1503-CW\">Neishi 內獅</a></li>\n			<li><a href=\"#station-2210-CW\">Neiwan 內灣</a></li>\n			<li><a href=\"#station-6103-CW\">NMMST 海科館</a></li>\n			<li><a href=\"#station-1024-CW\">North Hsinchu 北新竹</a></li>\n			<li><a href=\"#station-1802-CW\">Nuannuan 暖暖</a></li>\n			<li><a href=\"#station-1605-CW\">Pinghe 平和</a></li>\n			<li><a href=\"#station-1406-CW\">Pingtung 屏東</a></li>\n			<li><a href=\"#station-1907-CW\">Pingxi 平溪</a></li>\n			<li><a href=\"#station-1018-CW\">Puxin 埔心</a></li>\n			<li><a href=\"#station-2212-CW\">Qianjia 千甲</a></li>\n			<li><a href=\"#station-1234-CW\">Qiaotou 橋頭</a></li>\n			<li><a href=\"#station-1027-CW\">Qiding 崎頂</a></li>\n			<li><a href=\"#station-1003-CW\">Qidu 七堵</a></li>\n			<li><a href=\"#station-1114-CW\">Qingshui 清水</a></li>\n			<li><a href=\"#station-1243-CW\">Rende 仁德</a></li>\n			<li><a href=\"#station-1111-CW\">Rinan 日南</a></li>\n			<li><a href=\"#station-2211-CW\">Ronghua 榮華</a></li>\n			<li><a href=\"#station-1804-CW\">Ruifang 瑞芳</a></li>\n			<li><a href=\"#station-1628-CW\">Ruihe 瑞和</a></li>\n			<li><a href=\"#station-1616-CW\">Ruisui 瑞穗</a></li>\n			<li><a href=\"#station-1629-CW\">Ruiyuan 瑞源</a></li>\n			<li><a href=\"#station-1806-CW\">Sandiaoling 三貂嶺</a></li>\n			<li><a href=\"#station-1029-CW\">Sankeng 三坑</a></li>\n			<li><a href=\"#station-1617-CW\">Sanmin 三民</a></li>\n			<li><a href=\"#station-1035-CW\">Sanxingqiao 三姓橋</a></li>\n			<li><a href=\"#station-1310-CW\">Sanyi 三義</a></li>\n			<li><a href=\"#station-1115-CW\">Shalu 沙鹿</a></li>\n			<li><a href=\"#station-5102-CW\">Shalun 沙崙</a></li>\n			<li><a href=\"#station-2204-CW\">Shangyuan 上員</a></li>\n			<li><a href=\"#station-1225-CW\">Shanhua 善化</a></li>\n			<li><a href=\"#station-1013-CW\">Shanjia 山佳</a></li>\n			<li><a href=\"#station-1631-CW\">Shanli 山里</a></li>\n			<li><a href=\"#station-1205-CW\">Shetou 社頭</a></li>\n			<li><a href=\"#station-1811-CW\">Shicheng 石城</a></li>\n			<li><a href=\"#station-1904-CW\">Shifen 十分</a></li>\n			<li><a href=\"#station-1212-CW\">Shigui 石龜</a></li>\n			<li><a href=\"#station-1209-CW\">Shiliu 石榴</a></li>\n			<li><a href=\"#station-1606-CW\">Shoufeng 壽豐</a></li>\n			<li><a href=\"#station-1808-CW\">Shuangxi 雙溪</a></li>\n			<li><a href=\"#station-2706-CW\">Shuili 水里</a></li>\n			<li><a href=\"#station-1217-CW\">Shuishang 水上</a></li>\n			<li><a href=\"#station-1012-CW\">Shulin 樹林</a></li>\n			<li><a href=\"#station-1819-CW\">Sicheng 四城</a></li>\n			<li><a href=\"#station-1803-CW\">Sijiaoting 四腳亭</a></li>\n			<li><a href=\"#station-1007-CW\">Songshan 松山</a></li>\n			<li><a href=\"#station-1034-CW\">South Shulin 南樹林</a></li>\n			<li><a href=\"#station-1827-CW\">Suao 蘇澳</a></li>\n			<li><a href=\"#station-1826-CW\">Suaoxin 蘇澳新</a></li>\n			<li><a href=\"#station-1314-CW\">Taian 泰安</a></li>\n			<li><a href=\"#station-1113-CW\">Taichung Port 臺中港</a></li>\n			<li><a href=\"#station-1319-CW\">Taichung 臺中</a></li>\n			<li><a href=\"#station-1514-CW\">Taimali 太麻里</a></li>\n			<li><a href=\"#station-1228-CW\">Tainan 臺南</a></li>\n			<li><a href=\"#station-1008-CW\">Taipei 臺北</a></li>\n			<li><a href=\"#station-1632-CW\">Taitung 臺東</a></li>\n			<li><a href=\"#station-1323-CW\">Taiyuan 太原</a></li>\n			<li><a href=\"#station-1102-CW\">Tanwen 談文</a></li>\n			<li><a href=\"#station-1318-CW\">Tanzi 潭子</a></li>\n			<li><a href=\"#station-1015-CW\">Taoyuan 桃園</a></li>\n			<li><a href=\"#station-1206-CW\">Tianzhong 田中</a></li>\n			<li><a href=\"#station-1308-CW\">Tongluo 銅鑼</a></li>\n			<li><a href=\"#station-1109-CW\">Tongxiao 通霄</a></li>\n			<li><a href=\"#station-1816-CW\">Toucheng 頭城</a></li>\n			<li><a href=\"#station-1815-CW\">Waiao 外澳</a></li>\n			<li><a href=\"#station-1905-CW\">Wanggu 望古</a></li>\n			<li><a href=\"#station-1009-CW\">Wanhua 萬華</a></li>\n			<li><a href=\"#station-1611-CW\">Wanrong 萬榮</a></li>\n			<li><a href=\"#station-1004-CW\">Wudu 五堵</a></li>\n			<li><a href=\"#station-1320-CW\">Wuri 烏日</a></li>\n			<li><a href=\"#station-1706-CW\">Wuta 武塔</a></li>\n			<li><a href=\"#station-1026-CW\">Xiangshan 香山</a></li>\n			<li><a href=\"#station-1031-CW\">Xike 汐科</a></li>\n			<li><a href=\"#station-1712-CW\">Xincheng 新城</a></li>\n			<li><a href=\"#station-1022-CW\">Xinfeng 新豐</a></li>\n			<li><a href=\"#station-1825-CW\">Xinma 新馬</a></li>\n			<li><a href=\"#station-1108-CW\">Xinpu 新埔</a></li>\n			<li><a href=\"#station-1226-CW\">Xinshi 新市</a></li>\n			<li><a href=\"#station-1324-CW\">Xinwuri 新烏日</a></li>\n			<li><a href=\"#station-1220-CW\">Xinying 新營</a></li>\n			<li><a href=\"#station-2213-CW\">Xinzhuang 新莊</a></li>\n			<li><a href=\"#station-1242-CW\">Xinzuoying 新左營</a></li>\n			<li><a href=\"#station-1409-CW\">Xishi 西勢</a></li>\n			<li><a href=\"#station-1005-CW\">Xizhi 汐止</a></li>\n			<li><a href=\"#station-1019-CW\">Yangmei 楊梅</a></li>\n			<li><a href=\"#station-1820-CW\">Yilan 宜蘭</a></li>\n			<li><a href=\"#station-1014-CW\">Yingge 鶯歌</a></li>\n			<li><a href=\"#station-1204-CW\">Yongjing 永靖</a></li>\n			<li><a href=\"#station-1227-CW\">Yongkang 永康</a></li>\n			<li><a href=\"#station-1703-CW\">Yongle 永樂</a></li>\n			<li><a href=\"#station-1110-CW\">Yuanli 苑裡</a></li>\n			<li><a href=\"#station-1203-CW\">Yuanlin 員林</a></li>\n			<li><a href=\"#station-2702-CW\">Yuanquan 源泉</a></li>\n			<li><a href=\"#station-1619-CW\">Yuli 玉里</a></li>\n			<li><a href=\"#station-1302-CW\">Zaoqiao 造橋</a></li>\n			<li><a href=\"#station-1414-CW\">Zhenan 鎮安</a></li>\n			<li><a href=\"#station-1516-CW\">Zhiben 知本</a></li>\n			<li><a href=\"#station-1604-CW\">Zhixue 志學</a></li>\n			<li><a href=\"#station-1017-CW\">Zhongli 中壢</a></li>\n			<li><a href=\"#station-1822-CW\">Zhongli 中里</a></li>\n			<li><a href=\"#station-1230-CW\">Zhongzhou 中洲</a></li>\n			<li><a href=\"#station-1023-CW\">Zhubei 竹北</a></li>\n			<li><a href=\"#station-2205-CW\">Zhudong 竹東</a></li>\n			<li><a href=\"#station-1118-CW\">Zhuifen 追分</a></li>\n			<li><a href=\"#station-1028-CW\">Zhunan 竹南</a></li>\n			<li><a href=\"#station-2703-CW\">Zhuoshui 濁水</a></li>\n			<li><a href=\"#station-1410-CW\">Zhutian 竹田</a></li>\n			<li><a href=\"#station-2203-CW\">Zhuzhong 竹中</a></li>\n			<li><a href=\"#station-1236-CW\">Zuoying 左營</a></li>\n		</ul>";

footers="		\n	</body>\n</html>";

#thisFolder="/Users/infofab/bin/TRA";
thisFolder="/Users/peter/Documents/Homes/Taiwan/Kaohsiung/Social/TRA";


for ((dateOffset=0; dateOffset<=44; dateOffset++));
#for ((dateOffset=8; dateOffset<=9; dateOffset++));
do
	
	searchDay=`date -j -v+"$dateOffset"d +"%Y/%m/%d"`;
	thisDay=`date -j -v+"$dateOffset"d +"%Y-%m-%d"`;
	
	mkdir "$thisFolder/$thisDay";
	
	mkdir "$thisFolder/$thisDay/Lines/";
	mkdir "$thisFolder/$thisDay/Stations/";

	printf "$headers" >> "$thisFolder/$thisDay/$thisDay.html";

	for ((currentStation=0; currentStation<=225; currentStation++));
	do

		stationCode=${stationCodes[$currentStation]};
		thisName=${stationNames[$currentStation]};
		thisChineseName=${chineseNames[$currentStation]};
		
	
	for ((currentDirection=0; currentDirection<=1; currentDirection++));
	do

		direction=${directions[$currentDirection]};
		
		oppositeDirection=(1 - $currentDirection);
		otherDirection=${directions[$oppositeDirection]};
	
	thisUrl="http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=1&searchdate=$searchDay&fromstation=$stationCode&trainclass=undefined&traindirection=$currentDirection&fromtime=0000&totime=2359&language=eng";

	

		sourceHtml=`curl "$thisUrl" 2>/dev/null`;

	
		thisDateFolder=$thisDay;
	   

		trainNumbers=`echo "$sourceHtml" | grep "TrainCodeHyperLink" | sed -e 's/<[^>]*>//g' | sed 's/[^0-9]*//g'`;

		arrivalTimes=`echo "$sourceHtml" | grep -o "SearchResult_Time.*" | sed -e 's/<[^>]*>/ /g' | cut -d '>' -f 2 | sed 's/&nbsp;//g' | sed 's/    / /g' | sed 's/^[ \t]//g' | cut -d ' ' -f 1`;


		departureTimes=`echo "$sourceHtml" | grep -o "SearchResult_Time.*" | sed -e 's/<[^>]*>/ /g' | cut -d '>' -f 2 | sed 's/&nbsp;//g' | sed 's/    / /g' | sed 's/^[ \t]//g' | cut -d ' ' -f 2`;

		numberTrains=`echo "$trainNumbers" | wc -l`;

		filename="$thisName $thisChineseName $stationCode $direction";

		#filename=`basename "$thisFile" | sed 's/.html//g'`;
		#englishName=`echo "$filename" | cut -d ' ' -f 1`;
		#chineseName=`echo "$filename" | cut -d ' ' -f 2`;
		
		englishName="$thisName";
		chineseName="$thisChineseName";
		
		stationName=`echo "$englishName $chineseName"`;

		stationNameText="";
		trainDelimiterText="";
   
		for thisElement in $(seq 1 $numberTrains);do
			stationNameText+="$stationName ($stationCode)|";
			trainDelimiterText+="|;";
		done
		# end repeating station name

		stationNameText=`echo "$stationNameText" | tr '|' '\n'`;
		trainDelimiterText=`echo "$trainDelimiterText" | tr ';' '\n'`;
	   
		fileText=`paste -d ' ' <(echo "$trainNumbers") <(echo "$trainDelimiterText") <(echo "$arrivalTimes") <(echo "$stationNameText") <(echo "$departureTimes")`;

		echo "$fileText" >> "$thisFolder/$thisDateFolder/Stations/$filename.txt";

		#numberLines=`echo "$fileText" | wc -l`;

		#for ((currentLine = 1; currentLine <= numberLines; currentLine++));
		#do
   
		echo "		<ul id=\"station-$stationCode-$direction\" title=\"$stationName\">" >> "$thisFolder/$thisDateFolder/$thisDateFolder.html";
		echo "			<li><a href=\"#station-$stationCode-$otherDirection\">$otherDirection</a></li>" >> "$thisFolder/$thisDateFolder/$thisDateFolder.html";

   
		while read -r thisLine; do
   
   			# Build line data
   			
   			# Train line number
			outFilename=`echo "$thisLine" | sed 's/ |.*//g'`;
   
   			# Station stop info
			outText=`echo "$thisLine" | sed 's/.*| //g'`;
		   
			echo "$outText" >> "$thisFolder/$thisDateFolder/Lines/$outFilename.txt";

			# Line text without station code
			thisLinePlain=`echo "$outText" | sed -e 's/ ([^()]*) / /g'`;

   			# Station data to HTML
			echo "			<li><a href=\"#line-$outFilename\">$outFilename | $thisLinePlain</a></li>" >> "$thisFolder/$thisDateFolder/$thisDateFolder.html";

			
		done <<< "$fileText"
		# end put station data into line files
		
		echo "		</ul>" >> "$thisFolder/$thisDateFolder/$thisDateFolder.html";
		
	done


	done
	# end for every HTML file in folder

	#rm -r "$thisFolder/$thisDay/HTML";

	trainLineFiles="$thisFolder/$thisDateFolder/Lines/*.txt";

	for thisFile in $trainLineFiles
	do
		sort -o "$thisFile" "$thisFile";
		
		filename=`basename "$thisFile" | sed 's/.txt//g'`;
		
		echo "		<ul id=\"line-$filename\" title=\"$filename\">" >> "$thisFolder/$thisDateFolder/$thisDateFolder.html";
		
		fileText=`cat "$thisFile"`;
		
		while read -r thisLine; do
   
   			# Build line data
   			
   			# Train line number
			stationCode=`echo "$thisLine" | cut -d '(' -f 2 | cut -d ')' -f 1`;

			# Line text without station code
			thisLinePlain=`echo "$thisLine" | sed -e 's/ ([^()]*) / /g'`;
   
   			# Station data to HTML
			echo "			<li><a href=\"#station-$stationCode-CCW\">$thisLinePlain</a></li>" >> "$thisFolder/$thisDateFolder/$thisDateFolder.html";

			
		done <<< "$fileText"
		
		echo "		</ul>" >> "$thisFolder/$thisDateFolder/$thisDateFolder.html";

		
	done

	printf "$footers" >> "$thisFolder/$thisDay/$thisDay.html";
	
done
