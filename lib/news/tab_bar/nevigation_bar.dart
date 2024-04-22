import 'package:flutter/material.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/news/ui/setting_screen.dart';
import 'package:news_wave/news/utils/colors_const.dart';
import 'package:provider/provider.dart';
import 'bottom_tab _bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> list = [
    const TabScreen(),
    const TabScreen(),
    const TabScreen(),
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
        showUnselectedLabels: false,
        showSelectedLabels: false,
        enableFeedback: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: ColorsConst.orangeColor,
        unselectedItemColor: darkMode ? Colors.white54 : Colors.grey,
        elevation: 8,
        items:  [
           BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
            ),
            label: "Home",
            backgroundColor: darkMode ?ColorsConst.whiteColor : Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.search,
            ),
            label: "PortFolio",
            backgroundColor: darkMode ? Colors.white : Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.save,
            ),
            label: "Home",
            backgroundColor: darkMode ? Colors.white : Colors.black,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.settings,
            ),
            label: "PortFolio",
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
