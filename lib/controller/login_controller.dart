import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_getx_api_test/screen/products_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  var email = ''.obs;
  var password = ''.obs;
  var userCredential = Rxn<UserCredential>();

  Future<void> login() async {
    try {
      userCredential.value = await auth.signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      Fluttertoast.showToast(msg: "Logged in successfully");
      Get.to(ProductsScreen());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Login failed${e.message}");
    }
  }
}
