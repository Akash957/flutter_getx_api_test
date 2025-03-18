import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RazorpayController extends GetxController {
  late Razorpay razorpay;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String razorpayKey = "rzp_test_bToB0wfbBdrPfq";

  String title = "";
  String category = "";
  String image = "";
  String description = "";
  num price = 0;

  @override
  void onInit() {
    super.onInit();
    initializeRazorpay();
  }

  void initializeRazorpay() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  void startPayment(String titles, String categorys, String img, String desc, num prices) {
    title = titles;
    category = categorys;
    image = img;
    description = desc;
    price = prices;

    var options = {
      'key': razorpayKey,
      'amount': price * 100,
      'currency': 'INR',
      'name': title,
      'description': description,
      'image': image,
      'prefill': {'contact': '9876543210', 'email': 'user@example.com'},
      'theme': {'color': '#19A519'}
    };

    try {
      razorpay.open(options);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error in payment: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await saveOrder(response.paymentId);
    Fluttertoast.showToast(msg: "Payment Successful: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Failed: ${response.message}");
  }

  Future<void> saveOrder(String? paymentId) async {
    try {
      await firestore.collection('orders').add({
        'paymentId': paymentId,
        'status': 'Paid',
        'title': title,
        'category': category,
        'image': image,
        'description': description,
        'price': price,
      });
      Fluttertoast.showToast(msg: "Order Saved Successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error saving order: $e");
    }
  }

  @override
  void onClose() {
    razorpay.clear();
    super.onClose();
  }
}
