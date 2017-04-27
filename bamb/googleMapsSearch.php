<?php
$coordinates = $_GET['location'];
$thisRadius = $_GET['radius'];
$searchText = $_GET['query'];

$searchText = urlencode($searchText);

$thisUrl = "https://maps.googleapis.com/maps/api/place/textsearch/json?location=".$coordinates."&radius=".$thisRadius."&key=AIzaSyC49dQLf5m5pTJ0wBuCJQoae9uxqYWjQhw&query=".$searchText;

// exec ("curl \"".$thisUrl."\"", $out);

$out = file_get_contents($thisUrl);

print($out);

?>