#!/bin/bash

stationCodes=(1004 1005 1006 1013 1014 1016 1018 1019 1020 1021 1022 1023 1024 1026 1027 1029 1030 1031 1032 1033 1034 1035 1102 1104 1105 1106 1107 1108 1109 1110 1111 1112 1113 1114 1115 1116 1117 1118 1202 1204 1205 1206 1207 1208 1209 1211 1212 1213 1214 1217 1218 1219 1221 1222 1223 1224 1225 1226 1227 1229 1230 1231 1232 1234 1235 1236 1239 1240 1241 1243 1244 1302 1304 1307 1308 1310 1314 1315 1318 1320 1321 1322 1323 1324 1402 1403 1404 1405 1407 1408 1409 1410 1411 1412 1413 1414 1415 1416 1417 1418 1502 1503 1504 1507 1508 1510 1512 1514 1516 1517 1602 1604 1605 1606 1607 1609 1610 1611 1612 1613 1614 1616 1617 1620 1621 1622 1623 1624 1625 1626 1628 1629 1630 1631 1703 1704 1705 1706 1708 1709 1710 1711 1712 1713 1714 1802 1803 1805 1806 1807 1808 1809 1810 1811 1812 1813 1814 1815 1816 1817 1818 1819 1821 1822 1823 1824 1825 1826 1903 1904 1905 1906 1908 2203 2204 2205 2206 2207 2208 2209 2211 2212 2213 2214 2702 2703 2704 2706 2707 5101 6103);

#stationCodes=(1234 1235);


searchDay=`date +"%Y/%m/%d"`;

thisDay=`date +"%Y-%m-%d"`;

thisFolder="/Users/infofab/bin/TRA"

mkdir $thisFolder/$thisDay;

for stationCode in "${stationCodes[@]}"
do

thisUrl="http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=1&searchdate=$searchDay&fromstation=$stationCode&trainclass=undefined&traindirection=0&fromtime=0000&totime=2359&language=eng";

	thisHtml=`curl "$thisUrl" 1>"$thisFolder/$thisDay/$stationCode-CW.html" 2>/dev/null`;

thisUrl="http://twtraffic.tra.gov.tw/twrail/SearchResult.aspx?searchtype=1&searchdate=$searchDay&fromstation=$stationCode&trainclass=undefined&traindirection=1&fromtime=0000&totime=2359&language=eng";


	thisHtml=`curl "$thisUrl" 1>"$thisFolder/$thisDay/$stationCode-CCW.html" 2>/dev/null`;
	

done
