// ignore_for_file: use_build_context_synchronously
import 'package:news_wave/all_imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  void getData() {
    setState(() {
      loading = true;
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Image.asset(
                  StringConst.loginImage,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0),
                            backgroundColor: MaterialStatePropertyAll(
                          ColorsConst.white54Color,
                        )),
                        onPressed: () async {
                          await GoogleServices().googleAuth();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                StringConst.continueWith,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                StringConst.bigG,
                                style: TextStyle(
                                    color: ColorsConst.blueColor, fontSize: 24),
                              ),
                              Text(StringConst.o,
                                  style: TextStyle(
                                      color: ColorsConst.redColor, fontSize: 24)),
                              Text(
                                StringConst.o,
                                style: TextStyle(
                                    color: ColorsConst.yellowColor, fontSize: 24),
                              ),
                              Text(
                                StringConst.g,
                                style: TextStyle(
                                    color: ColorsConst.blueColor, fontSize: 24),
                              ),
                              Text(
                                StringConst.l,
                                style: TextStyle(
                                    color: ColorsConst.greenColor, fontSize: 24),
                              ),
                              Text(
                                StringConst.e,
                                style: TextStyle(
                                    color: ColorsConst.redColor, fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
      // : Container(
      //     decoration: const BoxDecoration(),
      //     child: Center(
      //       child: Container(
      //         margin: const EdgeInsets.symmetric(
      //           horizontal: 30,
      //         ),
      //         child: ElevatedButton(
      //           style: const ButtonStyle(
      //               backgroundColor: MaterialStatePropertyAll(
      //             ColorsConst.whiteColor,
      //           )),
      //           onPressed: () async {
      //             await GoogleServices().googleAuth();
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                 builder: (context) => const HomeScreen(),
      //               ),
      //             );
      //           },
      //           child: const Padding(
      //             padding: EdgeInsets.all(8.0),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 Text(
      //                   'Continue With',
      //                   style: TextStyle(
      //                     color: Colors.black54,
      //                     fontWeight: FontWeight.bold,
      //                     fontSize: 18,
      //                   ),
      //                 ),
      //                 SizedBox(width: 8),
      //                 Text(
      //                   'G',
      //                   style: TextStyle(color: Colors.blue, fontSize: 24),
      //                 ),
      //                 Text('o',
      //                     style:
      //                         TextStyle(color: Colors.red, fontSize: 24)),
      //                 Text(
      //                   'o',
      //                   style:
      //                       TextStyle(color: Colors.yellow, fontSize: 24),
      //                 ),
      //                 Text(
      //                   'g',
      //                   style: TextStyle(color: Colors.blue, fontSize: 24),
      //                 ),
      //                 Text(
      //                   'l',
      //                   style: TextStyle(color: Colors.green, fontSize: 24),
      //                 ),
      //                 Text(
      //                   'e',
      //                   style: TextStyle(color: Colors.red, fontSize: 24),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
    );
  }
}
