import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_api_test/screen/bottom_navigation_Bar.dart';
import 'package:flutter_getx_api_test/screen/splash_screen.dart';
import 'package:get/get.dart';
import 'auth/login_page.dart';
import 'auth/signUp_page.dart';
import 'controller/auth_controller.dart';
import 'controller/order_controller.dart';
import 'controller/razorpay_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());

  Get.put(RazorpayController());
  Get.put(AuthController());
  Get.put(OrderController());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignUpPage()),
      ],
    );
  }
}
