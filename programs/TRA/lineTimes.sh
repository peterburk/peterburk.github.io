#!/bin/bash

thisFolder="Monday/2016-10-17/Lines";

FILES="$thisFolder/*.txt";

mkdir "ConnectionTimes";

for thisFile in $FILES
do

	fileText=`cat "$thisFile"`;
	
	numberLines=`echo "$fileText" | wc -l`;

	trainNumber=`basename "$thisFile" | sed 's/.txt//g'`;
	
	for ((currentLine = 2; currentLine <= numberLines; currentLine++));
	do
		theseLines=`echo "$fileText" | head -n $currentLine | tail -n 2 | tr '\n' ';'`;
		
		#echo "$theseLines";
		
		startTime=`echo "$theseLines" | sed 's/;.*//g' | sed 's/.* //g'`;
		endTime=`echo "$theseLines" | sed 's/.*;\(.*\) .*/\1/g' | cut -d ' ' -f 1`;
		
		IFS=: read old_hour old_min <<< "$startTime"
		IFS=: read hour min <<< "$endTime"

		# convert hours to minutes
		# the 10# is there to avoid errors with leading zeros
		# by telling bash that we use base 10
		if  [[ !  -z  $old_hour  ]]; then
			if  [[ !  -z  $old_min  ]]; then
				total_old_minutes=$((10#$old_hour*60 + 10#$old_min))
				total_minutes=$((10#$hour*60 + 10#$min))

				minutesDifference=$((total_minutes - total_old_minutes));
		
		
				startPlace=`echo "$theseLines" | sed 's/;.*//g' | sed 's/\(.*\) .*/\1/g' | sed 's/[0-9][0-9]:[0-9][0-9] //g'`;
				endPlace=`echo "$theseLines" | sed 's/.*;\(.*\) .*/\1/g' | sed 's/[0-9][0-9]:[0-9][0-9] //g'`;

		
				connectionName="$startPlace - $endPlace.txt";
		
				echo "$minutesDifference | $startTime - $endTime | $trainNumber" >> "ConnectionTimes/$connectionName";		
			fi
		fi

	done;
	
done