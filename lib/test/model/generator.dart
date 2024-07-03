import 'shoe.dart';

generateShoe(int amount) {
  List<Shoe> shoes = List.generate(
    amount,
    (index) => Shoe(
      name: 'Shoe ${index++}',
      price: index * 1000,
      // discount: 0,
      brand: 'Nike',
    ),
  );
  return shoes;
}
