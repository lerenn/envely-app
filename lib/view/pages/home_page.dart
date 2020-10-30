import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:Envely/models/models.dart';

import '../widgets/widgets.dart';

const TabNb = 5;

enum EnvelyTabPosition {
  PreviewTab,
  BudgetTab,
  SpendingsTab,
  AccountsTab,
  SettingsTab
}

class HomePage extends StatefulWidget {
  final User user;
  final BudgetControllerSingleton controller;

  HomePage({Key key, this.user})
      : controller = BudgetControllerSingleton(),
        super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  EnvelyAppBarBuilder _appBarBuilder;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: TabNb);
    _tabController.addListener(() {
      // Set state to make sure that the [EnvelyTab] widgets get updated when changing tabs.
      setState(() {});
    });
    _appBarBuilder = EnvelyAppBarBuilder();
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
      appBar: _appBarBuilder.appBar(context, _tabController),
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: const CircularNotchedRectangle(),
          child: TabBar(
              labelStyle: TextStyle(fontSize: 12.0),
              labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
              controller: _tabController,
              indicatorColor: Theme.of(context).colorScheme.onPrimary,
              tabs: _buildTabs(context))),
      body: TabBarView(
        controller: _tabController,
        children: _buildTabsContent(context),
      ),
    );
  }

  List<Widget> _buildTabs(BuildContext context) {
    Map<int, Widget> map = {};
    List<Widget> list = [];

    map[EnvelyTabPosition.BudgetTab.index] = EnvelyTab(
        position: EnvelyTabPosition.BudgetTab.index,
        text: "Budget",
        iconData: Icons.assessment,
        tabController: _tabController);
    map[EnvelyTabPosition.SpendingsTab.index] = EnvelyTab(
        position: EnvelyTabPosition.SpendingsTab.index,
        text: "Spendings",
        iconData: Icons.attach_money,
        tabController: _tabController);
    map[EnvelyTabPosition.PreviewTab.index] = EnvelyTab(
        position: EnvelyTabPosition.PreviewTab.index,
        text: "Preview",
        iconData: Icons.pie_chart,
        tabController: _tabController);
    map[EnvelyTabPosition.AccountsTab.index] = EnvelyTab(
        position: EnvelyTabPosition.AccountsTab.index,
        text: "Accounts",
        iconData: Icons.account_balance_wallet,
        tabController: _tabController);
    map[EnvelyTabPosition.SettingsTab.index] = EnvelyTab(
        position: EnvelyTabPosition.SettingsTab.index,
        text: "Settings",
        iconData: Icons.account_circle,
        tabController: _tabController);

    for (int i = 0; i < TabNb; i++) list.add(map[i]);
    return list;
  }

  List<Widget> _buildTabsContent(BuildContext context) {
    Map<int, Widget> map = {};
    List<Widget> list = [];

    map[EnvelyTabPosition.PreviewTab.index] = PreviewTab();
    map[EnvelyTabPosition.BudgetTab.index] = BudgetTab();
    map[EnvelyTabPosition.SpendingsTab.index] = SpendingsTab();
    map[EnvelyTabPosition.AccountsTab.index] = AccountsTab();
    map[EnvelyTabPosition.SettingsTab.index] = SettingsTab(user: widget.user);

    for (int i = 0; i < TabNb; i++) list.add(map[i]);
    return list;
  }
}

class EnvelyAppBarBuilder {
  AppBar appBar(BuildContext context, TabController tabController) {
    if (tabController.index == EnvelyTabPosition.BudgetTab.index)
      return BudgetAppBarBuilder().build(context);
    if (tabController.index == EnvelyTabPosition.SpendingsTab.index)
      return SpendingsAppBarBuilder().build(context);
    if (tabController.index == EnvelyTabPosition.PreviewTab.index)
      return PreviewAppBarBuilder().build(context);
    if (tabController.index == EnvelyTabPosition.AccountsTab.index)
      return AccountsAppBarBuilder().build(context);
    if (tabController.index == EnvelyTabPosition.SettingsTab.index)
      return SettingsAppBarBuilder().build(context);

    return AppBar(title: Text("Unknown"));
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

    if (widget.tabController.index == widget.position)
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
