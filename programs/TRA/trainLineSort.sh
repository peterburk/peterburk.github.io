#!/bin/bash

#thisFolder="Wednesday/2016-10-12/Lines/";
thisFolder="Thursday/2016-10-13";
#thisFolder="Friday/2016-10-14";

FILES="$thisFolder/*.txt";

#IFS="";

for thisFile in $FILES
do
	sort -o "$thisFile" "$thisFile";
done