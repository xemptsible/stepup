// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  int? id;
  String? name;
  int? price;
  String? des;
  String? img;
  List<dynamic>? size;
  int? quantity;
  String? brand;
  String? color;

  Product({
    this.id,
    this.name,
    this.price,
    this.des,
    this.img,
    this.size,
    this.quantity,
    this.brand,
    this.color,
  });
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    des = json['des'];
    img = json['img'];
    size = json['size'];
    quantity = json['quantity'];
    brand = json['brand'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'des': des,
      'img': img,
      'size': size,
      'quantity': quantity,
      'brand': brand,
      'color': color,
    };
  }
}
