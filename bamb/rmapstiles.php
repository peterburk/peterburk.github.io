<?php

    header('Content-Type: text/html; charset=utf-8');

    if (isset($_SERVER['HTTP_ORIGIN'])) {
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
    }
    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");         

        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");

    }

$zoom = $_GET['z'];
$column = $_GET['x'];
$row = $_GET['y'];
$db = $_GET['db'];

$row = pow(2,$zoom) - $row - 1;
$zoom = 17 - $zoom;

  try
  {
    // Open the database
    $conn = new PDO("sqlite:$db");

    // Query the tiles view and echo out the returned image
	$sql = "SELECT * FROM tiles WHERE z = $zoom AND x = $column AND y = $row";

	$q = $conn->prepare($sql);
	$q->execute();

	$q->bindColumn(1, $x);
	$q->bindColumn(2, $y);
	$q->bindColumn(3, $z);
	$q->bindColumn(5, $image, PDO::PARAM_LOB);

	while($q->fetch())
	{
	header("Content-Type: image/png");
	echo $image;
	}
  }
  catch(PDOException $e)
  {
    print 'Exception : '.$e->getMessage();
  }
?>