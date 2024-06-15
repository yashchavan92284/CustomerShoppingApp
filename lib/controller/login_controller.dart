import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/pages/customer_home_page.dart';
import 'package:customer/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController emailLoginCtrl = TextEditingController();
  TextEditingController passwordLoginCtrl = TextEditingController();

  TextEditingController registerNameCtrl = TextEditingController();
  TextEditingController registerEmailCtrl = TextEditingController();
  TextEditingController registerPasswordCtrl = TextEditingController();
  TextEditingController registerContactCtrl = TextEditingController();
  TextEditingController registerAddressCtrl = TextEditingController();
  TextEditingController registerCityCtrl = TextEditingController();
  TextEditingController registerPincodeCtrl = TextEditingController();

  final RxBool isLoggingIn = false.obs;

  User? loginUser;

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Map<String, dynamic>? userData = box.read('loginUser');
    if (userData != null) {
      auth.authStateChanges().listen((User? user) {
        if (user != null && user.uid == userData['uid']) {
          loginUser = user;
          Get.offAll(() => CustomerHomePage());
        }
      });
    }
  }

  void loginUserMethod() async {
    if (emailLoginCtrl.text.isEmpty || passwordLoginCtrl.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields', colorText: Colors.red);
      return;
    }

    isLoggingIn.value = true;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: emailLoginCtrl.text,
        password: passwordLoginCtrl.text,
      );

      if (userCredential.user != null) {
        Get.snackbar('Success', 'Login successful');
        box.write('loginUser', {
          'uid': userCredential.user!.uid,
          'email': userCredential.user!.email,
        });
        clearData();
        Get.offAll(() => CustomerHomePage());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    } finally {
      isLoggingIn.value = false;
    }
  }

  void registerUser() async {
    if (registerNameCtrl.text.isEmpty ||
        registerEmailCtrl.text.isEmpty ||
        registerPasswordCtrl.text.isEmpty ||
        registerContactCtrl.text.isEmpty ||
        registerAddressCtrl.text.isEmpty ||
        registerCityCtrl.text.isEmpty ||
        registerPincodeCtrl.text.isEmpty) {
      Get.snackbar("Empty Input!!", "Please fill all the fields",
          colorText: Colors.red);
      return;
    }

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: registerEmailCtrl.text,
        password: registerPasswordCtrl.text,
      );

      if (userCredential.user != null) {
        DocumentReference doc = userCollection.doc(userCredential.user!.uid);
        await doc.set({
          'id': userCredential.user!.uid,
          'name': registerNameCtrl.text,
          'contact': registerContactCtrl.text,
          'email': registerEmailCtrl.text,
          'address': registerAddressCtrl.text,
          'city': registerCityCtrl.text,
          'pinCode': registerPincodeCtrl.text,
        });

        Get.snackbar('Success', 'User registered successfully');
        clearData();
        Get.offAll(() => LoginPage());
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
    }
  }

  void clearData() {
    registerAddressCtrl.clear();
    registerCityCtrl.clear();
    registerContactCtrl.clear();
    registerEmailCtrl.clear();
    registerNameCtrl.clear();
    registerPasswordCtrl.clear();
    registerPincodeCtrl.clear();
    emailLoginCtrl.clear();
    passwordLoginCtrl.clear();
  }
}
