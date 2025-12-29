import 'package:flutter/material.dart';
import 'package:flutter_leaflet/flutter_leaflet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Leaflet Example')),
        body: const FlutterLeaflet(
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
          polylines: [
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
          rectangles: [
            LeafletRectangle(
              points: [
                LatLng(-23.347683013682527, -47.85067319869996),
                LatLng(-23.346727528670904, -47.84879565238953),
              ],
              popupContent: 'I am a Rectangle',
            ),
          ],
          circles: [
            LeafletCircle(
              position: LatLng(-23.346569922234977, -47.84376382827759),
              radius: 80.68230575309364,
              popupContent: 'I am a Circle',
            ),
          ],
        ),
      ),
    );
  }
}
