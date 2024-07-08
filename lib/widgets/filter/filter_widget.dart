import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:stepup/data/providers/brand_vm.dart';
import 'package:stepup/widgets/brandBar/brand_grid.dart';
import 'package:stepup/widgets/brandBar/brand_select_bar.dart';
import 'package:stepup/widgets/filtedProducts/brand_selected_product.dart';
import 'package:stepup/widgets/filter/price_slider.dart';

class FilterWidget extends StatefulWidget {
  const FilterWidget({super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BrandsVM>(
      create: (context) => BrandsVM(),
      child: Container(
        padding: EdgeInsets.only(left: 25, top: 50),
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sắp xếp và lọc",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Lọc theo hãng",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            BrandGrid(),
            SizedBox(
              height: 10,
            ),
            Text(
              "Lọc theo giới tính",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Nam'),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Nữ'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Giá",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            PriceSlider(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Thấp đến cao'),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all()),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text('Cao đến thấp'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
