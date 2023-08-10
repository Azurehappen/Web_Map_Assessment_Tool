# Azure Map API tool

This tool allows users to place a blue point on the map and display position information (latitude, longitude, and elevation). It also preloads a GeoJSON file to display feature points on the map. Please note that these points are originally obtained from Google Earth and may not exactly match the feature points' positions in the Azure map. Users should retrieve the feature points for Azure by placing a point on the desired feature point.

Please note that the elevation data is obtained from Bing map API.
Reference:
https://azure.microsoft.com/en-us/updates/azure-maps-elevation-apis-and-render-v2-dem-tiles-will-be-retired-on-5-may-2023/#:~:text=The%20Azure%20Maps%20Elevation%20services,and%20API%20calls%20will%20fail.

https://learn.microsoft.com/en-us/bingmaps/rest-services/elevations/get-elevations

After completing the installation process below, follow this Assessment Process:
1. The html file should already be open and you can see the points. If not, retry the installation or talk with Wang Hu.
2. Open the spreadsheet in the file that lists the points. Arrange it adjacent to the browser.
3. For each point in the spreadsheet:
3a. find the point on the Azure map display.
3b. click on the map at the correct location of the point.
3c. cut and past the coordinates (latitude, longitude, and height) into the spreadsheet. Save at least seven decimal places for angles and three decimal places for elevation. 

To avoid CORS policy restrictions for HTML files, Node.js or Python is required.

Installation Process:
1. If you haven't already, install Node.js by downloading it from the official website: 
```
https://nodejs.org/en/download/
```

2. Install http-server (Using CMD in Windows or Ternimal in Mac OS):
```
npm install -g http-server
```

3. Open the terminal, navigate to the directory containing your index.html file, and run the following command:
```
http-server
```

4. Open your browser and navigate to http://localhost:8080 to view and use the Mapbox API tool. Note that this address may vary. Please check the returned information in the terminal.

5. If there are updates to this tool, to see the updated version, you may have to perform cache clear.
For example, on the webpage of this tool in Google Chrome: Press Ctrl + Shift + R (Windows/Linux) or Cmd + Shift + R (Mac).