import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthaid/Models/Staticmodel.dart';
import 'package:healthaid/Models/Usersmosel.dart';
import 'package:healthaid/view/Homescreen.dart';
import 'package:healthaid/view/Loginscreen.dart';
import 'package:healthaid/view/onboardingscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCustomSplashScreen extends StatefulWidget {
  const MyCustomSplashScreen({super.key});

  @override
  _MyCustomSplashScreenState createState() => _MyCustomSplashScreenState();
}

class _MyCustomSplashScreenState extends State<MyCustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;
  bool notificationinfo = false;
  AnimationController? _controller;
  Animation<double>? animation1;

  late final AnimationController _scaleController = AnimationController(
    duration: const Duration(seconds: 4),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _scaleAnimation = CurvedAnimation(
    parent: _scaleController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller!, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller!.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration.zero, () {
      Timer(const Duration(seconds: 4), () {
        Navigator.pushReplacement(
            context,
            PageTransition(
              OnboardingScreen(),
            ));
      });
    });
  }
 @override
  getDataFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("userId");
    print(userId);
    if (userId == null) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ));
      });
    } else {
      // check
      var query = await FirebaseFirestore.instance
          .collection("Users")
          .where("userId", isEqualTo: userId)
          .get();
      Users model = Users.fromMap(query.docs[0].data() as Map<String, dynamic>);
      Staticdata.userModel = model;
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      });
    }
  }
  @override
  void dispose() {
    _controller!.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: height / _fontSize),
                AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    opacity: _textOpacity,
                    child: const Text(
                      "Health_Aid",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  opacity: _containerOpacity,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: width / _containerSize,
                    width: width / _containerSize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      // color: Colors.amber,
                      image: const DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/icon.png'),
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PageTransition extends PageRouteBuilder {
  final Widget page;

  PageTransition(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                axisAlignment: 0,
                child: page,
              ),
            );
          },
        );
}
