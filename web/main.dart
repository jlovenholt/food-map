// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library food_map;

import 'dart:html';

import 'package:food_map/nav_menu.dart';
import 'package:food_map/maps/map_initialization.dart';
import 'package:food_map/add/add_location.dart';
import 'package:route_hierarchical/client.dart';

void main() {
  initNavMenu();
  initMapBuilder();
  initAddLoc();

  // Webapps need routing to listen for changes to the URL.
  var router = new Router();
  router.root
//    ..addRoute(name: 'add', path: '/add', enter: showAdd)
    ..addRoute(name: 'settings', path: '/settings', enter: showSettings)
    ..addRoute(name: 'about', path: '/about', enter: showAbout)
    ..addRoute(name: 'map', defaultRoute: true, path: '/', enter: showMap);
  router.listen();
}

void showAbout(RouteEvent e) {
//  querySelector('#add').style.display = 'none';
  querySelector('#settings').style.display = 'none';
  querySelector('#about').style.display = '';
  querySelector('#map').style.display = 'none';
}

//void showAdd(RouteEvent e) {
//  querySelector('#add').style.display = '';
//  querySelector('#settings').style.display = 'none';
//  querySelector('#about').style.display = 'none';
//  querySelector('#map').style.display = 'none';
//}

void showSettings(RouteEvent e) {
//  querySelector('#add').style.display = 'none';
  querySelector('#settings').style.display = '';
  querySelector('#about').style.display = 'none';
  querySelector('#map').style.display = 'none';
}

void showMap(RouteEvent e) {
//  querySelector('#add').style.display = 'none';
  querySelector('#settings').style.display = 'none';
  querySelector('#about').style.display = 'none';
  querySelector('#map').style.display = '';
}
