import 'package:get/get.dart';

class AuthController extends GetxController {
  final _isLoggedIn = false.obs;

  bool get isLoggedIn => _isLoggedIn.value;

  void logout() {
    _isLoggedIn.value = false;
    Get.offAllNamed('/login');
    update();
  }
}
