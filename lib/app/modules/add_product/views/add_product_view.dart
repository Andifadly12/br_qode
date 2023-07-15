

import 'package:exaple/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);
  final TextEditingController codeC=TextEditingController();
  final TextEditingController nameC=TextEditingController();
  final TextEditingController qtyC=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddProductView'),
        centerTitle: true,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: codeC,
                keyboardType: TextInputType.number,
                maxLength: 10,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Produk code',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              TextField(
                keyboardType: TextInputType.text,
                autocorrect: false,
                controller: nameC,
                decoration: InputDecoration(
                  hintText: "Produck name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: qtyC,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Quantity',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 50,),
              Container(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                  onPressed: () async{
                    if (controller.isLoding.isFalse) {
                      controller.isLoding(true);
                      if (codeC.text.isNotEmpty && nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                        Map<String, dynamic> hasil= await controller.addproduct(
                          {
                            "code":codeC.text,
                            "name":nameC.text,
                            "qr": int.parse(qtyC.text)
                          }
                        );
                        if(hasil["error"]==false){
                          Get.snackbar("success", "data berhasil di upload");
                           Get.offAllNamed(Routes.HOME);
                        }else{
                          Get.snackbar("error", "wajib behasail");
                        };
                      }
                      controller.isLoding(false);
                    }
                  }, child: Obx(() => controller.isLoding.isFalse?Text('Submit'):Text("Loding")),))
            ],                                                
          ),
        ),    
    ],)
    );
  }
}
