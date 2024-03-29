import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/app/home/tab_item.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key? key,
    this.currentTab,
    this.onSelectTab,
    required this.widgetBuilders,
    required this.navigatorKeys,
  }) : super(key: key);

  final TabItem? currentTab;
  final ValueChanged<TabItem>? onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildItem(TabItem.jobs),
          _buildItem(TabItem.entries),
          _buildItem(TabItem.account),
        ],
        onTap: (index) => onSelectTab!(TabItem.values[index]),
      ),
      tabBuilder: (BuildContext context, int index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[item] as dynamic,
          builder: (context) => widgetBuilders[item] as dynamic(context),
        );
      },
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Icon(itemData!.icon),
      ),
      label: itemData.title.toString(),
    );
  }
}
