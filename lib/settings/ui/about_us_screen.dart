import 'package:flutter/material.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/utils/colors_const.dart';
import 'package:news_wave/utils/string_const.dart';
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
        backgroundColor:
            darkMode ? ColorsConst.darkColor : ColorsConst.blueColor,
        title: const Text(
          'About Us',
          style: TextStyle(color: ColorsConst.whiteColor),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorsConst.whiteColor,
            )),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Our App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color:
                      darkMode ? Colors.white70 : ColorsConst.blackColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                StringConst.aboutTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: darkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022 ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? ColorsConst.white54Color : Colors.black54,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'CryptoPulse is a powerful and comprehensive cryptocurrency news app that provides you with the latest and most important news from around the world. In the eternal world of Cryptocurrency, staying up-to-date is a vital necessity, and CryptoPulse takes care of that responsibility.',
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode ? ColorsConst.white54Color : Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022 ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? ColorsConst.white54Color : Colors.black54,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'CryptoPulse gives you access to all the latest news and updates related to all major cryptocurrencies like Bitcoin, Ethereum, Ripple, and Litecoin. This app will give you important information like daily market analysis, price trends, and upcoming events, which will help you understand the value of crypto market.',
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode ? ColorsConst.white54Color : Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022 ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? ColorsConst.white54Color : Colors.black54,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      'In addition, CryptoPulse also provides you with thought-provoking articles, expert opinions, and in-depth research that exposes you to new ideas in the crypto space. You will also find technical innovations, regulatory updates, and the latest developments in blockchain technology here.',
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode ? ColorsConst.white54Color : Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022 ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? ColorsConst.white54Color : Colors.black54,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "CryptoPulse's user-friendly interface and customizable notifications help you reach the news that interests you. In this app you have access to the necessary features to immerse yourself in the crypto world without any offers and to stay safe.",
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode ? ColorsConst.white54Color : Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\u2022 ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode ? ColorsConst.white54Color : Colors.black54,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "CryptoPulse is an essential app for crypto enthusiasts, traders, and investors that keeps them connected to the forefront of the crypto world.",
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode ? ColorsConst.white54Color : Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
