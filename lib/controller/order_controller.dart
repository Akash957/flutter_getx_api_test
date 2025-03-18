import 'package:get/get.dart';
import '../model/ProductsModel.dart';

class OrderController extends GetxController {
  var orders = <ProductsModel>[].obs;

  void addOrder(ProductsModel product) {
    orders.add(product);
  }
}