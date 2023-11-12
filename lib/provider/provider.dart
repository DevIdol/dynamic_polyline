// ignore_for_file: avoid_print
import 'package:dynamic_polyline/model/model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../service/service.dart';

final polylineProvider = StreamProvider.autoDispose<List<PolylineModel>>(
  (ref) async* {
    try {
      final data = await FirebaseService.getPolylineData();
      final List<PolylineModel> polyline =
          data.map((point) => PolylineModel.fromJson(point)).toList();
      yield polyline;
    } catch (e) {
      print('Error: $e');
    }
  },
);
