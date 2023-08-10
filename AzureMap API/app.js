const subscriptionKey = 'ExzBA9VMHlVFv7M6sK9jFVc1NMbps3TApdxrrZJ_aiY';

const map = new atlas.Map('map', {
  center: [-117.328, 33.976],
  zoom: 12,
  view: 'Auto',
  style: 'satellite',
  authOptions: {
    authType: 'subscriptionKey',
    subscriptionKey: subscriptionKey
  }
});

// Load a GeoJSON file
const geojsonUrl = './Corrected_GE.geojson';

// Create two data sources
const dataSourceGeoJson = new atlas.source.DataSource();
const dataSourceClick = new atlas.source.DataSource();

const bingMapsKey = 'AqDcF1ZURfOc1MVzxDURoFM-JeGKLiX6TL3D0uDmGWNIE1zm52ytVsIDL_8Cnbdg';

// Wait for the map to be ready
map.events.add('ready', () => {
  // Add the data sources to the map's sources
  map.sources.add(dataSourceGeoJson);
  map.sources.add(dataSourceClick);

  // Import data from the GeoJSON URL
  dataSourceGeoJson.importDataFromUrl(geojsonUrl);

  // Add a BubbleLayer to render the points as red circles
  map.layers.add(new atlas.layer.BubbleLayer(dataSourceGeoJson, null, {
    radius: 5, // Adjust the circle size as needed
    color: 'red'
  }));

  // Add a BubbleLayer for the single point
  map.layers.add(new atlas.layer.BubbleLayer(dataSourceClick, null, {
    radius: 5,
    color: 'blue'
  }));

  // Add a layer to render the point names in red
  map.layers.add(new atlas.layer.SymbolLayer(dataSourceGeoJson, null, {
    iconOptions: {
      image: ''
    },
    textOptions: {
      textField: ['get', 'name'],
      color: 'red',
      offset: [0, 1.2],
      anchor: 'top'
    }
  }));

  // Add a SymbolLayer for the single point
  map.layers.add(new atlas.layer.SymbolLayer(dataSourceClick, null, {
    iconOptions: {
      image: ''
    },
    textOptions: {
      textField: 'Clicked Point',
      offset: [0, 1.2],
      color: 'blue',
      anchor: 'top'
    }
  }));

  // Click event to add a point to the map and display position information
  map.events.add('click', async (e) => {
    const position = e.position;
  
    // Generate a unique name for the new point
    const name = 'Clicked Point';
  
    // Create a new point feature
    const newPoint = new atlas.data.Feature(new atlas.data.Point(position), { name });
  
    // Clear the data source and add the new point
    dataSourceClick.setShapes([newPoint]);
  
    // Update the reference to the current point
    currentPoint = newPoint;

    // Get elevation for the clicked point using the Bing Maps API
    const url = `http://dev.virtualearth.net/REST/v1/Elevation/List?points=${position[1]},${position[0]}&key=${bingMapsKey}&zoomLevel=${20}`;
  
    try {
      const response = await fetch(url);
      const data = await response.json();
  
      if (data.resourceSets.length > 0 && data.resourceSets[0].resources.length > 0) {
        const elevation = data.resourceSets[0].resources[0].elevations[0];
  
        // Display position information with elevation
        const infoElement = document.getElementById('info');
        infoElement.innerHTML = `
          Latitude: ${position[1].toFixed(9)}<br>
          Longitude: ${position[0].toFixed(9)}<br>
          Elevation: ${elevation.toFixed(4)} meters
        `;
      }
    } catch (error) {
      console.error('Error retrieving elevation:', error);
    }
  });  
});