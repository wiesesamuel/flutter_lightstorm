import 'package:flutter/material.dart';
import 'dart:math';
import 'package:lsd/buttonType/button.dart';
import 'package:lsd/entity/pin.dart';
import 'package:lsd/entity/pin_type.dart';
class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyApplication createState() => _MyApplication();
}

class _MyApplication extends State<MyStatefulWidget> {
  Icon _IconAF = Icon(Icons.arrow_forward);

  Widget build(BuildContext context) {
    return Scaffold(

      // title label
      appBar: AppBar(
        title: Text('LSD Sample'),
      ),

      // side menu
      drawer: new Drawer(
          child: new ListView(
            children: <Widget> [
              new DrawerHeader(child: new Text('Header'),),
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

              ),
              new ListTile(
                title: new Text('About'),
                onTap: () {},
              ),
            ],
          )
      ),

      // components
      body: Center(

        // touchable ~container
        child: new InkWell(
          // tap action
          onTap: () => print("touched it"),

          // table
          child: Table(
            border: TableBorder.all(color: Colors.black),
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            defaultColumnWidth: FractionColumnWidth(0.25),


            children: [
              TableRow(children: [
                Text("groupbtn"),
                Expanded(child: PinButton()),
                Expanded(child: PinButton()),
                Expanded(child: PinButton()),
              ]),
            ],
          )
        )
      ),

      // bottom
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          onPressed: () => setState(() {
            Transform.rotate(
              angle: pi / 4,
              child: _IconAF,
            );
            print("bitch0");
          }),
          child: _IconAF,

        ),
        FlatButton(
          onPressed: () => setState(() {
            print("bitch1");
          }),
          child: Icon(Icons.arrow_back),

        )
      ]

/*
      // button located at bottom
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          print("bitch");
        }),
        tooltip: 'Increment Counter',
        child: Icon(Icons.arrow_forward),
      ),
      // set location
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      */
    );
  }
}
