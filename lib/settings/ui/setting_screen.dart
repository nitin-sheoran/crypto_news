import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:news_wave/login/service/google_service.dart';
import 'package:news_wave/news/provider/news_provider.dart';
import 'package:news_wave/news/theme/theme_provider.dart';
import 'package:news_wave/settings/ui/about_us_screen.dart';
import 'package:news_wave/settings/ui/help_screen.dart';
import 'package:news_wave/settings/ui/privacy_security_screen.dart';
import 'package:news_wave/utils/colors_const.dart';
import 'package:news_wave/utils/string_const.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../login/ui/login_screen.dart';

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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor:
            darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
        body: Consumer<NewsProvider>(
          builder: (create, provider, widget) {
            return Column(
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
                            leading: Container(
                              height: 90,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    FirebaseAuth.instance.currentUser!.photoURL
                                        .toString(),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              FirebaseAuth.instance.currentUser!.displayName
                                  .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: darkMode
                                    ? ColorsConst.whiteColor
                                    : ColorsConst.blackColor,
                              ),
                            ),
                            subtitle: Text(
                                FirebaseAuth.instance.currentUser!.email
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: darkMode
                                      ? ColorsConst.whiteColor
                                      : ColorsConst.blackColor,
                                )),
                          ),
                          // InkWell(
                          //   onTap: () async {
                          //     await GoogleServices().logOut();
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) =>
                          //             const LoginScreen()));
                          //   },
                          //   child: const Text(
                          //     StringConst.signOut,
                          //     style: TextStyle(
                          //         color: ColorsConst.orangeColor),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 26, right: 26, top: 26, bottom: 40),
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
                              height: 120,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: darkMode
                                    ? ColorsConst.gray800Color
                                    : ColorsConst.whiteColor,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
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
                                            thumbColor:
                                                const MaterialStatePropertyAll(
                                                    ColorsConst.whiteColor),
                                            activeColor: Colors.cyanAccent,
                                            inactiveTrackColor: darkMode
                                                ? Colors.white54
                                                : ColorsConst.black54Color,
                                            onChanged: (bool value) {
                                              Provider.of<ThemeProvider>(
                                                      context,
                                                      listen: false)
                                                  .darkMode = value;
                                            },
                                            value: darkMode,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Divider(),
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
                                            thumbColor:
                                                const MaterialStatePropertyAll(
                                                    ColorsConst.whiteColor),
                                            activeColor: Colors.cyanAccent,
                                            inactiveTrackColor: darkMode
                                                ? Colors.white54
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
                              height: 180,
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
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: darkMode
                                                  ? ColorsConst.darkColor
                                                  : ColorsConst.whiteColor,
                                              surfaceTintColor: darkMode
                                                  ? ColorsConst.darkColor
                                                  : ColorsConst.whiteColor,
                                              elevation: 100,
                                              title: Text(
                                                'Alert!',
                                                style: TextStyle(
                                                    color: darkMode
                                                        ? ColorsConst.whiteColor
                                                        : ColorsConst
                                                            .blackColor),
                                              ),
                                              content: Text(
                                                'Are you sure to logout!',
                                                style: TextStyle(
                                                    color: darkMode
                                                        ? ColorsConst.whiteColor
                                                        : ColorsConst
                                                            .blackColor),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: darkMode
                                                              ? ColorsConst
                                                                  .whiteColor
                                                              : ColorsConst
                                                                  .blackColor),
                                                    )),
                                                TextButton(
                                                  onPressed: () async {
                                                    await GoogleServices()
                                                        .logOut();
                                                    if (mounted) {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const LoginScreen()));
                                                    }
                                                  },
                                                  child: Text(
                                                    'Logout',
                                                    style: TextStyle(
                                                        color: darkMode
                                                            ? ColorsConst
                                                                .whiteColor
                                                            : ColorsConst
                                                                .blackColor),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: Row(
                                          children: [
                                            Text(
                                              StringConst.logOut,
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
                                      ),
                                    ),
                                    const Spacer(),
                                    const Divider(),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Share.share('Coming soon');
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: Row(
                                          children: [
                                            Text(
                                              'Share App',
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
                                      ),
                                    ),
                                    const Spacer(),
                                    const Divider(),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: Row(
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            StringConst.about,
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
                              height: 180,
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
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HelpScreen()));
                                      },
                                      child: Container(
                                        height: 24,
                                        decoration: const BoxDecoration(),
                                        child: Row(
                                          children: [
                                            Text(
                                              StringConst.help,
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
                                      ),
                                    ),
                                    const Spacer(),
                                    const Divider(),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AboutUsScreen()),
                                        );
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: Row(
                                          children: [
                                            Text(
                                              StringConst.aboutUs,
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
                                      ),
                                    ),
                                    const Spacer(),
                                    const Divider(),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const PrivacySecurityScreen()),
                                        );
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(),
                                        child: Row(
                                          children: [
                                            Text(
                                              StringConst.privacyAndSecurity,
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
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
