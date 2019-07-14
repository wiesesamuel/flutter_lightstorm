import 'package:flutter/material.dart';
import 'package:lsd/view/about.dart';
import 'package:lsd/view/main_view.dart';

class Settings {
  static bool darkMode = true;
}

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text("Dark Mode"),
            value: Settings.darkMode,
            onChanged: (value) {
              Settings.darkMode = value;
              setState(() {
                currentTheme =
                    Settings.darkMode ? AppTheme.Dark : AppTheme.Light;
              });
            },
          ),

          ListTile(
            title: Text("Licenses"),
            onTap: () {
              showLicensePage(context: context);
            },
          ),
          ListTile(
            title: Text("About"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AboutView()),
              );
            },
          ),
        ],
      ),
    );
  }
}
