import 'package:news_wave/all_imports.dart';

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
    const Tab(text: StringConst.allNews),
    const Tab(text: StringConst.business),
    const Tab(text: StringConst.entertainment),
    const Tab(text: StringConst.health),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 7, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return PopScope(
      canPop: false,
      onPopInvoked : (didPop){
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: darkMode ? const Color(0xff1F2125) : const Color(0xffF6F7F7),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 10,
          backgroundColor: darkMode ? const Color(0xff1F2125) : const Color(0xffF6F7F7),
          bottom: TabBar(
            dividerColor: darkMode ? const Color(0xff1F2125) : const Color(0xffF6F7F7),
            isScrollable: false,
            controller: tabController,
            indicatorColor: darkMode ? ColorsConst.whiteColor : ColorsConst.blackColor,
            tabs: const [
              Tab(text: StringConst.allNews),
              Tab(text: StringConst.business),
              Tab(text: StringConst.entertainment),
              Tab(text: StringConst.health),
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
      ),
    );
  }
}
