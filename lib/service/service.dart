// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static Future<List<Map<String, dynamic>>> getPolylineData() async {
    await Firebase.initializeApp();

    const storageUrl =
        'https://firebasestorage.googleapis.com/v0/b/dynamic-polyline.appspot.com/o/polyline%2Fpolyline.json?alt=media&token=0c2f6403-e898-440f-aa17-32fa38d82e83';

    final response = await http.get(Uri.parse(storageUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load polyline data');
    }
  }
}
