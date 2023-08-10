mapboxgl.accessToken = 'pk.eyJ1IjoiYXp1cmUxOTk2IiwiYSI6ImNsaDVqdXFrNjFkMWozanFyM2pmNmV1YzIifQ.YrzfuIHBaxFDL8yO6KZRPg';
const map = new mapboxgl.Map({
  container: 'map', // container ID
  // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
  style: 'mapbox://styles/mapbox/streets-v12', // style URL
  center: [-117.328, 33.976], // starting position [lng, lat]
  zoom: 9 // starting zoom
});

// Change map style to satellite map
const layerId = "satellite-v9";
map.setStyle('mapbox://styles/mapbox/' + layerId);

const geojsonUrl = './Corrected_GE.geojson';
const circleColor = '#B42222';

map.on('load', () => {
  // Load the GeoJSON file and add it as a source
  map.addSource('points', {
    type: 'geojson',
    data: geojsonUrl
  });

  // Add a circle layer to visualize the points
  map.addLayer({
    id: 'points-circle',
    type: 'circle',
    source: 'points',
    paint: {
      'circle-radius': 5,
      'circle-color': circleColor
    }
  });

  // Add a symbol layer to display the 'name' for each point
  map.addLayer({
    id: 'points-label',
    type: 'symbol',
    source: 'points',
    layout: {
      'text-field': ['get', 'name'],
      'text-font': ['Open Sans Semibold', 'Arial Unicode MS Bold'],
      'text-offset': [0, 1.25],
      'text-anchor': 'top',
      'icon-allow-overlap': true,
      'text-allow-overlap': true
    },
    paint: {
      'text-color': circleColor
    }
  });

  // add the digital elevation model tiles
  map.addSource('mapbox-dem', {
    type: 'raster-dem',
    url: 'mapbox://mapbox.mapbox-terrain-dem-v1',
    tileSize: 512,
    maxzoom: 22
  });
  map.setTerrain({ 'source': 'mapbox-dem', 'exaggeration': 1 });

  map.on('click', (e) => {
    const { lng, lat } = e.lngLat;
    marker.setLngLat([lng, lat]);
    // Get the elevation using queryTerrainElevation
    const elevation = map.queryTerrainElevation(e.lngLat);
    displayPositionInfo(lat, lng, elevation);
  });
});

const marker = new mapboxgl.Marker()
    .setLngLat([-117.328456, 33.976456])
    .addTo(map);

function displayPositionInfo(lat, lng, elevation) {
  const infoElement = document.getElementById('info');
  infoElement.innerHTML = `
      Latitude: ${lat.toFixed(9)}<br>
      Longitude: ${lng.toFixed(9)}<br>
      Elevation: ${elevation.toFixed(4)} meters
  `;
}
