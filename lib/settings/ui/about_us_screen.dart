import 'package:flutter/material.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/utils/colors_const.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
      appBar: AppBar(
        titleSpacing: -8,
        backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.blueColor,
        title: const Text('About Us',style: TextStyle(color:
        ColorsConst.whiteColor),),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorsConst.whiteColor,
            )),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About Our App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkMode
                    ? ColorsConst.whiteColor
                    : ColorsConst.blackColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your app description goes here. You can provide information about the purpose of the app, its features, and any other relevant details.',
              style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.w400,color: darkMode
                    ? ColorsConst.whiteColor
                    : ColorsConst.blackColor,),
            ),
          ],
        ),
      ),
    );
  }
}
