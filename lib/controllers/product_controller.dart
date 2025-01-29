import 'package:e_commerce_frontend/core/repositories/products_repository.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final ProductsRepository _productsRepository = ProductsRepository();

  var productInfo = <Map<String, dynamic>>[].obs;

  void getAllProducts() async {
    var products = await _productsRepository.getAllProducts();
    productInfo.value = products;
  }
}
