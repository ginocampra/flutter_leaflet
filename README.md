# Flutter Leaflet Package

⚠️ **Under Development** ⚠️

This project is currently under development. Features may change without notice.

Allows you to create pages with Leaflet maps in an integrated way with Flutter.

<img src="images/itworks.png" alt="Flutter Leaflet" height="350">

## Installation

Add the package to your pubspec.yaml:

```bash
flutter pub add flutter_leaflet
```

This package relies on webview_flutter. Ensure you have the necessary platform implementations:

```bash
flutter pub add webview_flutter
flutter pub add webview_flutter_web # For web support
```

## Usage

Import the package:

```dart
import 'package:flutter_leaflet/flutter_leaflet.dart';
```

Use the FlutterLeaflet widget in your build method:

```dart
FlutterLeaflet(
  title: 'Initial Map',
  options: LeafletOptions(
    center: LatLng(-23.347509137997484, -47.84753617004771),
    zoom: 18,
    zoomControl: true,
    minZoom: 13,
    maxZoom: 18,
    googleView: true,
  ),
  markers: [
    LeafletMarker(
      position: LatLng(-23.347509137997484, -47.84753617004771),
      draggable: false,
      title: 'Tatuí - SP',
    ),
  ],
  polygons: [
    LeafletPolygon(
      points: [
        LatLng(-23.34606370264136, -47.84818410873414),
        LatLng(-23.34575341324051, -47.84759938716888),
        LatLng(-23.34615728184211, -47.84729361534119),
        LatLng(-23.34651189716213, -47.84792125225068),
      ],
      popupContent: 'I am a Polygon',
    ),
  ],
  circles: [
    LeafletCircle(
      position: LatLng(-23.346569922234977, -47.84376382827759),
      radius: 80.68230575309364,
      popupContent: 'I am a Circle',
    ),
  ],
)
```

## License

The MIT License (MIT).
