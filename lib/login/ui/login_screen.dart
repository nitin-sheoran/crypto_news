// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:news_wave/login/service/google_service.dart';
import 'package:news_wave/news/tab_bar/nevigation_bar.dart';
import 'package:news_wave/utils/colors_const.dart';

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
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTupMo83tIDvaNHuC4GkiMtm2n7EpjSb0TO2g&usqp=CAU',
                  // 'https://t3.ftcdn.net/jpg/01/37/54/78/240_F_137547872_DdtEyxjBo7mZ3nPMwXCHYxbgxYIRsL3v.jpg',
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
                                'Continue With',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'G',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 24),
                              ),
                              Text('o',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 24)),
                              Text(
                                'o',
                                style: TextStyle(
                                    color: Colors.yellow, fontSize: 24),
                              ),
                              Text(
                                'g',
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 24),
                              ),
                              Text(
                                'l',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 24),
                              ),
                              Text(
                                'e',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 24),
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
