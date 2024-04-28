// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:news_wave/news/login/service/google_service.dart';
import 'package:news_wave/news/tab_bar/nevigation_bar.dart';
import 'package:news_wave/news/utils/colors_const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  getData() async {
    setState(() {
      loading = true;
    });
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.pink,
                Colors.blue,
              ])),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        ColorsConst.whiteColor,
                      )
                    ),
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
                            'Login With',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text('G',style: TextStyle(color: Colors.blue,fontSize: 24),),
                          Text('o',style: TextStyle(color: Colors.red,fontSize: 24) ),
                          Text('o',style: TextStyle(color: Colors.yellow,fontSize: 24),),
                          Text('g',style: TextStyle(color: Colors.blue,fontSize: 24 ),),
                          Text('l',style: TextStyle(color: Colors.green,fontSize: 24),),
                          Text('e',style: TextStyle(color: Colors.red,fontSize: 24),),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
