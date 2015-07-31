import 'package:google_maps/google_maps.dart';

//look at styles/images/TEMP_image_outline.png to see the poly
final shape = new MarkerShape()
  ..coords = [9, 31, 0, 14, 0, 6, 6, 0, 15, 0, 21, 6, 21, 14, 12, 31]
  ..type = 'poly';

final medImg = new Icon()
  ..url = 'styles/images/icon_meditech.png'
  // This marker is 22 pixels wide by 32 pixels tall.
  ..scaledSize = new Size(22, 32)
  // The origin for this image is top-left
  // The anchor for this image is bottom-middle
  ..anchor = new Point(11, 32);

final blueImg = new Icon()
  ..url = 'styles/images/icon_blue.png'
  // This marker is 22 pixels wide by 32 pixels tall.
  ..scaledSize = new Size(22, 32)
  // The origin for this image is top-left
  // The anchor for this image is bottom-middle
  ..anchor = new Point(11, 32);

final redImg = new Icon()
  ..url = 'styles/images/icon_red.png'
  // This marker is 22 pixels wide by 32 pixels tall.
  ..scaledSize = new Size(22, 32)
  // The origin for this image is top-left
  // The anchor for this image is bottom-middle
  ..anchor = new Point(11, 32);

final prplImg = new Icon()
  ..url = 'styles/images/icon_purple.png'
  // This marker is 22 pixels wide by 32 pixels tall.
  ..scaledSize = new Size(22, 32)
  // The origin for this image is top-left
  // The anchor for this image is bottom-middle
  ..anchor = new Point(11, 32);

final orngImg = new Icon()
  ..url = 'styles/images/icon_orange.png'
  // This marker is 22 pixels wide by 32 pixels tall.
  ..scaledSize = new Size(22, 32)
  // The origin for this image is top-left
  // The anchor for this image is bottom-middle
  ..anchor = new Point(11, 32);

final retroMapStyle = <MapTypeStyle>[
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD
    ..elementType = MapTypeStyleElementType.LABELS
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = "simplified"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.WATER
    ..elementType = MapTypeStyleElementType.ALL
    ..stylers = <MapTypeStyler>[
      new MapTypeStyler()..color = "#84afa3",
      new MapTypeStyler()..lightness = 52,
      new MapTypeStyler()..visibility = "simplified"
    ],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.TRANSIT
    ..elementType = MapTypeStyleElementType.ALL
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = "simplified"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.LANDSCAPE
    ..elementType = MapTypeStyleElementType.ALL
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = "simplified"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI
    ..elementType = MapTypeStyleElementType.LABELS
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = 'off'],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_BUSINESS
    ..elementType = MapTypeStyleElementType.LABELS
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..visibility = 'on'],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ALL
    ..elementType = MapTypeStyleElementType.ALL
    ..stylers = <MapTypeStyler>[
      new MapTypeStyler()..saturation = -17,
      new MapTypeStyler()..gamma = 0.36
    ],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.TRANSIT_LINE
    ..elementType = MapTypeStyleElementType.GEOMETRY
    ..stylers = <MapTypeStyler>[new MapTypeStyler()..color = "#3F518C"],
];
