import 'package:flutter/material.dart';
import 'package:lsd/controller/controller.dart';
import 'package:lsd/models/app_theme.dart';
import 'package:lsd/pin/mode_type.dart';

class ControllerView extends StatefulWidget {
  @override
  _ControllerViewState createState() => _ControllerViewState();
}

class _ControllerViewState extends State<ControllerView>
    with SingleTickerProviderStateMixin {
  List<Widget> tabs = [];
  List<String> titles = [];

  TabController _tabController;

  _ControllerViewState() {
    for (ModeType value in ModeType.values) {
      String name = modeTypeHelper.getName(value);
      titles.add(name);
      IconData iconData = modeTypeHelper.getIconData(value);
      tabs.add(Tab(icon: Icon(iconData),));
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
    _tabController.addListener(_updateCurrentMode);
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
              controller: _tabController,
              labelColor: getDefaultIconColor(),
            ),
            // components
            body: Center(
              child: ListView(
                children: modelController.getAllMembers(),
              ),
            ),
        ));
  }

  void _updateCurrentMode() {
    pinController.setCurrentModeType(ModeType.values[_tabController.index]);
    modelController.updateUI();
  }
}
