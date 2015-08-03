// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library map_data;

import 'dart:html';
import 'dart:convert';

List<Building> buildings = [];
List<Restaurant> restaurants = [];

void buildData() {
  HttpRequest.getString('data.json').then((response) {
    Map data = JSON.decode(response);

    if (data.containsKey("meditech")) {
      for (Map bldng in data["meditech"]) {
        buildings.add(new Building.fromJsonMap(bldng));
      }
    }
    if (data.containsKey("restaurants")) {
      for (Map food in data["restaurants"]) {
        restaurants.add(new Restaurant.fromJsonMap(food));
      }
    }
  });
}

class Building {
  String id;
  String name;
  num lat;
  num lng;
  bool show;

  Building.fromJsonMap(Map json) {
    id = json["id"];
    name = json["name"];
    lat = json["lat"];
    lng = json["lng"];
    show = true;
  }
}

class Restaurant {
  String id;
  String name;
  num lat;
  num lng;
  Review review;
  bool show;

  Restaurant.fromJsonMap(Map json) {
    id = json["id"];
    name = json["name"];
    lat = json["lat"];
    lng = json["lng"];
    show = true;
  }
}

class Review {
  num val;
  String cmt;

  Review.fromJsonMap(Map json) {
    val = json["val"];
    cmt = json["cmt"];
  }
}
