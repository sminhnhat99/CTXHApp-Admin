import 'dart:html';

import 'package:cool_alert/cool_alert.dart';
import 'package:ctxhadminpage/api_Service/apiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController _emailController, _passwordController;
  var email = ' ';
  var password = ' ';
  var isLoading = false.obs;
  var token = 'Chưa có Tài khoản Đăng nhập'.obs;
  var userId = 0.obs;

  @override
  void onInit(){
    super.onInit();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  Future<void> loginPage() async {
    print(email);
    isLoading(true);
    try {
      var response = await APIService.login(email, password);
      if(response != null) {
        print(response.success);
        if(response.success == 1) {
          _emailController.clear();
          _passwordController.clear();
          token(response.token);
          Get.offAllNamed("/dashboard");
        } 
        else {
         
        }
      }
    } finally {

    }
  }
}
