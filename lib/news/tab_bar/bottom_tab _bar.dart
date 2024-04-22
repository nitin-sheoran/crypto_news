import 'package:flutter/material.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/news/ui/news_information_screen.dart';
import 'package:news_wave/news/utils/colors_const.dart';
import 'package:provider/provider.dart';
import '../provider/news_provider.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  TabScreenState createState() => TabScreenState();
}

class TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  NewsProvider? newsProvider;
  int pageSize = 10;

  final List<Tab> topTabs = <Tab>[
    const Tab(text: 'Everything'),
    const Tab(text: 'Business'),
    const Tab(text: 'Entertainment'),
    const Tab(text: 'Health'),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: darkMode ? const Color(0xff1F2125) : const Color(0xffF6F7F7),
        bottom: TabBar(
          dividerColor: darkMode ? const Color(0xff1F2125) : const Color(0xffF6F7F7),
          isScrollable: false,
          controller: tabController,
          indicatorColor: ColorsConst.orangeColor,
          tabs: const [
            Tab(text: 'All News'),
            Tab(text: 'Business'),
            Tab(text: 'Entertainment'),
            Tab(text: 'Health'),
          ],
          labelColor:
              darkMode ? ColorsConst.whiteColor : ColorsConst.blackColor,
          unselectedLabelColor:
              darkMode ? ColorsConst.whiteColor : ColorsConst.blackColor,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          NewsInformationScreen(),
          NewsInformationScreen(),
          NewsInformationScreen(),
          NewsInformationScreen(),
        ],
      ),
    );
  }
}
