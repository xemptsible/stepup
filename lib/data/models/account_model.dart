class Account {
  String? id;
  String? Email;
  String? Password;
  String? UserName;
  String? Address;
  int? PhoneNumber;
  DateTime? BirthDay;
  String? Image;

  Account(
      {this.Email,
      this.Password,
      this.UserName,
      this.Address,
      this.BirthDay,
      this.PhoneNumber,
      this.Image});

  setUserName(String name) {
    this.UserName = name;
  }

  setAdress(String address) {
    this.Address = address;
  }

  setPhoneNumber(int phone) {
    this.PhoneNumber = phone;
  }

  setBirthDay(DateTime birthDay) {
    this.BirthDay = birthDay;
  }

  setImage(String img) {
    this.Image = img;
  }

  Account.fromJsonApi(Map<String, dynamic> json) {
    id = json['_id'];
    Email = json['Email'];
    Password = json['Password'];
    UserName = json['UserName'] ?? 'New User';
    Address = json['Address'] ?? '';
    PhoneNumber = json['PhoneNumber'];
    BirthDay =
        json['BirthDay'] != null ? DateTime.parse(json['BirthDay']) : null;
    // BirthDay = DateTime.parse(json['BirthDay']);
    // BirthDay = json['BirthDay'] ;
    Image = json['Image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Email': Email,
      'Password': Password,
      'UserName': UserName,
      'Address': Address,
      'PhoneNumber': PhoneNumber,
      'BirthDay': BirthDay!.toIso8601String() ?? null,
      'Image': Image,
    };
  }

  Map<String, dynamic> toJsonPost() {
    return {
      '_id': id,
      'Email': Email,
      'Password': Password,
      'UserName': UserName,
      'Address': Address,
      'PhoneNumber': PhoneNumber,
      'BirthDay': BirthDay,
      'Image': Image,
    };
  }
}
