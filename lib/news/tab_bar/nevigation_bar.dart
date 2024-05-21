import 'package:news_wave/all_imports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> list = [
    const NewsInformationScreen(),
    const CryptoCoinListScreen(),
    const SettingScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      body: list[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkMode ? Color(0xff1F2125) : const Color(0xffF6F7F7),
        currentIndex: currentIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: darkMode ? Colors.blue : Colors.blue,
        unselectedItemColor: darkMode ? Colors.white38 : Colors.grey[400],
        items:  [
           BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
            ),
            label: "Home",
            backgroundColor: darkMode ?ColorsConst.whiteColor : Colors.black,
          ),
          // BottomNavigationBarItem(
          //   icon: const Icon(
          //     Icons.search,
          //   ),
          //   label: "Search",
          //   backgroundColor: darkMode ? Colors.white : Colors.black,
          // ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.bar_chart,
            ),
            label: "Market",
            backgroundColor: darkMode ? Colors.white : Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
            ),
            label: "Settings",
            backgroundColor: darkMode ? Colors.white : Colors.black,
          ),
        ],

      ),
    );
  }
  void onTapHandler(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
