 import 'dart:io';
import 'dart:typed_data';


import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeController extends GetxController {
  void Downloadcatalog()async{
    final pdf=pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat:PdfPageFormat.a4,
        build:(context) => pw.Center(child: pw.Text('pdf foemat')),)
    );
  //simpan
  final Uint8List bytes=await pdf.save();

  final dir=await getApplicationSupportDirectory();
  final file=File('${dir.path}/mydocument.pdf');

  await file.writeAsBytes(bytes);

  await OpenFile.open(file.path);
  }

  
}
