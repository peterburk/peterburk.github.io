#!/bin/bash

thisFolder="/var/mobile/Sites/Scripts/GPSToGalileo";

NAME="Bookmark";

OUTFILE="$NAME.kml";

HEADERS="<?xml version=\"1.0\" encoding=\"UTF-8\"?><kml xmlns=\"http://earth.google.com/kml/2.2\"><Document><name>$NAME</name><description></description><Style id=\"other.png\"><IconStyle><Icon><href>http://galileo-app.com/media/images/bookmarks/other.png</href></Icon></IconStyle></Style>";

echo "$HEADERS" > "/var/mobile/Sites/Scripts/GPSToGalileo/$OUTFILE";

thisResult="+36.423159,+127.388791";

# Cut latitude

thisLat=`echo "$thisResult" | cut -d ',' -f 1`;

# Cut longitude

thisLng=`echo "$thisResult" | cut -d ',' -f 2`;

thisName=`echo "Bookmark" | sed 's/\\\"//g'`;

#echo "$thisName";

echo "<Placemark><name>$thisName</name><description></description><styleUrl>#other.png</styleUrl><Point><coordinates>$thisLng,$thisLat,0.000000</coordinates></Point></Placemark>"  >> "$thisFolder/$OUTFILE";

#done;

FOOTERS="</Document></kml>";

echo "$FOOTERS" >>"/var/mobile/Sites/Scripts/GPSToGalileo/$OUTFILE";

sbopenurl "ifile://localhost/var/mobile/Sites/Scripts/GPSToGalileo/$OUTFILE";