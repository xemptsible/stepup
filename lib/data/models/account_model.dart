class Account {
  String? id;
  String? Email;
  String? Password;
  String? UserName;
  String? Address;
  String? PhoneNumber;
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

  setPhoneNumber(String phone) {
    this.PhoneNumber = phone;
  }

  Account.fromJsonApi(Map<String, dynamic> json) {
    id = json['_id'];
    Email = json['Email'];
    Password = json['Password'];
    UserName = json['UserName'];
    Address = json['Address'];
    PhoneNumber = json['PhoneNumber'];
    BirthDay = json['BirthDay'];
    Image = json['Image'];
  }

  Map<String, dynamic> toJson() {
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
