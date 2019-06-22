import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyApplication createState() => _MyApplication();
}

class _MyApplication extends State<MyStatefulWidget> {
  int _count = 0;

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
          child: Column(
            // components
            children: <Widget>[

              Text(
                'You have pressed the button $_count times.',
                style: new TextStyle(color: Colors.pink, fontSize: 50),
              ),

              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    onPressed: () => Colors.cyan,
                  )
                ],
              ),

              Text("Tapptapp"),
            ],
          ),
        )
      ),

      // bottom
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),

      // button located at bottom
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _count++;
        }),
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      // set location
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
