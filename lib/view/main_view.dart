import 'package:flutter/material.dart';
import 'package:flutter_led_app/controller/controller.dart';
import 'package:flutter_led_app/models/app_theme.dart';
import 'package:flutter_led_app/view/views.dart';

class MainView extends StatefulWidget {
  final ReactiveController reactiveController = ReactiveController();

  _MainViewState createState() => _MainViewState(reactiveController);

  void updateUI() => reactiveController.updateUI();
}

class _MainViewState extends State<MainView> {
  final ReactiveController reactiveController;

  _MainViewState(this.reactiveController) {
    reactiveController.updateUI = () {
      setState(() {
        modelController.updateUI();
      });
    };
  }

  static Views _currentView = defaultView;
  static Widget _viewWidget = getView(_currentView);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appThemes[currentTheme],
      home: StatefulBuilder(
        builder: (BuildContext context, StateSetter state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(getViewName(_currentView)),
              elevation: 5.0,
            ),
            body: _viewWidget,
            drawer: Drawer(
                child: new ListView(
              children: <Widget>[
                new DrawerHeader(
                  child: new Text('LED'),
                ),
                ListTile(
                    title: new Text(getViewName(Views.SIMPLE)),
                    trailing: Icon(Icons.sentiment_satisfied),
                    onTap: () => setState(() {
                          _setView(Views.SIMPLE);
                          Navigator.of(context).pop();
                        })),
                ListTile(
                    title: new Text(getViewName(Views.COMPLEX)),
                    trailing: Icon(Icons.settings_input_component),
                    onTap: () => setState(() {
                          _setView(Views.COMPLEX);
                          Navigator.of(context).pop();
                        })),
                Divider(),
                ListTile(
                    title: new Text(getViewName(Views.SETTINGS)),
                    trailing: Icon(Icons.settings),
                    onTap: () => setState(() {
                          _setView(Views.SETTINGS);
                          Navigator.of(context).pop();
                        })),
              ],
            )),
          );
        },
      ),
    );
  }

  void _setView(Views view) {
    if (_currentView == view) return;
    _currentView = view;
    _viewWidget = getView(_currentView);
  }
}

// accessible functions holder
class ReactiveController {
  Function updateUI;
}
