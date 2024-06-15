import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/controller/login_controller.dart';
import 'package:customer/product/user.dart' as customer_user;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  TextEditingController addressController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  @override
  void onInit() {
    orderCollection = firestore.collection('orders');
    super.onInit();
  }

  Future<void> orderSuccess() async {
    customer_user.User? loginUser =
        Get.find<LoginController>().loginUser as customer_user.User?;
    if (loginUser == null) {
      Get.snackbar("Error", "No logged-in user found", colorText: Colors.red);
      return;
    }

    try {
      DocumentReference docRef = await orderCollection.add({
        'customer': loginUser.name ?? '',
        'phone': loginUser.contactNumber ?? '',
        'item': itemName,
        'price': orderPrice,
        'address': orderAddress,
        'dateTime': DateTime.now().toString(),
      });
      print("Order Created Successfully ${docRef.id}");
      Get.snackbar("Success", "Order Created Successfully",
          colorText: Colors.green);
    } catch (e) {
      Get.snackbar("Error", "Order unsuccessful! Try again",
          colorText: Colors.red);
    }
  }

  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';

  void submitOrder(
      {required double price,
      required String item,
      required String description}) {
    orderPrice = price;
    itemName = item;
    orderAddress = addressController.text;

    orderSuccess();
  }
}
