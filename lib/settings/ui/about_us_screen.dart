import 'package:news_wave/all_imports.dart';

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
          StringConst.aboutUsTitle,
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
                StringConst.aboutOurApp,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color:
                      darkMode ? ColorsConst.white70 : ColorsConst.blackColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                StringConst.aboutTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color:
                      darkMode ? ColorsConst.white70 : ColorsConst.black54Color,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringConst.descriptionDot,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode
                          ? ColorsConst.white54Color
                          : ColorsConst.black54Color,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      StringConst.aboutDescription,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.black54Color,
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
                    StringConst.descriptionDot,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode
                          ? ColorsConst.white54Color
                          : ColorsConst.black54Color,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      StringConst.aboutDescription1,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.black54Color,
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
                    StringConst.descriptionDot,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode
                          ? ColorsConst.white54Color
                          : ColorsConst.black54Color,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      StringConst.aboutDescription2,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.black54Color,
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
                    StringConst.descriptionDot,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode
                          ? ColorsConst.white54Color
                          : ColorsConst.black54Color,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      StringConst.aboutDescription3,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.black54Color,
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
                    StringConst.descriptionDot,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkMode
                          ? ColorsConst.white54Color
                          : ColorsConst.black54Color,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      StringConst.aboutDescription4,
                      style: TextStyle(
                        fontSize: 16,
                        color: darkMode
                            ? ColorsConst.white54Color
                            : ColorsConst.black54Color,
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
