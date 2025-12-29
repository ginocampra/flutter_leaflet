class LatLng {
  final double lat;
  final double lng;

  const LatLng(this.lat, this.lng);

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class LeafletOptions {
  final LatLng center;
  final double zoom;
  final bool zoomControl;
  final double minZoom;
  final double maxZoom;
  final bool googleView;

  const LeafletOptions({
    this.center = const LatLng(-23.347509137997484, -47.84753617004771),
    this.zoom = 18,
    this.zoomControl = true,
    this.minZoom = 13,
    this.maxZoom = 18,
    this.googleView = false,
  });

  Map<String, dynamic> toJson() => {
        'center': center.toJson(),
        'zoom': zoom,
        'zoomControl': zoomControl,
        'minZoom': minZoom,
        'maxZoom': maxZoom,
        'googleview': googleView,
      };
}

class LeafletMarker {
  final LatLng position;
  final bool draggable;
  final String? title;
  final String? popupContent;

  const LeafletMarker({
    required this.position,
    this.draggable = false,
    this.title,
    this.popupContent,
  });

  Map<String, dynamic> toJson() => {
        'position': position.toJson(),
        'draggable': draggable,
        'title': title,
        'popupContent': popupContent,
      };
}

class LeafletCircle {
  final LatLng position;
  final double radius;
  final String? popupContent;

  const LeafletCircle({
    required this.position,
    required this.radius,
    this.popupContent,
  });

  Map<String, dynamic> toJson() => {
        'position': position.toJson(),
        'radius': radius,
        'popupContent': popupContent,
      };
}

// Polygons, Polylines, and Rectangles are lists of LatLngs (or lists of lists for complex shapes)
// For simplicity, mirroring the Laravel project which seems to take arrays of arrays of coords.

class LeafletPolygon {
  final List<LatLng> points;
  final String? popupContent;

  const LeafletPolygon({
    required this.points,
    this.popupContent,
  });

  List<List<double>> toJson() => points.map((p) => [p.lat, p.lng]).toList();
}

class LeafletPolyline {
  final List<LatLng> points;
  final String? popupContent;

  const LeafletPolyline({
    required this.points,
    this.popupContent,
  });

  List<List<double>> toJson() => points.map((p) => [p.lat, p.lng]).toList();
}

class LeafletRectangle {
  final List<LatLng> points; // Usually 2 points defining bounds
  final String? popupContent;

  const LeafletRectangle({
    required this.points,
    this.popupContent,
  });

  List<List<double>> toJson() => points.map((p) => [p.lat, p.lng]).toList();
}
