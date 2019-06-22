import 'package:flutter/material.dart';

/// This is the stateless widget that the main application instantiates.
class staticView extends StatelessWidget {
  staticView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ready, Set, Shop!'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // Implement navigation to shopping cart page here...
              print('Shopping cart opened.');
            },
          ),
        ],
      ),
    );
  }
}
