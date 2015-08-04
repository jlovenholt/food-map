// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library map_init;

import 'dart:html' hide Animation, Point;

import 'package:google_maps/google_maps.dart';

import 'package:food_map/maps/map_vars.dart';
import 'package:food_map/maps/map_data.dart';

GMap map;
final markers = <Marker>[];
InfoWindow infowindow;

void initMapBuilder() {
  infowindow = new InfoWindow();
  importData();
  final mapOptions = new MapOptions()
    ..zoom = 10
    ..mapTypeControl = false
    ..streetViewControl = false
    ..minZoom = 6
    ..maxZoom = 20
    ..styles = retroMapStyle;
  map = new GMap(document.getElementById("map-canvas"), mapOptions);

  // Try HTML5 geolocation
  window.navigator.geolocation.getCurrentPosition().then((position) {
    final initPos = new LatLng(position.coords.latitude, position.coords.longitude);
    map.center = initPos;
  }, onError: (error) {
    final initPos = new LatLng(44.9106355, -93.503853);
    map.center = initPos;
    print('ERROR: Geolocation service failed.  Defaulting to Minnetonka building');
  });
}

//getLatLng(var zipReturn) {
//  HttpRequest.getString('http://maps.googleapis.com/maps/api/geocode/json?address=${zipReturn}').then((zipJson) {
//    var data = JSON.decode(zipJson);
//    if ("OK" == data["status"]) {
//      return new LatLng(data['results'][0]['geometry']['location']['lat'],
//      data['results'][0]['geometry']['location']['lng']);
//    } else {
//      return new LatLng(44.9106355, -93.503853);
//    }
//  });
//}