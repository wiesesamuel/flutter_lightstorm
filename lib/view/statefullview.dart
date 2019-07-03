import 'package:flutter/material.dart';
import 'dart:math';
import 'package:lsd/models/stripe_controller.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyApplication createState() => _MyApplication();
}

class _MyApplication extends State<MyStatefulWidget> {
  Icon _IconAF = Icon(Icons.arrow_forward);
  bool buttonstate = false;

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
              )
            ],
          )
      ),

      // components
      body: Center(

        // touchable ~container
        child: ListView(
          children: [
            SwitchListTile(
              title: Text("Funny Setting"),
              value: buttonstate,
              onChanged: (e) {
                setState(() {
                  buttonstate = !buttonstate;
                });
              },
            ),
            ListTile(
              title: Text("Tisch"),
              subtitle: Text("Currently on"),
              trailing: StripeController(),
              selected: false,
              onTap: () {},
            ),
            MaterialButton(
              child: Text("Text"),
              onPressed: () {},
            ),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
            StripeController(),
          ],
        ), /*new InkWell(
          // tap action
          onTap: () => print("touched it"),

          // table
          child: Table(
            border: TableBorder.all(color: Colors.black),
            defaultVerticalAlignment: TableCellVerticalAlignment.top,
            defaultColumnWidth: FractionColumnWidth(0.25),


            children: [
              TableRow(children: [
                Mate
                //CustomButton(pin: new Pin(0, PinType.raspberry)),
              ]),
            ],
          )*/
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
