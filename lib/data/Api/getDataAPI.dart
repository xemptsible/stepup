import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stepup/data/models/account.dart';
import 'package:stepup/data/models/shoe.dart';

class GetDataAPI {
  Future<List<ShoeAPI>> fetchData() async {
    final url = Uri.parse('https://api-giay.vercel.app/shoe');
    final response = await http.get(url);
    // print(response);

    if (response.statusCode == 200) {
      // lấy một mãng list dữ liệu
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<ShoeAPI> datas =
          jsonList.map((json) => ShoeAPI.fromJson(json)).toList();

      return datas;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<http.Response> createUser(Account account) async {
    print(account.Email + " " + account.Password);
    final response =
        await http.post(Uri.parse('https://api-giay.vercel.app/account'),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(account.toJson()));

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to create user');
    }
  }
}
