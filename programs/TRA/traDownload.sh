#!/bin/bash

stationCodes=(1001 1002 1003 1004 1005 1006 1007 1008 1009 1011 1012 1013 1014 1015 1016 1017 1018 1019 1020 1021 1022 1023 1024 1025 1026 1027 1028 1029 1030 1031 1032 1033 1034 1035 1102 1104 1105 1106 1107 1108 1109 1110 1111 1112 1113 1114 1115 1116 1117 1118 1120 1202 1203 1204 1205 1206 1207 1208 1209 1210 1211 1212 1213 1214 1215 1217 1218 1219 1220 1221 1222 1223 1224 1225 1226 1227 1228 1229 1230 1231 1232 1233 1234 1235 1236 1238 1239 1240 1241 1242 1243 1244 1302 1304 1305 1307 1308 1310 1314 1315 1317 1318 1319 1320 1321 1322 1323 1324 1402 1403 1404 1405 1406 1407 1408 1409 1410 1411 1412 1413 1414 1415 1416 1417 1418 1502 1503 1504 1507 1508 1510 1512 1514 1516 1517 1602 1604 1605 1606 1607 1609 1610 1611 1612 1613 1614 1616 1617 1619 1621 1622 1623 1624 1625 1626 1628 1629 1630 1631 1632 1703 1704 1705 1706 1708 1709 1710 1711 1712 1713 1714 1715 1802 1803 1804 1805 1806 1807 1808 1809 1810 1811 1811 1812 1813 1814 1815 1816 1817 1818 1819 1820 1821 1822 1823 1824 1825 1826 1827 1903 1904 1905 1906 1907 1908 2203 2204 2205 2206 2207 2208 2209 2210 2211 2212 2213 2214 2702 2703 2704 2705 2706 2707 5101 5102 6103);

stationNames=("Keelung" "Badu" "Qidu" "Wudu" "Xizhi" "Nangang" "Songshan" "Taipei" "Wanhua" "Banqiao" "Shulin" "Shanjia" "Yingge" "Taoyuan" "Neili" "Zhongli" "Puxin" "Yangmei" "Fugang" "Hukou" "Xinfeng" "Zhubei" "North Hsinchu" "Hsinchu" "Xiangshan" "Qiding" "Zhunan" "Sankeng" "Baifu" "Xike" "Fuzhou" "BaiHwu" "South Shulin" "Sanxingqiao" "Tanwen" "Dashan" "Houlong" "Longgang" "Baishatun" "Xinpu" "Tongxiao" "Yuanli" "Rinan" "Dajia" "Taichung Port" "Qingshui" "Shalu" "Longjing" "Dadu" "Zhuifen" "Changhua" "Huatan" "Yuanlin" "Yongjing" "Shetou" "Tianzhong" "Ershui" "Linnei" "Shiliu" "Douliu" "Dounan" "Shigui" "Dalin" "Minxiong" "Chiayi" "Shuishang" "Nanjing" "Houbi" "Xinying" "Liuying" "Linfengying" "Longtian" "Balin" "Shanhua" "Xinshi" "Yongkang" "Tainan" "Baoan" "Zhongzhou" "Dahu" "Luzhu" "Gangshan" "Qiaotou" "Nanzi" "Zuoying" "Kaohsiung" "Daqiao" "Dacun" "Jiabei" "Xinzuoying" "Rende" "Nanke" "Zaoqiao" "Fengfu" "Miaoli" "Nanshi" "Tongluo" "Sanyi" "Taian" "Houli" "Fengyuan" "Tanzi" "Taichung" "Wuri" "Chenggong" "Daqing" "Taiyuan" "Xinwuri" "Fengshan" "Houzhuang" "Jiuqutang" "Liukuaicuo" "Pingtung" "Guilai" "Linluo" "Xishi" "Zhutian" "Chaozhou" "Kanding" "Nanzhou" "Zhenan" "Linbian" "Jiadong" "Donghai" "Fangliao" "Jialu" "Neishi" "Fangshan" "Guzhuang" "Dawu" "Longxi" "Jinlun" "Taimali" "Zhiben" "Kangle" "Jian" "Zhixue" "Pinghe" "Shoufeng" "Fengtian" "Nanping" "Fenglin" "Wanrong" "Guangfu" "Dafu" "Fuyuan" "Ruisui" "Sanmin" "Yuli" "Dongli" "Dongzhu" "Fuli" "Chishang" "Haiduan" "Guanshan" "Ruihe" "Ruiyuan" "Luye" "Shanli" "Taitung" "Yongle" "Dongao" "Nanao" "Wuta" "Hanben" "Heping" "Heren" "Chongde" "Xincheng" "Jingmei" "Beipu" "Hualien" "Nuannuan" "Sijiaoting" "Ruifang" "Houtong" "Sandiaoling" "Mudan" "Shuangxi" "Gongliao" "Fulong" "Shicheng" "Shicheng" "Dali" "Daxi" "Guishan" "Waiao" "Toucheng" "Dingpu" "Jiaoxi" "Sicheng" "Yilan" "Erjie" "Zhongli" "Luodong" "Dongshan" "Xinma" "Suaoxin" "Suao" "Dahua" "Shifen" "Wanggu" "Lingjiao" "Pingxi" "Jingtong" "Zhuzhong" "Shangyuan" "Zhudong" "Hengshan" "Jiuzantou" "Hexing" "Fugui" "Neiwan" "Ronghua" "Qianjia" "Xinzhuang" "Liujia" "Yuanquan" "Zhuoshui" "Longquan" "Jiji" "Shuili" "Checheng" "Chang Jung Christian University" "Shalun" "NMMST");

