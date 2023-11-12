import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineState {
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  Future<void> onMapCreated(GoogleMapController controller) async {
    this.controller.complete(controller);
  }
}
