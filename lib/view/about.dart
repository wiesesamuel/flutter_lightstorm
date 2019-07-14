
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutView extends StatefulWidget {

  @override
  _AboutViewState createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {

  String content = "";

  @override
  void initState() {
    super.initState();

    // load file
    rootBundle.loadString("assets/about.txt").then((file) {
      content = file;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("About")
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(content, style: TextStyle(fontSize: 23),),
        ),
      ),
    );
  }
}
