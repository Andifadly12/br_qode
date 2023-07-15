import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
 String? uid;
 late FirebaseAuth auth;
 Future<Map<String, dynamic>> Login (String email, String pass)async{
  try {
    await auth.signInWithEmailAndPassword(email: email, password: pass);
    return{
      "error":false,
      "massage":"Berhasil login"
    };
  }on FirebaseAuthException catch (e) {
  return {
    "error":true,
    "massage":"${e.message}"
  };
  }catch (e) {
  return {
    "error":true,
    "massage":"anda gagal login"
  };
  }
 }

 Future<Map<String, dynamic>> Logout ()async{
  try {
    await auth.signOut();
    return{
      "error":false,
      "massage":"Berhasil logouth"
    };
  }on FirebaseAuthException catch (e) {
  return {
    "error":true,
    "massage":"${e.message}"
  };
  }catch (e) {
  return {
    "error":true,
    "massage":"anda gagal logouth"
  };
  }
 }
 @override
  void onInit() {
    auth=FirebaseAuth.instance;
    auth.authStateChanges().listen((event) {
      uid=event?.uid;
     });
    // TODO: implement onInit
    super.onInit();
  }
}
