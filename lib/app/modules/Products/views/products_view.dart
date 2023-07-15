import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exaple/app/data/model/porodects_model.dart';
import 'package:exaple/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductsView'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamProduct(),
        builder: (context, snapsProduct) {
          if (snapsProduct.connectionState==ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapsProduct.data!.docs.isEmpty) {
            return Center(
              child: Text('No data'),
            );
          }
          List<ProducModel> allProducts=[];

          for (var elemen in snapsProduct.data!.docs) {
            allProducts.add(ProducModel.fromJson(elemen.data()));
          }
          return ListView.builder(
            itemCount: allProducts.length,
            padding: EdgeInsets.all(20),
            itemBuilder:(context, index) {
              ProducModel product=allProducts[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.only(bottom: 20),
              elevation: 5,
              color: Colors.grey.shade300,
              child: InkWell(
                onTap: () {
                  Get.offNamed(Routes.DETAIL_PRODUCT, arguments: product);
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.code, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                          Text(product.name),
                          Text("jumlah : ${product.qr}")
                        ],
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: QrImageView(
                          data: product.code,
                          size: 200,
                          version: QrVersions.auto,
                        )
                      )
                    ],
                  ),
                ),
              ),
            );
          },);
        }
      )
    );
  }
}
