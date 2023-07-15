
class ProducModel {
    final String code;
    final String name;
    final String productsId;
    final int qr;

    ProducModel({
        required this.code,
        required this.name,
        required this.productsId,
        required this.qr,
    });

    factory ProducModel.fromJson(Map<String, dynamic> json) => ProducModel(
        code: json["code"]?? "",
        name: json["name"]?? "",
        productsId: json["products_id"]??"",
        qr: json["qr"]?? 0,
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "products_id": productsId,
        "qr": qr,
    };
}
