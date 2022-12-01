import 'dart:io';

String fixture(String name) {
  print(name);
  return File('lib/core/input_data/$name').readAsStringSync();
}
