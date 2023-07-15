import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class AddProductController extends GetxController {
 RxBool isLoding=false.obs;

    FirebaseFirestore firestore=FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addproduct(Map<String, dynamic> data) async{
    try {
    var hasil=  await firestore.collection("products").add(data);
    await firestore.collection('products').doc(hasil.id).update({
      'products_id':hasil.id
    });
      return {
        "error": false,
        "massge": "berhasil manmbah product"
      };
    } catch (e) {
      return{
        "error":true,
        "massge": "Tidak dapat manambah product"
      };
    }
  }
}
