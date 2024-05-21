import 'package:news_wave/all_imports.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = Provider.of<ThemeProvider>(context).darkMode;
    return Scaffold(
      backgroundColor:
      darkMode ? ColorsConst.darkColor : ColorsConst.cardColor,
      appBar: AppBar(
        titleSpacing: -8,
        backgroundColor: darkMode ? ColorsConst.darkColor : ColorsConst.blueColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child:  Icon(Icons.arrow_back_ios,color: darkMode
                ? ColorsConst.whiteColor
                : ColorsConst.whiteColor,),
          ),
        ),
        title: Text(
          StringConst.help,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: darkMode
                ? ColorsConst.whiteColor
                : ColorsConst.whiteColor,
          ),
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                   StringConst.submitAQuery,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: darkMode
                        ? ColorsConst.whiteColor
                        : ColorsConst.blackColor
                  ),
                ),
                const SizedBox(height: 16),
                 Text(
                   StringConst.helpTitle,
                  style: TextStyle(fontSize: 18,color: darkMode
                      ? ColorsConst.whiteColor
                      : ColorsConst.black54Color),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: subjectController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                  decoration:  InputDecoration(
                    border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    labelText: StringConst.subject,
                    labelStyle: TextStyle(color: darkMode
                        ? ColorsConst.whiteColor
                        : ColorsConst.black54Color)
                  ),
                    style:  TextStyle(color:darkMode
                        ? ColorsConst.whiteColor
                        : ColorsConst.blackColor),
                    cursorColor: darkMode
                        ? ColorsConst.whiteColor
                        : ColorsConst.blackColor,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  decoration:  InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    labelText: StringConst.description,
                    labelStyle: TextStyle(color: darkMode
                        ? ColorsConst.whiteColor
                        : ColorsConst.black54Color),
                  ),
                  maxLines: 4,
                  style:  TextStyle(color:darkMode
                      ? ColorsConst.whiteColor
                      : ColorsConst.blackColor),
                  cursorColor: darkMode
                      ? ColorsConst.whiteColor
                      : ColorsConst.blackColor,
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: ()async{
                    String subject = subjectController.text;
                    String description = descriptionController.text;
                    final Email email = Email(
                      body: description,
                      subject: subject,
                      recipients: [StringConst.myMail],
                      isHTML: false,
                    );
                    await FlutterEmailSender.send(email);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        ColorsConst.blueColor,
                       ColorsConst.blueColor
                      ]
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: double.infinity,
                    height: 46,
                    child: const Center(child: Text(StringConst.submitQuery,style: TextStyle(
                        color: ColorsConst.whiteColor, fontSize: 18),)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
