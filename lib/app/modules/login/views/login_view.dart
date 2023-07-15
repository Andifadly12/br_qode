import 'package:exaple/app/controllers/auth_controller.dart';
import 'package:exaple/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  late TextEditingController emailC=TextEditingController(
    text: 'admin@gmail.com'
  );
  late TextEditingController passwordC=TextEditingController(
    text: 'admin123'
  );

  final AuthController Authc=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login View'),
        centerTitle: true,
      ),
      body:ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  autocorrect: false,
                  controller: emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                   labelText: 'Masukkan Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))
                  ),
                ),
                SizedBox(height: 20,),
                Obx(() => TextField(
                  autocorrect: false,
                  controller: passwordC,
                  obscureText: controller.isHidden.value,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Masukkan Password',
                    suffixIcon: IconButton(onPressed: (){
                      controller.isHidden.toggle();
                    }, icon:Icon(controller.isHidden.value?Icons.remove_red_eye:Icons.remove_red_eye_outlined),),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(9))
                  ),
                ),),
                SizedBox(
                  height: 50,  ),
                Container(
                  height: 50,
                  width: 350, 
                  child: 
                ElevatedButton(onPressed: () async{
                  if (controller.isLoding.isFalse) {
                    if (emailC.text.isNotEmpty && passwordC.text.isNotEmpty) {
                      controller.isLoding(true);
                     Map <String, dynamic> hasil= await Authc.Login(emailC.text, passwordC.text);
                      controller.isLoding(false);
                      if (hasil['error']==true) {
                        print('object');
                        Get.snackbar('Error', 'tadak sesuai email atau password');
                      }else{
                        Get.offAllNamed(Routes.HOME);
                      }
                    }else(
                      Get.snackbar('Error', 'email dan password wajib diisi ')
                    );
                  }
                }, style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                  padding: EdgeInsets.symmetric(horizontal: 20)), child:Obx(() => Text(controller.isLoding.isFalse?'LOGIN':'LODING..') ), ))
              ],
            ),
          ),
        ],
      )
    );
  }
}
