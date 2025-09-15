import 'package:flutter/material.dart';
import 'package:manzal_office/core/network/local/cachHelper.dart';
import 'package:manzal_office/core/network/remote/header_constance.dart';
import 'package:manzal_office/features/auth/login.dart';
import 'package:manzal_office/features/home_page/home_page.dart';

import '../../core/constant/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    Widget startScreen;

    if( CacheHelper.getData(key: "token") != null){

      HeaderConstance.token=CacheHelper.getData(key: "token");
      print(HeaderConstance.token);
      startScreen = HomePage();
    }else{
      startScreen = Login();
    }
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>startScreen),(Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor,backgroundColor],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.asset('assets/images/logo.png', height: 300),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
