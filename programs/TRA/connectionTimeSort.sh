#!/bin/bash

thisFolder="ConnectionTimes";

FILES="$thisFolder/*.txt";

#IFS="";

for thisFile in $FILES
do
	filename=`basename "$thisFile" | sed 's/.txt//g'`;

	slowest=`sort -n "$thisFile"  | tail -n 1 | cut -d ' ' -f 1`;
	
	mv "$thisFolder/$filename.txt" "$thisFolder/$filename $slowest.txt";
	
	#echo "$slowest";
	
	#exit;
done