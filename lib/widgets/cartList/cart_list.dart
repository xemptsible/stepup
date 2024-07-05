import 'package:flutter/cupertino.dart';
import 'package:stepup/data/Api/getDataAPI.dart';
import 'package:stepup/data/models/product_model.dart';
import 'package:stepup/data/models/shoe.dart';
import 'package:stepup/data/providers/provider.dart';
import 'package:stepup/widgets/cartList/cart_item_detail.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  List<ShoeAPI> proList = [];
  Future<String> _loadProData() async {
    proList = await GetDataAPI().fetchData();
    print(proList);
    return '';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: FutureBuilder(
        future: _loadProData(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: proList.length,
              itemBuilder: (context, index) {
                return ListItemCart(context, proList[index]);
              });
        },
      ),
    );
  }
}
