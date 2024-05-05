import 'package:flutter/material.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/utils/colors_const.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      backgroundColor:
          darkMode ? const Color(0xff1F2125) : const Color(0xffF6F7F7),
      appBar: AppBar(
        backgroundColor:
            darkMode ? const Color(0xff1F2125) : const Color(0xffF6F7F7),
        title: Text(
          'Select Language',
          style: TextStyle(
            color: darkMode ? ColorsConst.whiteColor : ColorsConst.blackColor,
          ),
        ),
        titleSpacing: -8,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: darkMode
              ? ColorsConst.whiteColor
              : ColorsConst.blackColor,),
        ),
      ),
    );
  }
}
