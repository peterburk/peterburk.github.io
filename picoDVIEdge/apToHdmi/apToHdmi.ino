#include <WiFi.h>
#include <WebServer.h>
#include <PicoDVI.h>

#include "hardware/watchdog.h"

DVItext1 display(DVI_RES_640x240p60, pico_sock_cfg);

void handle_OnConnect();
void handle_update();
void handle_restart();
void handle_NotFound();
void software_reset();
String HTML();
String status = "Connected";
/*Specifying the SSID and Password of the AP*/
 
const char* ap_ssid = "PicoW-AP"; //Access Point SSID
const char* ap_password= "123456789"; //Access Point Password
uint8_t max_connections=1;//Maximum Connection Limit for AP
int current_stations=0, new_stations=0;

IPAddress local_IP(192, 168, 4, 1);  // Set your desired static IP address
IPAddress gateway(192, 168, 4, 1);   // Usually the same as the IP address
IPAddress subnet(255, 255, 255, 0);
IPAddress IP;

//Specifying the Webserver instance to connect with HTTP Port: 80
WebServer server(80);
 
void setup() {
  //Start the serial communication channel
  Serial.begin(9600);
  //while (!Serial); // Wait untill serial is available
  Serial.println();
 
  WiFi.mode(WIFI_AP);
  WiFi.softAPConfig(local_IP, gateway, subnet);  // Configure static IP
   
  //Setting the AP Mode with SSID, Password, and Max Connection Limit
  if(WiFi.softAP(ap_ssid,ap_password,1,false,max_connections)==true)
  {
    Serial.print("Access Point is Created with SSID: ");
    Serial.println(ap_ssid);
    Serial.print("Max Connections Allowed: ");
    Serial.println(max_connections);
    Serial.print("Access Point IP: ");
    Serial.println(WiFi.softAPIP());
  }
  else
  {
    Serial.println("Unable to Create Access Point");
  }
 
  //Specifying the functions which will be executed upon corresponding GET request from the client
  server.on("/",HTTP_GET, handle_OnConnect);
  server.on("/update", handle_update);
  server.on("/restart",handle_restart);
  server.onNotFound(handle_NotFound);
   
  //Starting the Server
  server.begin();
  Serial.println("HTTP Server Started");

  if (!display.begin()) { // Blink LED if insufficient RAM
    pinMode(LED_BUILTIN, OUTPUT);
    for (;;) digitalWrite(LED_BUILTIN, (millis() / 500) & 1);
  }

  display.print("PicoDVI started");

}
 
void loop() {
  //Assign the server to handle the clients
  server.handleClient();
     
  //Continuously check how many stations are connected to Soft AP and notify whenever a new station is connected or disconnected
  new_stations=WiFi.softAPgetStationNum();
   
  if(current_stations<new_stations)//Device is Connected
  {
    current_stations=new_stations;
    Serial.print("New Device Connected to SoftAP... Total Connections: ");
    Serial.println(current_stations);
  }
   
  if(current_stations>new_stations)//Device is Disconnected
  {
    current_stations=new_stations;
    Serial.print("Device disconnected from SoftAP... Total Connections: ");
    Serial.println(current_stations);
  }
 
  //Turn the LEDs ON/OFF as per their status set by the connected client
   
}
 
void handle_OnConnect()
{
  status = "Connected to AP";
  Serial.println("Client Connected");
  server.send(200, "text/html", HTML()); 
}
 
void handle_update()
{
  status = "Update initiated...";
  Serial.println("Update initiated...");
  String ssid_text = server.arg("ssid_txt");
  display.print(ssid_text + "\n");

  //String pwd_text = server.arg("pwd_txt");
  server.send(200, "text/html", HTML());
  //Serial.printf("SSID: %s\n", ssid_text.c_str());
  //Serial.printf("Password: %s\n", pwd_text.c_str());
  status = "Update complete!";
  //delay(1000);
  server.send(200, "text/html", HTML());
}
 
void handle_restart()
{
  status = "Restart initiated...";
  Serial.println("Restart initiated...");
  server.send(200, "text/html", HTML());
  delay(700);
  software_reset();
}
 

void handle_NotFound()
{
  server.send(404, "text/plain", "Not found");
}
 
String HTML()
{
  String msg="<!DOCTYPE html> <html>\n";
  msg+="<head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=no\">\n";
  msg+="<title>Config Update</title>\n";
  msg+="<style>html {font-family: Helvetica; display: inline-block; margin: 0px auto; text-align: center;}\n";
  msg+="body {margin-top: 50px;} h1 {color: #444444; margin: 50px auto 30px;} h3 {color: #444444; margin-bottom: 50px;}\n";
  msg+=".button {display: block; width: 180px; background-color: #0d81ec; border: none; color: white; padding: 13px 30px; text-decoration: none; font-size: 25px; margin: 0px auto 35px; cursor: pointer; border-radius: 4px;}\n";
  msg+=".button-update {background-color: #0d81ec;}\n";
  msg+=".button-update:active {background-color: #0d81ec;}\n";
  msg+=".button-restart {background-color: #ff0000;}\n";
  msg+=".button-restart:active {background-color: #ff0000;}\n";
  msg+=".textbox {width: 200px; height: 30px; border: none; background-color: #f48100; color: white; padding: 5px; font-size: 16px; border-radius: 4px; margin: 0px auto 35px;}\n";
  msg+=".status-field {width: 300px; height: 30px; border: none; background-color: #ffffff; color: black; padding: 5px; font-size: 16px; border-radius: 4px; margin: 0px auto 15px;}\n";
  msg+="</style>\n";
  msg+="</head>\n";
  msg+="<body>\n";
  msg+="<h1>PicoW to HDMI</h1>\n";
  msg+="<h3>Enter your text here:</h3>\n";
  msg+="<form method='POST' action='/update'>\n";
  msg+="<input type=\"text\" class=\"textbox\" name=\"ssid_txt\" id=\"ssid_txt\">\n";
  msg+="<input type='submit' value='Update' class=\"button button-update\">\n";
  msg+="</form>\n";
  msg+="</form>\n";
  msg+="<p>Status:</p>\n";

  msg+="<input type=\"text\" class=\"status-field\" readonly name=\"status_txt\" value=\"" + status + "\">\n";
   
  msg+="</body>\n";
  msg+="</html>\n";
  Serial.printf("%s",msg.c_str());
  return msg;
}

void software_reset()
{
    watchdog_enable(1, 1);
    while(1);
}