import 'package:exaple/app/data/model/porodects_model.dart';
import 'package:exaple/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({Key? key}) : super(key: key);

  final ProducModel product=Get.arguments;  
  TextEditingController codeC=TextEditingController();
  TextEditingController nameC=TextEditingController();
  TextEditingController qrC=TextEditingController();
  @override
  Widget build(BuildContext context) {
    codeC.text=product.code;
    nameC.text=product.name;
    qrC.text=product.qr.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailProductView'),
        centerTitle: true,
      ),
      body:  ListView(
        padding: EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: product.code,
                  size: 200,
                  version: QrVersions.auto,
                  ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          TextField(
            autocorrect: false,
            readOnly: true,
            controller: codeC,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            autocorrect: false,
            controller: nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'Name Product',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          ),
          SizedBox(height: 20,),
          TextField(
            autocorrect: false,
            controller: qrC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'qulantity',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),
          ),
          SizedBox(height: 40,),
          Container(
            height: 40,
            child: ElevatedButton(onPressed: ()async{
              if(controller.isLoding.isFalse){
                if (nameC.text.isNotEmpty && qrC.text.isNotEmpty) {
                  controller.isLoding(true);
                  Map<String, dynamic> hasil=await controller.updatedata({
                    "id":product.productsId,
                    "name":nameC.text,
                    "qr":int.tryParse(qrC.text)??0
                  });
                  controller.isLoding(false);
                  if (hasil['error']==false) {
                    Get.snackbar("success", "Upadate Product berhasil");
                    Get.offAllNamed(Routes.HOME);
                  }else{
                    Get.snackbar("error", "Update Product gagal");
                  }
                }else{
                  Get.snackbar('error', 'Wajib di isi');
                }
              }
            }, child:Obx(() => controller.isLoding.isFalse?Text('Update '):Text("Loding")), 
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
            )),)),
            TextButton(onPressed: (){
             Get.defaultDialog(
              title: 'Delete Products',
              middleText: 'Apakah  kamu yakin?',
              actions: [
                OutlinedButton(onPressed: ()=>Get.back(), child: Text('Cancel')),
                ElevatedButton(onPressed: ()async{
                  controller.isLodingUpdate(true);
                  Map<String, dynamic>hasil=await controller.Deleteporoduct(product.productsId);
                  controller.isLodingUpdate(false);
                  Get.offAllNamed(Routes.PRODUCTS);
                  if (hasil['error']==false) {
                    Get.snackbar('success', 'Data berhasil dihapus');
                    
                  }else{
                    Get.snackbar('error', 'Data gagal dihapus');
                  }
                }, child: Obx(() => controller.isLodingUpdate.isFalse?Text("Delete"): Text("Loding...")))
              ]
             );
            }, child: Text('Delete'))
        ],
      ),

    );
  }
}
