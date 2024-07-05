import 'package:flutter/material.dart';
import 'package:stepup/data/Api/getDataAPI.dart';
import 'package:stepup/data/models/shoe.dart';

import 'package:stepup/widgets/filtedProducts/listItem.dart';

class DanggiaoPage extends StatefulWidget {
  const DanggiaoPage({super.key});

  @override
  State<DanggiaoPage> createState() => _DanggiaoPageState();
}

class _DanggiaoPageState extends State<DanggiaoPage> {
  List<ShoeAPI> proList = [];
  Future<String> _LoadData() async {
    proList = await GetDataAPI().fetchData();
    print(proList);
    for (final shoe in proList) {
      print(
          'NameShoe: ${shoe.NameShoe}, Price: ${shoe.Price}, Size: ${shoe.Image}');
    }
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _LoadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _LoadData(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return ListView.builder(
              itemCount: proList.length,
              itemBuilder: (context, index) =>
                  ProductListItem(page: 2, shoe: proList[index]),
            );
          }),
    );
  }
}
