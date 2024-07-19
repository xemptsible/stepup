class User {
  String? name;
  int? age;

  User({this.name, this.age});

  setName(String name) {
    this.name = name;
  }

  setInt(int name) {
    this.age = age;
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        age: json["age"],
      );
}
