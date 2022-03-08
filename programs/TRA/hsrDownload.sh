#!/bin/bash

directions=("CW" "CCW");

stationNames=("Nangang" "Taipei" "Banqiao" "Taoyuan" "Hsinchu" "Miaoli" "Taichung" "Changhua" "Yunlin" "Chiayi" "Tainan" "Zuoying");

headers="<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"\n         \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\n<head>\n  <title>TRA</title>\n  <meta name=\"viewport\" content=\"width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;charset=utf-8\"/>\n  <link rel=\"apple-touch-icon\" href=\"images/SEScriptEditorX.png\" />\n  <meta name=\"apple-touch-fullscreen\" content=\"YES\" />\n  <link rel=\"stylesheet\" href=\"iui/iui.css\" type=\"text/css\" />\n		<script type=\"application/x-javascript\" src=\"iui/iui.js\"></script>\n		<script src=\"jquery-1.7.1.min.js\"></script>\n		<!-- https://github.com/pugetive/plist_parser -->\n		<script type=\"text/javascript\">\n        	iui.animOn = true;\n		</script>\n		\n		<meta http-equiv=\"Content-Type\" content=\"text/html;charset=UTF-8\">\n\n	</head>\n	\n	<body>\n		<div class=\"toolbar\" id=\"thisToolbar\">\n		<h1  id=\"toolbarTitle\">Station</h1>\n        	<a id=\"backButton\" class=\"button\" href=\"#\"></a>\n    	</div>\n\n		<ul id=\"home\" title=\"Station\" selected=\"true\">\n			<li><a href=\"#station-Nangang-CW\">Nangang 南港</a></li>\n			<li><a href=\"#station-Taipei-CW\">Taipei 臺北</a></li>\n			<li><a href=\"#station-Banqiao-CW\">Banqiao 板橋</a></li>\n			<li><a href=\"#station-Taoyuan-CW\">Taoyuan 桃園</a></li>\n			<li><a href=\"#station-Hsinchu-CW\">Hsinchu 新竹</a></li>\n			<li><a href=\"#station-Miaoli-CW\">Miaoli 苗栗</a></li>\n			<li><a href=\"#station-Taichung-CW\">Taichung 臺中</a></li>\n			<li><a href=\"#station-Changhua-CW\">Changhua 彰化</a></li>\n			<li><a href=\"#station-Yunlin-CW\">Yunlin 員林</a></li>\n			<li><a href=\"#station-Chiayi-CW\">Chiayi 嘉義</a></li>\n			<li><a href=\"#station-Tainan-CW\">Tainan 臺南</a></li>\n			<li><a href=\"#station-Zuoying-CW\">Zuoying 左營</a></li>\n		</ul>	\n";


footers="		\n	</body>\n</html>";



thisFolder="/Users/peter/Documents/Homes/Taiwan/Kaohsiung/Social/TRA";

for ((dateOffset=0; dateOffset<=44; dateOffset++));
#for ((dateOffset=8; dateOffset<=9; dateOffset++));
do
	
	searchDay=`date -j -v+"$dateOffset"d +"%Y%m%d"`;
	thisDay=`date -j -v+"$dateOffset"d +"%Y-%m-%d"`;

	mkdir "$thisFolder/$thisDay";
	
	mkdir "$thisFolder/$thisDay/Lines/";
	mkdir "$thisFolder/$thisDay/Stations/";

	printf "$headers" >> "$thisFolder/$thisDay/$thisDay.html";

thisUrl="https://www.thsrc.com.tw/en/TimeTable/DailyTimeTable/$searchDay";

IFS="
"

sourceHtml=(`curl "$thisUrl" 2>/dev/null`);

#numberParagraphs=`echo "$sourceHtml" | wc -l`;

