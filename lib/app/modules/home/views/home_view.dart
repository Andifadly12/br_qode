import 'package:exaple/app/controllers/auth_controller.dart';
import 'package:exaple/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final AuthController authc=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FloatingActionButton(onPressed: (){
          Get.offAllNamed(Routes.LOGIN);
        }, child: Icon(Icons.back_hand),)
        
      ),
      body: GridView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(25),
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
       itemBuilder:(context, index) {
        late IconData icon;
        late String title;
        late VoidCallback ontap;
        switch (index){
          case 0:
          title="add product";
          icon=Icons.post_add;
          ontap=()=>Get.toNamed(Routes.ADD_PRODUCT);
          break;
          case 1:
          title="Product";
          icon=Icons.list_alt_outlined;
          ontap=()=>Get.toNamed(Routes.PRODUCTS);
          break;
          case 2:
          title="Qr code";
          icon=Icons.qr_code;
          ontap=() async{
          String barqode= await  FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
            Get.snackbar('succes', barqode);
          };
          break;
          case 3:
          title="katalog";
          icon=Icons.document_scanner;
          ontap=() {
            controller.Downloadcatalog();
          };
          break;
        }
      return Material(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          onTap:ontap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 56,
                width: 50,
                child: Icon(icon, size: 50,),
              ),
              Text(title)
            ],
          ),
        ),
        
       );
    })
      
    );
  }
}
