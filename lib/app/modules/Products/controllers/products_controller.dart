import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  FirebaseFirestore firestrore= FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamProduct() async*{
    yield* firestrore.collection("products").snapshots();
  }
}
