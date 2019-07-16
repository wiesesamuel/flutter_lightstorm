/*
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> getLocalFile(String fileName) async {
  final path = await _localPath;
  return File('$path/$fileName');
}

Future<int> readCounter() async {
  try {
    final file = await getLocalFile("dft.json");

    // Read the file
    String contents = await file.readAsString();

    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0
    return 0;
  }
}

Future<File> writeCounter(int counter) async {
  final file = await getLocalFile("dft.json");

  // Write the file
  return file.writeAsString('$counter');
}
*/