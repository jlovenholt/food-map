// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library add_location;

import 'dart:html';

import 'package:google_maps/google_maps.dart';
import 'package:google_maps/google_maps_places.dart';
import 'package:food_map/maps/ui_variables.dart';
import 'package:food_map/maps/data_classes.dart';
import 'package:food_map/maps/initialization.dart';
import 'package:food_map/maps/add_markers.dart';

List<Marker> searchMarkers = <Marker>[];
var infoWindowAdd;

initAddLoc() {
  var addBtn = querySelector('.add-btn');
  addBtn.onClick.listen(searchByRadius);
}

searchByRadius(e) {
  ///Remove old markers
  for (Marker mark in searchMarkers) {
    mark.visible = false;
  }
//  if (searchInfoWindow != null) {
//    print(searchInfoWindow);
//    searchInfoWindow.cancel();
//  }
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

//////////////////////////////////////////////
///Search Restaurant Markers
//////////////////////////////////////////////

void createMarker(PlaceResult place) {
  final srchMarker = new Marker(new MarkerOptions()
    ..map = map
    ..position = place.geometry.location
    ..icon = srchImg
    ..shape = shape
    ..zIndex = 3);
  searchMarkers.add(srchMarker);

  addToRestaurants(e) {
    String id = (srchMarker.position.lat.toInt().toString() +
                 place.name.replaceAll(new RegExp(r' '),'') +
    srchMarker.position.lng.toInt().toString());
    var restaurant = new Restaurant(id)
        ..name = place.name
        ..lat = srchMarker.position.lat
        ..lng = srchMarker.position.lng
        ..reviews = [new Review(3,'asdflkjh')]
        ..show = true
        ..website = place.website;
    restaurants.add(restaurant);
    addRestaurant(restaurant);
    infowindow.close();
  }

  srchMarker.onClick.listen((e) {
    openInfoWindow(searchInfoWindow(place), srchMarker);
    infoWindowAdd = querySelector('.addInfoBtn').onClick.listen(addToRestaurants);
  });
}

String searchInfoWindow(PlaceResult place) {
  String searchInfoContent =
  '<div class="info-window">'
    '<div class="info-header">${place.name}'
      '<button>'
        '<i class="icon icon-plus icon addInfoBtn"></i>'
      '</button>'
    '</div>'
  '</div>';
  return searchInfoContent;
}