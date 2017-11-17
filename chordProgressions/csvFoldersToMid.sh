#!/bin/bash
theseFolders=(`ls "CSV/"`);

for ((currentFolder=0; currentFolder<=2400; currentFolder++));
do
	thisFolder=${theseFolders[$currentFolder]};
	
	mkdir "MID/$thisFolder";
	
	theseFiles=(`ls "CSV/$thisFolder/"`);
	
	for ((currentFile=0; currentFile<=210; currentFile++));
	do
		thisFile=${theseFiles[$currentFile]};
		
		thisFile=`echo "$thisFile" | sed 's/.csv//g'`
		
		./csvmidi "CSV/$thisFolder/$thisFile.csv" "MID/$thisFolder/$thisFile.mid";
		
	done
	
done
