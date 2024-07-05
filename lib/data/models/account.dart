class Account {
  final String Email;
  final String Password;

  Account({required this.Email, required this.Password});

  Map<String, dynamic> toJson() {
    return {
      'Email': Email,
      'Password': Password,
    };
  }
}
