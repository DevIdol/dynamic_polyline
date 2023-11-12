class PolylineModel {
  final double lat;
  final double lng;

  PolylineModel({required this.lat, required this.lng});

  factory PolylineModel.fromJson(Map<String, dynamic> json) {
    return PolylineModel(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
