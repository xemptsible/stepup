// ignore_for_file: public_member_api_docs, sort_constructors_first
class Brand {
  int? id;
  String? name;
  String? img;
  Brand({
    this.id,
    this.name,
    this.img,
  });

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
  }
}
