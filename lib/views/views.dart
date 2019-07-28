library views;

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_led_app/models/model_controller.dart';
import 'package:flutter_led_app/ledapi/ledapi.dart';
import 'package:flutter_led_app/pin/mode_type.dart';
import 'package:flutter_led_app/platform/platform.dart';
import 'package:flutter/services.dart';
import 'package:flutter_led_app/models/app_theme.dart';

part 'main_view.dart';
part 'settings.dart';
part 'about.dart';
part 'servers.dart';
part 'controller_view.dart';

final MainView mainView = MainView();
final ServerView _serverView = ServerView();
final ControllerView _controllerView = ControllerView();
final SettingsView _settingsView = SettingsView();

final Views defaultView = Views.SERVERS;

enum Views {
  SERVERS,
  SIMPLE,
  COMPLEX,
  SETTINGS
}

Widget getView(Views view) {
  switch (view) {
    case Views.SERVERS:
      return _serverView;
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
    case Views.SERVERS:
      return "Servers";
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
