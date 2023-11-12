import 'package:dynamic_polyline/state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final polylineStateProvider = Provider((ref) => PolylineState());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Maps with Polyline'),
        ),
        body: const Column(
          children: [
            Expanded(
              child: GoogleMapWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class GoogleMapWidget extends HookConsumerWidget {
  const GoogleMapWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(polylineStateProvider);

    final polyline = ref.watch(polylineProvider);

    return GoogleMap(
      onMapCreated: state.onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(25.774, -80.19), // Set your initial position
        zoom: 12.0,
      ),
      polylines: polyline.when(
        data: (polylineData) {
          final data = polylineData
              .map((point) => LatLng(point.lat, point.lng))
              .toList();
          print("=====>${data}");
          return {
            Polyline(
              polylineId: const PolylineId("polyline"),
              points: polylineData
                  .map((point) => LatLng(point.lat, point.lng))
                  .toList(),
              color: Colors.blue,
              width: 5,
            ),
          };
        },
        loading: () => {},
        error: (error, stack) => {},
      ),
    );
  }
}
