import 'dart:io';

String fixture(String name) =>
    File('lib/core/input_data/$name').readAsStringSync();
