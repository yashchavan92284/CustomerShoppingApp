import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/login_controller.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller.emailLoginCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.email),
                  labelText: "Email",
                  hintText: "Enter your email",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controller.passwordLoginCtrl,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.password),
                  labelText: "Password",
                  hintText: "Enter your password",
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => ElevatedButton(
                    onPressed: () {
                      if (_controller.isLoggingIn.value) return;
                      _controller.loginUserMethod();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: _controller.isLoggingIn.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                  )),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.to(() => RegisterPage());
                },
                child: const Text("Don't have an account? Register here"),
              ),
            ],
          ),
        ),
      );
    });
  }
}
