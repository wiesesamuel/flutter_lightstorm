import 'package:flutter/material.dart';
import 'package:lsd/view/controller_view.dart';
import 'package:lsd/view/settings.dart';

final ControllerView _controllerView = ControllerView();
final SettingsView _settingsView = SettingsView();

final Views defaultView = Views.SIMPLE;

enum Views {
  SIMPLE,
  COMPLEX,
  SETTINGS
}

Widget getView(Views view) {
  switch (view) {
    case Views.SIMPLE:
      return _controllerView;
    case Views.SETTINGS:
      return _settingsView;
    case Views.COMPLEX:
      return Material(
          color: Colors.green,
          child: Center(
            child: Text(
                'Complex View \'$view\'',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                )
            ),
          )
      );
      // TODO: Handle this case.
      break;

    default:
      return Material(
          color: Colors.red,
          child: Center(
            child: Text(
                'Unknown View \'$view\'',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                )
            ),
          )
      );
  }
}


String getViewName(Views view) {
  switch (view) {
    case Views.SIMPLE:
      return "Simple Controller";
    case Views.COMPLEX:
      return "Complex Controller";
    case Views.SETTINGS:
      return "Settings";
    default:
      return "unknown";
  }
}
