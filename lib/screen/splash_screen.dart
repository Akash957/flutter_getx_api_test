import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_api_test/screen/products_screen.dart';
import 'package:get/get.dart';
import '../auth/login_page.dart';
import '../auth/signUp_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Get.to(SignUpPage());
      _checkAuthState();
    });
  }

  void _checkAuthState() async {
    User? user = _auth.currentUser;
    if (user != null) {
      Get.offAll(() => ProductsScreen());
    } else {
      Get.offAll(() => LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg"),
        ],
      ),
    );
  }
}
