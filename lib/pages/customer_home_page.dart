import 'package:customer/controller/home_controller.dart';
import 'package:customer/pages/login_page.dart';
import 'package:customer/pages/product_description_page.dart';
import 'package:customer/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (ctrl) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.erase();
                  Get.offAll(LoginPage());
                },
                icon: const Icon(Icons.logout),
              )
            ],
            centerTitle: true,
            title: const Text(
              "Shopping Store",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => ctrl.refreshProducts(),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: ctrl.products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (context, index) {
                      final product = ctrl.products[index];
                      final imageUrl = product.imageUrl ?? "default_url";

                      return ProductCard(
                        name: product.name ?? "No name",
                        imageUrl: imageUrl,
                        price: product.price ?? 0.0,
                        offerTag: '20% off ',
                        onTap: () {
                          Get.to(() => ProductDescriptionPage(),
                              arguments: product);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