numberParagraphs=${#sourceHtml[@]};

thisTrain="";

thisDirection="CCW";

	for currentParagraph in $(seq 0 $numberParagraphs);do
		thisParagraph=${sourceHtml[currentParagraph]};
	
	
		if [[ ${thisParagraph} == *"text_orange_link"* ]];then
	
			thisTrain=`echo "$thisParagraph" | sed -e 's/<[^>]*>//g' | sed 's/[^0-9]*//g'`
		
		fi
	
#		echo "$thisParagraph";

		if [[ ${thisParagraph} == *"Northbound"* ]];then
			thisDirection="CW";
		fi
	
		if [[ ${thisParagraph} == *"<td align=\"center\" class=\"text_grey2\""* ]];then

			if [[ ${thisParagraph} != *"></td>"* ]];then
		
		
				thisStation=`echo "$thisParagraph" | sed -e 's/.*title=\"//g' | sed 's/\">.*//g';`
				thisTime=`echo "$thisParagraph" | sed -e 's/.*\">//g' | sed 's/<\/td>.*//g';`
		
				#echo "$thisTrain $thisStation $thisTime";
			
				echo "$thisTime $thisStation" >> "$thisFolder/$thisDay/Lines/$thisTrain.txt";
			
				echo "$thisTrain | $thisTime $thisStation" >> "$thisFolder/$thisDay/Stations/$thisStation-$thisDirection.txt";
			
			
			fi
		fi
	
	done
	
	
	for ((currentStation=0; currentStation<=11; currentStation++));
	do

		for ((currentDirection=0; currentDirection<=1; currentDirection++));
		do
	
			direction=${directions[$currentDirection]};
		
			oppositeDirection=(1 - $currentDirection);
			otherDirection=${directions[$oppositeDirection]};


			thisName=${stationNames[$currentStation]};
			#thisChineseName=${chineseNames[$currentStation]};
	
			echo "		<ul id=\"station-$thisName-$direction\" title=\"$thisName\">" >> "$thisFolder/$thisDay/$thisDay.html";
		
			echo "			<li><a href=\"#station-$thisName-$otherDirection\">$otherDirection</a></li>" >> "$thisFolder/$thisDay/$thisDay.html";

   			fileText=(`cat "$thisFolder/$thisDay/Stations/$thisName-$direction.txt"`);
   		   
			numberParagraphs=${#fileText[@]};
			
			numberParagraphs=`expr $numberParagraphs - 1`;

			for currentParagraph in $(seq 0 $numberParagraphs);do
				thisLine=${fileText[currentParagraph]};
   
   
   				# Build line data
   			
   				# Train line number
				outFilename=`echo "$thisLine" | sed 's/ |.*//g'`;
   
   				# Station stop info
				outText=`echo "$thisLine" | sed 's/.*| //g'`;
		   
				# Line text without station code
				thisLinePlain=`echo "$outText" | sed -e 's/ ([^()]*) / /g'`;
				
   				# Station data to HTML
				echo "			<li><a href=\"#line-$outFilename\">$outFilename | $thisLinePlain</a></li>" >> "$thisFolder/$thisDay/$thisDay.html";

			done

			echo "		</ul>" >> "$thisFolder/$thisDay/$thisDay.html";
		
		done
		
	done
	
	
	trainLineFiles="$thisFolder/$thisDay/Lines/*.txt";

	for thisFile in $trainLineFiles
	do
		sort -o "$thisFile" "$thisFile";
		
		filename=`basename "$thisFile" | sed 's/.txt//g'`;
		
		echo "		<ul id=\"line-$filename\" title=\"$filename\">" >> "$thisFolder/$thisDay/$thisDay.html";
		
		fileText=`cat "$thisFile"`;
		
		while read -r thisLine; do
   
   			# Build line data
   			
   			# Train line number
			#stationCode=`echo "$thisLine" | cut -d '(' -f 2 | cut -d ')' -f 1`;
			stationName=`echo "$thisLine" | cut -d ' ' -f 2`;

			# Line text without station code
			thisLinePlain=`echo "$thisLine" | sed -e 's/ ([^()]*) / /g'`;
   
   			# Station data to HTML
			echo "			<li><a href=\"#station-$stationName-CW\">$thisLinePlain</a></li>" >> "$thisFolder/$thisDay/$thisDay.html";

			
		done <<< "$fileText"
		
		echo "		</ul>" >> "$thisFolder/$thisDay/$thisDay.html";

		
	done
	
	printf "$footers" >> "$thisFolder/$thisDay/$thisDay.html";

done

