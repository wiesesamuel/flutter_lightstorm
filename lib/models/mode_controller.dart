import 'package:flutter/material.dart';
import 'package:lsd/pin/mode_type.dart';

class ModeController extends StatefulWidget {
  @override
  _ModeControllerState createState() => _ModeControllerState();
}

class _ModeControllerState extends State<ModeController> with SingleTickerProviderStateMixin {
  var tabs = [];
  var titles = [];

  TabController _tabController;

  _ModeControllerState() {
    for (ModeType value in ModeType.values) {
      String name = modeTypeHelper.getName(value);
      titles.add(name);
      IconData iconData = modeTypeHelper.getIconData(value);
      tabs.add(Tab(icon: Icon(iconData), text: name,));
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: titles.length,
        child: Scaffold(
          appBar: TabBar(
            isScrollable: true,
            tabs: tabs,

            //onTap: () {pinController.setCurrentModeType(ModeType.values[_tabController.index]);}
          ),
        ));
  }
}
