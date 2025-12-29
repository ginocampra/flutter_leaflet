import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'models.dart';

export 'models.dart';

class FlutterLeaflet extends StatefulWidget {
  final LeafletOptions options;
  final List<LeafletMarker> markers;
  final List<LeafletCircle> circles;
  final List<LeafletPolygon> polygons;
  final List<LeafletPolyline> polylines;
  final List<LeafletRectangle> rectangles;
  final String? title;

  const FlutterLeaflet({
    super.key,
    this.options = const LeafletOptions(googleView: true),
    this.markers = const [
      LeafletMarker(
        position: LatLng(-23.347509137997484, -47.84753617004771),
        draggable: false,
        title: 'Tatuí - SP',
      ),
    ],
    this.circles = const [
      LeafletCircle(
        position: LatLng(-23.346569922234977, -47.84376382827759),
        radius: 80.68230575309364,
        popupContent: 'I am a Circle',
      ),
    ],
    this.polygons = const [
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
    this.polylines = const [
      LeafletPolyline(
        points: [
          LatLng(-23.348914298657980, -47.850147485733040),
          LatLng(-23.347850469110245, -47.848109006881714),
          LatLng(-23.349209805352476, -47.847293615341194),
          LatLng(-23.347781516900888, -47.844675779342660),
        ],
        popupContent: 'I am a Polyline',
      ),
    ],
    this.rectangles = const [
      LeafletRectangle(
        points: [
          LatLng(-23.347683013682527, -47.85067319869996),
          LatLng(-23.346727528670904, -47.84879565238953),
        ],
        popupContent: 'I am a Rectangle',
      ),
    ],
    this.title = 'Initial Map',
  });

  @override
  State<FlutterLeaflet> createState() => _FlutterLeafletState();
}

class _FlutterLeafletState extends State<FlutterLeaflet> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    
    if (!kIsWeb) {
      _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      _controller.setBackgroundColor(const Color(0x00000000));
      _controller.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      );
    }
    
    _controller.loadHtmlString(_generateHtml());
  }

  String _generateHtml() {
    final optionsJson = jsonEncode(widget.options.toJson());
    final markersJson = jsonEncode(widget.markers.map((e) => e.toJson()).toList());
    final circlesJson = jsonEncode(widget.circles.map((e) => e.toJson()).toList());
    final polygonsJson = jsonEncode(widget.polygons.map((e) => e.toJson()).toList());
    final polylinesJson = jsonEncode(widget.polylines.map((e) => e.toJson()).toList());
    final rectanglesJson = jsonEncode(widget.rectangles.map((e) => e.toJson()).toList());

    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'>
    <style>
        body { margin: 0; padding: 0; }
        #map { width: 100%; height: 100vh; }
        .text-center { text-align: center; }
    </style>
    <link rel='stylesheet' href='https://unpkg.com/leaflet@1.9.4/dist/leaflet.css' crossorigin='' />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-control-geocoder/dist/Control.Geocoder.css" />
</head>
<body>
    ${widget.title != null ? "<h1 class='text-center'>${widget.title}</h1>" : ""}
    <div id='map'></div>

    <script src='https://unpkg.com/leaflet@1.9.4/dist/leaflet.js' crossorigin=''></script>
    <script src="https://unpkg.com/leaflet-control-geocoder/dist/Control.Geocoder.js"></script>
    <script>
        let map, markers = [];

        function initMap() {
            const options = $optionsJson;
            const initialMarkers = $markersJson;
            const initialCircles = $circlesJson;
            const initialPolygons = $polygonsJson;
            const initialPolylines = $polylinesJson;
            const initialRectangles = $rectanglesJson;

            map = L.map('map', {
                center: options.center,
                zoom: options.zoom || 18,
                zoomControl: options.zoomControl !== false,
                minZoom: options.minZoom || 13,
                maxZoom: options.maxZoom || 18,
            });

            var osm = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution: '© OpenStreetMap'
            });

            if (options.googleview) {
                var imagens = L.tileLayer('https://mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}', {
                    attribution: '© Google Maps'
                });
                var menuBase = {
                    "Google Maps": imagens,
                    "OpenStreetMap": osm
                };
                map.addLayer(imagens);
                L.control.layers(menuBase).addTo(map);
            } else {
                map.addLayer(osm);
            }

            if (initialMarkers && initialMarkers.length > 0) { initMarkers(initialMarkers); }
            if (initialCircles && initialCircles.length > 0) { initCircles(initialCircles); }
            if (initialPolygons && initialPolygons.length > 0) { initPolygons(initialPolygons); }
            if (initialPolylines && initialPolylines.length > 0) { initPolylines(initialPolylines); }
            if (initialRectangles && initialRectangles.length > 0) { initRectangles(initialRectangles); }
        }

        function initMarkers(initialMarkers) {
            for (let index = 0; index < initialMarkers.length; index++) {
                const data = initialMarkers[index];
                const marker = L.marker(data.position, {
                    draggable: data.draggable
                }).addTo(map);
                
                if (data.popupContent) {
                    marker.bindPopup(data.popupContent);
                } else if (data.title) {
                    marker.bindPopup(data.title);
                }
                
                markers.push(marker);
            }
        }

        function initCircles(initialCircles) {
            for (let index = 0; index < initialCircles.length; index++) {
                const data = initialCircles[index];
                const circle = L.circle(data.position, {radius: data.radius}).addTo(map);
                if (data.popupContent) circle.bindPopup(data.popupContent);
            }
        }

        function initPolygons(initialPolygons) {
            for (let index = 0; index < initialPolygons.length; index++) {
                const data = initialPolygons[index];
                const polygon = L.polygon(data).addTo(map);
                if (data.popupContent) polygon.bindPopup(data.popupContent);
            }
        }

        function initPolylines(initialPolylines) {
            for (let index = 0; index < initialPolylines.length; index++) {
                const data = initialPolylines[index];
                const polyline = L.polyline(data).addTo(map);
                if (data.popupContent) polyline.bindPopup(data.popupContent);
            }
        }

        function initRectangles(initialRectangles) {
            for (let index = 0; index < initialRectangles.length; index++) {
                const data = initialRectangles[index];
                const rectangle = L.rectangle(data).addTo(map);
                if (data.popupContent) rectangle.bindPopup(data.popupContent);
            }
        }

        initMap();
    </script>
</body>
</html>
    ''';
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
