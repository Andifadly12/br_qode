import 'package:exaple/app/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/lodingPage/loding.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController(), permanent: true);
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    // auto login untk firebase
    return StreamBuilder<User?>(
      stream:auth.authStateChanges() ,
      builder: (context, snapAuth) {
        //setiap login harus mengecek
        if (snapAuth.connectionState== ConnectionState.waiting) return LodingPage();
       
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Br Qode",
          initialRoute:snapAuth.hasData? Routes.HOME:Routes.LOGIN,
          getPages: AppPages.routes,
        );
      }
    );
  }
}
