part of views;

class ControllerView extends StatefulWidget {
  @override
  _ControllerViewState createState() => _ControllerViewState();
}

class _ControllerViewState extends State<ControllerView>
    with SingleTickerProviderStateMixin {
  List<Widget> tabs = [];
  List<String> titles = [];

  Timer refreshTimer;
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

    // update state on open
    update();

    // periodically poll
    refreshTimer = Timer.periodic(Duration(milliseconds: 250), (timer) => update());
  }

  void update() {
    modelController.updateMembers().then((v) {
      if (mounted)
        setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    refreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: titles.length,
        child: Scaffold(
            appBar: TabBar(
              //isScrollable: true,
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
