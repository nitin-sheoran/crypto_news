import 'package:flutter/material.dart';
import 'package:news_wave/news/provider/news_provider.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/news/utils/colors_const.dart';
import 'package:news_wave/news/utils/string_const.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late NewsProvider newsProvider;

  @override
  void initState() {
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
      body: Consumer<NewsProvider>(
        builder: (create, provider, widget) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: darkMode
                      ? ColorsConst.gray800Color
                      : ColorsConst.cardColor,
                  surfaceTintColor: darkMode
                      ? ColorsConst.gray800Color
                      : ColorsConst.cardColor,
                  elevation: 0,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: darkMode
                          ? ColorsConst.gray800Color
                          : ColorsConst.whiteColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 48),
                      child: Column(
                        children: [
                          Text(
                            StringConst.settings,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: darkMode
                                  ? ColorsConst.whiteColor
                                  : ColorsConst.blackColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundColor: ColorsConst.red100Color,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.network(
                                  StringConst.imgUrl,
                                  height: 58,
                                  width: 58,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              StringConst.userName,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: darkMode
                                    ? ColorsConst.whiteColor
                                    : ColorsConst.blackColor,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(StringConst.userEmail,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.blackColor,
                                    )),
                                const Text(
                                  StringConst.signOut,
                                  style:
                                      TextStyle(color: ColorsConst.orangeColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: darkMode
                            ? ColorsConst.gray800Color
                            : ColorsConst.cardColor,
                        surfaceTintColor: darkMode
                            ? ColorsConst.gray800Color
                            : ColorsConst.cardColor,
                        elevation: 0,
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: darkMode
                                ? ColorsConst.gray800Color
                                : ColorsConst.whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      StringConst.darkMood,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.blackColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Transform.scale(
                                      scale: 0.6,
                                      child: Switch(
                                        thumbColor: MaterialStatePropertyAll(
                                            darkMode
                                                ? ColorsConst.orangeColor
                                                : ColorsConst.whiteColor),
                                        activeColor: ColorsConst.orangeColor,
                                        inactiveTrackColor: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.black54Color,
                                        onChanged: (bool value) {
                                          Provider.of<ThemeProvider>(context,
                                                  listen: false)
                                              .darkMode = value;
                                        },
                                        value: darkMode,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      StringConst.notification,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.blackColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Transform.scale(
                                      scale: 0.6,
                                      child: Switch(
                                        thumbColor: MaterialStatePropertyAll(
                                            darkMode
                                                ? ColorsConst.orangeColor
                                                : ColorsConst.whiteColor),
                                        activeColor: ColorsConst.orangeColor,
                                        inactiveTrackColor: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.black54Color,
                                        onChanged: (bool value) {
                                          setState(() {
                                            provider.notification = value;
                                          });
                                        },
                                        value: provider.notification,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        StringConst.account,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: darkMode
                              ? ColorsConst.whiteColor
                              : ColorsConst.blackColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Card(
                        color: darkMode
                            ? ColorsConst.gray800Color
                            : ColorsConst.cardColor,
                        surfaceTintColor: darkMode
                            ? ColorsConst.gray800Color
                            : ColorsConst.cardColor,
                        elevation: 0,
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: darkMode
                                ? ColorsConst.gray800Color
                                : ColorsConst.whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      StringConst.editAccount,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.blackColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.blackColor,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      StringConst.changePassword,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.blackColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.blackColor,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      StringConst.language,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.blackColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.blackColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        StringConst.privacyAndSecurity,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: darkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Card(
                        color: darkMode
                            ? ColorsConst.gray800Color
                            : ColorsConst.cardColor,
                        surfaceTintColor: darkMode
                            ? ColorsConst.gray800Color
                            : ColorsConst.cardColor,
                        elevation: 0,
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: darkMode
                                ? ColorsConst.gray800Color
                                : ColorsConst.whiteColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 24, bottom: 10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      StringConst.private,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.blackColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Transform.scale(
                                      scale: 0.6,
                                      child: Switch(
                                        thumbColor: MaterialStatePropertyAll(
                                            darkMode
                                                ? ColorsConst.orangeColor
                                                : ColorsConst.whiteColor),
                                        activeColor: ColorsConst.orangeColor,
                                        inactiveTrackColor: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.black54Color,
                                        onChanged: (bool value) {
                                          setState(() {
                                            provider.private = value;
                                          });
                                        },
                                        value: provider.private,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Text(
                                      StringConst.privacyAndSecurityHelp,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: darkMode
                                            ? ColorsConst.whiteColor
                                            : ColorsConst.blackColor,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: darkMode
                                          ? ColorsConst.whiteColor
                                          : ColorsConst.blackColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
