import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stepup/data/models/shoe.dart';

class GetDataAPI {
  Future<List<ShoeAPI>> fetchData() async {
    final url = Uri.parse('https://api-giay.vercel.app/shoe');
    final response = await http.get(url);
    print(response);

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

  PrintData(List<ShoeAPI> listData) {
    for (final shoe in listData) {
      print(
          'NameShoe: ${shoe.NameShoe}, Price: ${shoe.Price}, Size: ${shoe.Image}');
    }
  }
}
