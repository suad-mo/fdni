import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

String fixture(String name) {
  // print(name);
  return File('lib/core/input_data/$name').readAsStringSync();
}

// Fetch content from the json file
Future<dynamic> readJsonFile(String filePath) async {
  final String response =
      await rootBundle.loadString('lib/core/input_data/$filePath');
  // final String response = await rootBundle.loadString('assets/data/$filePath');
  final data = await jsonDecode(response);
  return data;
}

// Fetch content from the json file
Future<dynamic> readJson(String filePath) async {
  // final String response = await rootBundle.loadString('assets/data/$filePath');
  final String response =
      await rootBundle.loadString('lib/core/input_data/$filePath');
  final data = await jsonDecode(response);
  return data;
}
