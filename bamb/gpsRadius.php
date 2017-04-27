<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
         "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title><?php
$thisFolder = $_SERVER["REQUEST_URI"];
$thisFolder = basename($thisFolder);
echo $thisFolder;
 ?></title>
  <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;charset=utf-8"/>
  <link rel="apple-touch-icon" href="icon.png" />
        <script>
        </script>
</head>
<body>
<?php

$longitude=77.014618;
$latitude=10.663816;

$distance=15;
$distance=$distance/1.6;

//$longitude=$longitude-($distance/53);
$latitude=$latitude-($distance/69.1);

$headers = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><kml xmlns=\"http://earth.google.com/kml/2.2\"><Document><name>Bookmark</name><description></description><Style id=\"other.png\"><IconStyle><Icon><href>http://galileo-app.com/media/images/bookmarks/other.png</href></Icon></IconStyle></Style>
<Placemark><name>Bookmark</name><description></description><styleUrl>#other.png</styleUrl><Point><coordinates>";

$footers = ",0.000000</coordinates></Point></Placemark>";

$bookmarkText = $headers;
$bookmarkText .= $longitude;
$bookmarkText .= ",";
$bookmarkText .= $latitude;
$bookmarkText .= $footers;

$file = "Bookmark.kml";

file_put_contents($file, $bookmarkText);

$script = "sbopenurl \"ifile://localhost/var/mobile/Sites/Scripts/GPSToGalileo/Bookmark.kml\"";
$out = "";

exec ($script, &$out);

 ?>
</body>
</html>