import 'package:flutter/material.dart';
import 'package:stepup/test/model/shoe.dart';

class ProductListItem extends StatelessWidget {
  final Widget thumbnail;
  final Shoe shoe;

  const ProductListItem({
    super.key,
    required this.thumbnail,
    required this.shoe,
  });

  Widget ListItem() {
    return SizedBox(
      height: 150,
      child: Card.outlined(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: thumbnail,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Shoe(
                    name: shoe.name,
                    brand: shoe.brand,
                    discount: shoe.discount,
                    price: shoe.price,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card.outlined(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: thumbnail,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Shoe(
                    name: shoe.name,
                    brand: shoe.brand,
                    discount: shoe.discount,
                    price: shoe.price,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
