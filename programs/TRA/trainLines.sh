#!/bin/bash

days=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday" "Saturday" "Sunday");

#thisFolder="Wednesday/2016-10-12";
#thisFolder="Thursday/2016-10-13";
#thisFolder="Friday/2016-10-14";
#thisFolder="Saturday/2016-10-15";
#thisFolder="Sunday/2016-10-16";


for ((currentDay=0; currentDay<7; currentDay++));
do

	thisDay=${days[$currentDay]};


	dayFolders="$thisDay/*";
	
	for thisDateFolder in $dayFolders
	do
	
		#echo "$thisDateFolder";

		FILES="$thisDateFolder/HTML/*.html";
		
		mkdir "$thisDateFolder/Lines/";
		mkdir "$thisDateFolder/Stations/";

	
		for thisFile in $FILES
		do

	
			trainNumbers=`cat "$thisFile" | grep "TrainCodeHyperLink" | sed -e 's/<[^>]*>//g' | sed 's/[^0-9]*//g'`;
	
			arrivalTimes=`cat "$thisFile" | grep -o "SearchResult_Time.*" | sed -e 's/<[^>]*>/ /g' | cut -d '>' -f 2 | sed 's/&nbsp;//g' | sed 's/    / /g' | sed 's/^[ \t]//g' | cut -d ' ' -f 1`;


			departureTimes=`cat "$thisFile" | grep -o "SearchResult_Time.*" | sed -e 's/<[^>]*>/ /g' | cut -d '>' -f 2 | sed 's/&nbsp;//g' | sed 's/    / /g' | sed 's/^[ \t]//g' | cut -d ' ' -f 2`;
	
			numberTrains=`echo "$trainNumbers" | wc -l`;
	
			filename=`basename "$thisFile" | sed 's/.html//g'`;
			englishName=`echo "$filename" | cut -d ' ' -f 1`;
			chineseName=`echo "$filename" | cut -d ' ' -f 2`;
	
			stationName=`echo "$englishName $chineseName"`;
	
			stationNameText="";
			trainDelimiterText="";
		
			for thisElement in $(seq 1 $numberTrains);do
		 	   	stationNameText+="$stationName|";
		    	trainDelimiterText+="|;";
			done
			# end repeating station name
	
			stationNameText=`echo "$stationNameText" | tr '|' '\n'`;
			trainDelimiterText=`echo "$trainDelimiterText" | tr ';' '\n'`;
			
			fileText=`paste -d ' ' <(echo "$trainNumbers") <(echo "$trainDelimiterText") <(echo "$arrivalTimes") <(echo "$stationNameText") <(echo "$departureTimes")`;
	
			echo "$fileText" >> "$thisDateFolder/Stations/$filename.txt";

			#numberLines=`echo "$fileText" | wc -l`;
	
			#for ((currentLine = 1; currentLine <= numberLines; currentLine++));
			#do
		
			while read -r thisLine; do
		
				outFilename=`echo "$thisLine" | sed 's/ |.*//g'`;
		
				outText=`echo "$thisLine" | sed 's/.*| //g'`;
				
				echo "$outText" >> "$thisDateFolder/Lines/$outFilename.txt";
	
			done <<< "$fileText"
			# end put station data into line files
		#done
	
	
		done
		# end for every HTML file in folder


		trainLineFiles="$thisDateFolder/Lines/*.txt";

		for thisFile in $trainLineFiles
		do
			sort -o "$thisFile" "$thisFile";
		done
		# end sort files

	done
	# end for every date folder

done
# end for every day