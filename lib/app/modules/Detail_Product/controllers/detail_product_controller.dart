import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
 RxBool isLoding=false.obs;
 RxBool isLodingUpdate=false.obs; 

 FirebaseFirestore firestore=FirebaseFirestore.instance;

 Future <Map<String, dynamic>> updatedata(Map<String, dynamic> data) async{
  try {
    await firestore.collection('products').doc(data['id']).update({
      'name':data['name'],
      'qr':data['qr']
    });
    return {
      'error':false,
      'message':'berhasil update data product'
    };
  } catch (e) {
    return {
      'error':true,
      'massage':'data product gagal diupdate'
    };
  }
 }
 Future<Map<String, dynamic>> Deleteporoduct(String id) async{
  try {
    await firestore.collection('products').doc(id).delete();
    return {
      'error':false,
      'massage':'data product berhasil di hapus'
    };
  } catch (e) {
    return{
      'error':true,
      'massage':'data products gagal dihapus'
    };    
  }
 }
}
