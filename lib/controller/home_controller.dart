import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/model/product/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference productCollection;
  final FirebaseStorage storage = FirebaseStorage.instance;
  List<Product> products = [];
  List<Product> productShowInUi = [];
  @override
  void onInit() async {
    productCollection = firestore.collection('products');
    await fetchProduct();
    super.onInit();
  }

  Future<void> refreshProducts() async {
    await Future.delayed(Duration(seconds: 2));

    products = await fetchProduct();
    update();
  }

  fetchProduct() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Prodcut fetch Sucessful',
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    } finally {
      update();
    }
  }
}