chineseNames=("基隆" "八堵" "七堵" "五堵" "汐止" "南港" "松山" "臺北" "萬華" "板橋" "樹林" "山佳" "鶯歌" "桃園" "內壢" "中壢" "埔心" "楊梅" "富岡" "湖口" "新豐" "竹北" "北新竹" "新竹" "香山" "崎頂" "竹南" "三坑" "百福" "汐科" "浮洲" "北湖" "南樹林" "三姓橋" "談文" "大山" "後龍" "龍港" "白沙屯" "新埔" "通霄" "苑裡" "日南" "大甲" "臺中港" "清水" "沙鹿" "龍井" "大肚" "追分" "彰化" "花壇" "員林" "永靖" "社頭" "田中" "二水" "林內" "石榴" "斗六" "斗南" "石龜" "大林" "民雄" "嘉義" "水上" "南靖" "後壁" "新營" "柳營" "林鳳營" "隆田" "拔林" "善化" "新市" "永康" "臺南" "保安" "中洲" "大湖" "路竹" "岡山" "橋頭" "楠梓" "左營" "高雄" "大橋" "大村" "嘉北" "新左營" "仁德" "南科" "造橋" "豐富" "苗栗" "南勢" "銅鑼" "三義" "泰安" "后里" "豐原" "潭子" "臺中" "烏日" "成功" "大慶" "太原" "新烏日" "鳳山" "後庄" "九曲堂" "六塊厝" "屏東" "歸來" "麟洛" "西勢" "竹田" "潮州" "崁頂" "南州" "鎮安" "林邊" "佳冬" "東海" "枋寮" "加祿" "內獅" "枋山" "古莊" "大武" "瀧溪" "金崙" "太麻里" "知本" "康樂" "吉安" "志學" "平和" "壽豐" "豐田" "南平" "鳳林" "萬榮" "光復" "大富" "富源" "瑞穗" "三民" "玉里" "東里" "東竹" "富里" "池上" "海端" "關山" "瑞和" "瑞源" "鹿野" "山里" "臺東" "永樂" "東澳" "南澳" "武塔" "漢本" "和平" "和仁" "崇德" "新城" "景美" "北埔" "花蓮" "暖暖" "四腳亭" "瑞芳" "猴硐" "三貂嶺" "牡丹" "雙溪" "貢寮" "福隆" "石城" "石城" "大里" "大溪" "龜山" "外澳" "頭城" "頂埔" "礁溪" "四城" "宜蘭" "二結" "中里" "羅東" "冬山" "新馬" "蘇澳新" "蘇澳" "大華" "十分" "望古" "嶺腳" "平溪" "菁桐" "竹中" "上員" "竹東" "橫山" "九讚頭" "合興" "富貴" "內灣" "榮華" "千甲" "新莊" "六家" "源泉" "濁水" "龍泉" "集集" "水里" "車埕" "長榮大學" "沙崙" "海科館");


# Closed: Antung 安通 1620
#stationCodes=(1234 1235);


for ((dateOffset=0; dateOffset<=44; dateOffset++));
#for ((dateOffset=8; dateOffset<=9; dateOffset++));
do
	
	searchDay=`date -j -v+"$dateOffset"d +"%Y/%m/%d"`;
	thisDay=`date -j -v+"$dateOffset"d +"%Y-%m-%d"`;
	mkdir $thisDay;

	for ((currentStation=0; currentStation<=225; currentStation++));
	do

		stationCode=${stationCodes[$currentStation]};
		thisName=${stationNames[$currentStation]};
		thisChineseName=${chineseNames[$currentStation]};
		
	thisUrl="http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=1&searchdate=$searchDay&fromstation=$stationCode&trainclass=undefined&traindirection=0&fromtime=0000&totime=2359&language=eng";

	
		curl "$thisUrl" 1>"$thisDay/$thisName $thisChineseName $stationCode CW.html" 2>/dev/null;

	thisUrl="http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=1&searchdate=$searchDay&fromstation=$stationCode&trainclass=undefined&traindirection=1&fromtime=0000&totime=2359&language=eng";


		curl "$thisUrl" 1>"$thisDay/$thisName $thisChineseName $stationCode CCW.html" 2>/dev/null;


	done
done
