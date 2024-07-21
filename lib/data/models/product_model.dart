// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  String? id;
  String? name;
  int? price;
  String? des;
  String? img;
  List<dynamic>? size;
  String? brand;

  Product({
    this.id,
    this.name,
    this.price,
    this.des,
    this.img,
    this.size,
    this.brand,
  });
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    des = json['des'];
    img = json['img'];
    size = json['size'];
    brand = json['brand'];
  }
  Product.fromJsonApi(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['NameShoe'];
    price = json['Price'];
    des = json['Description'];
    img = json['Image'];
    size = json['Sizes'];
    brand = json['Brand'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'des': des,
      'img': img,
      'size': size,
      'brand': brand,
    };
  }
}
