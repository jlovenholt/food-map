// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library add_location;

import 'dart:html';

import 'package:food_map/maps/map_initialization.dart';
import 'package:google_maps/google_maps.dart';
import 'package:google_maps/google_maps_places.dart';

InfoWindow infowindow;
List<Marker> searchMarkers = <Marker>[];

initAddLoc() {
  var addBtn = querySelector('.add-btn');
  addBtn.onClick.listen(searchByRadius);
}

searchByRadius(e) {
  ///Remove old markers
  for (Marker mark in searchMarkers) {
    mark.visible = false;
  }
  ///Search for new markers
  final request = new PlaceSearchRequest()
    ..location = map.center
    ..bounds = map.bounds
    ..types = ['restaurant'];

  infowindow = new InfoWindow();
  final service = new PlacesService(map);
  service.nearbySearch(request, callback);
}

void callback(List<PlaceResult> results, PlacesServiceStatus status,
              PlaceSearchPagination pagination) {
  if (status == PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      createMarker(results[i]);
    }
  }
}

void createMarker(PlaceResult place) {
  final marker = new Marker(new MarkerOptions()
    ..map = map
    ..position = place.geometry.location);
  searchMarkers.add(marker);

  addToRestaurants(e) {
  }

  marker.onClick.listen((e) {
    infowindow.content = '<div>${place.name}</div><i class="icon icon-plus icon addInfoBtn"></i>';
    infowindow.open(map, marker);
    var addInfoBtn = querySelector('.addInfoBtn');
    addInfoBtn.onClick.listen(addToRestaurants);
  });
}