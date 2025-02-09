import React, { useState } from 'react';
import { MapContainer, TileLayer, Marker, Popup, ZoomControl } from 'react-leaflet';
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';

// Import marker icon images
import markerIcon from 'leaflet/dist/images/marker-icon.png';
import markerIcon2x from 'leaflet/dist/images/marker-icon-2x.png';
import markerShadow from 'leaflet/dist/images/marker-shadow.png';

// Fix for marker icons
delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: markerIcon2x,
  iconUrl: markerIcon,
  shadowUrl: markerShadow,
});

const markers = [
  { 
    id: 1, 
    position: [37.7749, -122.4194], 
    name: 'San Francisco',
    description: 'The cultural, commercial, and financial center of Northern California'
  },
  { 
    id: 2, 
    position: [34.0522, -118.2437], 
    name: 'Los Angeles',
    description: 'The entertainment capital of the world and largest city in California'
  },
  { 
    id: 3, 
    position: [40.7128, -74.0060], 
    name: 'New York',
    description: 'The most populous city in the United States'
  },
];

const customIcon = new L.Icon({
  iconUrl: markerIcon,
  iconRetinaUrl: markerIcon2x,
  shadowUrl: markerShadow,
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
  shadowSize: [41, 41]
});

const Maps = () => {
  const [activeMarker, setActiveMarker] = useState(null);
  const center = [37.7749, -122.4194];

  return (
    <div className="p-6 bg-white rounded-xl shadow-lg">
      <h2 className="text-2xl font-bold text-gray-800 mb-4">Interactive Location Map</h2>
      
      <div className="grid grid-cols-1 lg:grid-cols-4 gap-6">
        <div className="lg:col-span-3">
          <MapContainer 
            center={center} 
            zoom={5} 
            className="rounded-lg shadow-md h-[600px] w-full"
            zoomControl={false}
          >
            <TileLayer
              url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
              attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
              className="transition-opacity duration-200"
            />
            <ZoomControl position="bottomright" />
            
            {markers.map(marker => (
              <Marker 
                key={marker.id} 
                position={marker.position}
                icon={customIcon}
                eventHandlers={{
                  click: () => setActiveMarker(marker),
                  mouseover: (e) => e.target.openPopup(),
                  mouseout: (e) => e.target.closePopup(),
                }}
              >
                <Popup className="rounded-lg">
                  <div className="p-2">
                    <h3 className="font-bold text-gray-800">{marker.name}</h3>
                    <p className="text-sm text-gray-600 mt-1">{marker.description}</p>
                  </div>
                </Popup>
              </Marker>
            ))}
          </MapContainer>
        </div>

        <div className="lg:col-span-1">
          <div className="bg-gray-50 p-4 rounded-lg">
            <h3 className="text-lg font-semibold text-gray-800 mb-4">Locations</h3>
            <div className="space-y-3">
              {markers.map(marker => (
                <div 
                  key={marker.id}
                  className={`p-3 rounded-lg cursor-pointer transition-all duration-200 ${
                    activeMarker?.id === marker.id 
                      ? 'bg-blue-50 border-l-4 border-blue-500'
                      : 'hover:bg-gray-100'
                  }`}
                  onClick={() => setActiveMarker(marker)}
                >
                  <h4 className="font-medium text-gray-800">{marker.name}</h4>
                  <p className="text-sm text-gray-600 mt-1 line-clamp-2">
                    {marker.description}
                  </p>
                </div>
              ))}
            </div>
          </div>

          <div className="mt-4 p-4 bg-gray-50 rounded-lg">
            <h3 className="text-lg font-semibold text-gray-800 mb-2">Map Controls</h3>
            <ul className="text-sm text-gray-600 space-y-2">
              <li>• Click markers to view details</li>
              <li>• Use mouse wheel to zoom</li>
              <li>• Drag to pan the map</li>
              <li>• Click location list to highlight</li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Maps;