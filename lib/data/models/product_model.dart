// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  int? id;
  String? name;
  int? price;
  String? des;
  String? img;
  int? size;
  int? quantity;
  int? brand;
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
}
