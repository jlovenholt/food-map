// Copyright (c) 2015, Jens Loven-Holt. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library map_data;

import 'dart:html' hide Animation, Point;
import 'dart:convert';

import 'package:google_maps/google_maps.dart';
import 'package:food_map/maps/map_initialization.dart';
import 'package:food_map/maps/map_vars.dart';

List<Building> buildings = [];
List<Restaurant> restaurants = [];

importData() {
  HttpRequest.getString('data.json').then((response) {
    Map data = JSON.decode(response);

    if (data.containsKey("meditech")) {
      for (Map bldng in data["meditech"]) {
        Building building = new Building.fromJsonMap(bldng);
        buildings.add(building);
        addMedBuilding(building);
      }
    }
    if (data.containsKey("restaurants")) {
      for (Map food in data["restaurants"]) {
        Restaurant restaurant = new Restaurant.fromJsonMap(food);
        restaurants.add(restaurant);
        addRestaurant(restaurant);
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

class Review {
  int val;
  String cmt;

  Review.fromJsonMap(Map json) {
    val = json["val"];
    cmt = json["cmt"];
  }
}

class Restaurant {
  String id;
  String name;
  num lat;
  num lng;
  List<Review> reviews = [];
  bool show;
  String website;

  Restaurant.fromJsonMap(Map json) {
    id = json["id"];
    name = json["name"];
    lat = json["lat"];
    lng = json["lng"];
    website = json["website"];
    for (Map rvw in json["reviews"]) {
      Review review = new Review.fromJsonMap(rvw);
      reviews.add(review);
    }
    show = true;
  }
}

addMedBuilding(Building building) {
  final medMarker = new Marker(new MarkerOptions()
    ..position = new LatLng(building.lat, building.lng)
    ..map = map
    ..icon = medImg
    ..animation = Animation.DROP
    ..title = building.name
    ..zIndex = 1);

  medMarker.onClick.listen((e) {
    infowindow.content = buildingInfoWindow(building);
    infowindow.open(map, medMarker);
  });
}

addRestaurant(Restaurant restaurant) {
  final infowindow = new InfoWindow(new InfoWindowOptions()
    ..content = restaurantInfoWindow(restaurant)
    ..maxWidth = 300);

  final restMarker = new Marker(new MarkerOptions()
    ..position = new LatLng(restaurant.lat, restaurant.lng)
    ..map = map
    ..icon = restImg
    ..animation = Animation.DROP
    ..title = restaurant.name);

  restMarker.onClick.listen((e) {
    infowindow.open(map, restMarker);
  });
}

String restaurantInfoWindow(Restaurant rest) {
  String htmlRvws =
  '<div class="info-window">'
    '<div class="info-header">${rest.name}'
      '<button>'
        '<a href="${rest.website}" target="_blank">     '
          '<i class="icon icon-external-link-square info-button"></i>'
        '</a>'
      '</button>'
    '</div>' +
    buildInfoReviews(rest) +
  '</div>';
  return htmlRvws;
}

String buildInfoReviews(Restaurant rest) {
  String reviewHtml = "";
  rest.reviews.forEach((review) {
    String starHtml = "";
    for (int i = 0; i < review.val; i++) {
      starHtml = starHtml + '<i class="icon icon-star"></i>';
    }
    reviewHtml = reviewHtml +
    '<div class="info-review">' +
    starHtml +
    '<div class="info-user"></div>'
    '<p>${review.cmt}</p>';
  });
  return reviewHtml;
}

buildingInfoWindow(Building build) {
  String htmlRvws = '<div>MEDITECH ${build.name}</div>';
  return htmlRvws;
}