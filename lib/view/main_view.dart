import 'package:flutter/material.dart';
import 'package:lsd/view/views.dart';

enum AppTheme { Light, Dark }

final appThemes = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.indigo,
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
  )
};

AppTheme currentTheme = AppTheme.Dark;

class MainView extends StatefulWidget {
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
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
