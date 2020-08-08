import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/models/models.dart';
import 'package:Envely/pages/tabs/tabs.dart';

const TabNb = 5;
const MajorTab = 2;

enum EnvelyTabPosition {
  BudgetTab,
  SpendingTab,
  AssistantTab,
  AccountsTab,
  ParametersTab
}

class HomePage extends StatefulWidget {
  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: TabNb, initialIndex: MajorTab);
    _tabController.addListener(() {
      // Set state to make sure that the [EnvelyTab] widgets get updated when changing tabs.
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
          title: EnvelyTitle(
        tabController: _tabController,
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          width: 70.0,
          height: 70.0,
          child: new RawMaterialButton(
              shape: new CircleBorder(),
              fillColor: Colors.lightGreen,
              elevation: 2.0,
              child: Icon(
                Icons.assistant,
                size: 30,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              onPressed: () {
                _tabController.animateTo(MajorTab);
              })),
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: const CircularNotchedRectangle(),
          child: TabBar(
              labelStyle: TextStyle(fontSize: 12.0),
              controller: _tabController,
              indicatorColor: Theme.of(context).secondaryHeaderColor,
              tabs: _buildTabs(context))),
      body: TabBarView(
        controller: _tabController,
        children: [
          Icon(Icons.pie_chart),
          Icon(Icons.assessment),
          Icon(Icons.assistant),
          Icon(Icons.account_balance_wallet),
          SettingsTab(user: widget.user),
        ],
      ),
    );
  }

  List<Widget> _buildTabs(BuildContext context) {
    Map<int, Widget> map = {};
    List<Widget> list = [];

    map[EnvelyTabPosition.BudgetTab.index] = EnvelyTab(
        position: EnvelyTabPosition.BudgetTab.index,
        text: "Budget",
        iconData: Icons.pie_chart,
        tabController: _tabController);
    map[EnvelyTabPosition.SpendingTab.index] = EnvelyTab(
        position: EnvelyTabPosition.SpendingTab.index,
        text: "Spending",
        iconData: Icons.assessment,
        tabController: _tabController);
    map[EnvelyTabPosition.AssistantTab.index] = EnvelyTab(
        position: EnvelyTabPosition.AssistantTab.index,
        text: "Assistant",
        iconData: null,
        tabController: _tabController);
    map[EnvelyTabPosition.AccountsTab.index] = EnvelyTab(
        position: EnvelyTabPosition.AccountsTab.index,
        text: "Accounts",
        iconData: Icons.account_balance_wallet,
        tabController: _tabController);
    map[EnvelyTabPosition.ParametersTab.index] = EnvelyTab(
        position: EnvelyTabPosition.ParametersTab.index,
        text: "Settings",
        iconData: Icons.account_circle,
        tabController: _tabController);

    for (int i = 0; i < TabNb; i++) list.add(map[i]);
    return list;
  }
}

class EnvelyTitle extends StatefulWidget {
  final TabController tabController;

  const EnvelyTitle({this.tabController});

  @override
  _EnvelyTitleState createState() => _EnvelyTitleState();
}

class _EnvelyTitleState extends State<EnvelyTitle> {
  @override
  Widget build(BuildContext context) {
    if (widget.tabController.index == EnvelyTabPosition.BudgetTab.index)
      return Text("Budget");
    if (widget.tabController.index == EnvelyTabPosition.SpendingTab.index)
      return Text("Spending");
    if (widget.tabController.index == EnvelyTabPosition.AssistantTab.index)
      return Text("Assistant");
    if (widget.tabController.index == EnvelyTabPosition.AccountsTab.index)
      return Text("Accounts");
    if (widget.tabController.index == EnvelyTabPosition.ParametersTab.index)
      return Text("Parameters");
    return Text("unkown");
  }
}

class EnvelyTab extends StatefulWidget {
  final int position;
  final TabController tabController;
  final String text;
  final IconData iconData;

  const EnvelyTab(
      {this.position, this.tabController, this.text, this.iconData});

  @override
  _EnvelyTabState createState() => _EnvelyTabState();
}

class _EnvelyTabState extends State<EnvelyTab> {
  @override
  Widget build(BuildContext context) {
    Widget displayedText;

    if (widget.tabController.index == widget.position &&
        widget.tabController.index != 2)
      displayedText = Text(widget.text, softWrap: false);
    else
      displayedText = Row();

    return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Tab(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Container(
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
                  child: Icon(widget.iconData)),
              displayedText
            ])));
  }
}
