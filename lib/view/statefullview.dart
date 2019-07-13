import 'package:flutter/material.dart';
import 'package:lsd/Controller/controller.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyApplication createState() => _MyApplication();
}

class _MyApplication extends State<MyStatefulWidget> {

  Widget build(BuildContext context) {
    return Scaffold(

      // title label
      appBar: AppBar(
        title: Text('LED'),
      ),

      // side menu
      drawer: new Drawer(
          child: new ListView(
            children: <Widget> [
              new DrawerHeader(child: new Text('LED'),),
              new ListTile(
                title: new Text('First Menu Item'),
                onTap: () {},
              ),
              new ListTile(
                title: new Text('Second Menu Item'),
                onTap: () {},
              ),
              new Divider(),
              new ListTile(
                title: new Text('About'),
                onTap: () {},
              )
            ],
          )
      ),

      // components
      body: Center(
        child: ListView(
          children: modelController.getAllMembers(),
        ),
      ),

    );
  }
}
