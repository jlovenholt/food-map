// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library map_init;

import 'dart:html' hide Animation, Point;

import 'package:google_maps/google_maps.dart';
import 'package:google_maps/google_maps_places.dart';
import 'package:js_wrapping/js_wrapping.dart';

import 'map_vars.dart';
import 'map_data.dart';

GMap map;
final markers = <Marker>[];
InfoWindow infowindow;

void initMapBuilder() {
  infowindow = new InfoWindow();
  buildData();
  final mapOptions = new MapOptions()
    ..zoom = 10
    ..styles = retroMapStyle;
  map = new GMap(document.getElementById("map-canvas"), mapOptions);

  // Try HTML5 geolocation
  if (window.navigator.geolocation != null) {
    window.navigator.geolocation.getCurrentPosition().then((position) {
      final pos =
          new LatLng(position.coords.latitude, position.coords.longitude);

//      final infowindow = new InfoWindow(new InfoWindowOptions()
//        ..position = pos
//        ..content = 'Location found using HTML5.');
//      // FIXME https://code.google.com/p/gmaps-api-issues/issues/detail?id=7908
//      infowindow.open(map);

      map.center = pos;
    }, onError: (error) {
      handleNoGeolocation(true);
    });
  } else {
    // Browser doesn't support Geolocation
    handleNoGeolocation(false);
  }
}

void handleNoGeolocation(bool errorFlag) {
  String content;
  if (errorFlag) {
    content = 'Geolocation service failed.';
  } else {
    content = 'browser doesn\'t support geolocation.';
  }


  //points
  for (final loc in restaurants) {
    final locMarker = new Marker(new MarkerOptions()
      ..position = new LatLng(loc.lat, loc.lng)
      ..map = map
      ..icon = medImg
      ..animation = Animation.DROP
      ..title = loc.name);

    locMarker.onClick.listen((e) {
      infowindow.content = restInfoWindow(loc.name, loc.review);
      infowindow.open(map, locMarker);
    });
  }

  for (final bld in buildings) {
    markers.add(new Marker(new MarkerOptions()
      ..position = new LatLng(bld.lat, bld.lng)
      ..map = map
      ..icon = restImg
      ..animation = Animation.DROP
      ..title = bld.name
      ..clickable = false
      ..zIndex = 1));
  }

  final options = new InfoWindowOptions()
    ..position = new LatLng(44.9106355, -93.503853)
    ..content = content;

  map.center = options.position;
}

restInfoWindow(String name, Review rvws) {
  String htmlRvws = '<div>' + name + '</div><a href="' + 'http://store.steampowered.com/' + '" target="_blank">Steam</a>';
  return htmlRvws;
}
