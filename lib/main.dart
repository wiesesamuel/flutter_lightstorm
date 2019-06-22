// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'package:lsd/view/homeview.dart';
import 'package:lsd/view/statefullview.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.cyan,
      title: "LSD",
      home: MyStatefulWidget(),
    );
  }
}
