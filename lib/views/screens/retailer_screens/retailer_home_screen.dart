import 'package:e_commerce_frontend/controllers/auth_contoller.dart';
import 'package:e_commerce_frontend/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RetailerHomeScreen extends StatefulWidget {
  const RetailerHomeScreen({super.key});

  @override
  State<RetailerHomeScreen> createState() => _RetailerHomeScreenState();
}

class _RetailerHomeScreenState extends State<RetailerHomeScreen> {
  final AuthController authController = Get.put(AuthController());
  final ProductController productController = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authController.decodeToken();
    productController.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            //   //Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [

            //       Obx(() {
            //         final userData = authController.userInfo;
            //         if (userData.isEmpty) {
            //           return const Text("Invalid or Expired Token");
            //         }

            //         return Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text("Name: ${userData['firstName'] ?? 'N/A'}",
            //                 style: const TextStyle(fontSize: 18)),
            //             Text("Email: ${userData['email'] ?? 'N/A'}",
            //                 style: const TextStyle(fontSize: 18)),
            //             Text("Password: ${userData['password'] ?? 'N/A'}",
            //                 style: const TextStyle(fontSize: 18)),
            //             TextButton(
            //                 onPressed: () async {
            //                   authController.logout();
            //                 },
            //                 child: const Text("Sign-out"))
            //           ],
            //         );
            //       }),
            //     ],
            //   ),

            Obx(() {
          final products = productController.productInfo;
          if (products.isEmpty) {
            return const Text("Product List is Empty");
          }

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return Column(
                children: [
                  Text(product['name']),
                  Text(product['price'].toString()),
                  Text(product['description']),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
