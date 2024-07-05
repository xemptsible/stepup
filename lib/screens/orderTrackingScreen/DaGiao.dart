import 'package:flutter/material.dart';
import 'package:stepup/data/Api/getDataAPI.dart';
import 'package:stepup/data/models/shoe.dart';
import 'package:stepup/widgets/filtedProducts/listItem.dart';

class DagiaoPage extends StatefulWidget {
  const DagiaoPage({super.key});

  @override
  State<DagiaoPage> createState() => _DagiaoPageState();
}

class _DagiaoPageState extends State<DagiaoPage> {
  List<ShoeAPI> proList = [];
  Future<String> _LoadData() async {
    proList = await GetDataAPI().fetchData();
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
              shrinkWrap: true,
              itemCount: proList.length,
              itemBuilder: (context, index) =>
                  ProductListItem(page: 1, shoe: proList[index]),
            );
          }),
    );
  }
}
