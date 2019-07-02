/**
 * Created by BRITENET on 13.06.2019.
 */
({
    initiateMap: function(component) {
        let map = L.map('map', {
                zoomControl: true,
                tap: false,
                markerZoomAnimation: true
            })
            .setView([42.7589211, 7.5564128], 3);
        L.tileLayer(
            'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}', {
                attribution: 'Tiles © Esri'
            }).addTo(map);
        component.set("v.map", map);
        let popup = L.popup();

        function onMapClick(e) {
            popup
                .setLatLng(e.latlng)
                .setContent(e.latlng.toString())
                .openOn(map);
        }
        map.on('click', onMapClick);
    },

    getMultiplePins: function(component, event) {
        let shops = event.getParam('accountList');
        map = component.get('v.map');
        let markers = [];
        let markersPinned = component.get('v.markers');
        if (markersPinned.length > 0) {
            markersPinned.forEach(function(marker) {
                map.removeLayer(marker);
            })
        }
        for (let i = 0; i < shops.length; i++) {
            let shop = shops[i];
            if (typeof shop.TW_Geolocation__Latitude__s != 'undefined' && typeof shop.TW_Geolocation__Longitude__s != 'undefined') {
                let latLng = [shop.TW_Geolocation__Latitude__s, shop.TW_Geolocation__Longitude__s];
                let marker = L.marker(latLng, {
                    shop: shop
                });
                marker.bindPopup(shop.Name);
                markers.push(marker);
            }
        }
        if (markers.length > 0) {
            markers.forEach(function(markerToPin) {
                map.addLayer(markerToPin);
            })
        }
        component.set('v.markers', markers);
    },

    getSinglePin: function(component, event) {
        let shops = [];
        let shop = event.getParam('account');
        shops.push(shop);
        map = component.get('v.map');
        let markers = [];
        let markersPinned = component.get('v.markers');
        if (markersPinned.length > 0) {
            markersPinned.forEach(function(marker) {
                map.removeLayer(marker);
            })
        }
        for (let i = 0; i < shops.length; i++) {
            let shop = shops[i];
            if (typeof shop.TW_Geolocation__Latitude__s != 'undefined' && typeof shop.TW_Geolocation__Longitude__s != 'undefined') {
                let latLng = [shop.TW_Geolocation__Latitude__s, shop.TW_Geolocation__Longitude__s];
                let marker = L.marker(latLng, {
                    shop: shop
                });
                marker.bindPopup(shop.Name);
                markers.push(marker);
            }
        }
        if (markers.length > 0) {
            markers.forEach(function(markerToPin) {
                map.addLayer(markerToPin);
            })
            map.panTo([shops[0].TW_Geolocation__Latitude__s, shops[0].TW_Geolocation__Longitude__s]);
        }
        component.set('v.markers', markers);
    },

    clearMapPins: function(component) {
        let markersPinned = component.get('v.markers');
        if (markersPinned.length > 0) {
            markersPinned.forEach(function(marker) {
                map.removeLayer(marker);
            })
        }
        component.set('v.markers', []);
    },
})