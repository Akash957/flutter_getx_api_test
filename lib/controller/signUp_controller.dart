import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../auth/login_page.dart';

class SignUpController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var userCredential = Rxn<UserCredential>();

  Future<void> signUp() async {
    try {
      userCredential.value = await auth.createUserWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      Fluttertoast.showToast(msg: "Signed in successfully");
      Get.to(LoginPage());
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "Signup failed${e.message}");
    }
  }
}
